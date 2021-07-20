---
title: VM showing disk size is 0 MB
author: itgaiden
type: post
date: 2018-10-03T11:15:37+00:00
url: /?p=348
rank_math_primary_category:
  - 11
rank_math_description:
  - VM showing disk size is 0 MB in vSphere Web Client
rank_math_focus_keyword:
  - disk size
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - VMware
tags:
  - disk error
  - VMware

---
<span style="font-size: 16px; font-family: Nunito;">Some time ago, I was doing some clean up on VMs that have attached an image file, when I found a particular VM with strange behavior, each disk from the VM (local and RDM disks) was showing 0 MB of disk size:</span>

<img loading="lazy" class="alignnone wp-image-360" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/10/error0MB_SQL08.png" alt="" width="663" height="283" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/10/error0MB_SQL08.png 640w, http://wp.docker.localhost:8000/wp-content/uploads/2018/10/error0MB_SQL08-300x128.png 300w" sizes="(max-width: 663px) 100vw, 663px" /> 

<span style="font-family: Nunito; font-size: 16px;">So, what I did? </span>

<span style="font-family: Nunito; font-size: 16px;">First of all, I checked the guest OS and verified that it was up and running. So I was wondering how the guest OS seems correct but vSphere Web Client (I refreshed several times the browser) was showing no space in all disks and I verified in the Datastores that the .vmdk files were there.</span>

### <span style="font-family: Nunito; color: #000000;">Investigation</span>

<span style="font-size: 16px; font-family: Nunito;">I found in the Events tab for this VM, an error about a snapshot a few weeks ago that it wasn&#8217;t successfully created (from the 3rd party Software), so, maybe this problem is related to the snapshots?</span>

<span style="font-family: Nunito; font-size: 16px;">I verified the .vmx file configuration and check that was correct, also reviewing each descriptor file (vmdk), they were pointing to the disk data (vmdk-flat) that really exists in the datastore, so it couldn&#8217;t be a problem related to snapshots.<br /> </span>

<span style="font-family: Nunito;"><span style="font-size: 16px;">Anyway, I logged out and logged in just to verify that it wasn&#8217;t a problem of the vSphere Web client but it showed the same (no luck), all disks (LUNs and disks) </span><span style="font-size: 16px;">attached to that VM showed</span><span style="font-size: 16px;"> 0 MB .<br /> </span></span>

### <span style="font-family: Nunito; color: #000000;">Conclusion</span>

<span style="font-family: Nunito;"><span style="font-size: 16px;">Well, it&#8217;s an easy solution, if you power-off the VM, unregister and register the VM in the vCenter then</span><span style="font-size: 16px;">&#8230; it works! The VM appeared as usual (showing the allocated space for each disk).<br /> </span></span>

<span style="font-family: Didact Gothic; font-size: 14px;"><span style="font-size: 16px; font-family: Nunito;">Hence, which was the error? I can&#8217;t assure which was the error but maybe something happened to the .vmx file and unregistering and registering the VM again «repaired» the VM configuration file.</span><br /> </span>