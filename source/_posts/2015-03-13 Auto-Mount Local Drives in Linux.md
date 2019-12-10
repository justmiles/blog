---
title: Auto-mount Local Drives/Partitions in Linux
date: 2015-03-13
id: 1426222800
tags:
  - linux
  - walkthrough
---

So you've dual-booted linux but haven't yet purged Windows from your machine. Congrats on your progress but if you really want to help yourself go ahead and wipe the Windows partition, too. Alas, if you can't bring yourself to do so, here's how to mount the partition and ensure its persistence after rebooting.

<!-- more -->

1.   View your local drives and partitions with `fdisk` and identify the drive you would like to mount. Following a dual-boot install, this will typically be */dev/sdb2*, so we'll assume that for the rest of the tut.
Note that if it is a Windows partition, you'll see a _NTFS/exFAT_ under the System stats.
    ```bash
    sudo fdisk -l
    #> Disk /dev/sdb: 320.1 GB, 320072933376 bytes
    #> 255 heads, 63 sectors/track, 30401 cylinders, total 488397168 sectors
    #> Units = sectors of 1 * 512 = 512 bytes
    #> Sector size (logical/physical): 512 bytes / 512 bytes
    #> I/O size (minimum/optimal): 512 bytes / 512 bytes
    #> Disk identifier: 0x000000
    #> 
    #>    Device Boot      Start         End      Blocks   Id  System
    #> /dev/sdb1            2048   167774207    234883071   82  Linux
    #> /dev/sdb2       167774208   234883072    625141759   82  HPFS/NTFS/exFAT
    ```
2. Create a folder for this partition to mount. It can be anywhere, but convention is in the */mnt* directory.
    ```bash
    sudo mkdir /mnt/windows
    ```
3. Mount the drivesudo mount /dev/sdb2 /mnt/windows (with /dev/* being whatever drive you identified in fdisk) 
    ```bash
    sudo mount /dev/sdb2 /mnt/windows
    ls -al /mnt/windows
    #> your data here
    ```
4. Now that you can successfully mount the partition let's configure it to mount automatically. To do this, start by identifying your partition's UUID with `blkid`
    ```bash
    sudo blkid /dev/sdb2
    #> /dev/sdb2: UUID="CEAA91D9AA91BE81" TYPE="ntfs" 
    ```
5. Copy the UUID and add a mount entry to */etc/fstab* as `UUID=YOUR_UUID /mnt/YOUR_LOCAL_MOUNTPOINT ntfs uid=root,gid=users,dmask=0002,fmask=0002 0`
    ```bash
    sudo vi /etc/fstab 
    #> UUID=CEAA91D9AA91BE81 /mnt/windows ntfs uid=root,gid=users,dmask=0002,fmask=0002 0 0
    ```
