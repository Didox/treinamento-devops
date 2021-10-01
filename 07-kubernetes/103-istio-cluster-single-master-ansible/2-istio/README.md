# install istio
https://istio.io/v1.2/docs/setup/kubernetes/install/kubernetes/

https://istio.io/latest/docs/setup/getting-started/

# istio-demo.yaml
kubectl apply -f https://gist.githubusercontent.com/chanwit/4e1e4f951cf3357c1c3d7804f8162312/raw/f09ee7ae446783cb334c593be64072d95c6092bb/istio-demo.yaml

# remover istio
https://stackoverflow.com/questions/54261468/uninstall-istio-all-components-completely-from-kubernetes-cluster

kubectl delete namespace istio-system 
istioctl x uninstall --purge

