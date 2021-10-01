Pacote
teste

Pacote agora vai ou nao

./mvnw package && java -jar target/validarCpf.jar

docker build -t alexandreponte/validadorcpfjava -f Dockerfile .

docker run -d -p 8090:8080 --name validador-cpf-cshar alexandreponte/validadorcpfjava

docker run -d -p 8090:8080 --name validador-cpf-java alexandreponte/validadorcpfjava
