# rodar a app
mvn spring-boot:run

# build jar
mvn package


# build imagem docker and publish
docker build -t didox/travel-agency-service -f Dockerfile .

docker tag didox/travel-agency-service hub.docker.com/r/didox/travel-agency-service

docker push didox/travel-agency-service

# build imagem docker and publish
docker build -t didox/travel-agency-service:v0.0.1 -f Dockerfile .

docker tag didox/travel-agency-service:v0.0.1 hub.docker.com/r/didox/travel-agency-service:v0.0.1

docker push didox/travel-agency-service:v0.0.1