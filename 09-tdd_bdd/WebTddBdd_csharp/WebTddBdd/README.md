
### Gerar o build do docker ###
docker build -t didox/validador-cpf-csharp-turma-devops -f Dockerfile .

### Rodar imagem docker e gravar localmente ###
docker run -d -p 5001:80 --name validador-cpf-csharp-turma-devops didox/validador-cpf-csharp-turma-devops
### Rodar imagem docker em modo iterativo localmente ###
docker run -it -p 5001:80 --name validador-cpf-csharp-turma-devops didox/validador-cpf-csharp-turma-devops

### Para parar o seriviço rodar ###
docker stop validador-cpf-csharp-turma-devops

### Para startar o seriviço rodar ###
docker start validador-cpf-csharp-turma-devops

### Para remover o seriviço rodar ###
docker rm validador-cpf-csharp-turma-devops

### Para fazer login no dockerhub ###
docker login

### Criar a tag apontando para o repositório do docker hub ###
docker tag didox/validador-cpf-csharp-turma-devops hub.docker.com/r/didox/validador-cpf-csharp-turma-devops

### Fazer o push da imagem para a docker hub ###
docker push didox/validador-cpf-csharp-turma-devops