# Traefik upgrade

## The overall process




## Context

- Upgrading traefik from 1.7.26 (chart traefik-1.87.7) to  2.5.6 (chart 10.9.1) isn't possible because of labels immutability:
``` shell
❯ helm upgrade -i traefik -n default -f values.yaml traefik/traefik --version 10.9.1 --force --debug
history.go:56: [debug] getting history for release traefik
upgrade.go:139: [debug] preparing upgrade for traefik
upgrade.go:147: [debug] performing update for traefik
upgrade.go:319: [debug] creating upgraded release for traefik
client.go:218: [debug] checking 5 resources for changes
client.go:493: [debug] Replaced "traefik" with kind ServiceAccount for kind ServiceAccount
client.go:493: [debug] Replaced "traefik" with kind ClusterRole for kind ClusterRole
client.go:493: [debug] Replaced "traefik" with kind ClusterRoleBinding for kind ClusterRoleBinding
client.go:250: [debug] error updating the resource "traefik":
	 failed to replace object: Deployment.apps "traefik" is invalid: spec.selector: Invalid value: v1.LabelSelector{MatchLabels:map[string]string{"app.kubernetes.io/instance":"traefik", "app.kubernetes.io/name":"traefik"}, MatchExpressions:[]v1.LabelSelectorRequirement(nil)}: field is immutable
client.go:250: [debug] error updating the resource "traefik":
	 failed to replace object: Service "traefik" is invalid: spec.clusterIPs[0]: Invalid value: []string(nil): primary clusterIP can not be unset
upgrade.go:430: [debug] warning: Upgrade "traefik" failed: failed to replace object: Deployment.apps "traefik" is invalid: spec.selector: Invalid value: v1.LabelSelector{MatchLabels:map[string]string{"app.kubernetes.io/instance":"traefik", "app.kubernetes.io/name":"traefik"}, MatchExpressions:[]v1.LabelSelectorRequirement(nil)}: field is immutable && failed to replace object: Service "traefik" is invalid: spec.clusterIPs[0]: Invalid value: []string(nil): primary clusterIP can not be unset
Error: UPGRADE FAILED: failed to replace object: Deployment.apps "traefik" is invalid: spec.selector: Invalid value: v1.LabelSelector{MatchLabels:map[string]string{"app.kubernetes.io/instance":"traefik", "app.kubernetes.io/name":"traefik"}, MatchExpressions:[]v1.LabelSelectorRequirement(nil)}: field is immutable && failed to replace object: Service "traefik" is invalid: spec.clusterIPs[0]: Invalid value: []string(nil): primary clusterIP can not be unset
helm.go:88: [debug] failed to replace object: Deployment.apps "traefik" is invalid: spec.selector: Invalid value: v1.LabelSelector{MatchLabels:map[string]string{"app.kubernetes.io/instance":"traefik", "app.kubernetes.io/name":"traefik"}, MatchExpressions:[]v1.LabelSelectorRequirement(nil)}: field is immutable && failed to replace object: Service "traefik" is invalid: spec.clusterIPs[0]: Invalid value: []string(nil): primary clusterIP can not be unset
helm.sh/helm/v3/pkg/kube.(*Client).Update
	helm.sh/helm/v3/pkg/kube/client.go:263
helm.sh/helm/v3/pkg/action.(*Upgrade).releasingUpgrade
	helm.sh/helm/v3/pkg/action/upgrade.go:375
runtime.goexit
	runtime/asm_arm64.s:1133
UPGRADE FAILED
main.newUpgradeCmd.func2
	helm.sh/helm/v3/cmd/helm/upgrade.go:202
github.com/spf13/cobra.(*Command).execute
	github.com/spf13/cobra@v1.2.1/command.go:856
github.com/spf13/cobra.(*Command).ExecuteC
	github.com/spf13/cobra@v1.2.1/command.go:974
github.com/spf13/cobra.(*Command).Execute
	github.com/spf13/cobra@v1.2.1/command.go:902
main.main
	helm.sh/helm/v3/cmd/helm/helm.go:87
runtime.main
	runtime/proc.go:255
runtime.goexit
	runtime/asm_arm64.s:1133
```


- You can see the problem about the labels because they're immutable, therefore, what I have done is to deploy a parallel traefik deployment (in version 2.5.6) which sits with the older version (1.8.7).

There are no issues, because the ELB which Traefik creates by default (if you're using AWS) is not used in our DNS. When I want to test it externally, I do need to create a new CNAME and point it to the:

```
NAME                                      TYPE           CLUSTER-IP       EXTERNAL-IP                                                              PORT(S)                      AGE
cerebro                                   ClusterIP      100.65.108.89    <none>                                                                   80/TCP                       539d
kubernetes                                ClusterIP      100.64.0.1       <none>                                                                   443/TCP                      540d
tokenservice                              ClusterIP      100.66.106.178   <none>                                                                   3000/TCP                     390d
traefik                                   LoadBalancer   100.67.75.183    a2c139e9a42564cbb897203cd2f9f16d-740162447.us-east-1.elb.amazonaws.com   443:30809/TCP,80:32518/TCP   11d
traefik-dashboard                         ClusterIP      100.67.228.71    <none>                                                                   80/TCP                       11d
traefik2                                  LoadBalancer   100.69.196.88    a60c47c8fa23e4f09b562afc93e80274-894996197.us-east-1.elb.amazonaws.com   80:31852/TCP,443:30701/TCP   5h57m
```

## Installing Traefik2 in parallel with current deployment.
- Then as this doesn't work, we will install Traefik v2 as a parallel deployment:

``` shell

 ~/Kodify/infrastructure/kubernetes/staging/namespaces/default/traefik │ SYS-1556/Traefik_upgrade  date;helm install traefik2 -f values.yaml traefik/traefik --version 10.9.1 --debug                                                                                                         ✔ │ tubes-stg ⎈ │ 12:50:30
Mon Mar  7 12:51:41 CET 2022
install.go:178: [debug] Original chart version: "10.9.1"
install.go:199: [debug] CHART PATH: /Users/dba7x/Library/Caches/helm/repository/traefik-10.9.1.tgz

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
client.go:128: [debug] creating 5 resource(s)
client.go:299: [debug] Starting delete for "traefik2-dashboard" IngressRoute
client.go:128: [debug] creating 1 resource(s)
NAME: traefik2
LAST DEPLOYED: Mon Mar  7 12:51:49 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
USER-SUPPLIED VALUES:
accessLogs:
  enabled: true
  fields:
    defaultMode: keep
    headers:
      defaultMode: drop
      names:
        Referer: keep
        User-Agent: keep
  format: json
additionalArguments:
- --providers.kubernetesCRD.allowCrossNamespace=true
- --providers.kubernetesingress.ingressclass=traefik-staging
autoscaling:
  maxReplicas: 5
  metrics:
  - resource:
      name: cpu
      targetAverageUtilization: 70
    type: Resource
  minReplicas: 1
dashboard:
  domain: traefik.kodify.com
  enabled: true
debug:
  enabled: false
deployment:
  hostPort:
    dashboardEnabled: true
    httpEnabled: true
    httpsEnabled: true
deploymentStrategy:
  rollingUpdate:
    maxSurge: 1
    maxUnavailable: 1
  type: RollingUpdate
externalTrafficPolicy: Local
forwardedHeaders:
  enabled: false
gzip:
  enabled: true
image:
  name: traefik
  tag: 2.5.6
metrics:
  prometheus:
    enabled: false
  serviceMonitor:
    enabled: false
proxyProtocol:
  enabled: true
  trustedIPs:
  - 10.0.0.0/8
rbac:
  enabled: true
replicas: 1
resources:
  limits:
    memory: 500Mi
  requests:
    cpu: 200m
    memory: 200Mi
sendAnonymousUsage: false
service:
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-proxy-protocol: '*'
serviceType: LoadBalancer
ssl:
  enabled: true
  enforced: false
  insecureSkipVerify: false
  upstream: false
tolerations: []
tracing:
  enabled: false
  serviceName: traefik
traefikLogFormat: json
websecure:
  tls:
    enabled: true

```

Then re-formatting the ```values.yaml``` file used in the helm release to use the appropiate values and removes the ones not needed as stated in the [official chart repository](https://github.com/traefik/traefik-helm-chart/blob/v10.9.1/traefik/templates/_podtemplate.tpl)

### Issue with HTTPS endpoints

I created a new CNAME record pointing to the new ELB created and when I try to access with *curl* I found that HTTPS didn't work correctly.
``` shell
curl -vvv https://int.fux.com                          ✔ │ 18:06:49
*   Trying 54.156.8.198:443...
* Connected to int.fux.com (54.156.8.198) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*  CAfile: /etc/ssl/cert.pem
*  CApath: none
* TLSv1.2 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-RSA-CHACHA20-POLY1305
* ALPN, server accepted to use h2
* Server certificate:
*  subject: OU=Domain Control Validated; CN=*.fux.com
*  start date: Jun  7 13:06:34 2021 GMT
*  expire date: Jul  9 13:06:34 2022 GMT
*  subjectAltName: host "int.fux.com" matched cert's "*.fux.com"
*  issuer: C=US; ST=Arizona; L=Scottsdale; O=GoDaddy.com, Inc.; OU=http://certs.godaddy.com/repository/; CN=Go Daddy Secure Certificate Authority - G2
*  SSL certificate verify ok.
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* Using Stream ID: 1 (easy handle 0x13e811e00)
> GET / HTTP/2
> Host: int.fux.com
> user-agent: curl/7.77.0
> accept: */*
>
* Connection state changed (MAX_CONCURRENT_STREAMS == 250)!
< HTTP/2 404
< content-type: text/plain; charset=utf-8
< x-content-type-options: nosniff
< content-length: 19
< date: Mon, 07 Mar 2022 17:06:50 GMT
<
404 page not found
* Connection #0 to host int.fux.com left intact

```

So, HTTP works but not HTTPs (although is presenting me the certifictate correctly).
Then, what *what am I missing?*

After reviewing the breaking changes from Traefik 1.x and 2.x, in my case, the problem is that my ingress resource doesn't have the [necessary annotation](https://doc.traefik.io/traefik/routing/providers/kubernetes-ingress/#enabling-tls-via-annotations) to enable TLS.

And if I check the ingress (here I am using the Ingress resource from K8s not the Ingressroute from Traefik) I see that is missing ```traefik.ingress.kubernetes.io/router.tls: "true"```:

``` shell
k get ingress -n fux fux-front -o yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    ingress.kubernetes.io/ssl-redirect: "false"
    ingress.kubernetes.io/whitelist-x-forwarded-for: "true"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"extensions/v1beta1","kind":"Ingress","metadata":{"annotations":{"ingress.kubernetes.io/ssl-redirect":"false","ingress.kubernetes.io/whitelist-x-forwarded-for":"true","kubernetes.io/ingress.class":"traefik-staging","kubernetes.io/tls-acme":"true","meta.helm.sh/release-name":"fux-front","meta.helm.sh/release-namespace":"","status":{"loadBalancer":{}}}
    kubernetes.io/ingress.class: traefik-staging
    kubernetes.io/tls-acme: "true"
    meta.helm.sh/release-name: fux-front
    meta.helm.sh/release-namespace: fux
  creationTimestamp: "2020-12-08T13:55:03Z"
  generation: 1
  labels:
    app.kubernetes.io/managed-by: Helm
  name: fux-front
  namespace: fux
  resourceVersion: "194662430"
  uid: 27406fb6-65f8-44ef-a396-e6bf656144f1
spec:
  rules:
  - host: int.fux.com
    http:
      paths:
      - backend:
          service:
            name: fux-front
            port:
              number: 80
        path: /
        pathType: ImplementationSpecific
  tls:

```

- Solution

I just added ``` traefik.ingress.kubernetes.io/router.tls: "true" ``` to my ingress resource by editing or just redeploying your ingress and, finally it works:

``` shell
 curl -v https://int.fux.com                 0|1 ✘ │ 16:41:40
*   Trying 34.196.145.235:443...
* Connected to int.fux.com (34.196.145.235) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*  CAfile: /etc/ssl/cert.pem
*  CApath: none
* TLSv1.2 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-RSA-CHACHA20-POLY1305
* ALPN, server accepted to use h2
* Server certificate:
*  subject: OU=Domain Control Validated; CN=*.fux.com
*  start date: Jun  7 13:06:34 2021 GMT
*  expire date: Jul  9 13:06:34 2022 GMT
*  subjectAltName: host "int.fux.com" matched cert's "*.fux.com"
*  issuer: C=US; ST=Arizona; L=Scottsdale; O=GoDaddy.com, Inc.; OU=http://certs.godaddy.com/repository/; CN=Go Daddy Secure Certificate Authority - G2
*  SSL certificate verify ok.
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* Using Stream ID: 1 (easy handle 0x120010600)
> GET / HTTP/2
> Host: int.fux.com
> user-agent: curl/7.77.0
> accept: */*
>
* Connection state changed (MAX_CONCURRENT_STREAMS == 250)!
< HTTP/2 200
< content-type: text/html; charset=utf-8
< date: Tue, 08 Mar 2022 15:41:46 GMT
< etag: W/"50590-miVJLAHT/A1iTR6izN3u0hAsgL4"
< server: nginx/1.11.13
< strict-transport-security: max-age=15552000; includeSubDomains
< vary: Accept-Encoding
< x-content-type-options: nosniff
< x-dns-prefetch-control: off
< x-download-options: noopen
< x-frame-options: SAMEORIGIN
< x-xss-protection: 1; mode=block
<
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <title>
.
.
.
  <script>
  </script>
  <script async src='https://www.google-analytics.com/analytics.js'></script>

      </body>
    </html>
* Connection #0 to host int.fux.com left intact
```


Then I upgraded to latest chart version (after changing my values.yaml):

``` date;helm upgrade traefik2 -f values.yaml traefik/traefik --version 10.14.2 ```



## Side notes

- Found that for Whitelisting IPs, you need to use a middleware instead of the annotation in the ingress. Then in your ingress, point to that middleware you have created.


![[Pasted image 20220405174110.png]]

Middleware created:

![[Pasted image 20220405174158.png]]


- Good thing to test if it works correctly is pointing your etc/hosts to the Public IP of the LB you have created in Kubernetes.

![[Pasted image 20220405174348.png]]


Then in your /etc/hosts

![[Pasted image 20220405174411.png]]