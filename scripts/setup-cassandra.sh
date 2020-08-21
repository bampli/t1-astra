#!/bin/sh
# DataStax Cassandra setup
# https://github.com/DataStax-Academy/cassandra-workshop-series/tree/master/week6-App-in-k8s

kubectl cluster-info --context kind-kind-cassandra
kubectl create ns cass-operator
kubectl -n cass-operator apply -f kube/02-storageclass-kind.yaml
kubectl -n cass-operator apply -f kube/03-install-cass-operator-v1.3.yaml
sleep 5
kubectl -n cass-operator apply -f kube/04-cassandra-cluster-1nodes.yaml
