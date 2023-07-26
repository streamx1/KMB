### 8.1 CI training 4. AWS. Linux, SSH.
#### Create ECR, create an additional EC2, create new user on all EC2s for the gitlab runner, implement SSH access from the new EC2 to the previously created EC2s, provide appropriate access from all EC2s to the ECR.

```bash

-- for EC2.ADD only
ssh-keygen -t rsa


--for each EC2 same:
(add,    name:  ip-172-31-21-220 
dev,     name:  ip-172-31-35-181
staging, name:  ip-172-31-25-222
prod     name:  ip-172-31-24-236
):

sudo adduser git-run
(26122009)

--OUTPUT:
Adding user `git-run' ...
Adding new group `git-run' (1001) ...
Adding new user `git-run' (1001) with group `git-run' ...
Creating home directory `/home/git-run' ...
Copying files from `/etc/skel' ...
New password:
Retype new password:
passwd: password updated successfully
Changing the user information for git-run
Enter the new value, or press ENTER for the default
        Full Name []:
        Room Number []:
        Work Phone []:
        Home Phone []:
        Other []:
Is the information correct? [Y/n] y
--
sudo usermod -aG sudo,adm git-run
su git-run
nano ~/.ssh/authorized_keys






--- use ssh-conect to each EC2 (dev, staging, prod) from EC2.add :

git-run@ip-172-31-21-220:~$ ssh git-run@18.184.103.65

The authenticity of host '18.184.103.65 (18.184.103.65)' can't be established.
ED25519 key fingerprint is SHA256:9+KRDrQ3dW3PyOpm30ZSlxleTgst0/UcBFxFqKmztmI.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '18.184.103.65' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.2 LTS (GNU/Linux 5.19.0-1028-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue Jul 25 10:46:28 UTC 2023

  System load:  0.0                Processes:                112
  Usage of /:   44.0% of 13.39GB   Users logged in:          1
  Memory usage: 29%                IPv4 address for docker0: 172.17.0.1
  Swap usage:   0%                 IPv4 address for eth0:    172.31.35.181

 * Ubuntu Pro delivers the most comprehensive open source security and
   compliance features.

   https://ubuntu.com/aws/pro

Expanded Security Maintenance for Applications is not enabled.

36 updates can be applied immediately.
3 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

git-run@ip-172-31-35-181:~$ exit
logout

Connection to 18.184.103.65 closed.

git-run@ip-172-31-21-220:~$ ssh git-run@3.70.229.196

The authenticity of host '3.70.229.196 (3.70.229.196)' can't be established.
ED25519 key fingerprint is SHA256:2VEcQZJYBAWNXEMVTAGJ+7aUK1IfUdC+kK0e+GBhOlU.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '3.70.229.196' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.2 LTS (GNU/Linux 5.19.0-1025-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue Jul 25 10:50:04 UTC 2023

  System load:  0.11767578125     Processes:             109
  Usage of /:   30.8% of 7.57GB   Users logged in:       1
  Memory usage: 33%               IPv4 address for eth0: 172.31.25.222
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

33 updates can be applied immediately.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


*** System restart required ***

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

git-run@ip-172-31-25-222:~$ exit
logout

Connection to 3.70.229.196 closed.
git-run@ip-172-31-21-220:~$ ssh git-run@3.124.3.29

The authenticity of host '3.124.3.29 (3.124.3.29)' can't be established.
ED25519 key fingerprint is SHA256:phkD5BcgrCGfJPwUv0T+6Dt/6M7DIzP1a+Ry8F6TSUw.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '3.124.3.29' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.2 LTS (GNU/Linux 5.19.0-1025-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue Jul 25 10:50:29 UTC 2023

  System load:  0.0               Processes:             106
  Usage of /:   30.8% of 7.57GB   Users logged in:       1
  Memory usage: 33%               IPv4 address for eth0: 172.31.24.236
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

33 updates can be applied immediately.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


*** System restart required ***

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

git-run@ip-172-31-24-236:~$ exit
logout

Connection to 3.124.3.29 closed.
git-run@ip-172-31-21-220:~$

```

#### Provide appropriate access from all EC2s to the ECR:

```bash

see next screenshot:

AWS_ECR_1.png
AWS_ECR_2.png
AWS_ECR_3.png
AWS_ECR_4.png
AWS_ECR_5.png

```

### 8.2 CI training 4. GitLab-CIH.
#### Install an agent on the new EC2 and configure it to use the new user and connect to the other EC2s via SSH, remove previously installed agents on those EC2s, update created jobs to build the docker images on the new EC2 and to deploy them on the other EC2s.

```bash

--- install github action agent on new EC2.ADD:

git clone git@github.com:streamx1/KMB.AWS.git
"install" NodeJS
"install" Docker

-- Script server.js for NodeJS

// Подключаем модуль http
const http = require('http');

// Создаем сервер
const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('HELLO ANYBODY!');
});

// Задаем порт для прослушивания
const port = 3000;

// Запускаем сервер
server.listen(port, () => {
  console.log(`Server started on the port ${port}`);
});

-- Start

ubuntu@ip-172-31-35-7:~/nodejs$ node server.js

-- Output in command line:
Server started on the port 3000

-- Output in browser http://18.197.32.199:3000/  
HELLO ANYBODY!

-- Output on other EC2.STAGING 

git-run@ip-172-31-25-222:~$ curl http://18.197.32.199:3000/
HELLO ANYBODY!



--- for deploy on other EC2.STAGING create workflow :
git-run@ip-172-31-21-220:~/KMB.AWS/.github/workflows$ nano docker.build.push.EC2.yaml


name: Build and Deploy Docker Image

on:
  push:
    branches:
      - main

jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Login to GHCR
        uses: docker/login-action@v2
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.KMBFORAWS }}

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2

      - name: Build and push Docker image
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: ghcr.io/streamx1/docker-image:latest

      # Add deployment steps for first EC2 instances
      - name: Deploy to EC2 Instance 1
        uses: appleboy/ssh-action@master
        with:
          host: 18.184.210.43
          username: git-run
          key: ${{ secrets.SSH_PRIVATE_KEY }}
          script: |
            docker stop container_server3000 || true
            docker rm container_server3000 || true
            echo ${{ secrets.KMBFORAWS }} | docker login ghcr.io -u ${{ github.actor }} --password-stdin
            docker pull ghcr.io/streamx1/docker-image:latest
            docker run -d --name container_server3000 -p 3000:3000 ghcr.io/streamx1/docker-image:latest

      # Add deployment steps for other EC2 instances: same

---

OUTPUT in browser from external IP EC2.STAGING: 
http://18.184.210.43:3000/
HELLO ANYBODY!

see next screenshot:
 
AWS_EC2_CI_1.png
AWS_EC2_CI_2.png
AWS_EC2_CI_3.png

```
