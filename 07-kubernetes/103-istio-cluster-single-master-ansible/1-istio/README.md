https://istio.io/latest/docs/setup/install/istioctl/

# source <(kubectl completion bash) # para deixar o kubeclt com auto complete

curl -L https://istio.io/downloadIstio | sh - 
export PATH="$PATH:/root/istio-1.11.3/bin"

<!-- Adicionar no bashrc -->
vim ~/.bashrc
source ~/.bashrc

cd istio-1.11.3/
istioctl install --set profile=demo -y
<!-- istioctl install --manifests=manifests/ # não instala o egressgatway ou seja mais para AKS e EKS -->

kubectl label namespace default istio-injection=enabled # isso faz com que habilite ou crie os pods entro do junto com o istio, justamente porque agora ele é padrão(default) isso habilita ao criar um pod, o sidecar(envoi)

<!-- kubectl apply -f samples/bookinfo/platform/kube/bookinfo-mysql.yaml -->

kubectl -n istio-system get IstioOperator installed-state -o yaml > installed-state.yaml

istioctl version
istioctl operator init

istioctl analyze

kubectl get namespaces

kubectl -n istio-system get deploy

kubectl get services -n istio-system
kubectl get pods -n istio-system
kubectl get svc istio-ingressgateway -n istio-system
kubectl get svc istio-egressgateway -n istio-system
kubectl get deployment -n istio-system


istioctl profile dump default # para ver todos os recursos instalado no k8s


kubectl get services -n istio-operator
kubectl get pods -n istio-operator
kubectl get all -n istio-operator
kubectl get deployment -n istio-operator


https://istio.io/latest/docs/tasks/observability/metrics/using-istio-dashboard/

<!-- Grafana -->
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.11/samples/addons/grafana.yaml

<!-- 
# Address of Grafana
GRAFANA_HOST="http://localhost:3000"
# Login credentials, if authentication is used
GRAFANA_CRED="USER:PASSWORD"
# The name of the Prometheus data source to use
GRAFANA_DATASOURCE="Prometheus"
# The version of Istio to deploy
VERSION=1.11.3
# Import all Istio dashboards
for DASHBOARD in 7639 11829 7636 7630 7645; do
    REVISION="$(curl -s https://grafana.com/api/dashboards/${DASHBOARD}/revisions -s | jq ".items[] | select(.description | contains(\"${VERSION}\")) | .revision")"
    curl -s https://grafana.com/api/dashboards/${DASHBOARD}/revisions/${REVISION}/download > /tmp/dashboard.json
    echo "Importing $(cat /tmp/dashboard.json | jq -r '.title') (revision ${REVISION}, id ${DASHBOARD})..."
    curl -s -k -u "$GRAFANA_CRED" -XPOST \
        -H "Accept: application/json" \
        -H "Content-Type: application/json" \
        -d "{\"dashboard\":$(cat /tmp/dashboard.json),\"overwrite\":true, \
            \"inputs\":[{\"name\":\"DS_PROMETHEUS\",\"type\":\"datasource\", \
            \"pluginId\":\"prometheus\",\"value\":\"$GRAFANA_DATASOURCE\"}]}" \
        $GRAFANA_HOST/api/dashboards/import
    echo -e "\nDone\n"
done 
-->


<!-- Prometeus -->
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.11/samples/addons/prometheus.yaml

https://istio.io/latest/docs/tasks/observability/metrics/using-istio-dashboard/
kubectl -n istio-system get svc prometheus
kubectl -n istio-system get svc grafana

export PATH="$PATH:/root/istio-1.11.3/bin"
istioctl dashboard grafana # grafana UI no caso de install local


https://istio.io/latest/docs/tasks/observability/kiali/
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.11/samples/addons/kiali.yaml
kubectl -n istio-system get svc kiali


https://istio.io/latest/docs/tasks/observability/distributed-tracing/jaeger/
jaeger # istio-tracing monitorar requests da aplicação


kubectl -n istio-system get svc

<!-- 
istiod # dyno do istio responsavel pelo trabalho do istio (exemplo tem o sidecar(envoi) interno)
kiali # para ver a aplicação em execução
prometeus # para ter a metricas da aplicação
istio-tracing # para ver quanto tempo gasta cada aplicação requisição web
istio-ingressgateway / istio-egressgateway # que é o dado de entrada
grafana # dashboards graficos etc 
-->




<!-- Deployar uma aplicação de teste -->
https://istio.io/latest/docs/examples/bookinfo/
kubectl label namespace default istio-injection=enabled
kubectl get services
kubectl get pods

<!-- 
antes de testar, veja se vc liberou a rede no security group das entre as maquinas dos workers para o master acessar para all trafic
sgr-0a14ef020473a19ee	–	All traffic	All	All	sg-03d14421ddaf2f77e / a
agora pode testar 
-->

kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>" # esta a aplicação

kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml # para ver a aplicação de fora o cluster aplicar o ingress controller

kubectl get gateway # para ver o mesmo criado
kubectl describe gateway bookinfo-gateway # para ver as especificações

vim samples/bookinfo/networking/bookinfo-gateway.yaml # para analsar as rotas da aplicação

kubectl get svc -n istio-system # para ver o ingress gateway
<!-- 
istio-ingressgateway   LoadBalancer   10.97.189.252   <pending>     15021:31646/TCP,80:31350/TCP,443:32417/TCP,31400:31379/TCP,15443:31287/TCP 

vamos utilizar o da porta 80
15021:31646/TCP,80:31350/

ou seja a porta 31350 pois não estamos configurados no EKS

ou seja acessar:
http://54.162.34.26:31350/productpage # não se esqueça de habilitar a porta 31350 tcp no security group do cluster
IPv4	Custom TCP	TCP	31350	0.0.0.0/0
 -->

<!-- Agora analizar as méricas com kiali -->
kubectl get svc -n istio-system | grep kiali # aqui podemos criar um nodeport para expor ou rodar o comando abaixo
kubectl port-forward svc/kiali 20001:20001 -n istio-system --address 0.0.0.0 # para expor para qualqur IP
<!-- 
Liberar a porta na AWS e acessar
http://54.162.34.26:20001 # se tiver senha, a padrão é admin/admin
 -->

<!-- Agora analizar as méricas com grafana -->
kubectl get svc -n istio-system | grep grafana # aqui podemos criar um nodeport para expor ou rodar o comando abaixo
kubectl port-forward svc/grafana 3000:3000 -n istio-system --address 0.0.0.0 # para expor para qualqur IP
<!-- 
Liberar a porta na AWS e acessar
http://54.162.34.26:3000 # se tiver senha, a padrão é admin/admin
 -->

<!-- Agora analizar as méricas com prometheus -->
kubectl get svc -n istio-system | grep prometheus # aqui podemos criar um nodeport para expor ou rodar o comando abaixo
kubectl port-forward svc/prometheus 9090:9090 -n istio-system --address 0.0.0.0 # para expor para qualqur IP
<!-- 
Liberar a porta na AWS e acessar
http://54.162.34.26:9090 # se tiver senha, a padrão é admin/admin
 -->


<!-- Agora analizar as tracing com jaeger -->
kubectl get svc -n istio-system | grep jaeger # aqui podemos criar um nodeport para expor ou rodar o comando abaixo
kubectl port-forward svc/jaeger-query 16686:16686 -n istio-system --address 0.0.0.0 # para expor para qualqur IP
<!-- 
Liberar a porta na AWS e acessar
http://54.162.34.26:16686 # se tiver senha, a padrão é admin/admin
 -->




# remover istio
https://stackoverflow.com/questions/54261468/uninstall-istio-all-components-completely-from-kubernetes-cluster

kubectl delete namespace istio-system 
istioctl x uninstall --purge

