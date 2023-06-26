###  Linux loading


#### A task to perform some actions during different Linux loading stages
#### 1. Download Ubuntu latest (LTS) 
#### 2. Install to Oracle VM VirtualBox 
#### 3. Set up interfaces (static) 
#### 4. Set authorization by SSH key w/o password 


```bash

1. Download Ubuntu latest (LTS) 

Get Ubuntu Server 22.04.2 LTS
OS security guaranteed until April 2027
Expanded security maintenance until April 2032
Commercial support for enterprise customers

2. Install to Oracle VM VirtualBox 

cat /etc/*release

DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04.2 LTS"
PRETTY_NAME="Ubuntu 22.04.2 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.2 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy

3. Set up interfaces (static) 

cat /etc/netplan/*

network:
  ethernets:
    enp0s3:
      dhcp4: true
    enp0s8:
      dhcp4: false
      addresses: [192.168.94.111/24]
      nameservers:
        addresses:
        - 8.8.8.8
        - 8.8.4.4
  version: 2

4. Set authorization by SSH key w/o password 

ssh streamx@192.168.94.111
Welcome to Ubuntu 22.04.1 LTS (GNU/Linux 5.15.0-60-generic x86_64)

```

### Users and permissions
#### Some task about new user creation, group management, providing root priveledges, ownership transfer, permissions change
#### 1.	Create new user
#### 2.	Create new group
#### 3.	Change group for new user
#### 4.	Providing root privileges to new user
#### 5.	Transfer file ownership to new user
#### 6.	Change file permissions

```bash
1. Create new user

sudo adduser streamx1

2. Create new group

sudo addgroup newgroup

3. Change group for new user

sudo adduser streamx1 newgroup

4. Providing root privileges to new user

sudo adduser streamx1 sudo

5. Transfer file ownership to new user

streamx@ubuntu111:~$ touch test.file

streamx@ubuntu111:~$ ls -l
total 4
-rw-rw-r-- 1 streamx streamx 4 May 23 17:24 test.file

streamx@ubuntu111:~$ sudo chown streamx1 test.file

streamx@ubuntu111:~$ ls -l
total 4
-rw-rw-r-- 1 streamx1 streamx 4 May 23 17:24 test.file

6. Change file permissions 

streamx@ubuntu111:~$ sudo chmod 777 test.file

streamx@ubuntu111:~$ ls -l
total 4
-rwxrwxrwx 1 streamx1 streamx 4 May 23 17:24 test.file

```

### Main logs and their management
#### File systems
#### Task on creating a swap drive

```bash

streamx@ubuntu111:~$ swapon --show

streamx@ubuntu111:~$ sudo fallocate -l 1G /swapfile.test

streamx@ubuntu111:~$ sudo chmod 600 /swapfile.test

streamx@ubuntu111:~$ sudo mkswap /swapfile.test

Setting up swapspace version 1, size = 1024 MiB (1073737728 bytes)
no label, UUID=4aa5818b-2a5d-4149-a629-74116c0fc32b

streamx@ubuntu111:~$ sudo swapon /swapfile.test

streamx@ubuntu111:~$ sudo nano /etc/fstab

streamx@ubuntu111:~$ swapon --show

NAME           TYPE  SIZE USED PRIO
/swapfile.test file 1024M   0B   -2


```

### Main logs and their management
#### Cat system logs, tail, head, grep

```bash

1. Show syslogs

streamx@ubuntu111:~$ ls /var/log -l | grep syslog
-rw-r-----  1 syslog    adm              51250 May 23 17:43 auth.log
-rw-r-----  1 syslog    adm             259097 May 23 16:05 cloud-init.log
-rw-r-----  1 syslog    adm             245766 May 23 17:43 kern.log
-rw-r-----  1 syslog    adm             473108 May 23 17:43 syslog

Shouldn`t use command `cat syslog` because files too big.

2. Output 10 last strings in file syslog.

streamx@ubuntu111:/var/log$ tail syslog

3. Output 20 last strings in file syslog.

streamx@ubuntu111:/var/log$ tail -n 20 filename

4. Realtime output 10 last strings in file syslog.

streamx@ubuntu111:/var/log$ tail -f syslog

5. Output 10 first strings in file syslog.

streamx@ubuntu111:/var/log$ head syslog

6. Output 20 first strings in file syslog.

streamx@ubuntu111:/var/log$ head -n 20 syslog

7. Output strings content word "swap" in file syslog. 

streamx@ubuntu111:/var/log$ grep swap syslog
May 22 11:09:44 ubuntu111 kernel: [    0.147126] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
May 22 11:09:44 ubuntu111 kernel: [    1.210422] zswap: loaded using pool lzo/zbud
May 22 11:17:13 ubuntu111 kernel: [    0.147459] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
May 22 11:17:13 ubuntu111 kernel: [    1.397362] zswap: loaded using pool lzo/zbud
May 22 16:35:58 ubuntu111 kernel: [    0.119034] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
May 22 16:35:58 ubuntu111 kernel: [    1.221650] zswap: loaded using pool lzo/zbud
May 23 16:05:05 ubuntu111 kernel: [    0.198927] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
May 23 16:05:05 ubuntu111 kernel: [    1.620362] zswap: loaded using pool lzo/zbud
May 23 17:43:05 ubuntu111 kernel: [ 5900.606084] Adding 1048572k swap on /swapfile.test.  Priority:-2 extents:3 across:1294332k FS

```






