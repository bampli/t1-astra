#!/bin/bash -e

# Kubernetes dashboard v2.0.0-rc5 released 7 feb 2020
DASHBOARD="https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml"

#export MSYS_NO_PATHCONV=1
#export MSYS_NO_PATHCONV=0

# --------------------------------------------------------
# Dashboard
# --------------------------------------------------------
kubectl create -f $DASHBOARD

cat <<EOF > dashboard.admin-user.yml 
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
EOF

cat <<EOF > dashboard.admin-user-role.yml 
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF

kubectl create -f dashboard.admin-user.yml -f dashboard.admin-user-role.yml
kubectl -n kubernetes-dashboard describe secret admin-user-token | grep ^token

# Dashboard available at:
# http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
