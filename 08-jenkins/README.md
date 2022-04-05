video legal

https://www.youtube.com/watch?v=7KCS70sCoK0



Como rodar docker no usuário do jenkins

https://faun.pub/docker-build-push-with-declarative-pipeline-in-jenkins-2f12c2e43807

After that, allow Jenkins users to access the docker socket.
$ sudo usermod -aG docker jenkins
$ sudo systemctl restart jenkins


Test your docker access with Jenkins user
$ sudo su - jenkins
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
