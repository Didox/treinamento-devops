```shell
# ### dar nome para o master
ssh -i ~/Desktop/devops/Treinamento ubuntu@ec2-54-226-188-130.compute-1.amazonaws.com

sudo su -
hostname k8s-master 
echo "k8s-master" > /etc/hostname
bash

sudo su -
hostname k8s-node-1
echo "k8s-node-1" > /etc/hostname
bash

sudo su -
hostname k8s-node-2
echo "k8s-node-2" > /etc/hostname
bash

sudo su -
hostname k8s-node-3
echo "k8s-node-3" > /etc/hostname
bash

# ou hostnamectl set-hostname <nome>

source <(kubectl completion bash) # para deixar o kubeclt com auto complete

uname -a # para saber o nome do servidor

kubeadm init --apiserver-advertise-address $(hostname -i | awk '{print $1;exit}') --ignore-preflight-errors cri

# caso trave com erro de timeout, olhar o security group do haproxy
systemctl status kubelet | less # verifica se o serviço está de pé
sudo systemctl start kubelet # se precisar start do serviço

####################################################
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a Pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  /docs/concepts/cluster-administration/addons/

You can now join any number of machines by running the following on each node
as root:

  kubeadm join <control-plane-host>:<control-plane-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>
####################################################


kubectl delete -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
kubectl get pod -n kube-system -w

kubectl get nodes -o wide # lista os nos com seus respectivos IPs
kubectl get all --all-namespaces # llista todos os pods do kubernetes
kubectl get pods -n kube-system # lista os pods internos do kubernetes

kubectl get ev # verifica todos os possiveis erros dos pods

etcd-k8s-master-0 # onde o kubernetes guarda suas informações, sua base de infos
kube-apiserver-k8s-master-0 # API de conexão do kubernetes
kube-proxy-4sxnj #proxy interno dos pods
kube-scheduler-k8s-master-0 # seus agendamentos
weave-net-4txql # sua gestão de rede
kubectl describe pod etcd-k8s-master-0 -n kube-system # mostra o describe do pod do system
kubectl run ngnix-treinamento --image nginx # vou criar um deployment do nginx
kubectl run ngnix-treinamento --image nginx --replicas 5 # vou criar um deployment do nginx
kubectl get pods -o wide # para ver o pod criado
kubectl describe pod ngnix-treinamento # descreve o pod
kubectl scale deployment nginx-treinamento --replicas=3 # para escalar um deployment

# ---

```
