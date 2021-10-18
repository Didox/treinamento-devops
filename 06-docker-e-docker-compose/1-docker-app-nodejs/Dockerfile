FROM node:10
WORKDIR /usr/src/app
COPY package-docker.json ./package.json
RUN npm install
COPY . .
CMD ["node", "./bin/www"]