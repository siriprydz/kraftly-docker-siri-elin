# syntax=docker/dockerfile:1
# Steg 1: bygg appen med Node – bara det Vite behöver, inte tester/mock-API
FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN --mount=type=cache,target=/root/.npm npm ci
COPY index.html vite.config.js ./
COPY src ./src
RUN npm run build

# Steg 2: servera dist med BusyBox httpd på scratch (~80 KB bas)
FROM lipanski/docker-static-website:2.6.0
COPY httpd.conf /etc/httpd.conf
COPY --from=build /app/dist .
EXPOSE 80
CMD ["/busybox-httpd", "-f", "-v", "-p", "80"]
