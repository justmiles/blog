---
title: Debugging Network Traffic with tcpdump
date: 2016-04-27
id: 1461733200
categories:
  - walkthrough
tags:
  - networking
---
```
apt-get install tcpdump
apt-get install wireshark
```

Monitor a specific port.
```
tcpdump -i any -w /tmp/http-80.log port 80 &
```

View the monitor with tcpdump
```
tcpdump -A -r /tmp/http-80.log 
```

Optionally, pop open file in wireshark to view it in a more detailed view.
