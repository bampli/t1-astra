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