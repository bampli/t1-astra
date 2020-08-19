# t1-astra

### DataStax Cassandra cluster development with Kind & Tilt

This is a fork from the original DataStax Series workshop, reorganized to work with Kind, Tilt, and a local registry. This automation for the workshop's demo app expects to help developers with a starter for new projects.

Still a work in progress, some infrastructure is being included, like the Kubernetes dashboard. The idea is to build applications that use microservices to cooperatively access Cassandra databases with both CQL and graph codes.

## Kind & Tilt launch infrastructure

Prerequisites:
- Docker
- Kind
- Tilt

### Cluster with Cassandra

- Create local registry at localhost:5000
- Create and launch Cassandra operator v1.3
- Create configMap with secret password
- Apps apply configMap before running
- Setup for VS Code Python debugger
- Python code changes go directly to cluster container
- Check Tiltfile for Kubernetes setup

### Get started

```console

# cleaning
scripts/prune.sh

# start the fun
scripts/setup.sh
scripts/setup-configMap.sh
scripts/setup-dashBoard.sh

kubectl get pods --all-namespaces
NAMESPACE              NAME                                                   READY   STATUS    RESTARTS   AGE
cass-operator          cass-operator-56fcb9ff47-l6scr                         1/1     Running   8          2d
cass-operator          cluster1-dc1-default-sts-0                             1/2     Running   0          7h40m
default                astra-backend                                          1/1     Running   0          61m
kube-system            coredns-66bff467f8-9bmdn                               1/1     Running   4          2d
kube-system            coredns-66bff467f8-crxtb                               1/1     Running   4          2d
kube-system            etcd-kind-cassandra-control-plane                      1/1     Running   0          7h51m
kube-system            kindnet-8fjvq                                          1/1     Running   7          2d
kube-system            kindnet-q4d8k                                          1/1     Running   8          2d
kube-system            kindnet-rk6ch                                          1/1     Running   5          2d
kube-system            kindnet-tx8hw                                          1/1     Running   7          2d
kube-system            kube-apiserver-kind-cassandra-control-plane            1/1     Running   0          7h51m
kube-system            kube-controller-manager-kind-cassandra-control-plane   1/1     Running   4          2d
kube-system            kube-proxy-fv62w                                       1/1     Running   4          2d
kube-system            kube-proxy-h6d6p                                       1/1     Running   4          2d
kube-system            kube-proxy-jcv8g                                       1/1     Running   4          2d
kube-system            kube-proxy-vl7st                                       1/1     Running   4          2d
kube-system            kube-scheduler-kind-cassandra-control-plane            1/1     Running   4          2d
kubernetes-dashboard   dashboard-metrics-scraper-6b4884c9d5-z9nd4             1/1     Running   4          2d
kubernetes-dashboard   kubernetes-dashboard-7b544877d5-fz245                  1/1     Running   7          2d
local-path-storage     local-path-provisioner-bd4bb6b75-jcc9v                 1/1     Running   8          2d

# develop apps
tilt up

```

![image](https://user-images.githubusercontent.com/86032/90684134-0fd9c080-e23e-11ea-88f6-5a886a2e7e8c.png)

### Kubernetes Dashboard

Available at:
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

Authenticate with Token provided by following command:

```console

kubectl -n kubernetes-dashboard describe secret admin-user-token | grep ^token

```
### DataStax README

Follow the original [README](DataStax_README.md).