title: Working with AWS Parameter Store
date: 2018-10-26 11:10:46
tags:
---

There are several very reliable key-value stores to choose from - [HashiCorp's Vault](https://www.vaultproject.io) is an honorable mention, but when deploying applications in AWS I often lean on the [AWS Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-paramstore.html) as the de facto key-value repository. It simplifies the process of storing, encrypting, and retrieving application data and does so in a secure enough manner to satisfy even the most persnickety security engineers. Data is encrypted using the [Key Management Service](https://aws.amazon.com/kms) and access is controlled via IAM.

<!-- more -->

## Managing the Parameter Store Like a Boss
Once you start using the Parameter Store and begin to reference it somewhat regularly the the first thing you will notice is how difficult it can be to find and view data quickly from the console - especially for larger stores. The inability to quickly search the store when trying to lookup or debug an issue eventually led me to [write a tool that syncs the store to disk](https://github.com/justmiles/ssm-parameter-store). 

```
		mkdir parameter-store
		cd parameter-store
		ssm-parameter-store pull
```

Now you can search through the store:

```
		grep -ri somehostname.internal.com .
```

## Using the Parameter Store with Docker
If you want to pull out values from the Parameter Store you have a few options on how to retrieve it. The standard AWS CLI is great for bashing out repeatable processes but it only returns 10 parameters at a time. You could bash out a way to paginate the API for whatever you are looking for and but you would also need to handle merging it all back together and eventually formatting it for whatever application or service you're attempting to configure. My attempts to satisfy this led me to creating the [get-ssm-params](https://github.com/justmiles/go-get-ssm-params) tool. It is a light-weight way to pull all the parameters for an application out of the store and merge them into one of several standard output types: `json`, `text`, or even `shell`.

When using with my Docker images I'll add the small binary to the image and then execute it in an `ENTRYPOINT` script that either export necessary environment variables or writes the configs to the filesystem. 
