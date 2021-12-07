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
docker build -t didox/SEU_APP -f Dockerfile .

## Build Docker and run
docker run -d -p 80:3000 --name SEU_CONTAINER didox/SEU_APP

## Build watch Docker
docker run -it -p 80:3000 --name SEU_CONTAINER didox/SEU_APP

# Para subir app no docker
docker start SEU_CONTAINER

# Para parar o docker
docker stop SEU_CONTAINER

## Lista processos ativos
docker ps

## Lista todos os containers
docker ps -a

# para remover a imagem do docker
docker rm SEU_CONTAINER

# para depurar
docker attach SEU_CONTAINER

# entra dentro do container
docker exec -it SEU_CONTAINER bash
docker exec -it SEU_CONTAINER /bin/sh
docker exec -it SEU_CONTAINER /bin/bash

# roda comando dentro do container
docker exec -it SEU_CONTAINER ls -la

# para ver logs
docker logs SEU_CONTAINER -f --tail 100

# Gerar a tag da imagem no docker hub, coloca como latest
docker tag didox/SEU_APP hub.docker.com/r/didox/SEU_APP

# Gerar a tag da imagem no docker hub, com tag 0.0.1
docker tag didox/SEU_APP hub.docker.com/r/didox/SEU_APP:0.0.1

# Publicar a imagem no docker hub, para o latest
docker push didox/SEU_APP

# Publicar a imagem no docker hub, para o tag 
docker push didox/SEU_APP:0.0.1

# Remover imagem
docker image rm didox/SUA_IMG

# Ver imagens
docker image ls