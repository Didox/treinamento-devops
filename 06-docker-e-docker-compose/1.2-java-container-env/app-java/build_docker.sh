#!/bin/bash -e
# echo "Digite a tag que deseja para deploy"
# read tag
# git checkout tag
# docker build -t "didox/crud-java-login:$tag" -f Dockerfile .

#### Pegando ultima tag do git #####
tag=$(git describe --tags $(git rev-list --tags --max-count=1))
echo "Fazendo deploy da tag $tag"
docker build -t "didox/crud-java-login:$tag" -f Dockerfile .