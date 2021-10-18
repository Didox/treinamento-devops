export USER='root' 
export PASSWORD='root' 
export DATABASE_URL='mysql://localhost:3306/SpringWebYoutubeTest?useTimezone=true&serverTimezone=UTC'

# ./mvnw spring-boot:run

# docker run -e USER -e PASSWORD -e DATABASE_URL -p 8081:8080 --name crud-java-login didox/crud-java-login
docker run -d -e USER -e PASSWORD -e DATABASE_URL -p 8081:8080 --name crud-java-login didox/crud-java-login
docker start crud-java-login