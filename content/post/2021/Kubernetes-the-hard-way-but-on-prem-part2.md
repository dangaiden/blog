 ---
title: Kubernetes the hard way but on-prem - part 2
author: itgaiden
type: draft
date: 2021-08-1x
url: kubernetes-the-hard-way-but-on-prem-part2
categories:
  - microservices
  - kubernetes
tags:
  - certification
  - kubernetes
  - cka
---

# Context

Let's continue with the guide, in this **part 2**.

This is based in: https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/03-compute-resources.md



# Kubernetes Controllers

We will be using the following CIDR `192.168.1.0/24` for node within the cluster:

- Somred1: 192.168.1.50/24
- Somred2: 192.168.1.51/24
- Somred3: 192.168.1.52/24

# Kubernetes Workers

This nodes will act as the Kubernetes workers nodes which will host the pods, we need to have 2 NICs for each node.

One NIC will be the one used before to communicate with the other nodes: `192.168.1.0/24`

Therefore:

- Worknet1 NIC1: 192.168.1.101
- Worknet2 NIC1: 192.168.1.102
- Worknet3 NIC1: 192.168.1.103

%%We will be using the following **pod CIDR** `10.200.0.0/16` for each worker node.

- Worknet1 NIC2: 10.200.1.1/24
- Worknet2 NIC2: 10.200.2.1/24
- Worknet3 NIC2: 10.200.3.1/24%%









