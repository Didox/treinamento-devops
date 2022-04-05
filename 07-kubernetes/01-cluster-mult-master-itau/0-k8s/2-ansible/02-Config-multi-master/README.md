# ### dar nome para as maquinas
# ssh -i ~/Desktop/devops/treinamentoItau ubuntu@ec2-54-226-188-130.compute-1.amazonaws.com

# sudo su -
# hostname k8s-master-0 
# echo "k8s-master-0" > /etc/hostname
# bash

# sudo su -
# hostname k8s-worker-0
# echo "k8s-worker-0" > /etc/hostname
# bash

# source <(kubectl completion bash) # para deixar o kubeclt com auto complete

# https://phoenixnap.com/kb/install-kubernetes-on-ubuntu
# sudo apt-get install docker.io
# kubeadm reset -f
# kubeadm init --control-plane-endpoint "k8s-haproxy:6443" --upload-certs # mandando para o IP do haproxy
# caso trave com erro de timeout, olhar o security group do haproxy
# systemctl status kubelet | less # verifica se o serviço está de pé
# sudo systemctl start kubelet # se precisar start do serviço

# kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
# kubectl get pod -n kube-system -w
# kubectl get nodes -o wide

####################################################
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of the control-plane node running the following command on each as root:

  kubeadm join k8s-haproxy:6443 --token vzs27d.ld5cvhdw912y9w71 \
	--discovery-token-ca-cert-hash sha256:1ce552632ddd7480a4d3bb669fb4d62c7bcf1c95b451e59d5503ec6dd43c33a9 \
	--control-plane --certificate-key b04713698b04c39f476bf7e8a1f977d1097f3641c3aa850741b5acea7a8fa187

Please note that the certificate-key gives access to cluster sensitive data, keep it secret!
As a safeguard, uploaded-certs will be deleted in two hours; If necessary, you can use
"kubeadm init phase upload-certs --upload-certs" to reload certs afterward.

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join k8s-haproxy:6443 --token vzs27d.ld5cvhdw912y9w71 \
	--discovery-token-ca-cert-hash sha256:1ce552632ddd7480a4d3bb669fb4d62c7bcf1c95b451e59d5503ec6dd43c33a9
####################################################
# kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
# kubectl get pod -n kube-system -w

# kubectl get nodes -o wide # lista os nos com seus respectivos IPs
# kubectl get all --all-namespaces # llista todos os pods do kubernetes
# kubectl get pods -n kube-system # lista os pods internos do kubernetes

# etcd-k8s-master-0 # onde o kubernetes guarda suas informações, sua base de infos
# kube-apiserver-k8s-master-0 # API de conexão do kubernetes
# kube-proxy-4sxnj #proxy interno dos pods
# kube-scheduler-k8s-master-0 # seus agendamentos
# weave-net-4txql # sua gestão de rede
# kubectl describe pod etcd-k8s-master-0 -n kube-system # mostra o describe do pod do system
# kubectl run ngnix-treinamento --image nginx # vou criar um deployment do nginx
# kubectl run ngnix-treinamento --image nginx --replicas 5 # vou criar um deployment do nginx
# kubectl get pods -o wide # para ver o pod criado
# kubectl describe pod ngnix-treinamento # descreve o pod
# kubectl scale deployment nginx-treinamento --replicas=3 # para escalar um deployment


# wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
# [kubelet-check] Initial timeout of 40s passed.
# https://stackoverflow.com/questions/57648829/how-to-fix-timeout-at-waiting-for-the-kubelet-to-boot-up-the-control-plane-as-st


#### remove kubernetes
# kubeadm reset
# sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*   
# sudo apt-get autoremove  
# sudo rm -rf ~/.kube

# ssh -i ~/Desktop/devops/treinamentoItau ubuntu@ec2-50-16-162-135.compute-1.amazonaws.com
# sudo su -
# hostname k8s-master-1
# echo "k8s-master-1" > /etc/hostname 
# bash

# ssh -i ~/Desktop/devops/treinamentoItau ubuntu@ec2-54-173-115-181.compute-1.amazonaws.com
# sudo su -
# hostname k8s-master-2 
# echo "k8s-master-2" > /etc/hostname 
# bash

# doc https://phoenixnap.com/kb/install-kubernetes-on-ubuntu
# doc ansible https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/

# Rodar na maquina 1
# - name: Initialize the Kubernetes cluster using kubeadm
#   become: true
#   command: sudo kubeadm init --control-plane-endpoint "172.31.92.187:6443" --upload-certs

# - name: Mostra keys config kubeadm
#   debug:
#     msg: kubeadm version #TODO Colocar comando que mostra configs

# ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/Desktop/devops/treinamentoItau
# ssh -i ~/Desktop/devops/treinamentoItau ubuntu@ec2-54-174-235-197.compute-1.amazonaws.com
# ssh -i ~/Desktop/devops/treinamentoItau ubuntu@ec2-50-16-162-135.compute-1.amazonaws.com
# ssh -i ~/Desktop/devops/treinamentoItau ubuntu@ec2-54-173-115-181.compute-1.amazonaws.com

# *** verifica log error
# vim /etc/haproxy/haproxy.cfg
# systemctl restart haproxy
# systemctl status haproxy.service
# tail -f /var/log/haproxy.log

# tail -f /var/log/nginx/error.log

