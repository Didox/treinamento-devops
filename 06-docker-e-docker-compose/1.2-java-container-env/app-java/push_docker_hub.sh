tag=$(git describe --tags $(git rev-list --tags --max-count=1))
docker tag didox/crud-java-login:$tag hub.docker.com/r/didox/crud-java-login:$tag
docker push didox/crud-java-login:$tag