# t1-astra

### DataStax Cassandra development with Kind & Tilt

This is a fork from the original DataStax Series workshop, reorganized to work with Kind, Tilt, and a local registry. This automation for the workshop's demo app expects to help developers with a starter for new projects.

Still a work in progress, some infrastructure is being included, like the Kubernetes dashboard and Prometheus. The idea is to build applications that use microservices to cooperatively access Cassandra databases with both CQL and graph codes.

## Kind & Tilt launch infrastructure

Prerequisites:
- Docker
- Kind
- Tilt
- Helm

### Cluster features

- Cassandra
- Kubernetes Dashboard
- Prometheus
- DSE Studio
- Kind with local registry at localhost:5000
- Ready for GKE with Cassandra operator v1.3
- Auto generate configMap with secret password
- Tilt apply configMap and Kubernetes setup
- Setup for VS Code Python debugger
- Code changes go directly to cluster container

## Get started

```console

# cleaning
scripts/prune.sh

# start the fun
scripts/setup.sh
scripts/setup-cassandra.sh
# wait pods initialization
scripts/setup-configMap.sh
scripts/setup-dashBoard.sh
scripts/setup-prometheus.sh
scripts/setup-studio.sh

# what you get
kubectl get pods --all-namespaces
NAMESPACE              NAME                                                   READY   STATUS    RESTARTS   AGE
cass-operator          cass-operator-56fcb9ff47-sh7zp                         1/1     Running   0          6h14m
cass-operator          cluster1-dc1-default-sts-0                             2/2     Running   0          6h14m
default                astra-backend                                          1/1     Running   0          6h7m
default                studio-lb-7fc88d786f-srp24                             1/1     Running   0          46m
kube-system            coredns-66bff467f8-6qwzl                               1/1     Running   0          6h20m
kube-system            coredns-66bff467f8-kdb5q                               1/1     Running   0          6h20m
kube-system            etcd-kind-cassandra-control-plane                      1/1     Running   0          6h21m
kube-system            kindnet-kgtdg                                          1/1     Running   1          6h20m
kube-system            kindnet-lhlc2                                          1/1     Running   0          6h20m
kube-system            kindnet-n7xg5                                          1/1     Running   0          6h20m
kube-system            kindnet-s56xx                                          1/1     Running   0          6h20m
kube-system            kube-apiserver-kind-cassandra-control-plane            1/1     Running   0          6h21m
kube-system            kube-controller-manager-kind-cassandra-control-plane   1/1     Running   0          6h21m
kube-system            kube-proxy-hhkpn                                       1/1     Running   0          6h20m
kube-system            kube-proxy-mlfqz                                       1/1     Running   0          6h20m
kube-system            kube-proxy-sn4wz                                       1/1     Running   0          6h20m
kube-system            kube-proxy-zsndl                                       1/1     Running   0          6h20m
kube-system            kube-scheduler-kind-cassandra-control-plane            1/1     Running   1          6h21m
kubernetes-dashboard   dashboard-metrics-scraper-6b4884c9d5-v56df             1/1     Running   0          6h10m
kubernetes-dashboard   kubernetes-dashboard-7b544877d5-hsrdp                  1/1     Running   0          6h10m
local-path-storage     local-path-provisioner-bd4bb6b75-vdf48                 1/1     Running   0          6h20m
prometheus             monitor-kube-state-metrics-d9d84b6b6-nq6k5             1/1     Running   0          6h10m
prometheus             monitor-prometheus-alertmanager-68fcd588b6-hqjbf       2/2     Running   0          6h10m
prometheus             monitor-prometheus-node-exporter-j52k8                 1/1     Running   0          6h10m
prometheus             monitor-prometheus-node-exporter-vwtqc                 1/1     Running   0          6h10m
prometheus             monitor-prometheus-node-exporter-xdcb5                 1/1     Running   0          6h10m
prometheus             monitor-prometheus-pushgateway-5c485f6f54-jzvtt        1/1     Running   0          6h10m
prometheus             monitor-prometheus-server-f8ddc97f-zg8jd               2/2     Running   0          6h10m
studio                 studio-lb-7fc88d786f-sqjv4                             1/1     Running   0          41m

# develop apps
tilt up

```
## Tilt 

![image](https://user-images.githubusercontent.com/86032/90684134-0fd9c080-e23e-11ea-88f6-5a886a2e7e8c.png)

## VS Code debugger

![image](https://user-images.githubusercontent.com/86032/90913177-40426b80-e3b2-11ea-9c9f-e3579f1141fd.png)

## Kubernetes Dashboard

Start a proxy:

```console

kubectl proxy

```

Get the token provided by the following command:

```console

kubectl -n kubernetes-dashboard describe secret admin-user-token | grep ^token

```

Open a browser and authenticate with token:

http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

![image](https://user-images.githubusercontent.com/86032/90908948-77f9e500-e3ab-11ea-9a26-dd9f6a47163d.png)

## Prometheus

Get the Prometheus server URL by running these commands in the same shell:

```console

export POD_NAME=$(kubectl get pods --namespace prometheus -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace prometheus port-forward $POD_NAME 9090

```

Open a browser:

http://localhost:9090/

![image](https://user-images.githubusercontent.com/86032/90909696-84327200-e3ac-11ea-9dda-5b657c74ce25.png)

## DSE Studio

Run these commands in the same shell

```console
export STUDIO_POD_NAME=$(kubectl get pods --namespace studio -l "app=studio-lb" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace studio port-forward $STUDIO_POD_NAME 9091

```

![image](https://user-images.githubusercontent.com/86032/90940482-50277300-e3e5-11ea-8361-cd7e82e12178.png)

## DataStax README

Follow the original [README](DataStax_README.md) for more details.