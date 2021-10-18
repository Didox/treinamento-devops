
## Build Docker
docker build -t didox/app-nodejs-validacao-cnpj -f Dockerfile .

## Build Docker and run
docker run -d -p 3000:3000 --name app-nodejs-validacao-cnpj didox/app-nodejs-validacao-cnpj

## Build watch Docker
docker run -it -p 3000:3000 --name app-nodejs-validacao-cnpj didox/app-nodejs-validacao-cnpj

# Para parar o docker
docker stop app-nodejs-validacao-cnpj

# para remover a imagem do docker
docker rm app-nodejs-validacao-cnpj

# para depurar
docker attach app-nodejs-validacao-cnpj

# entra dentro do container
docker exec -it app-nodejs-validacao-cnpj bash
docker exec -it app-nodejs-validacao-cnpj /bin/sh
docker exec -it app-nodejs-validacao-cnpj /bin/bash

# roda comando dentro do container
docker exec -it app-nodejs-validacao-cnpj ls -la

# para ver logs
docker logs app-nodejs-validacao-cnpj -f --tail 100

# Gerar a tag da imagem no docker hub, coloca como latest
docker tag didox/app-nodejs-validacao-cnpj hub.docker.com/r/didox/app-nodejs-validacao-cnpj

# Gerar a tag da imagem no docker hub, com tag 0.0.1
docker tag didox/app-nodejs-validacao-cnpj hub.docker.com/r/didox/app-nodejs-validacao-cnpj:0.0.1

# Publicar a imagem no docker hub, para o latest
docker push didox/app-nodejs-validacao-cnpj

# Publicar a imagem no docker hub, para o tag 
docker push didox/app-nodejs-validacao-cnpj:0.0.1

# Download da imagem no docker hub, na ultima versão
docker pull didox/app-nodejs-validacao-cnpj
