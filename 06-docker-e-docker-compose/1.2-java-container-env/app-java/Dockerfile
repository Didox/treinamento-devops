FROM openjdk:8-jdk-alpine
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

# FROM openjdk:8-jdk-alpine
# ARG JAR_FILE=target/*.jar
# COPY . /tmp_build
# WORKDIR /tmp_build
# RUN ./mvnw -T 1C clean install -Dmaven.test.skip -DskipTests -Dmaven.javadoc.skip=true \
#     && cp ${JAR_FILE} /app.jar \
#     && rm -fr *
# EXPOSE 8080

ENTRYPOINT ["java","-jar","/app.jar"]

# ### Gerar o build do docker ###
# $ docker build -t didox/crud-java-login -f Dockerfile .

# ### Preparar container ###
# $ docker run -d -p 8081:8080 --name crud-java-login didox/crud-java-login

# ### Rodar container ###
# $ ./start.sh

# ### Para rodar os testes ###
# $ ./test.sh

# ### Acesso by "ssh" ###
# $ ./ssh.sh

# ### Para ver logs ###
# $ ./logs.sh

# ### Para parar o seriviço ###
# $ ./kill.sh

# ### Para remover o seriviço rodar ###
# $ docker rm crud-java-login