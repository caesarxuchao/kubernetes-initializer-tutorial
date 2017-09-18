set -o errexit
set -o nounset
set -o pipefail

NUM=10

kubectl config use-context local
kubectl delete deployment --all
kubectl delete initializerconfiguration --all

kubectl create clusterrolebinding initializer-admin --clusterrole=cluster-admin --serviceaccount=default:default

cp deployment.local.yaml deployment.yaml
echo "        - name: noop-initializer
          image: gcr.io/chao1-149704/noop-initializer:0.0.1
          imagePullPolicy: Never
          env:
          - name: \"INITIALIZER_NAME\"
            value: \"imagelabel.demo.io\"" >> deployment.yaml

kubectl create -f deployment.yaml


cp initializerconfiguration.local.yaml initializerconfiguration.yaml
echo "  - name: imagelabel.demo.io
    rules:
      - apiGroups:
          - ""
        apiVersions:
          - "v1"
        resources:
          - pods" >> initializerconfiguration.yaml
exit 0
kubectl create -f initializerconfiguration.yaml --validate=false
