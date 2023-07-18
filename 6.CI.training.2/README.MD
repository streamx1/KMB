### CI training 2.	
#### NodeJS. Find a simple app on NodeJS and build it locally on the EC2 using agent.

```bash

-- Install NodeJS to EC2 instance

ubuntu@ip-172-31-35-7:~$ sudo apt update

ubuntu@ip-172-31-35-7:~$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

ubuntu@ip-172-31-35-7:~$ nvm --version
0.39.0

ubuntu@ip-172-31-35-7:~$ nvm install stable
Downloading and installing node v20.3.1...
Downloading https://nodejs.org/dist/v20.3.1/node-v20.3.1-linux-x64.tar.xz...
################################################################## 100.0%
Computing checksum with sha256sum
Checksums matched!
Now using node v20.3.1 (npm v9.6.7)
Creating default alias: default -> stable (-> v20.3.1)

ubuntu@ip-172-31-35-7:~$ node --version
v20.3.1

-- Script for NodeJS

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

-- Output in browser http://18.195.51.144:3000/  
HELLO ANYBODY!

```

#### Docker. Do the same application build but inside a docker container (local).

```bash

streamx1@ubuntu111:~$ sudo apt update

streamx1@ubuntu111:~$ sudo apt install ca-certificates curl gnupg

streamx1@ubuntu111:~$ sudo install -m 0755 -d /etc/apt/keyrings

streamx1@ubuntu111:~$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

streamx1@ubuntu111:~$ sudo chmod a+r /etc/apt/keyrings/docker.gpg

streamx1@ubuntu111:~$ echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

streamx1@ubuntu111:~$ sudo apt update

streamx1@ubuntu111:~$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

streamx1@ubuntu111:~$ sudo usermod -aG docker $USER

--- reload terminal session

streamx1@ubuntu111:~$ npm init

streamx1@ubuntu111:~$ npm install


--- dockerfile

# Установка базового образа
FROM node:14

# Установка директории приложения
WORKDIR /app

# Копирование файлов приложения
COPY package.json package-lock.json /app/
COPY server.js /app/

# Установка зависимостей
RUN npm install

# Открытие порта
EXPOSE 3000

# Запуск приложения
CMD ["node", "server.js"]

---

streamx1@ubuntu111:~$ docker build -t dockercontainer.server.js:1 .

streamx1@ubuntu111:~$ docker images
REPOSITORY                  TAG       IMAGE ID       CREATED             SIZE
dockercontainer.server.js   1         b9a0af8675fe   About an hour ago   1.1GB

streamx1@ubuntu111:~$ docker run -p 3000:3000 dockercontainer.server.js:1


--- run
curl 127.0.0.0:3000

--- output
HELLO ANYBODY!

```

#### GitLab-CI. Create two jobs: docker build job (with previous build process) and a deployment job with docker run on the same EC2.

```bash
1. --- workflow docker.build.push.yaml


name: Build and Push Docker Image

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
          password: ${{ secrets.KMB }}

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2


      - name: Build and push Docker image
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: ghcr.io/streamx1/docker-image:latest


--- see pictures Docker_bild_1.png and Docker_bild_2.png

2. install Docker on EC2

ubuntu@ip-172-31-35-181:~$ sudo apt update

ubuntu@ip-172-31-35-181:~$ sudo apt install ca-certificates curl gnupg

ubuntu@ip-172-31-35-181:~$ sudo install -m 0755 -d /etc/apt/keyrings

ubuntu@ip-172-31-35-181:~$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

ubuntu@ip-172-31-35-181:~$ sudo chmod a+r /etc/apt/keyrings/docker.gpg

ubuntu@ip-172-31-35-181:~$ echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

ubuntu@ip-172-31-35-181:~$ sudo apt update

ubuntu@ip-172-31-35-181:~$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

ubuntu@ip-172-31-35-181:~$ sudo groupadd docker

ubuntu@ip-172-31-35-181:~$ sudo usermod -aG docker $USER



-- EC2 as runner:



# Authentication

√ Connected to GitHub

# Runner Registration

Enter the name of the runner group to add this runner to: [press Enter for Default]

Enter the name of runner: [press Enter for ip-172-31-35-181]

This runner will have the following labels: 'self-hosted', 'Linux', 'X64'
Enter any additional labels (ex. label-1,label-2): [press Enter to skip]

√ Runner successfully added
√ Runner connection is good

# Runner settings

Enter name of work folder: [press Enter for _work]

√ Settings Saved.

--- ubuntu@ip-172-31-35-181:~/actions-runner$ ./run.sh

√ Connected to GitHub

Current runner version: '2.305.0'
2023-07-17 10:54:44Z: Listening for Jobs
Runner update in progress, do not shutdown runner.
Downloading 2.306.0 runner
Waiting for current job finish running.
Generate and execute update script.
Runner will exit shortly for update, should be back online within 10 seconds.
Runner update process finished.
Runner listener exit because of updating, re-launch runner after successful update
Update finished successfully.
Restarting runner...

√ Connected to GitHub

Current runner version: '2.306.0'
2023-07-17 10:55:19Z: Listening for Jobs


--- workflow docker.build.push.EC2.yaml


name: Build and Push Docker Image EC2

on:
  push:
    branches:
      - main

jobs:
  build-and-push:
    runs-on: self-hosted
    steps:
      - uses: actions/checkout@v3

      - name: Login to GHCR
        uses: docker/login-action@v2
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.KMB }}

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2


      - name: Build and push Docker image EC2
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: ghcr.io/streamx1/docker-image:latest


--- see pictures: 
 
Docker_bild_3_EC2.png
Docker_bild_4_EC2.png
Docker_bild_5_EC2.png
Docker_bild_5_Packages.png


```

#### AWS. Assign a Security Group to the EC2 to test the running app


```bash

-- set AWS security group

step 1 - AWS.SG_1.png 
step 2 - AWS.SG_2.png 
step 3 - AWS.SG_3.png
step 4 - AWS.SG_4.png


-- start docker container

ubuntu@ip-172-31-35-181:~/docker.ec2$ docker run -p 3000:3000 dockercontainer.server.js:1
Server started on the port 3000


-- start browser http://18.195.166.4:3000/
HELLO ANYBODY!

```


