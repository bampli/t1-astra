#!/bin/sh

#kubectl delete ns cass-operator
docker stop kind-registry
kind delete cluster --name=kind-cassandra
kind delete cluster --name=kind-registry
docker rm kind-registry
