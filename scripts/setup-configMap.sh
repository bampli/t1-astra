#!/bin/sh
# Add secret password to configMap
PASS=$(echo $(kubectl get secret cluster1-superuser -n cass-operator -o yaml | grep -m1 -Po 'password: \K.*') | base64 -d && echo "")
cat kube/05-configMap.yaml | sed "s/superuserpassword/$PASS/" - > configMap.yaml
