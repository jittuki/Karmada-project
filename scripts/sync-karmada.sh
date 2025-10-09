#sync-karmada.sh
#!/bin/bash
# Karmada kubeconfig 경로
KARMADA_KUBECONFIG=~/karmada/karmada-apiserver.config

# propagation policy 적용
kubectl apply -f ../propagation-policies/ --kubeconfig=$KARMADA_KUBECONFIG

# 워크로드 적용 (예: Deployment)
kubectl apply -f ../workloads/ --kubeconfig=$KARMADA_KUBECONFIG
