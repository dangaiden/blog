---
title: 'VMkernel: vMotion and Provisioning in dedicated TCP/IP stacks'
author: itgaiden
type: post
date: 2018-07-23T18:19:09+00:00
url: /?p=125
rank_math_primary_category:
  - 11
rank_math_description:
  - We will discuss vMotion and Provisioning in dedicated TCP/IP stacks. It can help you to decide which TCP/IP stack to use when configuring your network.
rank_math_focus_keyword:
  - vmkernel
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - Network
  - VMware
tags:
  - networking
  - VMware
  - vswitch

---
<span style="font-size: 16px; font-family: Nunito;">It’s been a while since I posted something, but I was busy with university duties and to be honest I couldn’t spend time on publishing things but, here we are!</span>

<span style="font-size: 16px; font-family: Nunito;">First, I am currently studying for the <strong>VCAP6 &#8211; DCV Deployment Exam (3V0-623) </strong>and I am learning a lot with it, so maybe I will post more topics related with.</span>

<span style="font-size: 16px; font-family: Nunito;">Today I am going to talk about <strong>TCP/IP stacks in VMkernels </strong>(for vSphere 6). This is a thing that I didn’t care so much when I studied for the VCP6-DCV but now with the VCAP and all the time spent in the lab I thought that it was a great topic to talk!</span>

<span style="font-size: 16px; font-family: Nunito;">So, get down to brass tacks.</span>

<span style="font-size: 16px; font-family: Nunito;">Just as a reminder, a VMkernel port is a port you create in an ESXi host to connect with the “outside world” (outside the host), so when you want to communicate two hosts, each host will have a VMkernel port to communicate.</span>

## <span style="font-size: 24px; font-family: Nunito; color: #000000;">TCP/IP stacks</span>

<span style="font-size: 16px; font-family: Nunito;">A TCP/IP stack is a set of networking protocols (Do you remember the OSI Model?) used to provide networking support for the services that it handles. So you can use different stacks to support in different ways a service within the stack.</span>

<span style="font-size: 16px; font-family: Nunito;">A quick look at the services you can choose when creating a VMkernel port:<img loading="lazy" class="alignnone size-full wp-image-137" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/07/services_vmk-1.png" alt="" width="400" height="203" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/07/services_vmk-1.png 400w, http://wp.docker.localhost:8000/wp-content/uploads/2018/07/services_vmk-1-300x152.png 300w" sizes="(max-width: 400px) 100vw, 400px" /></span>

<span style="font-size: 16px; font-family: Nunito;">I am not going to explain each one because we are going to focus on <strong>vMotion and Provisioning traffic</strong>.<br /> </span>

<span style="font-size: 16px; font-family: Nunito;">Continuing with TCP/IP stacks, when you create a new VMkernel in an ESXi host, you can choose which services do you want to enable:  <img loading="lazy" class="alignnone wp-image-136" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/07/addNW-1.png" alt="" width="599" height="394" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/07/addNW-1.png 647w, http://wp.docker.localhost:8000/wp-content/uploads/2018/07/addNW-1-300x198.png 300w" sizes="(max-width: 599px) 100vw, 599px" /></span>

<span style="font-size: 16px; font-family: Nunito;">Regarding vMotion and Provisioning TCP/IP stacks you could do it in two ways:</span>

<ul style="list-style-type: square;">
  <li>
    <span style="font-size: 16px; font-family: Nunito;">For vMotion, for example, you can do the following (this is the most common configuration, Default TCP/IP stack with a service Enabled):<img loading="lazy" class="alignnone size-full wp-image-138" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/07/vmkopt1-1.png" alt="" width="649" height="429" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/07/vmkopt1-1.png 649w, http://wp.docker.localhost:8000/wp-content/uploads/2018/07/vmkopt1-1-300x198.png 300w" sizes="(max-width: 649px) 100vw, 649px" /></span>
  </li>
  <li>
    <span style="font-size: 16px; font-family: Nunito;">Or (Dedicated TCP/IP stack):<img loading="lazy" class="alignnone size-full wp-image-135" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/07/vmkopt2-1.png" alt="" width="654" height="431" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/07/vmkopt2-1.png 654w, http://wp.docker.localhost:8000/wp-content/uploads/2018/07/vmkopt2-1-300x198.png 300w" sizes="(max-width: 654px) 100vw, 654px" /></span>
  </li>
</ul>

<span style="font-size: 16px; font-family: Nunito;">I must admit I always use the first one, the Default TCP/IP stack with the service enabled, so which should we use, the dedicated stack or the default one?</span>

## <span style="font-size: 24px; font-family: Nunito; color: #000000;">Dedicated TCP/IP stack options</span>

  * <span style="font-size: 16px; font-family: Nunito;"><strong><em>vMotion:</em> </strong>It provides better isolation (more security), a separate set of buffers and sockets and avoids routing table conflicts than using the same TCP/IP Stack.</span>
  * <span style="font-size: 16px; font-family: Nunito;"><strong><em>Provisioning:</em> </strong> Used for cold VM migration (migrate power-off VMs), cloning and snapshot traffic.</span>

<span style="font-size: 16px; font-family: Nunito;">So, I discussed with some people because I wanted to know which benefit could give you to use the dedicated TCP/IP stacks and this is what I gathered:<br /> </span>

  * <span style="font-size: 16px; font-family: Nunito;"><strong>For vMotion:</strong> As a short answer, I would say, that if you need to do <strong>Cross vCenter vMotion</strong> you will need it because the dedicated stack gives you a  Layer 3 VMkernel, meaning routing. With a dedicated stack, you can change the Gateway and DNS used in the default TCP/IP stack, meaning that you don&#8217;t have to use the same stack options that other services.do.</span>
  * <span style="font-size: 16px; font-family: Nunito;"><strong>For Provisioning traffic:</strong> If you have massive data coming from snapshots or cloning, is better that you use this dedicated stack instead of the default one.</span>

<span style="font-size: 16px; font-family: Nunito;">In the end, this is my recap and I hope it can help someone that is not familiar with it. Obviously, you could <strong>use the dedicated TCP/IP stack</strong> whenever you want but bear in mind that <strong>it will disable that service in the rest of the VMkernels</strong>.<br /> </span>

<span style="font-size: 16px; font-family: Nunito;">Anyway, if you think that I missed or want to discuss something, let me know in the comments!</span>