
### Gerar Build do java ###
./mvnw package 

### Gerar o build do docker ###
docker build -t didox/validador-cpf-java-turma-devops -f Dockerfile .

### Rodar imagem docker e gravar localmente ###
docker run -d -p 8081:8080 --name validador-cpf-java-turma-devops didox/validador-cpf-java-turma-devops
### Rodar imagem docker em modo iterativo localmente ###
docker run -it -p 8081:8080 --name validador-cpf-java-turma-devops didox/validador-cpf-java-turma-devops

### Para parar o seriviço rodar ###
docker stop validador-cpf-java-tuma-devops

### Para startar o seriviço rodar ###
docker start validador-cpf-java-turma-devops

### Para remover o seriviço rodar ###
docker rm validador-cpf-java-turma-devops

### Para fazer login no dockerhub ###
docker login

### Criar a tag apontando para o repositório do docker hub ###
docker tag didox/validador-cpf-java-turma-devops hub.docker.com/r/didox/validador-cpf-java-turma-devops

### Fazer o push da imagem para a docker hub ###
docker push didox/validador-cpf-java-turma-devops

### Descobrir e matar processo ###
sudo lsof -t -i:8000
sudo kill -9 329293