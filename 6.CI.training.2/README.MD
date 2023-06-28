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
