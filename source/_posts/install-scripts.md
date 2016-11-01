---
title: Collection of Install Scripts
date: 2015-10-08
id: 1444280400
categories:
  - uncategorized
---
Chef, Ansible, and Puppet are all excellent tools for configuration management but every now and then you just need to install something quick and all you have is bash. I keep a constantly evolving collection of scripts for just this purpose. They are almost all for the Ubuntu flavor. If I know I am going to be in a VM for a while, I'll just kick off the whole spread.

<!-- more -->

You can [view the collection here](https://www.milesmaddox.com/owncloud/index.php/s/6zBPi8aSOPBrO7B "Install Scripts"), hosted via OwnCloud. Some examples below


**Java**
```bash
#!/bin/sh

MAJOR_VERSION=7
MINOR_VERSION=76
BUILD=13

VERSION="$MAJOR_VERSION"u"$MINOR_VERSION"
wget --no-cookies --no-check-certificate \
--header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
"http://download.oracle.com/otn-pub/java/jdk/$VERSION-b$BUILD/jdk-$VERSION-linux-x64.tar.gz" \
-O jdk-$VERSION-linux-x64.tar.gz

sudo mkdir -p /usr/local/java
sudo tar xvzf jdk-$VERSION-linux-x64.tar.gz -C /usr/local/java
rm jdk-$VERSION-linux-x64.tar.gz

JAVADIR=/usr/local/java/jdk1."$MAJOR_VERSION".0_"$MINOR_VERSION"

#Completely remove the OpenJDK/JRE from your system and create a directory to hold your Oracle Java JDK/JRE binaries. 
sudo apt-get purge openjdk-\*

#Inform your Ubuntu Linux system where your Oracle Java JDK/JRE is located.
sudo update-alternatives --install "/usr/bin/java" "java" $JAVADIR/jre/bin/java 1

#Inform your Ubuntu Linux system that Oracle Java JDK/JRE must be the default Java.
sudo update-alternatives --set java "$JAVADIR/jre/bin/java"
```



**ChefDK**
```bash
#!/bin/sh
VERSION=0.9.0
wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_$VERSION_amd64.deb -O ~/Downloads/chefdk.deb

sudo dpkg -i ~/Downloads/chefdk.deb
rm ~/Downloads/chefdk.deb
sudo apt-get install ruby-full

sh ./vagrant.sh
```


**IntelliJ**
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