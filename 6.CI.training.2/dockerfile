
# Установка базового образа
FROM node:latest

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

