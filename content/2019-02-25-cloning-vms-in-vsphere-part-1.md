---
title: 'Cloning virtual machines in vSphere series – Part 1: Types of clone'
author: itgaiden
type: post
date: 2019-02-25T10:22:37+00:00
url: /?p=577
rank_math_primary_category:
  - 11
rank_math_description:
  - Series of posts talking about cloning virtual machines in vSphere.This is part 1 of the series and you will find the different types of clones that exists.
rank_math_focus_keyword:
  - cloning virtual machines
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - VMware
  - vSphere
tags:
  - clones
  - VMware
  - vSphere

---
<span style="font-family: Didact Gothic; font-size: 16px;">Most of you already know how to <strong>clone virtual machines within vSphere</strong>, and I mean cloning from the vSphere Web client within vCenter but, beyond that, there are other types of clones you can use in vCenter like, Linked Clones or Instant Clones (aka Project Fargo/VMfork)<br /> </span>

<span style="font-family: Didact Gothic; font-size: 16px;">Due to the large content that can be discussed about each clone&#8217;s type, I decided to make a <strong>short series of posts</strong> talking about cloning VMs!</span>

&nbsp;

# **<span style="font-family: Didact Gothic; font-size: 32px;">Types of clone</span>**

<span style="font-size: 16px; font-family: Didact Gothic;">Here I will summarize each type of clone that exists in vSphere, some of them are used in different products or interfaces but in the end, all of them are accessible through PowerCLI.<br /> </span>

### <span style="font-family: Didact Gothic;"><strong>Full clone</strong></span>

<span style="font-size: 16px; font-family: Didact Gothic;">This is the «classic» clone you can perform in vSphere Web Client no matter which is the VM&#8217;s status (powered on or off), that you can perform a copy of the VM.<br /> </span>

<span style="font-size: 16px; font-family: Didact Gothic;">If you want to perform a consistent clone, it&#8217;s recommended that you power off the VM and then perform the clone.</span>

<span style="font-family: Didact Gothic; font-size: 16px;">This is an <strong>independent</strong> copy and has no dependency from the parent virtual machine after the clone is complete (meaning that you can remove the parent VM if you need it).</span>

<span style="font-family: Didact Gothic; font-size: 16px;">The <strong>main advantage</strong> is that you can have a reliable copy of the Parent VM (remember this is not a backup) if you want to replace it. As this is a full copy of the VM (it will copy the entire disk), this might take several minutes depending on the size of the VM.<br /> </span>

<span style="font-size: 16px; font-family: Didact Gothic;">After you perform it, remember that everything will be the same then, all configuration (SID, network configuration, hostname, etc.) within the VM will be identical hance, it can lead to problems if both VMs co-exist at the same time without the proper configuration.</span>

<figure id="attachment_607" aria-describedby="caption-attachment-607" style="width: 549px" class="wp-caption alignleft"><img loading="lazy" class="wp-image-607" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/02/FullClone-768x505.png" alt="FullClone" width="549" height="361" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/02/FullClone-768x505.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/02/FullClone-300x197.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/02/FullClone.png 977w" sizes="(max-width: 549px) 100vw, 549px" /><figcaption id="caption-attachment-607" class="wp-caption-text">Full clone</figcaption></figure>

### 

### <span style="font-size: 24px; font-family: Didact Gothic;"><strong>Linked clone</strong></span>

<span style="font-family: Didact Gothic; font-size: 16px;">Is a clone<span class="ILfuVd"> made from a snapshot of the Parent VM. This means that both VMs (the Linked clone and the parent VM) have in common virtual disks. </span></span>

<span style="font-family: Didact Gothic; font-size: 16px;"><span class="ILfuVd">So, the linked clone is <strong>dependent</strong> on the parent VM, meaning that the linked clone needs access to the parent VM. The clone must be done while the Parent VM is powered off (as a best practice).<br /> </span></span>

<span style="font-family: Didact Gothic; font-size: 16px;">Once a linked clone is performed, changes on the parent VM doesn&#8217;t affect the linked clone and in the other way, changes in the linked clone don&#8217;t affect the original VM. Mainly the <strong>benefits</strong> of using linked clones are: </span>

<ul style="list-style-type: square;">
  <li>
    <span style="font-family: Didact Gothic; font-size: 16px;">Saving disk space because only the differences between the origin snapshot and the linked clone are allocated and the fast.</span>
  </li>
  <li>
    <span style="font-size: 16px; font-family: Didact Gothic;">Quickly deploy tens or hundreds of VMs in a fast way as it doesn&#8217;t need to copy the entire disk.</span>
  </li>
</ul>

<span style="font-family: Didact Gothic; font-size: 16px;">This is a technology commonly used in VMware Horizon View to provide desktop deployment (rapidly deploy a lot of VMs). The thing is that we can also use it with PowerCLI without having Horizon View and use it for more use cases.</span>

<figure id="attachment_605" aria-describedby="caption-attachment-605" style="width: 526px" class="wp-caption alignleft"><img loading="lazy" class="wp-image-605" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/02/LinkedClone-768x730.png" alt="LinkedClone" width="526" height="500" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/02/LinkedClone-768x730.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/02/LinkedClone-300x285.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/02/LinkedClone.png 961w" sizes="(max-width: 526px) 100vw, 526px" /><figcaption id="caption-attachment-605" class="wp-caption-text">Linked clone</figcaption></figure>

### 

### **<span style="font-family: Didact Gothic;">Instant clone</span>**

<span style="font-size: 16px; font-family: Didact Gothic;">Similar to the linked clone, Instant Clone is like an improved version of linked clone technology. This is something «new» in vSphere 6.7 as is available through the API.<br /> </span>

<span style="font-family: Didact Gothic; font-size: 16px;">Like the linked clone technology, there is a parent VM which will <strong>share the disk</strong> with the clone (Instant clone) but, in this case, it will <strong>share the memory</strong> too (even if TPS is disabled).</span>

<span style="font-family: Didact Gothic; font-size: 16px;">There are two types of Instant Clones that I will explain in more detail in the next posts but, as a summary, you can do an instant clone from a source VM from a point in time and deliver many VMs (instant clones) as you want. </span>

<span style="font-family: Didact Gothic; font-size: 16px;">The Parent VM must be powered-on instead of powered off like other types of clones, in this way, it can provide even a faster way to deploy VMs because it will not require to power-cycle the Instant Clones.<br /> </span>

<span style="font-family: Didact Gothic; font-size: 16px;">As <strong>benefits</strong>, we will have the same as in Linked Clones technology plus memory efficiency (because it shares memory between VMs) and the ability to resume the VM in a point of time without power cycling the clone. </span>

<span style="font-family: Didact Gothic;"><span style="font-size: 16px;">In the other hand, depending on which type of instant clone you can run with a lot of delta disks.</span><br /> </span>

<figure id="attachment_626" aria-describedby="caption-attachment-626" style="width: 656px" class="wp-caption alignnone"><img loading="lazy" class="wp-image-626 size-large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/02/InstantClone-1-1024x614.png" alt="InstantClone" width="656" height="393" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/02/InstantClone-1-1024x614.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/02/InstantClone-1-300x180.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/02/InstantClone-1-768x460.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/02/InstantClone-1.png 1280w" sizes="(max-width: 656px) 100vw, 656px" /><figcaption id="caption-attachment-626" class="wp-caption-text">Instant clone</figcaption></figure>

# <span style="font-family: Didact Gothic; font-size: 32px;">So&#8230;</span>

<span style="font-family: Didact Gothic; font-size: 16px;">I tried to summarize each clone&#8217;s type that we can perform within vSphere and if you want to read more, stay tuned to go in more detail in the coming series of posts related to cloning VMs within vSphere.</span>

&nbsp;