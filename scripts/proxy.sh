#!/bin/sh
export PROMETHEUS_POD_NAME=$(kubectl get pods --namespace prometheus -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
export STUDIO_POD_NAME=$(kubectl get pods --namespace studio -l "app=studio-lb" -o jsonpath="{.items[0].metadata.name}")

# Proxies for Kubernetes dashboard, prometheus and dse-studio
kubectl proxy &
kubectl --namespace prometheus port-forward $PROMETHEUS_POD_NAME 9090 &
kubectl --namespace studio port-forward $STUDIO_POD_NAME 9091

# Tilt takes care of this
# kubectl -n my-app port-forward --address 0.0.0.0 pod/astra-backend 9090 &
# kubectl -n my-app port-forward --address 0.0.0.0 pod/astra-ui 3000 &