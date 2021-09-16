# oracle13thsept2021

## training plan 

<img src="plan.png">

##  day3 revision 

<img src="rev.png">

## cleaning up namespace pods 

```
 fire@ashutoshhs-MacBook-Air  ~  kubectl  config get-contexts 
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   ashu-space
 fire@ashutoshhs-MacBook-Air  ~  kubectl  get  po 
NAME         READY   STATUS    RESTARTS   AGE
ashupod2     1/1     Running   0          18h
ashuwebpod   1/1     Running   0          18h
 fire@ashutoshhs-MacBook-Air  ~  kubectl  delete  pods --all
pod "ashupod2" deleted
pod "ashuwebpod" deleted

```


## K8s Pod Networking 

### list of CNI 

[CNI URL](https://github.com/containernetworking/cni)

### POd networking L1

<img src="podnet1.png">

### deploying pod with ENV var 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  run  ashuapp3  --image=dockerashu/httpd:orweb14sept2021  --port 80  --dry-run=client -o yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: ashuapp3
  name: ashuapp3
spec:
  containers:
  - image: dockerashu/httpd:orweb14sept2021
    name: ashuapp3
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  run  ashuapp3  --image=dockerashu/httpd:orweb14sept2021  --port 80  --dry-run=client -o yaml  >ashuapp3.yaml 
 
 ```
 
 ### Deploying pod 
 
 ```
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  apply -f  ashuapp3.yaml 
pod/ashuapp3 created
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  po 
NAME       READY   STATUS    RESTARTS   AGE
ashuapp3   1/1     Running   0          8s
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  po  -o wide
NAME       READY   STATUS    RESTARTS   AGE   IP                NODE      NOMINATED NODE   READINESS GATES
ashuapp3   1/1     Running   0          14s   192.168.179.230   minion2   <none>           <none>
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  
 
```

## access pod app 

### case 1 from k8s client machine 
```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  port-forward   ashuapp3  1234:80 
Forwarding from 127.0.0.1:1234 -> 80
Forwarding from [::1]:1234 -> 80
Handling connection for 1234
Handling connection for 1234
Handling connection for 1234
Handling connection for 1234
Handling connection for 1234
Handling connection for 1234
Handling connection for 1234

```

### case 2 as end user 

### Understanding and creating service 

<img src="svc.png">

### service can not use ip or name of pod to forward traffic 

<img src="svc2.png">

### service will use label to find pod 

<img src="svc3.png">

## type of service 


<img src="stype.png">

## Nodeport 

<img src="np.png">

### checking label of POd

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  po  --show-labels 
NAME       READY   STATUS    RESTARTS   AGE   LABELS
ashuapp3   1/1     Running   0          42m   x=helloashuapp3

```

### Nodeport creation of service 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  create   service  
Create a service using specified subcommand.

Aliases:
service, svc

Available Commands:
  clusterip    Create a ClusterIP service.
  externalname Create an ExternalName service.
  loadbalancer Create a LoadBalancer service.
  nodeport     Create a NodePort service.

Usage:


===


```

### creating service 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  create   service   nodeport  ashusvc1  --tcp  1234:80  --dry-run=client  -o yaml 
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: ashusvc1
  name: ashusvc1
spec:
  ports:
  - name: 1234-80
    port: 1234
    protocol: TCP
    targetPort: 80
  selector:
    app: ashusvc1
  type: NodePort
status:
  loadBalancer: {}
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  create   service   nodeport  ashusvc1  --tcp  1234:80  --dry-run=client  -o yaml   >ashusvc1.yaml 
 
 ```
 
 ### matching label of POD to service selector 
 
 <img src="sel.png">
 
 ### deploy service
 
 ```
  fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  apply -f  ashusvc1.yaml 
service/ashusvc1 created
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  service
NAME       TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
ashusvc1   NodePort   10.104.0.62   <none>        1234:32468/TCP   8s
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  svc    
NAME       TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
ashusvc1   NodePort   10.104.0.62   <none>        1234:32468/TCP   12s

```

## cleaning up namespace 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  all
NAME           READY   STATUS    RESTARTS   AGE
pod/ashuapp3   1/1     Running   0          95m

NAME               TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
service/ashusvc1   NodePort   10.104.0.62   <none>        1234:32468/TCP   43m
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  delete  all --all
pod "ashuapp3" deleted
service "ashusvc1" deleted

```



## Intro to Replication controller 

<img src="rc.png">

### creating RC

```
replicationcontroller/ashurc-123 created (dry run)
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl apply -f  ashurc1.yaml                replicationcontroller/ashurc-123 created
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  rc
NAME         DESIRED   CURRENT   READY   AGE
ashurc-123   1         1         1       8s
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  po
NAME               READY   STATUS    RESTARTS   AGE
ashurc-123-x59qf   1/1     Running   0          16s

```

### scaling Pod 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  scale  rc ashurc-123  --replicas=3
replicationcontroller/ashurc-123 scaled
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  po 
NAME                   READY   STATUS    RESTARTS   AGE
ashurc-123-4xgll       0/1     Pending   0          5s
ashurc-123-9rzll       0/1     Pending   0          5s
ashurc-123-bj82w       1/1     Running   0          5m33s

```

### Journey from RC to RS to Deployement 

<img src="dep.png">

### Demo of deployment with OCR 

<img src="ocr.png">

### Building tomcat app image 

```
 fire@ashutoshhs-MacBook-Air  ~  docker  build -t  ashujava:webappv1  https://github.com/redashu/javawebapp.git  
[+] Building 53.7s (3/8)                                                                                                       
 => CACHED [internal] load git source https://github.com/redashu/javawebapp.git                                           0.0s
 => [internal] load metadata for docker.io/library/tomcat:latest                                                          4.3s
 => [auth] library/tomcat:pull token for registry-1.docker.io                                                             0.0s
 => [1/5] FROM docker.io/library/tomcat@sha256:54876d82d30746c5b625a784938864d5b726219e0aace09b3e57ef4dfa85d594          49.4s
 => => resolve docker.io/library/tomcat@sha256:54876d82d30746c5b625a784938864d5b726219e0aace09b3e57ef4dfa85d594           0.0s
 => => sha256:54876d82d30746c5b625a784938864d5b726219e0aace09b3e57ef4dfa85d594 549B / 549B                                0.0s
 => => sha256:709c112a87273828f4df9caa99540a1d4f59891455cdfff7ec0ec99edc49f59b 2.42kB / 2.42kB                            0.0s
 => => sha256:955615a668ce
```


### pushing image to OCR 

```
4235 docker  tag  462a7d9a5f01   phx.ocir.io/axmbtg8judkl/javawebapp:v1 
 4236  docker  images
 4237  docker  login  phx.ocir.io  
 4238  docker  logout  phx.ocir.io  
 4239  docker  login  phx.ocir.io  
 fire@ashutoshhs-MacBook-Air  ~  docker push  phx.ocir.io/axmbtg8judkl/javawebapp:v1                 
The push refers to repository [phx.ocir.io/axmbtg8judkl/javawebapp]
387bab7ff1dd: Pushed 
5f70bf18a086: Pushed 
8b22855c0159: Pushed 
4831bcd1167f: Pushed 
977cfcbcf0fa: Pushing [======================>                            ]  8.926MB/20.16MB
4e4de253c94d: Pushed 
3891808a925b: Pushing [=>                                                 ]  13.22MB/342.7MB
d402f4f1b906: Pushed 
00ef5416d927: Pushing [==============================>                    ]  6.847MB/11.31MB
8555e663f65b: Pushing [=======>                                           ]  21.43MB/151.9MB
d00da3cd7763: Pushing [======================>                            ]  8.527MB/18.95MB
4e61e63529c2: Waiting 
799760671c38: Waiting 

```
