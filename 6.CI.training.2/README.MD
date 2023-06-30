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

2.

```
