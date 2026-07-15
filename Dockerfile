# Этап 1: Сборка фронтенда
FROM node:22-alpine AS builder
WORKDIR /build
# Копируем файлы конфигурации npm
COPY package*.json ./
RUN npm ci
# Копируем весь исходный код фронтенда
COPY . .
# Собираем папку dist
RUN npm run build

# Этап 2: Финальный образ с бэкендом Gramps
FROM dmstraub/gramps-webapi:latest
# Копируем собранный дистрибутив из первого этапа
COPY --from=builder /build/dist /app/static
LABEL org.opencontainers.image.source="https://github.com/gramps-project/gramps-web"
