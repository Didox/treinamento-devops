FROM node:latest
WORKDIR /usr/src/app
COPY . .
# COPY package-docker.json ./package.json
RUN npm install
CMD ["node", "./bin/www"]