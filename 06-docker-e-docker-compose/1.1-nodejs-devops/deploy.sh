cd itau-tdd-lab
docker build -t didox/app-nodejs-validacao-cnpj -f Dockerfile .
docker run -d -p 3000:3000 --name app-nodejs-validacao-cnpj didox/app-nodejs-validacao-cnpj
docker exec -it app-nodejs-validacao-cnpj npm run test
docker stop app-nodejs-validacao-cnpj
docker tag didox/app-nodejs-validacao-cnpj hub.docker.com/r/didox/app-nodejs-validacao-cnpj
docker push didox/app-nodejs-validacao-cnpj
docker rm app-nodejs-validacao-cnpj

cd ../terraform
~/terraform/terraform init
~/terraform/terraform validate
~/terraform/terraform apply -auto-approve

echo "Aguardando criação de maquinas ..."
sleep 10 # 10 segundos

echo $"[ec2-nodejs]" > ../ansible/hosts # cria arquivo
echo "$(~/terraform/terraform output | awk '{print $3;exit}')" >> ../ansible/hosts # captura output faz split de espaco e replace de ",

echo "Aguardando criação de maquinas ..."
sleep 10 # 20 segundos

cd ../ansible
ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/Desktop/devops/treinamentoItau

cd ../terraform

open "http://$(~/terraform/terraform output | awk '{print $3;exit}' | sed -e "s/\"//g")"

# *** verifica se aplicação está de pé
# sudo lsof -iTCP -sTCP:LISTEN -P | grep :3000

