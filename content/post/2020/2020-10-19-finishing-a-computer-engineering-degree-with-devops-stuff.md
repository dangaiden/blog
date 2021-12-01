---
title: Finishing a Computer Engineering degree with DevOps stuff
author: itgaiden
type: post
date: 2020-10-19T12:55:26+00:00
url: 2020-10-19-finishing-a-computer-engineering-degree-with-devops-stuff
categories:
  - DevOps
tags:
  - devops
  - docker
  - kubernetes

---
It's been more than one month since I published something here but I've been changing quite a lot my focus learning and I changed now from CCNA to **DevOps** things.

> **<span><em>TL;DR  </em>I will be building an automated CI/CD pipeline for my final assignment focusing on tools installed and configured on-premise although there will be cloud services like the front-end.**

Also, I forgot to mention that last month I started the <span style="text-decoration: underline;">last semester of my Computer Engineering degree that **I started back in 2014** (oh my!), and I expect to finish it (if I pass the last «subject») next January 2021!.

And now let's move to the point.

In this last semester, I have to deliver the «final assignment» which consists of a project of my own that will be documented and then defended (virtually as per the current circumstances) against university judges.

In my case, I finally decided to get into the **DevOps** world and my assignment is **<em>Building a production CI/CD pipeline</em>**.

# Some sort of introduction

I suppose you're currently aware of the trending topic regarding <em>Containers</em> and <em>Container Orchestrators</em>, in particular (you know them), **Docker** and **Kubernetes**. 

Those two are the most used technologies in the **DevOps** world because they work great in conjunction although there are alternatives that could work as good as them.

So regarding DevOps, you probably know is a culture and it follows a set of practices where the software development world and the IT operations are combined in order to speed up and improve the process of application delivery (a.k.a. SDLC).

<img loading="lazy" class="alignnone wp-image-1842 " src="/wp-content/uploads/2020/10/devops.png" alt="" width="550" height="275" srcset="/wp-content/uploads/2020/10/devops.png 800w, /wp-content/uploads/2020/10/devops-300x150.png 300w, /wp-content/uploads/2020/10/devops-768x384.png 768w" sizes="(max-width: 550px) 100vw, 550px" />

Continuing with DevOps, there is a pipeline or process which combines the practices of CI (Continuos Integrity) and CD (Continuous Delivery) and that's the process that I am going to describe and build for my final assignment.<br /> 

# But...why this topic?

Good question...I know almost nothing about that world which is a good approach for many enterprises but not for all of them.

And, the same thing with containers, all the applications shouldn't be always in containers but if you can re-code your app to split it into <em>micro-services</em> to make it better would you do it (That probably means spending large amounts of money)?

Anyway, why I am choosing this topic?

I think it's a great opportunity to finally take a look into this area where developers need to push updates to production apps in the faster way possible. We saw that even VMware focused on Kubernetes in their product catalog so maybe you should take a look as well...

But not because VMware did it nevertheless, we are moving to a faster and automated world where everything is becoming more and more automatized.  

Just deploying containers and building micro-services will make you the coolest guy in the world but in my opinion, knowing the use cases and some tools to provision and automate lots of items will make you smarter.

I believe that this will help me to gain knowledge in those areas and advance in my career, therefore, I will be sharing all the useful information I researched during the entire project.

<img loading="lazy" class="alignnone wp-image-1851 size-full" src="/wp-content/uploads/2020/10/could-devops-mean-using-all-the-tools-i-can-at-once.jpg" alt="" width="480" height="480" srcset="/wp-content/uploads/2020/10/could-devops-mean-using-all-the-tools-i-can-at-once.jpg 480w, /wp-content/uploads/2020/10/could-devops-mean-using-all-the-tools-i-can-at-once-300x300.jpg 300w, /wp-content/uploads/2020/10/could-devops-mean-using-all-the-tools-i-can-at-once-150x150.jpg 150w" sizes="(max-width: 480px) 100vw, 480px" /> 

# How?

It is known that there many ways to build a CI/CD pipeline and **many** tools that you can use for each phase but in this project, I will try to start with the «foundation» of the main tools used (Container runtime, Container Orchestrator, Configuration and provision management, etc.).

All of them would be hosted in on-premise infrastructure, instead of going to the cloud where there are a lot of tools that integrates many things and will help you to avoid problems and headaches.

So basically, I am aiming* to **build everything on-premise** except the service itself (which will be a web application) that would be hosted in the cloud, in order to achieve a better service in terms of availability, resiliency, etc.

<img loading="lazy" class="alignnone wp-image-1848 " src="/wp-content/uploads/2020/10/yoda_devops.jpg" alt="" width="398" height="398" srcset="/wp-content/uploads/2020/10/yoda_devops.jpg 640w, /wp-content/uploads/2020/10/yoda_devops-300x300.jpg 300w, /wp-content/uploads/2020/10/yoda_devops-150x150.jpg 150w" sizes="(max-width: 398px) 100vw, 398px" /> 

Therefore,** a mix of on-premise and cloud CI/CD pipeline is the objective** with the main focus on the process and not the code of the application.

That doesn't mean that the process where the developer has to push code to a repository (CI) will be neglected, in fact, probably some tools for the developer will be cloud-based due to the simplicity that adds but can't ensure that this will be my final approach

&nbsp;

# Summary

<img loading="lazy" class="alignnone wp-image-1852 size-full" src="/wp-content/uploads/2020/10/i-know-devops-maybe-not.jpg" alt="" width="853" height="480" srcset="/wp-content/uploads/2020/10/i-know-devops-maybe-not.jpg 853w, /wp-content/uploads/2020/10/i-know-devops-maybe-not-300x169.jpg 300w, /wp-content/uploads/2020/10/i-know-devops-maybe-not-768x432.jpg 768w" sizes="(max-width: 853px) 100vw, 853px" /> 

In short, I am aiming to gain knowledge about this new area where developers and operations meet, and «everything» is automated (or at least a great part of it).

Although there are many tools to build a CI/CD pipeline, learning which tools to use on each phase, how and why are chosen will be key in order to understand clearly the whole process from a technical perspective.

I forgot to mention that, there are other things like IaC (Infrastructure as Code) and Control Version which are handy everywhere but especially in this environment as with code you can have different versions and avoid more errors than provisioning resources manually.<br /> 

&nbsp;

&nbsp;