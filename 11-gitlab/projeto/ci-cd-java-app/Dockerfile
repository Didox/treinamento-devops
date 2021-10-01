# FROM openjdk:8-jdk-alpine
# ARG JAR_FILE=target/*.jar
# COPY ${JAR_FILE} app.jar
# ENTRYPOINT ["java","-jar","/app.jar"]

# builda e gera a imagem
FROM openjdk:8-jdk-alpine
RUN mkdir src
COPY . /src
WORKDIR /src
RUN ./mvnw package && cp target/*.jar app.jar
ENTRYPOINT ["java","-jar","/src/app.jar"]


# ### Gerar o build do docker ###
# docker build -t didox/validador-cpf-java-turma-devops -f Dockerfile .

# ### Rodar imagem docker e gravar localmente ###
# $ docker run -d -p 8081:8080 --name validador-cpf-java-turma-devops didox/validador-cpf-java-turma-devops

# ### Para parar o seriviço rodar ###
# $ docker stop validador-cpf-java-turma-devops

# ### Para startar o seriviço rodar ###
# $ docker start validador-cpf-java-turma-devops

# ### Para remover o seriviço rodar ###
# $ docker rm validador-cpf-java-turma-devops