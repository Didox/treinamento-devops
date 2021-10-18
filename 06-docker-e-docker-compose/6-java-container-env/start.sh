export USER='bad3b77b0a262d'
export PASSWORD='040e170e'
export DATABASE_URL='mysql://um_host_de_base.com/heroku_7f94424f56f1693?reconnect=true'

# ./mvnw spring-boot:run

# docker run -e USER -e PASSWORD -e DATABASE_URL -p 8081:8080 --name crud-java-login didox/crud-java-login
docker run -d -e USER -e PASSWORD -e DATABASE_URL -p 8081:8080 --name crud-java-login didox/crud-java-login
docker start crud-java-login