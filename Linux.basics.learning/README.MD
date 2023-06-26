###  Linux loading


#### A task to perform some actions during different Linux loading stages
#### Download Ubuntu latest (LTS) 
#### Install to Oracle VM VirtualBox 
#### Set up interfaces (static) 
#### Set authorization by SSH key w/o password 


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
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-poli                                                         cy"
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

### Main logs and their management
