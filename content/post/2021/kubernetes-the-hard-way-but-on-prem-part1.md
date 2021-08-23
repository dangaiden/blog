---
title: Kubernetes the hard way but on-prem - part 1
author: itgaiden
type: post
date: 2021-08-12T11:47:51+00:00
url: kubernetes-the-hard-way-but-on-prem-part1
categories:
  - microservices
  - kubernetes
tags:
  - certification
  - kubernetes
  - cka
---

# DISCLAIMER

>I decided to not continue with this due to the huge implications that will be to do everything in VMs, basically, a lot of time should be invested and I miscalculated it too much. Therefore, this will be probably the first and only post about these series.

# Context

In order to practice for the CKA exam, it is recommended to perform the famous [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way#kubernetes-the-hard-way) by Kelsey Hightower.

That guide is one of the best way to create a Kubernetes cluster by installing each component of them separatedly instead of using other tools like Kind, MiniKube, etc. which will create a K8s cluster without dealing about any complexity.

In this way, we can learn the componentes involved and how they really interact them.

As per writting this blog, the components will be:

-   [kubernetes](https://github.com/kubernetes/kubernetes) v1.21.0
-   [containerd](https://github.com/containerd/containerd) v1.4.4
-   [coredns](https://github.com/coredns/coredns) v1.8.3
-   [cni](https://github.com/containernetworking/cni) v0.9.1
-   [etcd](https://github.com/etcd-io/etcd) v3.4.15

Therefore, the **Kubernetes the hard way** guide will be my base to perform the Kubernetes cluster creation with all the componenrs or basically saying, I will do the "Kubernetes the hard way" a bit different :)

This is the **first part of the series** for the Kubernetes the hard way but on-prem. (**Now  discontinued**)

# Local infrastructure

>Note: This post explains how I did it and I can be wrong  in some parts,  do it in the most comfortable way for you.

Here is the main point when it differs from the guide, we will do it **with virtual machines** (a.k.a. VMs) instead of using instances in the cloud, why? 

Because I don't want to setup a cloud account in GCP which will exceed the limits of the free tier (as it does in the guide) plus other concerns.

In this way, **I can do it for free** (with Virtual Box and with almost any Linux distribution) but it will require you to setup more things from the "nodes" (VMs) side. 

A quick diagram of what I will have in the PC (3 VMs in the same network):

<span><img src = "/wp-content/uploads/2021/VMs_infra_k8s_hardway.png" /></span>

# Let's start with the infra

We basically need a hypervisor (type 2, as we'll install it in our OS), 3 virtual machines (that will act as our nodes for the K8s cluster) with an operating system, configure them and then the Kubernetes hype can start.

### The hypervisor

As easy as downloading [Virtual Box](https://www.virtualbox.org/wiki/Linux_Downloads) (Oracle VM VirtualBox) and installing it in the flavour you want (I am using Debian 10).

### Operating system for our nodes

For the OS, you can use whatever Linux distro you like the most, I am choosing [Redhat 8](https://developers.redhat.com/content-gateway/file/rhel-8.4-x86_64-dvd.iso) as months ago it was announced that CentOS 8 will be discontinued in 2022 and I wanted something that is widely used.

>I'll link soon a simple guide to install the OS within a VM and some tips.


# Install the needed tools in your PC

Going through my own "hard way" for Kubernetes, I started directly [here](https://github.com/dangaiden/kubernetes-the-hard-way/blob/master/docs/02-client-tools.md) since I don't need any SDK.

So here is how I did it the "Installing the Client Tools" part which differs from the version published in GKE.

As a reminder I am doing this in my PC with Debian 10 (buster).

## Installing cfssl and cfssljson

- [ ] Install CFSSL to provision the PKI infrastructure and generate TLS certificates:

```bash
$ sudo curl -s -L -o /bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
```
```bash
$ sudo curl -s -L -o /bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
```
```bash
$ sudo curl -s -L -o /bin/cfssl-certinfo https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64
```
```bash
$ sudo chmod +x /bin/cfssl*
```
```bash
$ sudo ls -lah /bin/ | grep cfssl          
-rwxr-xr-x.  1 root root 9.9M Aug 12 22:31 cfssl
-rwxr-xr-x.  1 root root 6.3M Aug 12 22:33 cfssl-certinfo
-rwxr-xr-x.  1 root root 2.2M Aug 12 22:31 cfssljson
```

 - Verifying that is installed correctly:

```bash
$ cfssl version
Version: 1.2.0
Revision: dev
Runtime: go1.6
```
```bash 
$ cfssljson --help
Usage of cfssljson:
  -bare
    	the response from CFSSL is not wrapped in the API standard response
  -f string
    	JSON input (default "-")
  -stdout
    	output the response instead of saving to a file
```

## Install kubectl

- [ ] Install kubectl (command line utility) to interact with the Kubernetes API server.

We will install kubectl based in the official [documentation](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/):

```bash
$ curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

Validate the checksum as specified in the Kubernetes official documentation and proceed to install it:

```bash
$ sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

Now verify the version to see if it's working correctly:

```bash
$ kubectl version --client
Client Version: version.Info{Major:"1", Minor:"22", GitVersion:"v1.22.0", GitCommit:"c2b5237ccd9c0f1d600d3072634ca66cefdf272f", GitTreeState:"clean", BuildDate:"2021-08-04T18:03:20Z", GoVersion:"go1.16.6", Compiler:"gc", Platform:"linux/amd64"}
```

---

Summary of tasks completed:
- [x] VMs (compute resources) ready.
- [x] Install CFSSL to provision the PKI infrastructure and generate TLS certificates
- [x] Install kubectl to interact with the Kubernetes API server

---

So this is the **end of the first part**.

We made some things in our future nodes and installed some tools that will be required for later.

In the next post I'll continue with the *Provisioning Compute Resources* section based in the [Kubernetes the Hard way tutorial](https://github.com/kelseyhightower/kubernetes-the-hard-way)







