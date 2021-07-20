---
title: Finishing a Computer Engineering degree with DevOps stuff
author: itgaiden
type: post
date: 2020-10-19T12:55:26+00:00
url: /?p=1837
categories:
  - DevOps
tags:
  - devops
  - docker
  - kubernetes

---
<span style="font-family: Nunito; font-size: 16px;">It&#8217;s been more than one month since I published something here but I&#8217;ve been changing quite a lot my focus learning and I changed now from CCNA to <strong>DevOps</strong> things.</span>

> **<span class="aCOpRe" style="font-family: Nunito; font-size: 16px;"><em>TL;DR  </em>I will be building an automated CI/CD pipeline for my final assignment focusing on tools installed and configured on-premise although there will be cloud services like the front-end.</span>**

<span style="font-family: Nunito; font-size: 16px;">Also, I forgot to mention that last month I started the <span style="text-decoration: underline;">last semester</span> of my Computer Engineering degree that <strong>I started back in 2014</strong> (oh my!), and I expect to finish it (if I pass the last «subject») next January 2021!.</span>

<span style="font-family: Nunito; font-size: 16px;">And now let&#8217;s move to the point.</span>

<span style="font-family: Nunito; font-size: 16px;">In this last semester, I have to deliver the «final assignment» which consists of a project of my own that will be documented and then defended (virtually as per the current circumstances) against university judges.</span>

<span style="font-family: Nunito; font-size: 16px;">In my case, I finally decided to get into the <strong>DevOps</strong> world and my assignment is <strong><em>Building a production CI/CD pipeline</em></strong>.</span>

# <span style="font-family: Nunito; color: #000000; font-size: 32px;">Some sort of introduction&#8230;</span>

<span style="font-family: Nunito;">I<span style="font-size: 16px;"> suppose you&#8217;re currently aware of the trending topic regarding <em>Containers</em> and <em>Container Orchestrators</em>, in particular (you know them), <strong>Docker</strong> and <strong>Kubernetes</strong>. </span></span>

<span style="font-family: Nunito; font-size: 16px;">Those two are the most used technologies in the <strong>DevOps</strong> world because they work great in conjunction although there are alternatives that could work as good as them.</span>

<span style="font-family: Nunito; font-size: 16px;">So regarding DevOps, you probably know is a culture and it follows a set of practices where the software development world and the IT operations are combined in order to speed up and improve the process of application delivery (a.k.a. SDLC).</span>

<span style="font-family: Nunito; font-size: 16px;"><img loading="lazy" class="alignnone wp-image-1842 " src="http://wp.docker.localhost:8000/wp-content/uploads/2020/10/devops.png" alt="" width="550" height="275" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/10/devops.png 800w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/devops-300x150.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/devops-768x384.png 768w" sizes="(max-width: 550px) 100vw, 550px" /></span>

<span style="font-family: Nunito;"><span style="font-size: 16px;">Continuing with DevOps, there is a pipeline or process which combines the practices of CI (Continuos Integrity) and CD (Continuous Delivery) and that&#8217;s the process that I am going to describe and build for my final assignment.</span><br /> </span>

# <span style="font-family: Nunito; color: #000000; font-size: 32px;">But&#8230;why this topic?</span>

<span style="font-family: Nunito; font-size: 16px;">Good question&#8230; I know almost nothing about that world which is a good approach for many enterprises but not for all of them.</span>

<span style="font-family: Nunito; font-size: 16px;">And, the same thing with containers, all the applications shouldn&#8217;t be always in containers but if you can re-code your app to split it into <em>micro-services</em> to make it better would you do it (That probably means spending large amounts of money)?</span>

<span style="font-family: Nunito; font-size: 16px;">Anyway, why I am choosing this topic?</span>

<span style="font-family: Nunito; font-size: 16px;">I think it&#8217;s a great opportunity to finally take a look into this area where developers need to push updates to production apps in the faster way possible. We saw that even VMware focused on Kubernetes in their product catalog so maybe you should take a look as well&#8230;</span>

<span style="font-family: Nunito; font-size: 16px;">But not because VMware did it nevertheless, we are moving to a faster and automated world where everything is becoming more and more automatized.  </span>

<span style="font-family: Nunito; font-size: 16px;">Just deploying containers and building micro-services will make you the coolest guy in the world but in my opinion, knowing the use cases and some tools to provision and automate lots of items will make you smarter.</span>

<span style="font-family: Nunito; font-size: 16px;">I believe that this will help me to gain knowledge in those areas and advance in my career, therefore, I will be sharing all the useful information I researched during the entire project.</span>

<img loading="lazy" class="alignnone wp-image-1851 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2020/10/could-devops-mean-using-all-the-tools-i-can-at-once.jpg" alt="" width="480" height="480" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/10/could-devops-mean-using-all-the-tools-i-can-at-once.jpg 480w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/could-devops-mean-using-all-the-tools-i-can-at-once-300x300.jpg 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/could-devops-mean-using-all-the-tools-i-can-at-once-150x150.jpg 150w" sizes="(max-width: 480px) 100vw, 480px" /> 

# <span style="font-family: Nunito; color: #000000; font-size: 32px;">How?</span>

<span style="font-family: Nunito; font-size: 16px;">It is known that there many ways to build a CI/CD pipeline and <strong>many</strong> tools that you can use for each phase but in this project, I will try to start with the «foundation» of the main tools used (Container runtime, Container Orchestrator, Configuration and provision management, etc.).</span>

<span style="font-family: Nunito; font-size: 16px;">All of them would be hosted in on-premise infrastructure, instead of going to the cloud where there are a lot of tools that integrates many things and will help you to avoid problems and headaches.</span>

<span style="font-family: Nunito; font-size: 16px;">So basically, I am aiming to <strong>build everything on-premise</strong> except the service itself (which will be a web application) that would be hosted in the cloud, in order to achieve a better service in terms of availability, resiliency, etc.</span>

<img loading="lazy" class="alignnone wp-image-1848 " src="http://wp.docker.localhost:8000/wp-content/uploads/2020/10/yoda_devops.jpg" alt="" width="398" height="398" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/10/yoda_devops.jpg 640w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/yoda_devops-300x300.jpg 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/yoda_devops-150x150.jpg 150w" sizes="(max-width: 398px) 100vw, 398px" /> 

<span style="font-size: 16px;">Therefore,<strong> a mix of on-premise and cloud CI/CD pipeline is the objective</strong> with the main focus on the process and not the code of the application.</span>

<span style="font-size: 16px;">That doesn&#8217;t mean that the process where the developer has to push code to a repository (CI) will be neglected, in fact, probably some tools for the developer will be cloud-based due to the simplicity that adds but can&#8217;t ensure that this will be my final approach</span>

&nbsp;

# <span style="font-family: Nunito; color: #000000; font-size: 32px;">Summary</span>

<img loading="lazy" class="alignnone wp-image-1852 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2020/10/i-know-devops-maybe-not.jpg" alt="" width="853" height="480" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/10/i-know-devops-maybe-not.jpg 853w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/i-know-devops-maybe-not-300x169.jpg 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/i-know-devops-maybe-not-768x432.jpg 768w" sizes="(max-width: 853px) 100vw, 853px" /> 

<span style="font-size: 16px; font-family: Nunito;">In short, I am aiming to gain knowledge about this new area where developers and operations meet, and «everything» is automated (or at least a great part of it).</span>

<span style="font-size: 16px; font-family: Nunito;">Although there are many tools to build a CI/CD pipeline, learning which tools to use on each phase, how and why are chosen will be key in order to understand clearly the whole process from a technical perspective.</span>

<span style="font-family: Nunito; font-size: 16px;">I forgot to mention that, there are other things like IaC (Infrastructure as Code) and Control Version which are handy everywhere but especially in this environment as with code you can have different versions and avoid more errors than provisioning resources manually.<br /> </span>

&nbsp;

&nbsp;