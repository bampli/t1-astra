#!/bin/sh

# Add secret password to configMap
PASS=$(echo $(kubectl get secret cluster1-superuser -n cass-operator -o yaml | grep -m1 -Po 'password: \K.*') | base64 -d && echo "")
cat kube/05-configMap.yaml | sed "s/superuserpassword/$PASS/" - > configMap.yaml

# TODO: wait for cluster ready
# jo@CANOAS23 MINGW64 ~
# $ echo $CLUSTER_NAME
# kind-cassandra
#kind get kubeconfig --name "${CLUSTER_NAME}" --internal | sed "s/${CLUSTER_NAME}-control-plane/$(docker inspect "${CLUSTER_NAME}-control-plane" --format "{{ .NetworkSettings.Networks.kind.IPAddress }}")/g"
