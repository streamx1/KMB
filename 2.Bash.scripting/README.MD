### Usefull utilities
#### Run utils: hd, free, ps, top
#### Use script with output: 
#### 1.	hd
#### 2.	free
#### 3.	ps
#### 4.	top


```bash

1. All about HDD

streamx@ubuntu111:~$ lsblk
NAME                      MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0                       7:0    0  63.3M  1 loop /snap/core20/1822
loop1                       7:1    0  63.5M  1 loop /snap/core20/1891
loop2                       7:2    0 111.9M  1 loop /snap/lxd/24322
loop3                       7:3    0  53.2M  1 loop /snap/snapd/19122
loop4                       7:4    0  49.8M  1 loop /snap/snapd/18357
sda                         8:0    0    25G  0 disk
├─sda1                      8:1    0     1M  0 part
├─sda2                      8:2    0     2G  0 part /boot
└─sda3                      8:3    0    23G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0  11.5G  0 lvm  /
sr0                        11:0    1  1024M  0 rom

streamx@ubuntu111:~$ sudo hdparm -I /dev/sda3
[sudo] password for streamx:

/dev/sda3:

ATA device, with non-removable media
        Model Number:       VBOX HARDDISK
        Serial Number:      VB57fa0c9d-465916a3
        Firmware Revision:  1.0
Standards:
        Used: ATA/ATAPI-6 published, ANSI INCITS 361-2002
        Supported: 6 5 4
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:    16514064
        LBA    user addressable sectors:    52428800
        LBA48  user addressable sectors:    52428800
        Logical/Physical Sector size:           512 bytes
        device size with M = 1024*1024:       25600 MBytes
        device size with M = 1000*1000:       26843 MBytes (26 GB)
        cache/buffer size  = 256 KBytes (type=DualPortCache)
Capabilities:
        LBA, IORDY(cannot be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Vendor, no device specific minimum
        R/W multiple sector transfer: Max = 128 Current = 128
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns

streamx@ubuntu111:~$ df -h
Filesystem                         Size  Used Avail Use% Mounted on
tmpfs                              1.3G  1.1M  1.3G   1% /run
/dev/mapper/ubuntu--vg-ubuntu--lv   12G  4.0G  6.7G  38% /
tmpfs                              6.4G     0  6.4G   0% /dev/shm
tmpfs                              5.0M     0  5.0M   0% /run/lock
/dev/sda2                          2.0G  130M  1.7G   8% /boot
tmpfs                              1.3G  4.0K  1.3G   1% /run/user/1000


2. free

streamx@ubuntu111:~$ free -h
               total        used        free      shared  buff/cache   available
Mem:            12Gi       224Mi        12Gi       1.0Mi       298Mi        12Gi
Swap:             0B          0B          0B

3. ps

streamx@ubuntu111:~$ ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0 166372 11704 ?        Ss   08:47   0:01 /sbin/init
root           2  0.0  0.0      0     0 ?        S    08:47   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        I<   08:47   0:00 [rcu_gp]
...
streamx      942  0.0  0.0  17084  9696 ?        Ss   08:48   0:00 /lib/systemd/systemd --user
streamx      943  0.0  0.0 169288  3804 ?        S    08:48   0:00 (sd-pam)
streamx     1043  0.0  0.0  17212  8308 ?        S    08:48   0:00 sshd: streamx@pts/0
streamx     1044  0.0  0.0   8732  5608 pts/0    Ss   08:48   0:00 -bash
root        1138  0.0  0.0      0     0 ?        I    08:53   0:00 [kworker/1:0-cgroup_destroy]
root        1140  0.0  0.0      0     0 ?        I    08:53   0:00 [kworker/u4:3-events_power_efficient]
root        1152  0.0  0.0      0     0 ?        I    09:02   0:00 [kworker/0:1]
root        1160  0.0  0.0      0     0 ?        I    09:09   0:00 [kworker/u4:0-events_power_efficient]
root        1161  0.0  0.0      0     0 ?        I    09:15   0:00 [kworker/u4:1-events_unbound]
streamx     1162  0.0  0.0  10068  1564 pts/0    R+   09:16   0:00 ps aux

4. top

streamx@ubuntu111:~$ top
top - 06:18:19 up 30 min,  1 user,  load average: 0.00, 0.00, 0.00
Tasks: 111 total,   1 running, 110 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.3 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :  12978.0 total,  12400.7 free,    228.7 used,    348.6 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.  12495.5 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
      1 root      20   0  166372  11704   8384 S   0.0   0.1   0:01.26 systemd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.00 kthreadd
      3 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_gp
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_par_gp
```
