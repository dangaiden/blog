
Traefik currently seats on a custom version owned by us but the patch was merged into the upstream repository and needs to be back to the main docker image along with the upgrade to > 2.5

# Steps

1.  Check 2.4 and 2.5 releases for breaking changes

Reference: [https://doc.traefik.io/traefik/migration/v2/#v23-to-v24](https://doc.traefik.io/traefik/migration/v2/#v23-to-v24)
Reference: [https://doc.traefik.io/traefik/migration/v2/#v24-to-v25](https://doc.traefik.io/traefik/v2.4/migration/v2/#v23-to-v24)

- [x] ServersTransport -> Update RBAC and CRD (To check in Helm chart for 2.4)
This is done by the chart as it updates everything needed.

- [x] K8S CrossNamespace
- [x] K8S ExternalName Service

Defined in the values.yaml which will be applied for the upgrade:

![[Pasted image 20220127095012.png]]

- [x] Non-ASCII Domain Names
- [x] Update RBAC and CRD definitions.
- [x] Headers middleware: ssl redirect options & accessControlAllowOrigin
- [x] X.509 CommonName
- [x] API version: The extensions/v1beta1 API Version should now be replaced either by networking.k8s.io/v1beta1 or by networking.k8s.io/v1 (as of Kubernetes v1.19+)

Paysites (prod and staging)

```                                                                   fallback
Current: helm.sh/chart=traefik-9.13.0 
Containers:
   traefik2-frontend:
    Image:       javipolo/traefik:2.3.3-router-metrics

We need to put: traefik v2.5.6

❯ helm search repo traefik -l | grep -i 2.5.6
traefik/traefik         	10.9.1       	2.5.6      	A Traefik based Kubernetes ingress controller
```


2.  Check helm chart releases for breaking changes

https://wiki.cac.washington.edu/display/MCI/Ingress+Resource+Changes+Kubernetes+1.19+through+1.21 

https://kubernetes.io/docs/reference/using-api/deprecation-guide/

Changes in Ingress apiVersion make the object to be defined different:

##### Specific Changes to Ingress

-   _spec.backend_ is renamed to _spec.defaultBackend_
    
-   The backend _serviceName_ field is renamed to _service.name_
    
-   Numeric backend _servicePort_ fields are renamed to _service.port.number_
    
-   String backend _servicePort_ fields are renamed to _service.port.name_


> I changed different YAML manifests where the backend service had a different structure. For each project I changed all the manifests.

![[GH_changes_SYS-1556.png]]

5.  Upgrade tag in staging and deploy to paysites staging

- New parameters needed: 

![[Pasted image 20220127095012.png]]

& 

![[Pasted image 20220127094937.png]]


Latest 2.5.4 version in  is: 

``` bash
❯ helm search repo traefik -l | grep -i 2.5.6
traefik/traefik         	10.9.1       	2.5.6      	A Traefik based Kubernetes ingress controller
```


- Destination chart: ` > helm show values traefik/traefik --version 10.2.0`

Helm uses the app version as tag so the process to upgrade is:

```
helm upgrade -i traefik2 --namespace staging -f values.yaml traefik/traefik
```

> This installs the latest version from Traefik!

Where values.yaml is the file where we override for our own values.

```
helm upgrade -i traefik2 -n staging -f values.yaml traefik/traefik --version 10.9.1
```

Check the traefik dashboard (http://127.0.0.1:9000) to see the general status of Traefik objects:
``` bash
kubectl port-forward deployment/traefik2 -n staging 9000:9000
```

- Added new middleware within the same templates with <namespace>-<middleware-name>

Example

``` YAML
{{- $name := include "chart.name" . -}}
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
name: "whitelist-{{ $name }}"
spec:
ipWhiteList:
ipStrategy:
depth: {{ .Values.whitelist.depth }}
sourceRange:
{{- range .Values.whitelist.ips }}
- {{ . }}
{{- end }}
---
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
name: "{{ .Release.Namespace }}-whitelist-{{ $name }}"
spec:
ipWhiteList:
ipStrategy:
depth: {{ .Values.rssWhiteList.depth }}
sourceRange:
{{- range .Values.rssWhiteList.ips }}
- {{ . }}
{{- end }}
```


8. Deploy your new ingresses that are pointing to your new apiVersion **networking.k8s.io/v1** 

Once deployed, you probably can check that you haven't missed anything by doing something like.

``` shell # Be aware of the extensive output depending on how many
❯ k get ingress -o yaml -A | grep apiVersion: | more
apiVersion: v1
- apiVersion: networking.k8s.io/v1
- apiVersion: networking.k8s.io/v1
- apiVersion: networking.k8s.io/v1
- apiVersion: networking.k8s.io/v1
.
.
.
```

7. Upgrade CRDs manually!!!

How [snippets work](https://facelessuser.github.io/pymdown-extensions/extensions/snippets/)
Great gist --> [Useful](https://gist.github.com/Startouf/bd961cee307a6ad93aba51f082f4b7f6)

Traefik CRDs reference: https://github.com/traefik/traefik/blob/v2.5/docs/content/reference/dynamic-configuration/kubernetes-crd.md

CRDs to be updated, in particular [these definitions](https://github.com/traefik/traefik/blob/v2.5/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml)
and the [RBAC one](https://raw.githubusercontent.com/traefik/traefik/v2.5/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml)



- Check current CRDs from Traefik
```
❯ k get crd | grep traefik
ingressroutes.traefik.containo.us                    2020-10-16T13:49:48Z
ingressroutetcps.traefik.containo.us                 2020-10-16T13:49:48Z
ingressrouteudps.traefik.containo.us                 2020-10-16T13:49:48Z
middlewares.traefik.containo.us                      2020-10-16T13:49:48Z
tlsoptions.traefik.containo.us                       2020-10-16T13:49:48Z
tlsstores.traefik.containo.us                        2020-10-16T13:49:48Z
traefikservices.traefik.containo.us                  2020-10-16T13:49:48Z
```
- Exported Traefik CRDs

``` shell
k get crd -A | grep traefik | awk '{  print $1 }' | xargs -I % /bin/bash -c 'kubectl get crd % -o yaml > %.yaml'
```

- After being sure that I am in the correct context and those are the CRDs I want to apply

``` shell
❯ ./CRDs.sh
Warning: resource customresourcedefinitions/ingressroutes.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/ingressroutes.traefik.containo.us configured
Warning: resource customresourcedefinitions/ingressroutetcps.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/ingressroutetcps.traefik.containo.us configured
Warning: resource customresourcedefinitions/ingressrouteudps.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/ingressrouteudps.traefik.containo.us configured
Warning: resource customresourcedefinitions/middlewares.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/middlewares.traefik.containo.us configured
customresourcedefinition.apiextensions.k8s.io/middlewaretcps.traefik.containo.us created
customresourcedefinition.apiextensions.k8s.io/serverstransports.traefik.containo.us created
Warning: resource customresourcedefinitions/tlsoptions.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/tlsoptions.traefik.containo.us configured
Warning: resource customresourcedefinitions/tlsstores.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/tlsstores.traefik.containo.us configured
Warning: resource customresourcedefinitions/traefikservices.traefik.containo.us is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
customresourcedefinition.apiextensions.k8s.io/traefikservices.traefik.containo.us configured
clusterrole.rbac.authorization.k8s.io/traefik-ingress-controller created
clusterrolebinding.rbac.authorization.k8s.io/traefik-ingress-controller created
```
- After the CRDs are installed, I have a couple more:

```
❯ k get crd | grep traefik
ingressroutes.traefik.containo.us                    2020-10-16T13:49:48Z
ingressroutetcps.traefik.containo.us                 2020-10-16T13:49:48Z
ingressrouteudps.traefik.containo.us                 2020-10-16T13:49:48Z
middlewares.traefik.containo.us                      2020-10-16T13:49:48Z
middlewaretcps.traefik.containo.us                   2022-02-22T10:05:26Z
serverstransports.traefik.containo.us                2022-02-22T10:05:28Z
tlsoptions.traefik.containo.us                       2020-10-16T13:49:48Z
tlsstores.traefik.containo.us                        2020-10-16T13:49:48Z
traefikservices.traefik.containo.us                  2020-10-16T13:49:48Z
```

- Now applying the upgrade with Helm to v.2.5.6 (chart version is 10.9.1)

```
helm upgrade -i traefik2 -n staging -f values.yaml traefik/traefik --version 10.9.1
```

- After applying the upgrade, **all went well** although some redirections didn't work in the **staging** environment I applied it. Checked the logs and saw some middlewares were missing:

``` shell
{"entryPointName":"websecure","level":"error","msg":"middleware \"staging-blue-auth-pass-blacked-frontend-canary-redesign@kubernetescrd\" does not exist","routerName":"tushyraw-frontend-blue-redesign-new-join-form-staging-blue-staging-blue-members-tushyraw-com-joinnow@kubernetes","time":"2022-02-22T13:10:37Z"}

{"entryPointName":"websecure","level":"error","msg":"middleware \"staging-blue-auth-pass-blacked-frontend-canary-redesign@kubernetescrd\" does not exist","routerName":"slayed-frontend-blue-redesign-new-join-form-staging-blue-staging-blue-members-slayed-com-joinnow@kubernetes","time":"2022-02-22T13:10:37Z"}

{"entryPointName":"websecure","level":"error","msg":"middleware \"staging-auth-pass-blacked-frontend-canary-redesign@kubernetescrd\" does not exist","routerName":"deeper-frontend-redesign-new-join-form-staging-staging-members-deeper-com-joinnow@kubernetes","time":"2022-02-22T13:10:37Z"}

{"entryPointName":"websecure","level":"error","msg":"middleware \"staging-auth-pass-blacked-frontend-canary-redesign@kubernetescrd\" does not exist","routerName":"vixen-frontend-redesign-new-join-form-staging-staging-members-vixen-com-joinnow@kubernetes","time":"2022-02-22T13:10:37Z"}
```

After some investigation, I found that in the previous version of Traefik (2.3.3) the middlewares were already missing, so it wasn't a problem with the upgrade.

> In conclusion, the newer version of Traefik (2.5.6) simply gave an incorrect redirection for a Router when a middleware was missing but in the previous version don't. 

In the end, I created the missing middlewares and redirections were working as expected.

---

# Upgrading to 2.6.1

❯ ./CRDs_2_6.sh
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



❯ helm search repo traefik -l | grep -i 2.6.1
traefik/traefik         	10.14.2      	2.6.1      	A Traefik based Kubernetes ingress controller


- Change values.yaml tag for "2.6.1"

Then:

``` shell
helm upgrade -i traefik2 -n staging -f values.yaml traefik/traefik --version 10.14.2 --dry-run
```

Real update:

```shell

❯ helm upgrade -i traefik2 -n staging -f values.yaml traefik/traefik --version 10.14.2
Release "traefik2" has been upgraded. Happy Helming!
NAME: traefik2
LAST DEPLOYED: Wed Feb 23 16:42:11 2022
NAMESPACE: staging
STATUS: deployed
REVISION: 29
TEST SUITE: None
```