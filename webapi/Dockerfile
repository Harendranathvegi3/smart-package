FROM node:12

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

RUN npm install -g swagger

RUN npm ci --only=production

COPY . .

ENV PORT 10010

EXPOSE 10010

CMD [ "npm", "start" ]