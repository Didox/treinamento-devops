# levantar cluster minicube local
minikube start --driver=virtualbox

# saber se o kubectl está conectado com o seu cluster local
kubectl get nodes

# aplicar o script de cricação de um pod
kubectl apply -f pod-nginx.yml

# acompanhar o starts do pod criado
kubectl apply -f pod-nginx.yml

# verificar se pod foi criado
kubectl get pods

# verificar se pod foi criado com número de IP
kubectl get pods -o wide

# verificar qual é o IP interno/externo do cluester
kubectl get nodes -o wide

# verificar os servicos que foi criado no kubernets
kubectl get services -o wide

# Entrar via ssh no pod
kubectl exec --stdin --tty imersao-nginx -- /bin/bash

# Executa item dentro do pod
kubectl exec nodejs-deployment-6fd74b494d-97xbp -- ls -la

# Criar conta na azure
# fazer download do az cli
https://docs.microsoft.com/pt-br/cli/azure/install-azure-cli-windows?tabs=azure-cli

# se logar na azure
az login

# vincular azure com kubectl
az aks get-credentials --name kubernets_imersao_tornese --resource-group Kubernets-Test-Danilo

# verificar cluster na azure
kubectl get nodes -o wide