---
title: Is the applications’ future «containe(r)d»?
author: itgaiden
type: post
date: 2020-10-31T20:32:17+00:00
url: /?p=1866
categories:
  - DevOps
  - VMware
tags:
  - containers
  - virtualization

---
<span style="font-family: Nunito; font-size: 16px;">Well, I&#8217;ll be lying if I haven&#8217;t heard of containers in the past years although I used them barely at my job (solutions engineer) shouldn&#8217;t I consider them more every time to replace the applications where my customers have their servers?</span>

<span style="font-family: Nunito; font-size: 16px;">Like many people that work as sysadmin these days, they are used to work with virtualization, in particular <strong>Virtual Machines (VMs)</strong>, customers still using them (and it will continue) to deploy their applications in an OS which delivers great benefits against the legacy approach of the Baremetal (Mainframe) era.</span>

<span style="font-family: Nunito; font-size: 16px;">Although there are other ways to deploy your applications (always depends on your application but we are taking a general approach), containers are always in the mind of Cx0 people because of their advantages against virtualization and the trend that has become in the past years.</span>

<span style="font-family: Nunito; font-size: 16px;">But, which is the correct approach for an application? As always, it depends but I am going to talk about the technologies used now and the trend that I can see.</span>

<span style="font-family: Nunito;"><img loading="lazy" class="alignnone wp-image-1867 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2020/10/containers-vm-bare-metal.png" alt="" width="797" height="399" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/10/containers-vm-bare-metal.png 797w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/containers-vm-bare-metal-300x150.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/containers-vm-bare-metal-768x384.png 768w" sizes="(max-width: 797px) 100vw, 797px" /></span>

# <span style="font-family: Nunito; color: #000000; font-size: 32px;">Talking about virtualization&#8230;</span>

<span style="font-family: Nunito; font-size: 16px;">For many years, virtual machines have been the way to go to deploy applications within servers. You seize the hardware by running an «OS» (hypervisor) and inside of it, you<strong> run your VMs where you can assign virtual resources as you desire</strong>.</span>

<span style="font-family: Nunito; font-size: 16px;">This has been (and it continues) to be the first approach for many new companies as it&#8217;s now quite standardized.</span>

<span style="font-family: Nunito; font-size: 16px;">In my opinion, I think that VMware is the most famous provider by offering their Hypervisor ESXi, which has proved to be the standard for VMs.</span>

<span style="font-family: Nunito; font-size: 16px;">I am not going to dive in on this as you can search for more information on Google (or whatever search engine you like to use).</span>

&nbsp;

# <span style="font-family: Nunito; font-size: 32px; color: #000000;">Talking about containers&#8230;</span>

<span style="font-family: Nunito; font-size: 16px;">It&#8217;s known that the most famous container runtime is <strong>Docker</strong> although <strong>Podman</strong> seems to be the direct rival (perspective only from my understanding, which is little)</span>

<span style="font-family: Nunito; font-size: 16px;">Also, the benefits of segmenting your applications on different services (containers) will normally let you escalate, perform, etc. better than running it on VMs</span>

<span style="font-family: Nunito; font-size: 16px;">The <strong>principal benefit of running services in containers</strong> is that you have a single OS where each container runs on it. All dependencies for the application you are deploying in the container are «in the OS» and this isolation is managed by the container runtime (Docker in the image that you see below):</span>

<span style="font-family: Nunito;"><img loading="lazy" class="alignnone size-full wp-image-1868" src="http://wp.docker.localhost:8000/wp-content/uploads/2020/10/containers_versus_virtual_machines.png" alt="" width="984" height="604" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/10/containers_versus_virtual_machines.png 984w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/containers_versus_virtual_machines-300x184.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/containers_versus_virtual_machines-768x471.png 768w" sizes="(max-width: 984px) 100vw, 984px" /></span>

# <span style="font-family: Nunito; color: #000000; font-size: 32px;">Is there a mix? Something&#8230;</span>

<span style="font-family: Nunito; font-size: 16px;">The main problem I saw the first time when I saw how the container runtime works is, how «isolated» is each container from each other? What about a <strong>security breach in the OS</strong>?</span>

<span style="font-family: Nunito; font-size: 16px;">And then it&#8217;s when I found a mix of both worlds (which I really need to dig into it).</span>

<span style="font-family: Nunito; font-size: 16px;"><a href="https://katacontainers.io/"><strong>Kata Containers</strong></a>, a promising Open Source project where it <strong>combines both worlds and trying to deliver the best features from both technologies</strong>.<img loading="lazy" class="alignnone size-full wp-image-1869" src="http://wp.docker.localhost:8000/wp-content/uploads/2020/10/Kata-Containers.png" alt="" width="2999" height="1902" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/10/Kata-Containers.png 2999w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/Kata-Containers-300x190.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/Kata-Containers-1024x649.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/Kata-Containers-768x487.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/Kata-Containers-1536x974.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/Kata-Containers-2048x1299.png 2048w, http://wp.docker.localhost:8000/wp-content/uploads/2020/10/Kata-Containers-1568x994.png 1568w" sizes="(max-width: 2999px) 100vw, 2999px" /></span>

<span style="font-family: Nunito; font-size: 16px;">By running a dedicated kernel (part of the operating system) you provide isolation from many resource perspectives like network, memory, and I/O for example without the performance disadvantatges that virtual machines have.</span>

<span style="font-family: Nunito; font-size: 16px;">Removes the necessity of nesting containers in virtual machines (which I do like in some environments to provide the isolation that a container runtime can provide).</span>

<span style="font-family: Nunito; font-size: 16px;">Obviously not everything is good and it has some limitations like Networking, Host Resource and more. You can find them <a href="https://github.com/kata-containers/documentation/blob/master/Limitations.md">here</a></span>

# <span style="font-family: Nunito; font-size: 32px; color: #000000;">Summary</span>

<span style="font-size: 16px; font-family: Nunito;">We don&#8217;t know the future but for sure containers are still a trend for many years.</span>

<span style="font-size: 16px; font-family: Nunito;">You can see that even VMware embedded Kubernetes (Container orchestrator) in their products.</span>

<span style="font-size: 16px; font-family: Nunito;">So it will be everything containers, a mix of containers and VMs or something like Kata Containers could be the next thing?</span>

<span style="font-size: 16px; font-family: Nunito;">We will see, for now, let me research more in this last open-source project and see how it really delivers!</span>

&nbsp;