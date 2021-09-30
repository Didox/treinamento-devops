# para buildar imagem
docker-compose build

# para criar e levantar
docker-compose up
docker-compose up --detach # roda em background

# para levantar
docker-compose start

# para derrubar
docker-compose stop

# para mostrar log
docker-compose logs --follow

# para ver os serviços disponíveis
docker-compose ps

# para derrubar os serviços
docker-compose down

# para verificar network containers
docker network ls

# para entrar na maquina e verificar rede
docker exec -it sistema_csharp bash
docker exec -it sistema_java bash
docker exec -it sistema_nodejs bash
