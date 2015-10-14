title: Install Scripts
tags: install-script
date: 2015-10-08 18:31:38
---

```bash
#!/bin/sh
VERSION=14.1.1
GROUP=`id -g -n $USERNAME | awk '{ print $1 }'`
wget https://download.jetbrains.com/idea/ideaIU-$VERSION.tar.gz -O ideaIU.tar.gz
sudo rm -rf /opt/intellij
sudo tar -zxf ideaIU.tar.gz --transform 's_^idea-IU-[0-9]*\.[0-9]*\.[0-9]*/_intellij/_'  -C /opt/
sudo chown -R $USERNAME:$GROUP /opt/intellij
rm ideaIU.tar.gz
```