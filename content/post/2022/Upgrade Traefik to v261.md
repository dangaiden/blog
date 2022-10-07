## Apply the correct CRDs for 2.5 and 2.6 versions:

Great gist --> [Useful](https://gist.github.com/Startouf/bd961cee307a6ad93aba51f082f4b7f6)

Traefik CRDs reference: https://github.com/traefik/traefik/blob/v2.5/docs/content/reference/dynamic-configuration/kubernetes-crd.md

``` shell

 ~/Traefik_upgrade/backup_220222_2_5v  ./CRDs_2_5.sh                                                                                                                                                       ✔ │ 17:29:32
Warning: resource customresourcedefinitions/ingressroutes.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/ingressroutes.traefik.containo.us configured
Warning: resource customresourcedefinitions/ingressroutetcps.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/ingressroutetcps.traefik.containo.us configured
Warning: resource customresourcedefinitions/ingressrouteudps.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/ingressrouteudps.traefik.containo.us configured
Warning: resource customresourcedefinitions/middlewares.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/middlewares.traefik.containo.us configured
Warning: resource customresourcedefinitions/middlewaretcps.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/middlewaretcps.traefik.containo.us configured
Warning: resource customresourcedefinitions/serverstransports.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/serverstransports.traefik.containo.us configured
Warning: resource customresourcedefinitions/tlsoptions.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/tlsoptions.traefik.containo.us configured
Warning: resource customresourcedefinitions/tlsstores.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/tlsstores.traefik.containo.us configured
Warning: resource customresourcedefinitions/traefikservices.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/traefikservices.traefik.containo.us configured
clusterrole.rbac.authorization.k8s.io/traefik-ingress-controller created
clusterrolebinding.rbac.authorization.k8s.io/traefik-ingress-controller created

```

- Then immediately the changes for v.2.6

``` shell

~/Traefik_upgrade/backup_230222_2_6v  ./CRDs_2_6.sh                                                                                                                                                       ✔ │ 17:33:52
customresourcedefinition.apiextensions.k8s.io/ingressroutes.traefik.containo.us configured
customresourcedefinition.apiextensions.k8s.io/ingressroutetcps.traefik.containo.us configured
customresourcedefinition.apiextensions.k8s.io/ingressrouteudps.traefik.containo.us configured
customresourcedefinition.apiextensions.k8s.io/middlewares.traefik.containo.us configured
customresourcedefinition.apiextensions.k8s.io/middlewaretcps.traefik.containo.us configured
customresourcedefinition.apiextensions.k8s.io/serverstransports.traefik.containo.us configured
customresourcedefinition.apiextensions.k8s.io/tlsoptions.traefik.containo.us configured
customresourcedefinition.apiextensions.k8s.io/tlsstores.traefik.containo.us configured
customresourcedefinition.apiextensions.k8s.io/traefikservices.traefik.containo.us configured
clusterrole.rbac.authorization.k8s.io/traefik-ingress-controller unchanged
clusterrolebinding.rbac.authorization.k8s.io/traefik-ingress-controller unchanged

```


## Now let's install a new release of Traefik in parallel

``` shell

 ~/K/paysite-systems/k/p/n/d/traefik2-frontend │ SYS-1628/Traefikv2_upgrade  date;helm install traefik2 -f values.yaml traefik/traefik --version 10.16.0 --debug
Thu Apr 21 17:37:41 CEST 2022
install.go:178: [debug] Original chart version: "10.16.0"
install.go:199: [debug] CHART PATH: /Users/dba7x/Library/Caches/helm/repository/traefik-10.16.0.tgz

client.go:128: [debug] creating 1 resource(s)
install.go:151: [debug] CRD ingressroutes.traefik.containo.us is already present. Skipping.
client.go:128: [debug] creating 1 resource(s)
install.go:151: [debug] CRD ingressroutetcps.traefik.containo.us is already present. Skipping.
client.go:128: [debug] creating 1 resource(s)
install.go:151: [debug] CRD ingressrouteudps.traefik.containo.us is already present. Skipping.
client.go:128: [debug] creating 1 resource(s)
install.go:151: [debug] CRD middlewares.traefik.containo.us is already present. Skipping.
client.go:128: [debug] creating 1 resource(s)
install.go:151: [debug] CRD middlewaretcps.traefik.containo.us is already present. Skipping.
client.go:128: [debug] creating 1 resource(s)
install.go:151: [debug] CRD serverstransports.traefik.containo.us is already present. Skipping.
client.go:128: [debug] creating 1 resource(s)
install.go:151: [debug] CRD tlsoptions.traefik.containo.us is already present. Skipping.
client.go:128: [debug] creating 1 resource(s)
install.go:151: [debug] CRD tlsstores.traefik.containo.us is already present. Skipping.
client.go:128: [debug] creating 1 resource(s)
install.go:151: [debug] CRD traefikservices.traefik.containo.us is already present. Skipping.
client.go:128: [debug] creating 6 resource(s)
client.go:299: [debug] Starting delete for "traefik2-dashboard" IngressRoute
client.go:328: [debug] ingressroutes.traefik.containo.us "traefik2-dashboard" not found
client.go:128: [debug] creating 1 resource(s)
NAME: traefik2
LAST DEPLOYED: Thu Apr 21 17:37:47 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
```


- The new LB has been created: 

![[Pasted image 20220421174244.png]]

Proceed to check which Public IPs are using the new LB as we'll use it later:

``` shell

 ~/Kodify/paysite-systems/kubernetes/prod/namespace/default/traefik2-frontend │ SYS-1628/Traefikv2_upgrade  dig +short aee7021d96f3f4e30ad2d12442baff49-641409121.us-east-1.elb.amazonaws.com                                                                             INT ✘ │ 17:45:18
52.200.222.41
34.230.158.253
35.169.146.177

```

- Now I will tweak my hosts file to see if I can reach some endpoints (ingresses) and check with cURL:

```
curl -Isv https://vixen.com                                                              ✔ │ 18:02:47
*   Trying 52.200.222.41:443...
* Connected to vixen.com (52.200.222.41) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*  CAfile: /etc/ssl/cert.pem
*  CApath: none
* (304) (OUT), TLS handshake, Client hello (1):
* LibreSSL SSL_connect: SSL_ERROR_SYSCALL in connection to vixen.com:443
* Closing connection 0
```



