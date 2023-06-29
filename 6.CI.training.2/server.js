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
