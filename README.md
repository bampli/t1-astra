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
scripts/setup-configMap.sh
scripts/setup-dashBoard.sh
scripts/setup-prometheus.sh

# what you get
kubectl get pods --all-namespaces
NAMESPACE              NAME                                                   READY   STATUS    RESTARTS   AGE
cass-operator          cass-operator-56fcb9ff47-jbvgq                         1/1     Running   0          11m
cass-operator          cluster1-dc1-default-sts-0                             2/2     Running   0          11m
kube-system            coredns-66bff467f8-jcljk                               1/1     Running   0          15m
kube-system            coredns-66bff467f8-m5f6v                               1/1     Running   0          15m
kube-system            etcd-kind-cassandra-control-plane                      1/1     Running   0          15m
kube-system            kindnet-47gdg                                          1/1     Running   0          15m
kube-system            kindnet-l4drp                                          1/1     Running   0          15m
kube-system            kindnet-q7twg                                          1/1     Running   0          15m
kube-system            kindnet-sjdql                                          1/1     Running   1          15m
kube-system            kube-apiserver-kind-cassandra-control-plane            1/1     Running   0          15m
kube-system            kube-controller-manager-kind-cassandra-control-plane   1/1     Running   1          15m
kube-system            kube-proxy-2npdg                                       1/1     Running   0          15m
kube-system            kube-proxy-2qn56                                       1/1     Running   0          15m
kube-system            kube-proxy-snscn                                       1/1     Running   0          15m
kube-system            kube-proxy-szg9r                                       1/1     Running   0          15m
kube-system            kube-scheduler-kind-cassandra-control-plane            1/1     Running   1          15m
kubernetes-dashboard   dashboard-metrics-scraper-6b4884c9d5-bdb98             1/1     Running   0          9m7s
kubernetes-dashboard   kubernetes-dashboard-7b544877d5-4tl6d                  1/1     Running   0          9m7s
local-path-storage     local-path-provisioner-bd4bb6b75-dgbbm                 1/1     Running   0          15m
prometheus             monitor-kube-state-metrics-d9d84b6b6-854s6             1/1     Running   0          7m35s
prometheus             monitor-prometheus-alertmanager-68fcd588b6-qbvt9       2/2     Running   0          7m35s
prometheus             monitor-prometheus-node-exporter-cng92                 1/1     Running   0          7m35s
prometheus             monitor-prometheus-node-exporter-cr6jw                 1/1     Running   0          7m35s
prometheus             monitor-prometheus-node-exporter-ps2lc                 1/1     Running   0          7m35s
prometheus             monitor-prometheus-pushgateway-5c485f6f54-jx2m9        1/1     Running   0          7m35s
prometheus             monitor-prometheus-server-f8ddc97f-fjr7q               2/2     Running   0          7m35s

# develop apps
tilt up

```

![image](https://user-images.githubusercontent.com/86032/90684134-0fd9c080-e23e-11ea-88f6-5a886a2e7e8c.png)

## VS Code debugger

![image](https://user-images.githubusercontent.com/86032/90907396-4bdd6480-e3a9-11ea-9821-b50277d15c5b.png)

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

## DataStax README

Follow the original [README](DataStax_README.md) for more details.