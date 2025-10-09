#sync-karmada.sh
#!/bin/bash
# Karmada kubeconfig ���
KARMADA_KUBECONFIG=~/karmada/karmada-apiserver.config

# propagation policy ����
kubectl apply -f ../propagation-policies/ --kubeconfig=$KARMADA_KUBECONFIG

# ��ũ�ε� ���� (��: Deployment)
kubectl apply -f ../workloads/ --kubeconfig=$KARMADA_KUBECONFIG
