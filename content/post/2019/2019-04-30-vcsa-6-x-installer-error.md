---
title: 'vCSA 6.x installer error: “No networks on the host. Cannot proceed with the installation.»'
author: itgaiden
type: post
date: 2019-04-30T08:00:57+00:00
url: /?p=836
rank_math_primary_category:
  - 11
rank_math_description:
  - A solution to a particular error while deploying a new vCenter server appliance with an embedded PSC.
rank_math_focus_keyword:
  - vCSA installer error
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - vCenter
  - VMware
  - vSphere
tags:
  - port group
  - vCenter
  - vcsa
  - VMware

---
<span style="font-family: Didact Gothic;"><span style="font-size: 16px;">This is a quick post of an error I found sometimes</span><span style="font-size: 16px;"> while deploying a new vCenter server appliance with an embedded PSC on the vCSA 6.x installer.</span></span>

### <span style="font-family: Didact Gothic;">The problem</span>

<span style="font-size: 16px; font-family: Didact Gothic;">In my case, I was trying to install vCSA 6.5 without DNS (this is why the system name has an IP address and the DNS is itself). Also, notice that the <strong>network section is empty</strong>:</span>

<span style="font-size: 16px; font-family: Didact Gothic;"><img loading="lazy" class="alignnone wp-image-842 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/04/vcsa_installer_wonw.jpg" alt="" width="582" height="427" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/04/vcsa_installer_wonw.jpg 582w, http://wp.docker.localhost:8000/wp-content/uploads/2019/04/vcsa_installer_wonw-300x220.jpg 300w" sizes="(max-width: 582px) 100vw, 582px" /></span>

<span style="font-family: Didact Gothic; font-size: 16px;">If you try to continue with the installation, it will show you an error:</span>

> <span style="font-family: Didact Gothic; font-size: 16px;">No networks on the host. Cannot proceed with the installation.</span>

&nbsp;

### <span style="font-family: Didact Gothic;">Solution</span>

<span style="font-size: 16px; font-family: Didact Gothic;">I checked the ESXi host and obviously, it has other port groups created in a standard virtual switch, then, which was the problem? Why I can&#8217;t see them in the drop-down list?<br /> </span>

&nbsp;

<span style="font-family: Didact Gothic; font-size: 16px;">Checking on the internet I found this: <a href="https://serverfault.com/questions/886776/vcenter-server-appliance-6-5-installer-error-no-networks-on-the-host-cannot-p">https://serverfault.com/questions/886776/vcenter-server-appliance-6-5-installer-error-no-networks-on-the-host-cannot-p</a></span>

<span style="font-family: Didact Gothic; font-size: 16px;">So, that web page mentions the «VM network» port group that is a default port group that is created once you deploy an ESXi host. In my case, it was auto-deployed with different port groups and that one didn&#8217;t exist.</span>

<span style="font-family: Didact Gothic; font-size: 16px;">Hence, I decided to <strong>create a port group called «VM Network»</strong> in the host that I am trying to deploy the vCSA and&#8230;it worked!</span>

<span style="font-family: Didact Gothic; font-size: 16px;"><img loading="lazy" class="alignnone size-full wp-image-843" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/04/vcsa_installer_wnw.jpg" alt="" width="598" height="290" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/04/vcsa_installer_wnw.jpg 598w, http://wp.docker.localhost:8000/wp-content/uploads/2019/04/vcsa_installer_wnw-300x145.jpg 300w" sizes="(max-width: 598px) 100vw, 598px" /></span>

<span style="font-family: Didact Gothic; font-size: 16px;">Now, as you can see, I can see that port group and I was able to <strong>continue the installation with success</strong>!</span>

<span style="font-family: Didact Gothic; font-size: 16px;">It seems that with you must have this port group if you are deploying a vCSA at least from your PC, so, bear in mind if you are trying to deploy a new vCSA and you don&#8217;t have the default port groups when deploying a vCenter Server.</span>

&nbsp;

<span style="font-size: 16px;">I hope this helps if someone has this issue.</span>