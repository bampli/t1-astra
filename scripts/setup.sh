#!/bin/sh
# Adapted from:
# https://github.com/tilt-dev/kind-local/blob/master/kind-with-registry.sh

# Copyright 2020 The Kubernetes Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Windows10: Setting MSYS_NO_PATHCONV to avoid bash error
# https://forums.docker.com/t/weird-error-under-git-bash-msys-solved/9210
export MSYS_NO_PATHCONV=1

set -o errexit

# desired cluster name - default "kind-cassandra"
KIND_CLUSTER_NAME="${KIND_CLUSTER_NAME:-kind-cassandra}"

kind_version=$(kind version)
kind_network='kind'
reg_name='kind-registry'
reg_port='5000'
case "${kind_version}" in
  "kind v0.7."* | "kind v0.6."* | "kind v0.5."*)
    kind_network='bridge'
    ;;
esac

# create registry container unless it already exists
running="$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)"
if [ "${running}" != 'true' ]; then
  docker run \
    -d --restart=always -p "${reg_port}:5000" --name "${reg_name}" \
    registry:2
fi

reg_host="${reg_name}"
if [ "${kind_network}" = "bridge" ]; then
    reg_host="$(docker inspect -f '{{.NetworkSettings.IPAddress}}' "${reg_name}")"
fi
echo "Registry Host: ${reg_host}"

# create a cluster with the local registry enabled in containerd
cat <<EOF | kind create cluster --name "${KIND_CLUSTER_NAME}" --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  apiServerPort: 45451
nodes:
- role: control-plane
- role: worker
- role: worker
- role: worker
containerdConfigPatches:
- |-
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."localhost:${reg_port}"]
    endpoint = ["http://${reg_host}:${reg_port}"]
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: local-registry-hosting
  namespace: kube-public
data:
  localRegistryHosting.v1: |
    host: "localhost:${reg_port}"
    help: "https://kind.sigs.k8s.io/docs/user/local-registry/"
EOF

if [ "${kind_network}" != "bridge" ]; then
  containers=$(docker network inspect ${kind_network} -f "{{range .Containers}}{{.Name}} {{end}}")
  needs_connect="true"
  for c in $containers; do
    if [ "$c" = "${reg_name}" ]; then
      needs_connect="false"
    fi
  done
  if [ "${needs_connect}" = "true" ]; then               
    docker network connect "${kind_network}" "${reg_name}" || true
  fi
fi

# Load DataStax Cassandra setup
# https://github.com/DataStax-Academy/cassandra-workshop-series/tree/master/week6-App-in-k8s

kubectl cluster-info --context kind-kind-cassandra
kubectl create ns cass-operator
kubectl -n cass-operator apply -f kube/02-storageclass-kind.yaml
kubectl -n cass-operator apply -f kube/03-install-cass-operator-v1.3.yaml
sleep 5
kubectl -n cass-operator apply -f kube/04-cassandra-cluster-1nodes.yaml

# Add secret password to configMap (TODO: should wait cluster finish setup. For now, do it manually, using scripts/setup-configMap.sh)
# PASS=$(echo $(kubectl get secret cluster1-superuser -n cass-operator -o yaml | grep -m1 -Po 'password: \K.*') | base64 -d && echo "")
# cat kube/05-configMap.yaml | sed "s/superuserpassword/$PASS/" - > configMap.yaml

# You should be able to push an image to local registry
# docker tag alpine localhost:5000/alpine
# docker push localhost:5000/alpine
