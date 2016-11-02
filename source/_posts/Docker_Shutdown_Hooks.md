---
title: Docker Shutdown Hooks
date: 2016-10-31
id: 1477944296
tags:
  - docker
categories:
  - devops
---

Let me start by saying there are no shutdown hooks for docker. Supporting hooks in general have been an [open feature request](https://github.com/docker/docker/issues/6982) for two years now. In lieu of a legitimate shutdown hook, you can manage the graceful shutdown of your container through a wrapper script that responds to `SIGINT` and `SIGTERM` signals.

<!-- more -->

By default, Docker stops containers by sending `SIGTERM` to process `1` inside the container. It gives the process a short few seconds (I'm not sure exactly how long the default is) before sending `SIGKILL` to the kernel itself to terminate the process. If your process needs to properly close connections or exit in a clean fashion it has a very short window to do so. You can set the amount of time your between the `SIGTERM` signal being sent to the process and the `SIGKILL` signal sent to the kernel with the `--time` argument: `docker stop --time=30 <container>`, but sometimes you need to manually specify a shutdown procedure.
By default, Docker stops containers by sending `SIGTERM` to process `1` inside the container. It gives the process a short few seconds (I'm not sure exactly how long the default is) before sending `SIGKILL` to the kernel itself to terminate the process. If your process needs to properly close connections or exit in a clean fashion it has a very short window to do so. You can set the amount of time your between the `SIGTERM` signal being sent to the process and the `SIGKILL` signal sent to the kernel with the `--time` argument: `docker stop --time=30 <container>`, but sometimes you need to manually specify a shutdown procedure.

I ran into this issue recently when building a container that mounts an  [s3ql filesystem](https://bitbucket.org/nikratio/s3ql/). In order to ensure data is completely written to the filesystem you need to properly dismount it before closing the container. If you drop a file onto the filesystem and close it shortly thereafter, there a strong chance the file hasn't fully uploaded to S3. And with S3QL specifically you need to properly unmount the filesystem in order to mount it again without errors. So I had to find a way to unmount before the container closed. 
 
## entrypoint.sh
Enter the wrapper script. If you're familiar with Docker, you know of the [docker entrypoint](https://docs.docker.com/engine/reference/#entrypoint-default-command-to-execute-at-runtime) functionality. This trick here is to write an entrypoint script that stays process 1 in the container. The entrypoint script will start your application and contain the functionality to gracefully shutdown. 

```bash
#!/bin/bash
function gracefulShutdown {
  echo "Shutting down!"
  # do something..
}
trap gracefulShutdown SIGTERM
exec "$@" &
wait
```
Using `trap` we can call the gracefulShutdown function once `SIGTERM` is received.
Executing all arguments in the background with `exec "$@" &` allows us to start our application in its own separate process, leaving process 1 for the entrypoint script.
The `wait` tells our script not to exit until our application does. This keeps the entrypoint script alive long enough to hear any system signals.

## s3ql example
Below is the script I used to mount and unmount s3ql.

```
#!/bin/bash
function gracefulshutdown {
  echo "Shutting down!"
  umount.s3ql /mnt && echo "s3ql unmounted" || echo "could not unmount s3ql"
}

trap gracefulshutdown SIGTERM
trap gracefulshutdown SIGINT

export AUTH_FILE=/root/s3ql_auth
cat << EOF > $AUTH_FILE
[$AWS_BUCKET]
storage-url: s3://$AWS_BUCKET
backend-login: $AWS_SECRET
backend-password: $AWS_KEY
fs-passphrase: $S3QL_FS_PASSPHRASE
EOF

chmod 600 $AUTH_FILE

echo 'continue' | fsck.s3ql s3://$AWS_BUCKET --authfile $AUTH_FILE
mount.s3ql s3://$AWS_BUCKET /mnt \
  --quiet \
  --authfile $AUTH_FILE \
  --allow-other && echo "fs mounted"

exec "$@" &
wait
```