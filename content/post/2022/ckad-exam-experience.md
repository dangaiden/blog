---
title: My CKAD experience
author: itgaiden
type: post
date: 2022-03-11T11:37:03+00:00
url: ckad-exam-experience
categories:
  - Kubernetes
  - DevOps
  - Education
tags:
  - kubernetes
  - certification
  - devops
---

# CKAD exam

As I already expected, it was easier than the CKA. 

How much do I study for this one? Well, I already have experience with Kubernetes, took the CKA 3 weeks ago so I just took twice the *killer.sh test* and It was enough but your mileage may vary.

This post will be way shorter than the [other one I published](https://itgaiden.com/cka-exam-experience/) as the topics for the exam are "similar" and most of the stuff is relevant to this exam.

![](https://media.giphy.com/media/l2Je4Eo5gkJtfItCE/giphy.gif)

## Day of the exam

Tips are the same as I have used for my [CKA experience post](https://itgaiden.com/cka-exam-experience/)

- It's a 2-hour exam, so any extra time you can save, the better, maybe you should go to the toilet before taking the exam (although you can request a break if needed).
- Use the cheat sheet provided by the [Kubernetes documentation](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) at the beginning of the exam (search for it) as it will help you to remember some commands if you don't remember them correctly
- You can have opened another tab to read through the documentation but *only one tab*. In my case I had the official Kubernetes documentation opened in my other screen to read/search as fast as I can.
- Don't worry too much about the alias, the "alias k=kubectl" is already provided, maybe you want to remember the one for **--dry-run=client -o yaml**. *Bash completion* is provided as well.
- If you get stuck in one question for more than 10 min, probably you should flag it and go with the next one!

> Note: The exam taken was based in Kubernetes v1.23

## Some resources

- CKAD exercises from https://github.com/dgkanatsios/CKAD-exercises
- More exercises: https://github.com/StenlyTU/K8s-training-official
- The Killer.sh test provided by the Linux training foundation is extremely helpful.

![](https://media.giphy.com/media/l2Jedlq0pQBx4UbOo/giphy.gif)

## Useful things to know for the exam

- Useful "shortcuts" to use (use them as exported variables or aliases)

```
export k=kubectl                        # already configured
export do="--dry-run=client -o yaml"    # k get pod x $do
export now="--force --grace-period 0"   # k delete pod x $now
````
---
-  Commands to test within the pods

Review if port is opened from a particular pod (using a shell):
``` shell
> k exec -it <pod-name> -- bin/sh -c "nc -vz 10.36.0.18 80"
```
---
- Learn to run a temporary pod to test something
``` shell
k run temp --restart=Never --rm -i --image=nginx:alpine -- curl 10.18.38.43:443
```
---
- Check how a resource manifest is structured (aka how to put fields within the YAML)

``` bash
> k explain --recursive <api-resource> 
```
---
- Test if an SA or user can perform an action

For a user:
``` shell
> k auth can-i create configmap --as <user> -n <namespace>
```
For a SA:
``` shell
> k auth can-i list pod  --as system:serviceaccount:<namespace>:<role>
```
---
- Important commands to know related to **Helm** 

``` shell
# List installed releases in selected namespace
> helm ls -n <namespace> 
```

``` shell
# Install and upgrade releases
> helm install <name-you-want-to-use> -f values.yaml <repository> --version <chart-version> --debug

> helm upgrade <release-name> -n default -f values.yaml traefik/traefik --version 10.9.1

- Optional values:
> --version: if not used, will use latest chart version
> --debug: verbose output of what is being performed
> -f <file>: values.yaml is the file which you use to override default values provided by a chart.
> --force: can be used to replace (kubectl replace) objects instead of patching them (by default, kubectl apply)
```

``` shell
# Commands related to repositories
> helm repo list 
> helm repo update
> helm search repo <release>
```

``` shell
> helm history <release-name> -> Check deployed releases
```

``` shell
> helm uninstall -n <namespace> <release-name> -> Uninstall an installed release
```

``` shell
> helm rollback <release-name> -> Rollback to previous version
> helm rollback <release-name> <revision> -> Rollback to specific release revision
```

- Learn how a Dockerfile [is structured](https://docs.docker.com/engine/reference/builder/) and how to build, tag and push Docker images.
---
## Summary

An easier exam compared to the CKA as expected but good to know some things for this *developer path* which is more focused in how to use Kubernetes itself.

Next one, will be the **CKS** which is the harder one, I'll take a break so probably I'll take it on April. 

More things for the CKS in the next post! ;)

![](https://media.giphy.com/media/5USTijryafZEQ/giphy.gif)