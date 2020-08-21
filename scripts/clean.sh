#!/bin/sh
docker stop kind-registry
kind delete cluster --name="${KIND_CLUSTER_NAME:-kind-cassandra}"
kind delete cluster --name=kind-registry
docker rm kind-registry
