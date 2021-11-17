# imersão feita na comunidade do torne-se um programador no dia 10/04/2021

## staks
 - Nodejs
 - Java
 - Dotnet

## temas
 - Docker
 - Docker compose
 - Kubernets
 - AKS - Azure


## Build Docker
docker build -t didox/app-imersao-docker-nodejs -f Dockerfile .

## Build Docker and run
docker run -d -p 80:3000 --name app-imersao-docker-nodejs didox/app-imersao-docker-nodejs

## Build watch Docker
docker run -it -p 80:3000 --name app-imersao-docker-nodejs didox/app-imersao-docker-nodejs

# Para parar o docker
docker stop app-imersao-docker-nodejs

# para remover a imagem do docker
docker rm app-imersao-docker-nodejs

# para depurar
docker attach app-imersao-docker-nodejs

# entra dentro do container
docker exec -it app-imersao-docker-nodejs bash
docker exec -it app-imersao-docker-nodejs /bin/sh
docker exec -it app-imersao-docker-nodejs /bin/bash

# roda comando dentro do container
docker exec -it app-imersao-docker-nodejs ls -la

# para ver logs
docker logs app-imersao-docker-nodejs -f --tail 100

# Gerar a tag da imagem no docker hub, coloca como latest
docker tag didox/app-imersao-docker-nodejs hub.docker.com/r/didox/app-imersao-docker-nodejs

# Gerar a tag da imagem no docker hub, com tag 0.0.1
docker tag didox/app-imersao-docker-nodejs hub.docker.com/r/didox/app-imersao-docker-nodejs:0.0.1

# Publicar a imagem no docker hub, para o latest
docker push didox/app-imersao-docker-nodejs

# Publicar a imagem no docker hub, para o tag 
docker push didox/app-imersao-docker-nodejs:0.0.1