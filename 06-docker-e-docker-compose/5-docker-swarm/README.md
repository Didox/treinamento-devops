# imersão feita na comunidade do torne-se um programador no dia 10/04/2021
- Criar maquinas na AWS EC2
- Ideal é ter de 1 a 7 maquinas principais (Main), sempre em números impares, para melhor performance
- Ideal pelo menos 3 worknodes

### Todos em zonas de disponibilidades diferentes

## rodar o script de deploy
```shell
./deploy.sh
```

## acessar via ssh
```shell
ssh -i ../../devops-acesso-sh.pem ubuntu@ec2-204-236-198-169.compute-1.amazonaws.com -o ServerAliveInterval=60
```

# iniciar cluster 
## https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/
```shell
sudo su -
docker swarm init --advertise-addr <MANAGER-IP>
docker swarm init --advertise-addr $(hostname -i | awk '{print $1;exit}')
```

### irá gerar para você o script para os worknodes
```shell
Swarm initialized: current node (xqy4r8i1rcgutq8l203cy1y46) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-1x9nw8bmbg5lkskuzmoyygx8zvqmyri4bchfnh4j9ym5n644l5-cov830t2yyf0ynh8wsvvsif16 172.31.22.189:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

### para cancelar o docker rodar
```shell
docker swarm leave
```

### para verificar os nós rodar
```shell
docker node ls
docker node list
```

### descobrir scripts join worker
```shell
docker swarm join-token worker
```

### descobrir scripts join manager
```shell
docker swarm join-token manager
```

### acessar o nó worker e rodar o comando
```shell
docker swarm join --token SWMTKN-1-1x9nw8bmbg5lkskuzmoyygx8zvqmyri4bchfnh4j9ym5n644l5-cov830t2yyf0ynh8wsvvsif16 172.31.22.189:2377
```

### acessar o nó master e rodar o comando
```shell
docker swarm join --token SWMTKN-1-1x9nw8bmbg5lkskuzmoyygx8zvqmyri4bchfnh4j9ym5n644l5-a9dky9gmhwobymd5hzat6xhpo 172.31.22.189:2377
```

# para fazer o deploy, somente criar um docker-compose da seguinte forma
```docker-compose
version: '3.9'
services:
  nodejs:
    image: didox/app-imersao-docker-nodejs:latest
    ports:
      - "3000:3000"
    deploy:
      mode: replicated
      replicas: 3
      restart_policy:
        condition: on-failure
```

# Aplicar o docker-compose.yml
```shell
docker stack deploy --compose-file docker-compose.yml nodejs
```

# irá mostrar a mensagem
```shell
Creating network nodejs_website_default
Creating service nodejs_website_nodejs
```

# Para mostrar o serviço deployado
```shell
docker stack ls
# irá listar os serviços de replicas rodando no cluster
```

# ver containers deployados
```shell
docker service ps nodejs_website_nodejs
# irá listar os containers rodando agrupados no serviço
```

# aplicados depois é somente acessar as urls dos servidores e curtir
- http://ec2-204-236-198-169.compute-1.amazonaws.com:3000
- http://ec2-204-236-255-153.compute-1.amazonaws.com:3000
- http://ec2-3-81-14-126.compute-1.amazonaws.com:3000
- http://ec2-54-81-180-202.compute-1.amazonaws.com:3000
- http://ec2-35-175-206-222.compute-1.amazonaws.com:3000
- http://ec2-3-91-238-223.compute-1.amazonaws.com:3000

## rodar o apagar
```shell
./destroy.sh
```