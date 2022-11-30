# Confluent Support Container
---
A Docker Container that can be useful to perform basic troubleshooting actions for a deployed Confluent Platform in a Containerized Infrastructure.

## TODO
---
- [x] Create Dockerfile

## Deploy in Kubernetes
---
Deploy the pod using the following yaml
```
kind: Pod
apiVersion: v1
metadata:
  name: csc-tool
spec:
  containers:
    - name: csc-tool
      image: ghcr.io/huynconfluent/csc:dev
```
or
```
kubectl -n <namespace> apply -f examples/pod.yaml
```

## Deploy in docker
---
```
docker run -d ghcr.io/huynconfluent/csc:dev -n csc-tool
```