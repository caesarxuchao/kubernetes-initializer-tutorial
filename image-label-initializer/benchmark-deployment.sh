set -o errexit
set -o nounset
set -o pipefail

NUM=10

kubectl config use-context gke_chao1-149704_us-central1-a_initializer-benchmark-2
kubectl delete deployment --all
kubectl delete initializerconfiguration --all

cp deployment.local.yaml deployment.yaml
for i in $(seq 1 $NUM); do
echo "        - name: noop-initializer-$i
          image: gcr.io/chao1-149704/noop-initializer:0.0.1
          imagePullPolicy: Always
          env:
          - name: \"INITIALIZER_NAME\"
            value: \"initializer.benchmark.io.$i\"" >> deployment.yaml
done

kubectl create -f deployment.yaml


cp initializerconfiguration.local.yaml initializerconfiguration.yaml
for i in $(seq 1 $NUM); do
echo "  - name: initializer.benchmark.io.$i
    rules:
      - apiGroups:
          - ""
        apiVersions:
          - "v1"
        resources:
          - pods" >> initializerconfiguration.yaml
done
exit 0
kubectl create -f initializerconfiguration.yaml --validate=false
