# oracle13thsept2021

## training plan 

<img src="plan.png">

## Revision of 2 days 

<img src="rev.png">

## Intro to docker. compose 

<img src="compose.png">

## more about docker compose 

<img src="compose1.png">

## Installing docker-compose on CLient side 

[Install](https://docs.docker.com/compose/install/)

### checking installation 

```
[ashu@ip-172-31-5-127 myimages]$ docker-compose -v
docker-compose version 1.29.2, build 5becea4c

```

## Compose example 1 

```
[ashu@ip-172-31-5-127 myimages]$ ls
ashucompose  customer1  pythonapp  ubuntuimg  webapp
[ashu@ip-172-31-5-127 myimages]$ cd  ashucompose/
[ashu@ip-172-31-5-127 ashucompose]$ ls
docker-compose.yaml
[ashu@ip-172-31-5-127 ashucompose]$ docker-compose up  -d  
Creating network "ashucompose_default" with the default driver
Pulling ashuapp1 (alpine:)...
latest: Pulling from library/alpine
a0d0a0d46f8b: Downloading [>                                                  ]   41.3kB/2.814Ma0d0a0d46f8b: Pull complete
Digest: sha256:e1c082e3d3c45cccac829840a25941e679c25d438cc8412c2fa221cf1a824e6a
Status: Downloaded newer image for alpine:latest
Creating ashuc1 ... done

```

### more compose operations 

```
[ashu@ip-172-31-5-127 ashucompose]$ docker-compose ps 
 Name      Command     State   Ports
------------------------------------
ashuc1   ping fb.com   Up      

```

### 

```
[ashu@ip-172-31-5-127 ashucompose]$ docker-compose  stop 
Stopping ashuc1 ... done
[ashu@ip-172-31-5-127 ashucompose]$ docker-compose  ps
 Name      Command      State     Ports
---------------------------------------
ashuc1   ping fb.com   Exit 137        
[ashu@ip-172-31-5-127 ashucompose]$ docker-compose  start
Starting ashuapp1 ... done
[ashu@ip-172-31-5-127 ashucompose]$ docker-compose  ps
 Name      Command     State   Ports
------------------------------------
ashuc1   ping fb.com   Up           
[ashu@ip-172-31-5-127 ashucompose]$ docker-compose  kill
Killing ashuc1 ... done
[ashu@ip-172-31-5-127 ashucompose]$ docker-compose  start
Starting ashuapp1 ... done

```

### removing all 

```
[ashu@ip-172-31-5-127 ashucompose]$ docker-compose down 
Stopping ashuc1 ... done
Removing ashuc1 ... done
Removing network ashucompose_default

```

### Compsoe with diff file name 

```
351  docker-compose -f  two-container.yaml up -d
  352  docker-compose -f  two-container.yaml ps
  353  docker-compose -f  two-container.yaml stop
  354  docker-compose -f  two-container.yaml  down
  355  history 
  
```

### build docker. image everytime 

```
docker-compose -f  imagebuild.yaml  up -d --build 

```

## Problem with Container Engine 

<img src="prob.png">

## kubernetes as container orchestration engine 

<img src="carch.png">

### k8s arch 

### Level 1 

<img src="l1.png">

##  kube-apiserver 

<img src="api.png">

### kube-schedular. 

<img src="sch.png">

### etcd 

<img src="etcd.png">

### kube-controller-manager

<img src="kcm.png">

### setting up cluster with minikube on local laptop 

<img src="minikube.png">

### Minikube version 

```
❯ minikube  version
minikube version: v1.22.0
commit: a03fbcf166e6f74ef224d4a63be4277d017bb62e

```

### cluster done 

```
❯ minikube  version
minikube version: v1.22.0
commit: a03fbcf166e6f74ef224d4a63be4277d017bb62e
❯ minikube  start  --driver=docker
😄  minikube v1.22.0 on Darwin 11.4
🎉  minikube 1.23.0 is available! Download it: https://github.com/kubernetes/minikube/releases/tag/v1.23.0
💡  To disable this notice, run: 'minikube config set WantUpdateNotification false'

✨  Using the docker driver based on user configuration
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
🔥  Creating docker container (CPUs=2, Memory=1988MB) ...
🐳  Preparing Kubernetes v1.21.2 on Docker 20.10.7 ...
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: storage-provisioner, default-storageclass
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default


```

### checking cluster 

```
❯ minikube  status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured

```

### connecting k8s cluster using client software called kubectl 

```
❯ kubectl   get  nodes
NAME       STATUS   ROLES                  AGE    VERSION
minikube   Ready    control-plane,master   8m6s   v1.21.2

```

### minikube stop 

```
❯ minikube stop
✋  Stopping node "minikube"  ...
🛑  Powering off "minikube" via SSH ...
🛑  1 nodes stopped.
❯ 
❯ kubectl   get  nodes
The connection to the server localhost:8080 was refused - did you specify the right host or port?

```

### on k8s master side there is an authentication file 

```
[root@masternode ~]# cd /etc/kubernetes/
[root@masternode kubernetes]# ls
admin.conf 

```


### sharing file to k8s clients

### connecting  cluster

```
kubectl   get   nodes  --kubeconfig  admin.conf
NAME         STATUS   ROLES                  AGE     VERSION
masternode   Ready    control-plane,master   4h20m   v1.22.1
minion1      Ready    <none>                 4h20m   v1.22.1
minion2      Ready    <none>                 4h20m   v1.22.1

```

### more client commands 

```
❯ kubectl  cluster-info
Kubernetes control plane is running at https://52.0.159.165:6443
CoreDNS is running at https://52.0.159.165:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

```



