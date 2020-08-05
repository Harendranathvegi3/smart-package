### STAGE 1: Build ###
FROM node:12 AS build

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY . .

RUN npm run build

### STAGE 2: Run ###
FROM nginx:1.17.1-alpine

EXPOSE 8000

COPY nginx/nginx.conf /etc/nginx/nginx.conf

COPY --from=build /usr/src/app/dist /usr/share/nginx/html
