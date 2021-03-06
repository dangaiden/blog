---
title: Increasing the heap memory on vCSA 6.7 services
author: itgaiden
type: post
date: 2020-08-31T09:00:11+00:00
url: 2020-08-31-increasing-the-heap-memory-on-vcsa-6-7-services
categories:
  - vCenter
  - VMware
  - vSphere
tags:
  - vcsa

---
<span >For some reason, our monitoring alerted that the service “vsphere-ui” from the vCSA it was having some problems randomly. From the user perspective only we noticed some slowness when navigating within the HTML5 client.</span>

<span >I took a quick view of the VAMI I saw this message from the <strong>VMware vSphere Client</strong> service:</span>

<span style="font-family: courier new, courier;">The server is running low on heap memory (>90% utilized.)</span>

<span >So it was time to solve those random alerts about memory utilization.</span>

# 

# <span style="font-family: Nunito;  font-size: 32px;">Let&#8217;s work a bit&#8230;</span>

<span >Accessing the vCSA via SSH (using PuTTY):</span>

<img loading="lazy" class="alignnone wp-image-1818 " src="/wp-content/uploads/2020/08/2020-08-21-11_52_42-Remote-Desktop-Manager-AMZ.png" alt="" width="620" height="888" srcset="/wp-content/uploads/2020/08/2020-08-21-11_52_42-Remote-Desktop-Manager-AMZ.png 825w, /wp-content/uploads/2020/08/2020-08-21-11_52_42-Remote-Desktop-Manager-AMZ-209x300.png 209w, /wp-content/uploads/2020/08/2020-08-21-11_52_42-Remote-Desktop-Manager-AMZ-715x1024.png 715w, /wp-content/uploads/2020/08/2020-08-21-11_52_42-Remote-Desktop-Manager-AMZ-768x1100.png 768w" sizes="(max-width: 620px) 100vw, 620px" /> 

<span >I can see the service has 1110 MB assigned. So as the deployed VM for the vCenter Server appliance has 16GB of RAM allocated(you can see it anyway how much is being assigned in the previous screenshot), </span><span >I decided to give it ~1.5x (1665MB) but in powers of 2!:<br /> </span><span >512+1024 = 1536 MB . </span>

<span >Executed:</span>

[powershell]cloudvm-ram-size -C 1536 vsphere-ui [/powershell]

&nbsp;

<span >Now, restart the affected service:</span>

[powershell]service-control &#8211;stop vsphere-ui;service-control &#8211;start vsphere-ui; [/powershell]

<img loading="lazy" class="alignnone wp-image-1819 size-full" src="/wp-content/uploads/2020/08/2_restart_service.png" alt="" width="1122" height="155" srcset="/wp-content/uploads/2020/08/2_restart_service.png 1122w, /wp-content/uploads/2020/08/2_restart_service-300x41.png 300w, /wp-content/uploads/2020/08/2_restart_service-1024x141.png 1024w, /wp-content/uploads/2020/08/2_restart_service-768x106.png 768w" sizes="(max-width: 1122px) 100vw, 1122px" /> 

<span >And now check the allocated memory for the service we configured:</span><span ><img loading="lazy" class="alignnone wp-image-1820" src="/wp-content/uploads/2020/08/3_vsphereui.png" alt="" width="625" height="40" srcset="/wp-content/uploads/2020/08/3_vsphereui.png 728w, /wp-content/uploads/2020/08/3_vsphereui-300x19.png 300w" sizes="(max-width: 625px) 100vw, 625px" /></span>

<span >It seems that the vCSA itself adjusted the value to what it considers it’s best so nothing that we can modify there. So finally this service memory allocation changed from <strong>1110 MB to 1792 MB</strong>.</span>

<span style="font-family: Nunito;"><img loading="lazy" class="alignnone wp-image-1821 " src="/wp-content/uploads/2020/08/4_service-allocation-after-config.png" alt="" width="490" height="910" srcset="/wp-content/uploads/2020/08/4_service-allocation-after-config.png 510w, /wp-content/uploads/2020/08/4_service-allocation-after-config-162x300.png 162w" sizes="(max-width: 490px) 100vw, 490px" /></span>

&nbsp;

<span ><strong>Final note:</strong> Obviously other services were modified and have allocated less memory, in general, it gathered a bit of memory allocation from each service (the most impacted was <em><strong>vmware-vpxd</strong></em> with ~ 300 MB)</span>

&nbsp;

<span >All this information can be also reviewed in this KB: <a href="https://kb.vmware.com/s/article/2150757">https://kb.vmware.com/s/article/2150757</a></span>

<span style="font-size: 16px; font-family: Nunito;">That&#8217;s all for this quick post!</span>

&nbsp;