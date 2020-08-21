#!/bin/bash -e
# --------------------------------------------------------
# Prometheus
# --------------------------------------------------------
# It is necessary to add stable helm repo before:
# helm repo add stable https://kubernetes-charts.storage.googleapis.com/
#
kubectl create ns prometheus

helm -n prometheus install monitor stable/prometheus

# Add ingress
cat << EOF | kubectl -n prometheus apply -f -
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: monitor-prometheus-ingress
  annotations:
    kubernetes.io/ingress.class: "traefik"
spec:
  rules:
  - http:
      paths:
      - path: /
        backend:
          serviceName: monitor-prometheus-server
          servicePort: 80
EOF
