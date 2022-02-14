---
title: My CKA experience
author: itgaiden
type: post
date: 2022-02-14T11:37:03+00:00
url: cka-exam-experience
categories:
  - Kubernetes
  - DevOps
  - Education
tags:
  - kubernetes
  - certification
  - devops
---

# It was about time...

>TL;DR Last week I've taken the CKA exam last week and I have passed it!
>You can read the rest of the post for more insights and resources.


I have been studying for 2-3 weeks but I wanted to share what I have used to study although I already have experience with Kubernetes so your mileage may vary.

Anyway, I really like the practice exams as they really test you but practice and understand things instead of memorizing questions from a test.

In my opinion, the exam wasn't hard, by doing the **killer.sh** test (provided when you order the exam) you have great questions which will be harder than the real exam.

Therefore, once you understand all questions from the tests, feel fluent using the VIM editor (quite useful as you'll have to tweak manifests/YAML files) and creating/modifying resources, you should feel ready for taking the exam.

![](https://media.giphy.com/media/BpGWitbFZflfSUYuZ9/giphy.gif)

## Day of the exam

- It's a 2-hour exam, so any extra time you can save, the better, maybe you should go to the toilet before taking the exam (although you can request a break if needed).
- Use the cheat sheet provided by the [Kubernetes documentation](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) at the beginning of the exam (search for it) as it will help you to remember some commands if you don't remember them correctly
- You can have opened another tab to read through the documentation but *only one tab*. In my case I had the official Kubernetes documentation opened in my other screen to read/search as fast as I can.
- Don't worry too much about the alias, the "alias k=kubectl" is already provided, maybe you want to remember the one for **--dry-run=client -o yaml**. *Bash completion* is provided as well.
- If you get stuck in one question for more than 10 min, probably you should flag it and go with the next one!

![](https://media.giphy.com/media/3o6fJb3wLZeWqHu5os/giphy.gif)

## Resources

- The famous CKA [Udemy course](https://www.udemy.com/course/certified-kubernetes-administrator-with-practice-tests/learn/lecture/15271428?start=1#notes) by Mumshad Mannambeth was great to know about some other resources I haven't used nor known and for reviewing many others.
- The amazing collection of resources from Walid is a *must*: https://github.com/walidshaari/Kubernetes-Certified-Administrator
- CKA/CKAD exercises from https://github.com/dgkanatsios/CKAD-exercises
- More exercises: https://github.com/StenlyTU/K8s-training-official
- The Killer.sh test provided by the Linux training foundation is extremely helpful.

## Useful things I have learnt but aren't mandatory for the exam

- Useful "shortcuts" to use (use them as exported variables or aliases)

```
export k=kubectl                        # already configured
export do="--dry-run=client -o yaml"    # k get pod x $do
export now="--force --grace-period 0"   # k delete pod x $now
````

---
- Check expiration of certificates (using openssl and kubeadm):

```
> openssl x509 -noout -text -in /var/lib/minikube/certs/apiserver.crt | grep -i valid -A2
        Validity
            Not Before: May 13 22:33:43 2021 GMT
            Not After : May 14 22:33:43 2022 GMT
```

- With kubeadm:  ```kubeadm certs check-expiration```

---

- Quick check of versions of kubelet, kubeadm and kubectl (for upgrading):

```
> ssh <kubernetes-node>
> kubectl version --short
> kubeadm version
> kubelet --version
```

---

- Check where and which control-plane components are installed:

Default CNI location:  ```/etc/cni/net.d/```

Kubelet, DNS, scheduler, etcd, and API server (as pods): ```/etc/kubernetes/manifests``` 

Check if it's managed by SystemD under the folder: ```/etc/systemd/system```

---

- Stop control-plane components.

Proceed to move manifests file from (default) location: ```/etc/kubernetes/manifests``` or stop the appropiate service within the master node (in case is installed as service).

---

- Troubleshooting nodes

If you have other clusters (like in the exam), check the manifests from other master nodes to see if you're missing something.

Usually, the main issues are related to paths, ports or some other sort of mispelling within the */etc/kubernetes/manifests* folder.

Others can be as simple as checking and starting the kubelet service in the worker nodes:

```sql
> systemctl status service_name
> service status service_name
```

Also you can check if process is running on the worker node: ```ps aux | grep kubelet```

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
- ETCD backup and restore summary

1. Gather the data from the etcd pod: k describe <etcd-pod>
2. Review the IP and port provided by "listen clients"
3. Use the snapshot save command
4. Stop all control plane components (by moving the YAML files where the static pods are defined to another folder):

```
root@master-node:~# cd /etc/kubernetes/manifests/
root@master-node:/etc/kubernetes/manifests# mv * ..
```
5. Check no pods are running within the master-node: ```crictl ps```
6. Create directory before restoring snapshot: mkdir...
7. Restore snapshot (in new empty directory created): 
``` shell
ETCDCTL_API=3 etcdctl --data-dir /var/lib/etcd/restore snapshot restore /tmp/etcd-backup.db
```
8. Change manifest from etcd to point to new directory: vim /etc/kubernetes/manifests/etcd.yaml

> NOTE: Don't use ```snapshot status``` because it can alter the snapshot file and render it invalid

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

---

## Wrap up 

It wasn't a hard exam even for the limited time you have (2h) and I learnt about other resources I usually don't use but overall it was great to know about them.

Remember you have a **free retake** when you order the exam so don't worry if you don't make it in the first one but make sure to use your time wisely when taking it.

That's all, next one is the CKAD which should be "easier" as per other reviews I have read.

More in the next post!

![](https://media.giphy.com/media/BoHCeLmEKytt7oFxyR/giphy.gif)