---
title: My CKS experience
author: itgaiden
type: post
date: 2023-06-01T11:37:03+00:00
url: cks-exam-experience
categories:
  - Kubernetes
  - DevOps
  - Education
tags:
  - kubernetes
  - certification
  - devops
---

## It was about time...

>TL;DR A couple of months ago I've taken the CKS exam last week and I have passed it. It was about time to make a post about it which can be helpful to others.

After studying for some weeks of studying (in fact, I scheduled the exam a week before the exam was expiring) and two attempts, I got the pass, the first was just to be safe as it was going to expire but the second one, let me 2 additional weeks to nail a couple of things.

In my opinion, the exam wasn't that hard, by doing the **killer.sh** tests (provided when you order the exam) you have great questions which will be harder than the real exam.

As with other experiences with CKx certifications, **killer-sh** is extremely helpful but maybe you will have to dig deeper in some aspects if you want to have everything clear.

This one is not like the CKA or CKAD, as already mentioned in the CHECK THE DOC, you need to know your way around about many things: processes, tools, different K8s of course, and more. Check the DOC!!!!!

![](https://media.giphy.com/media/tF8vMUeGUkHNTgCC4E/giphy.gif)

## Day of the exam

- It's a 2-hour exam, so any extra time you can save, the better, maybe you should go to the toilet before taking the exam (although you can request a break if needed).

- Use the cheat sheet provided by the [Kubernetes documentation](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) at the beginning of the exam (search for it) as it will help you to remember some commands if you don't remember them correctly
- You can have opened more than one tab (that was my experience) to read through the documentation. In my case I had the official Kubernetes documentation opened to search as fast as I can through each topic.

- If you get stuck in one question for more than 10 min, probably you should flag it and go with the next one!

> Note: The exam taken was based in Kubernetes v1.26 so obviously, PSPs were already out of the equation!

![](https://media.giphy.com/media/X86IXaftArdHRmnBli/giphy.gif)

## Resources

- I used this CKS course which can help you to know some of the topics if you don't know them already: https://www.udemy.com/course/certified-kubernetes-security-specialist/
- The amazing collection of resources from Walid is a *must*: https://github.com/walidshaari/Certified-Kubernetes-Security-Specialist
- The Killer.sh test provided by the Linux training foundation is **extremely helpful**.

## Some handy things to know (NOT ALL are mandatory for the exam)

- Useful "shortcuts" to use (use them as exported variables or aliases)

```
export k=kubectl                        # already configured
export do="--dry-run=client -o yaml"    # k get pod x $do
export now="--force --grace-period 0"   # k delete pod x $now
```

---

- Can be helpful where and which control-plane components are installed:

Kubelet, DNS, scheduler, etcd, and API server (as pods): ```/etc/kubernetes/manifests``` 
Check if it's managed by SystemD under the folder: ```/etc/systemd/system```

---

- "Restart" control-plane components.

Proceed to move manifests files from (default) location: ```/etc/kubernetes/manifests``` if you want to quickly "restart" a service which runs in an specific container.

Then check there are no containers running and move it back to the previous

---

-  Commands to test within the pods

Review if port is opened from a particular pod (using a shell)
``` shell
> k exec -it <pod-name> -- bin/sh -c "nc -vz 10.36.0.18 80"
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
k auth can-i create configmap --as <user> -n <namespace>
```
For a SA:
``` shell
k auth can-i list pod  --as system:serviceaccount:<namespace>:<role>
```
## Wrap up 

It wasn't a hard exam even for the limited time you have (2h) and I learnt about other resources I usually don't use but overall it was great to know about them.

Remember you have a **free retake** when you order the exam so don't worry if you don't make it in the first one but make sure to use your time wisely when taking it.

That's all, next one is the CKAD which should be "easier" as per other reviews I have read.

More in the next post!

![](https://media.giphy.com/media/BoHCeLmEKytt7oFxyR/giphy.gif)