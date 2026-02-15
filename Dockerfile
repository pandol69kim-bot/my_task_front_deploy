# Build React App
# FROM node:alpine3.18 as build
FROM node:18-alpine3.18 AS build
WORKDIR /app
COPY package*.json .
# RUN npm install
RUN npm ci

COPY . .
RUN npm run build

# Server Setting Nginx
# FROM nginx:1.23-alpine
FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/dist .
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
