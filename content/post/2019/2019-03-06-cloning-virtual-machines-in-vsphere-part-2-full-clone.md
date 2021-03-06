---
title: 'Cloning virtual machines in vSphere series – Part 2: Full clone'
author: itgaiden
type: post
date: 2019-03-06T11:00:54+00:00
url: 2019-03-06-cloning-virtual-machines-in-vsphere-part-2-full-clone
rank_math_primary_category:
  - 11
rank_math_description:
  - Continuing with the cloning virtual machines in vSphere series, today I am going to write about the full clone, how it works and some information about it.
rank_math_focus_keyword:
  - full clone
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - VMware
  - vSphere
tags:
  - clones
  - cloning
  - full clone
  - PowerCLI
  - VMware
  - vSphere

---
<span style="">Continuing with the <strong>cloning virtual machines in vSphere</strong> series, today I am going to write about the full clone, how it works and some useful information about it.<br /> </span>

<span style="">So, let&#8217;s talk about clones&#8230; but just full clones.</span>

<img loading="lazy" class="alignnone wp-image-649 " src="/wp-content/uploads/2019/03/2clones_matrix_v2-1024x576.jpg" alt="clones_thematrix" width="636" height="358" srcset="/wp-content/uploads/2019/03/2clones_matrix_v2-1024x576.jpg 1024w, /wp-content/uploads/2019/03/2clones_matrix_v2-300x169.jpg 300w, /wp-content/uploads/2019/03/2clones_matrix_v2-768x432.jpg 768w, /wp-content/uploads/2019/03/2clones_matrix_v2-1536x864.jpg 1536w, /wp-content/uploads/2019/03/2clones_matrix_v2-1568x882.jpg 1568w, /wp-content/uploads/2019/03/2clones_matrix_v2.jpg 1920w" sizes="(max-width: 636px) 100vw, 636px" /> 

### **<span style="font-size: 24px; font-family: Didact Gothic;">How does it work?</span>**

<span ><span >As you probably know a <strong>f</strong></span><strong><span >ull c</span>lone is an exact copy of a source VM</strong>, meaning that, everything from the parent VM is copied (VM settings, disks, files, etc.).</span>

<span >This action can be performed if the <strong>parent VM is powered off or powered on</strong> and, if it has snapshots it will consolidate them once the clone is done.</span>

<img loading="lazy" class="alignnone wp-image-647" src="/wp-content/uploads/2019/03/FullClone_process-768x739.png" alt="Fullclone_process" width="585" height="563" srcset="/wp-content/uploads/2019/03/FullClone_process-768x739.png 768w, /wp-content/uploads/2019/03/FullClone_process-300x289.png 300w, /wp-content/uploads/2019/03/FullClone_process.png 1001w" sizes="(max-width: 585px) 100vw, 585px" /> 

<span style="">When you clone a VM be aware that, all data will be identical so, if you power on the clone without performing any customization, probably you will have conflicts with IPs, MAC addresses, SIDs (Windows), etc.</span>

<span ><span >The great thing about a full clone is that, after the cloning operations are performed the clone will be an independent copy of a virtual machine that doesn&#8217;t share anything with the parent virtual machine (we are talking about from a </span></span><span >compute<span > and storage perspective within vSphere).</span></span>

### <span ><strong>Ways to do it</strong></span>

<span style="">First of all, you will need VMware vCenter to do it. </span>

<span style="">There are other ways (not official) like copying all data related to the virtual machine (.vmdk and .vmx files) and then register the «new» VM with another name.</span>

<span >Let&#8217;s continue with the usual ways:</span>

#### <span >vSphere Web Client</span>

<span >You can do it through vSphere Web Client, as simple as, right-click a VM -> «Clone to Virtual Machine&#8230;» :</span>

<img loading="lazy" class="alignnone wp-image-638 " src="/wp-content/uploads/2019/03/vSphereWebClient_clone.png" alt="vSphereWebClient_clone" width="637" height="309" srcset="/wp-content/uploads/2019/03/vSphereWebClient_clone.png 881w, /wp-content/uploads/2019/03/vSphereWebClient_clone-300x145.png 300w, /wp-content/uploads/2019/03/vSphereWebClient_clone-768x372.png 768w" sizes="(max-width: 637px) 100vw, 637px" /> 

<span >Once it finishes, it takes some time (depends on the storage that the source VM has allocated) but in the end, you will have your new clone.</span>

<span >Likely you are more familiar about deploying templates&#8230;</span>

<span >Deploying a template is the same as cloning but. aside from copying the same data from the parent virtual machine, vSphere lets you customize the deployed VM for creating many clones and with different configurations as you wish.</span>

#### <span style="font-size: 20px; font-family: Didact Gothic;">PowerCLI</span>

<span >Of course, you can do it with PowerCLI. These are the minimal parameters needed to perform it (<strong>Disk Storage Format</strong> parameter is optional but recommended because, by default, it will convert all disks to Thick Provision Eager Zeroed):</span><img loading="lazy" class="alignnone wp-image-637 " src="/wp-content/uploads/2019/03/PowerCLIwithPercentatge_clone-1024x348.png" alt="PowerCLIwithPercentatge_clone" width="641" height="218" srcset="/wp-content/uploads/2019/03/PowerCLIwithPercentatge_clone-1024x348.png 1024w, /wp-content/uploads/2019/03/PowerCLIwithPercentatge_clone-300x102.png 300w, /wp-content/uploads/2019/03/PowerCLIwithPercentatge_clone-768x261.png 768w, /wp-content/uploads/2019/03/PowerCLIwithPercentatge_clone.png 1228w" sizes="(max-width: 641px) 100vw, 641px" />

<span style="font-size: 14px;"><span style="background-color: #999999;"><span style="background-color: #c7c7c7;"><span style="background-color: #e8e8e8;"><strong>New-VM -Name <CloneName> -VMHost <VMHost> -VM <VirtualMachineSourceVM> [-DiskStorageFormat <VirtualDiskStorageFormat>]</strong></span></span></span></span>

<span >In the previous screenshot, you can see the minimum parameters required to perform a full clone, if you want to see more options you can check it <span style="text-decoration: underline;"><strong><a href="https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.powercli.cmdletref.doc%2FNew-VM.html">here</a>.</strong></span></span>

<span >As you can see in the code, it&#8217;s similar to deploying a template, isn&#8217;t it?</span>

### **<span >Use cases</span>**

<span >The main use case is <strong>deploying from a template</strong>, maybe we are not aware but, deploying from a template is just cloning our source VM (Master template) and then customizing it.</span>

<span >I saw many customers <strong>use it as a «rollback»</strong> when they have to perform a destructive task within the Guest OS. In this way, just shutting down the parent VM and powering on the clone.</span>

<span >If you think a snapshot can do the same as a clone well, not always&#8230; some applications don&#8217;t handle well doing a quiesced snapshot.</span>

<span >This is why, as a solution, you can create a full clone when the virtual machine is powered off and then, have a copy that will be consistent and without corruption.</span>

<span >Another use case could be to perform a full clone to <strong>use it in other environments</strong>. Although there are better ways to do this (with other products), when the Guest OS has many customizations, this can be an alternative solution of re-creating the entire virtual machine.</span>

### <span ><strong>Benefits and limitations</strong><br /> </span>

<span style="">The <strong>benefits</strong> of a full clone were mentioned before: </span>

  * <span style="">If the cloning operation is executed when the source VM is powered off, it can be used as a rollback in many cases (there are better options like a VM backup but, it can help a lot).</span>
  * <span style="">Creation of an independent VM that shares nothing with the source VM. </span>
  * <span style="">Used in templates, so, they are very useful!</span>

<span style="">These are some <strong>limitations</strong> instead of disadvantages that we can find:</span>

  * <span style="">It takes some time to create a full clone (it depends on the allocated storage) as it has to copy all storage from the source VM.</span>
  * <span style="">It can only be performed with VMware vCenter (there are other ways as I explained before but they are not official).</span>
  * <span style="">If done when the VM is powered on, it has an impact on the source VM that can be noticed by the business so, isn&#8217;t the best option to do it while the virtual machine is in running.</span>

### 

### **<span >Conclusion</span>**

<span style="">To sum up, a full clone is a great way to have an identical copy of another VM to use it as a permanent virtual machine once you configure it accordingly.</span>

<span style="">As said before, is the same as deploying a template because you are just cloning a VM (deploying a template) and then customizing it. </span>

<span style="">It usually takes some minutes to finish the clone (depending on the storage allocated in the parent VM), this is why there are other ways to deploy clones in a faster way (on the next posts!).</span>