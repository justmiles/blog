---
title: Clone a Hard Drive Using DD
date: 2015-10-25
id: 1445792400
tags:
  - linux
---

With the ever decreasing price on storage it is becoming increasingly common to upgrade hard drives to something a little faster or a little bigger. I, myself, am making a jump from a 500GB 7200RPM HDD to a 1TB SSD. Pretty excited about it. To emphasise my enthusiasm I decided to crank out a quick article on the technical side of the migration.
<!-- more -->
It's a small project but still falls into basic project planning practice. 

**Functional Requirements**
- Data integrity - Ensure that data is not missing or corrupt
- Compatibility - Other than speed and space, there shouldn't be a noticable difference after swapping hard drives

**Non-Functional Requirements**
- Migration is complete in a timely manner

### The How
Using `dd` is convenient because it'll clone every single byte. It's important though to be cognizant of the fact that every byte being migrated is in jeopardy of becoming corrupt if the data is in use. To prevent this, make sure the drives aren't mounted first (step 2). 

The `if` and `of` options from `dd` determine the input and output, respectively, of the data to be copied. 

The `bs` option of `dd` determines how many bytes of data to migrate at a time. Bumping this will help improve the overall speed but reduces the granularity of each chunk migrated.

Note that we're going to copy the entire drive and not each partition individually (`/dev/sda1` for example). Copying the drives will migrate the partitions for us.

1. Use `fdisk` to identify your old and new drives.
```bash
sudo fdisk -l
```

2. Unmount the drives you're working with `umount`
```bash
sudo umount /dev/sda
sudo umount /dev/sdb
```

3. Perform the migration with `dd`
```bash
dd if=/dev/sda of=/dev/sdb bs=32M
```