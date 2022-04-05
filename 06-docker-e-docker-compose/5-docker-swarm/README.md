# imersão feita na comunidade do torne-se um programador no dia 10/04/2021
- Criar maquinas na AWS EC2
- Ideal é ter de 1 a 7 maquinas principais (Main), sempre em números impares, para melhor performance
- Ideal pelo menos 3 worknodes

### Todos em zonas de disponibilidades diferentes

# iniciar cluster
```shell
docker swarm init --advertise-addr <MANAGER-IP>
docker swarm init --advertise-addr $(hostname -i | awk '{print $1;exit}')
```