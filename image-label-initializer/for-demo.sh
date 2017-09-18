kubectl create clusterrolebinding initializer-admin --clusterrole=cluster-admin --serviceaccount=default:default
kubectl delete deployment --all
kubectl delete pods --all
kubectl delete initializerconfiguration --all


#starts
kubectl get pods
kubectl get initializerconfiguration

cat initializer-deployment.yaml
kubectl create -f initializer-deployment.yaml
kubectl get pods
kubectl log ?

cat initializerconfiguration.yaml
kubectl create -f initializerconfiguration.yaml --validate=false

cat redis-master.yaml
kubectl create -f redis-master.yaml --request-timeout=1

kubectl get pod

kubectl get pod redis-master -o yaml | head -n 12

kubectl get pod --include-uninitialized

kubectl get pod redis-master -o yaml | head
