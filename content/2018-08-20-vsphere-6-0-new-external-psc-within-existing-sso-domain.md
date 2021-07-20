---
title: 'vSphere 6.0: New external PSC within existing SSO Domain'
author: itgaiden
type: post
date: 2018-08-20T14:30:12+00:00
url: /?p=190
rank_math_primary_category:
  - 11
rank_math_focus_keyword:
  - external psc
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - vCenter
  - VMware
tags:
  - PSC
  - vCenter
  - VMware

---
<span style="font-size: 16px; font-family: Didact Gothic;">Hello there!</span>

<span style="font-size: 16px; font-family: Didact Gothic;">A quick post talking about a new external PSC in vSphere 6.0 environments.</span>

<span style="font-size: 16px; font-family: Didact Gothic;">As you may now the <strong>vCenter product</strong> is composed by the PSC (Platform Services Controller) and the vCenter component.</span>

### <span style="font-size: 16px; font-family: Didact Gothic;">Services provided by each component:</span>

<table style="height: 187px; width: 100.458%; border-collapse: collapse; border-style: solid;" border="1">
  <tr style="height: 10px;">
    <td style="width: 50%; height: 10px; text-align: center;">
      <span style="font-family: Didact Gothic;"><strong><span style="background-color: #ffffff; color: #000000; font-size: 12pt;">Platform Services Controller</span></strong></span>
    </td>
    
    <td style="width: 50%; height: 10px; text-align: center;">
      <span style="font-family: Didact Gothic;"><strong><span style="background-color: #ffffff; color: #000000; font-size: 12pt;">vCenter</span></strong></span>
    </td>
  </tr>
  
  <tr style="height: 27px;">
    <td style="width: 50%; height: 27px; text-align: center;">
      <span style="font-size: 10pt; font-family: Didact Gothic;">vCenter Single Sign-On</span>
    </td>
    
    <td style="width: 50%; height: 27px; text-align: center;">
      <span style="font-size: 10pt; font-family: Didact Gothic;">PostgreSQL or SQL Express (in 6.0 version)</span>
    </td>
  </tr>
  
  <tr style="height: 27px;">
    <td style="width: 50%; height: 27px; text-align: center;">
      <span style="font-size: 10pt; font-family: Didact Gothic;">VMware Certificate Authority</span>
    </td>
    
    <td style="width: 50%; height: 27px; text-align: center;">
      <span style="font-size: 10pt; font-family: Didact Gothic;">vSphere Web Client</span>
    </td>
  </tr>
  
  <tr style="height: 27px;">
    <td style="width: 50%; height: 27px; text-align: center;">
      <span style="font-size: 10pt; font-family: Didact Gothic;">vSphere License Service</span>
    </td>
    
    <td style="width: 50%; height: 27px; text-align: center;">
      <span style="font-size: 10pt; font-family: Didact Gothic;">vSphere Client</span>
    </td>
  </tr>
  
  <tr style="height: 27px;">
    <td style="width: 50%; height: 27px; text-align: center;">
    </td>
    
    <td style="width: 50%; height: 27px; text-align: center;">
      <span style="font-size: 10pt; font-family: Didact Gothic;">vSphere ESXi Dump Collector</span>
    </td>
  </tr>
  
  <tr style="height: 10px;">
    <td style="width: 50%; height: 10px; text-align: center;">
    </td>
    
    <td style="width: 50%; height: 10px; text-align: center;">
      <span style="font-size: 10pt; font-family: Didact Gothic;">vSphere Syslog Collector</span>
    </td>
  </tr>
  
  <tr style="height: 27px;">
    <td style="width: 50%; height: 27px; text-align: center;">
    </td>
    
    <td style="width: 50%; height: 27px; text-align: center;">
      <span style="font-size: 10pt; font-family: Didact Gothic;">vSphere Auto Deploy</span>
    </td>
  </tr>
  
  <tr style="height: 32px;">
    <td style="width: 50%; height: 32px; text-align: center;">
    </td>
    
    <td style="width: 50%; height: 32px; text-align: center;">
      <span style="font-size: 10pt; font-family: Didact Gothic;">vSphere Update Manager<br /> </span>
    </td>
  </tr>
</table>

<p style="text-align: left;">
  <span style="font-size: 16px; font-family: Didact Gothic;">Let&#8217;s go to the point. I am going to repoint a vCenter with an embedded PSC (a vCSA called «pokecenter») to an external PSC I created in a Windows server called «digicenter» (I know is kinda original). <span style="text-decoration: underline;">Digicenter</span> is already joined to the same SSO domain as <span style="text-decoration: underline;">pokecenter</span>.<br /> </span>
</p>

* * *

<span style="font-family: Didact Gothic; font-size: 16px;"><strong>Note:</strong> If you have any problem when adding an external PSC to an existing SSO domain, check <strong>cmsso-util unregister </strong>command in the vCSA appliance. In my case, I had to re-install it three times and in the last one, I used the command. </span>

<span style="font-size: 16px; font-family: Didact Gothic;">More information in KB: <a href="https://kb.vmware.com/s/article/2114233">https://kb.vmware.com/s/article/2114233</a></span>

* * *

<span style="font-size: 16px; font-family: Didact Gothic;">In the vCenter with embedded PSC, I will connect through SSH and repoint my vCenter to the external Windows PSC «digicenter».</span>

<span style="font-size: 16px; font-family: Didact Gothic;">The command is: <strong>cmsso-util reconfigure –-repoint-psc digicenter.pokemon.jp &#8211;username administrator &#8211;domain-name vsphere</strong>.<strong>local &#8211;passwd VMware1!</strong></span>

<span style="font-family: Didact Gothic;"><img loading="lazy" class="alignnone size-full wp-image-197 alignleft" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/cmsso_beforelaunch.png" alt="" width="803" height="106" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/cmsso_beforelaunch.png 803w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/cmsso_beforelaunch-300x40.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/cmsso_beforelaunch-768x101.png 768w" sizes="(max-width: 803px) 100vw, 803px" /></span>

<p style="text-align: left;">
  <span style="font-family: Didact Gothic;"><span style="font-size: 12pt;">Now, ti<span style="font-size: 16px;">me to wait, it will take a couple of minutes as the text says:</span></span><span style="font-size: 16px;"><img loading="lazy" class="size-full wp-image-196 alignleft" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/repointingpsc_2.png" alt="" width="796" height="110" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/repointingpsc_2.png 796w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/repointingpsc_2-300x41.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/repointingpsc_2-768x106.png 768w" sizes="(max-width: 796px) 100vw, 796px" /></span></span>
</p>

<span style="font-family: Didact Gothic; font-size: 16px;"> And after the pass, successful!<img loading="lazy" class="size-full wp-image-199 aligncenter" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/repointingpscSUCCESS_3.png" alt="" width="792" height="335" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/repointingpscSUCCESS_3.png 792w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/repointingpscSUCCESS_3-300x127.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/repointingpscSUCCESS_3-768x325.png 768w" sizes="(max-width: 792px) 100vw, 792px" /></span>

&nbsp;

<span style="font-family: Didact Gothic; font-size: 16px;">Hence, our vCenter «pokecenter» has an external PSC «digicenter». We can check it in vCenter > Manage > Settings > Advanced Settings:<img loading="lazy" class="alignnone size-full wp-image-198" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/repoint_correct_4.png" alt="" width="984" height="463" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/repoint_correct_4.png 984w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/repoint_correct_4-300x141.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/repoint_correct_4-768x361.png 768w" sizes="(max-width: 984px) 100vw, 984px" /></span>

### <span style="font-family: Didact Gothic; color: #000000;">So&#8230;</span>

<span style="font-family: Didact Gothic; font-size: 16px;">If found some problems when repointing to the external PSC,  make sure the time on both servers is the same (check NTP server), also DNS resolution of the external PSC. Give some time for the vSphere Client to initialize after the repointment.</span>

<span style="font-size: 16px; font-family: Didact Gothic;">Finally, be patient, I found some errors (SSO errors about the external PSC) when login to the vSphere Web Client but, after waiting about 10 minutes finally it initialized up successfully.</span>