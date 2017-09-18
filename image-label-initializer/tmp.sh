for i in $(seq 101 500); do
cat /google/data/rw/users/mm/mml/k8/big-configmap.yaml | sed "s/NUMERO/$i/g" | kubectl create --validate=false -f -
done
