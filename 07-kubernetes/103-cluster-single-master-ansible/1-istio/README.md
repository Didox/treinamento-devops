https://istio.io/latest/docs/setup/install/istioctl/

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

istioctl analyze # analisa métricas





# remover istio
https://stackoverflow.com/questions/54261468/uninstall-istio-all-components-completely-from-kubernetes-cluster

kubectl delete namespace istio-system 
istioctl x uninstall --purge

