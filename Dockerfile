# Build React App
FROM node:alpine3.18 as build
WORKDIR /app
COPY package*.json .
RUN npm run build

# Server Setting Nginx
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/dist ./
EXPOSE 80
CMD ["nginx", "-G", "daemon off;"]
