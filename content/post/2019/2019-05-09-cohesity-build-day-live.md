---
title: Cohesity Build Day Live
author: itgaiden
type: post
date: 2019-05-09T12:00:08+00:00
url: /?p=861
rank_math_primary_category:
  - 61
rank_math_description:
  - In this post, you can read a review of the Cohesity Build Day Live video. The author share some thoughts and opinions about Cohesity and the video.
rank_math_focus_keyword:
  - Cohesity Build Day Live
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - Cohesity
tags:
  - backup
  - Build Day Live
  - cohesity
  - vBrownbag

---
<span style="font-family: Didact Gothic; font-size: 16px;">I am going to share some thoughts and opinions about a recent <a href="https://www.youtube.com/watch?v=pcoSPrS9doU">video</a> from the <strong>Cohesity Build Day Live</strong> recorded recently with the Build Day Live! team.</span>

<span style="font-size: 16px;"><strong>Disclosure:</strong> This post is sponsored by Cohesity.</span>

<span style="font-family: Didact Gothic; font-size: 16px;">First, just let me introduce briefly you what is Cohesity:</span>

<span style="font-size: 16px;"><span style="font-family: Didact Gothic;">Cohesity is a platform focused on managing and </span>consolidating secondary<span style="font-family: Didact Gothic;"> applications and the data. It provides a unified view and access to converge that secondary data, such as system backups and analytics in a simpler way to an IT administrator.</span></span>

&nbsp;

<span style="font-size: 16px;"><span style="font-family: Didact Gothic;">Now, let&#8217;s <span style="font-size: 16px;">deep </span></span>into<span style="font-family: Didact Gothic;"><span style="font-size: 16px;"> the top</span>ic.</span></span>

<span style="font-family: Didact Gothic; font-size: 16px;">In the <a href="https://www.youtube.com/watch?v=pcoSPrS9doU">video</a>, you will see how Alastair Cooke and Bharath Nagaraj building a Cohesity cluster from the scratch, configuring jobs, updating the physical appliance, restoring some data and showing some other cool stuff.</span>

<span style="font-family: Didact Gothic; font-size: 16px;">I really like this kind of videos because, you can see how they install a cluster, configure it or resolve any problems that can happen in real time without cuts.</span>

<span style="font-family: Didact Gothic; font-size: 16px;">Also, you can notice how much time it can take to deploy and configure a Cohesity cluster in some minutes, or even upgrading the whole cluster (node by node) while running some protection jobs (backup jobs).</span>

## **<span style="font-family: Didact Gothic;">Hardware</span>**

<span style="font-size: 16px;"><span style="font-family: Didact Gothic;">In this case, they use a  </span>physical<span style="font-family: Didact Gothic;"> unit for deploying their solution, so it&#8217;s a 2U enclosure with 4 servers/nodes inside (blade server type). </span></span>

<span style="font-size: 16px;"><span style="font-family: Didact Gothic;">It </span>comes,<span style="font-family: Didact Gothic;"> like most other solutions, with 1GB ports for Management purposes and 10GB ports for Production Data.</span></span>

<span style="font-size: 16px;"><span style="font-family: Didact Gothic;">As this is an HCI solution, it comes with the storage and </span>computes<span style="font-family: Didact Gothic;"> resources necessary to process and store all data (PCIe Flash card and hard drives in each node).</span></span>

&nbsp;

## **<span style="font-family: Didact Gothic;">Cluster configuration and UI</span>**

<span style="font-size: 16px;">To configure the cluster you won&#8217;t need a lot of data to fill or knowledge to do it, they configure the cluster easier than I thought and straightforward. </span>

<span style="font-size: 16px;">In a real scenario, a Cohesity engineer will do it for you thus, this is just to let you know of the simplicity of it.</span>

<span style="font-size: 16px;">The UI is simple and clean, the home dashboard looks nice with some graphics regarding your Storage Reduction, Health, Throughput, Protection Runs, etc.</span>

<img loading="lazy" class="alignnone wp-image-884 size-large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Dashboard-1024x507.png" alt="" width="656" height="325" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Dashboard-1024x507.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Dashboard-300x148.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Dashboard-768x380.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Dashboard-1536x760.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Dashboard-2048x1013.png 2048w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Dashboard-1568x776.png 1568w" sizes="(max-width: 656px) 100vw, 656px" /> 

## **<span style="font-family: Didact Gothic;">Backup</span>**

<span style="font-size: 16px;"><span style="font-family: Didact Gothic;">As you probably guess, it backups your vSphere/Hyper-V/Nutanix environment like other products do, so you can configure a Backup Policy with a schedule, time retention, etc. to </span>back up<span style="font-family: Didact Gothic;"> your data and then you configure a Protection job which will be the backup job that is associated to a policy.</span></span>

<span style="font-family: Didact Gothic; font-size: 16px;">Just register the hypervisor of your choice and basically, you&#8217;re ready to back up your virtual servers (VMs). </span>

<span style="font-family: Didact Gothic; font-size: 16px;">One option I really liked when registering a hypervisor was, the option of selecting «Auto Cancel Backup if Datastore is running low on space», so the DataPlatform solution is aware of the datastore&#8217;s space and can avoid you a big problem there&#8230;</span>

<img loading="lazy" class="alignnone wp-image-882 size-large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Auto-Cancel-Backups-1024x598.png" alt="" width="656" height="383" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Auto-Cancel-Backups-1024x598.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Auto-Cancel-Backups-300x175.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Auto-Cancel-Backups-768x448.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Auto-Cancel-Backups-1536x897.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Auto-Cancel-Backups-1568x915.png 1568w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Auto-Cancel-Backups.png 1994w" sizes="(max-width: 656px) 100vw, 656px" /> 

&nbsp;

<span style="font-family: Didact Gothic; font-size: 16px;">About <strong>granularity</strong>, there is a lot of options to select when you create a protection job (DB, Virtual/Physical Servers,  but regarding what you can see in the video they protected only VMs and Office 365 mailboxes in different backup policies.</span>

<span style="font-size: 16px;">It&#8217;s great that when you are creating a protection job (a.k.a. backup job). you can select an object like a cluster or a folder with some particular VMs and then check the «Autoprotect» option to ensure that new VMs that are added to that object (folder, cluster, etc.) will be automatically protected.</span>

<img loading="lazy" class="alignnone wp-image-883 size-large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Autoprotect-1024x460.png" alt="" width="656" height="295" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Autoprotect-1024x460.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Autoprotect-300x135.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Autoprotect-768x345.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Autoprotect-1536x690.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Autoprotect-2048x920.png 2048w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Autoprotect-1568x704.png 1568w" sizes="(max-width: 656px) 100vw, 656px" /> 

&nbsp;

<span style="font-size: 16px;">Regarding <strong>long term retentions</strong>, you can choose to add an external target like a NAS or any cloud (AWS, Azure, GCP, etc.) to store your archive backups there.</span>

 <span style="font-size: 16px;">This is an option that adds great value to your strategy because when storing great amounts of data for several years, you usually don&#8217;t want to store it locally or even in a NAS.</span>

<span style="font-size: 16px;">In my opinion, having a flexible option to store it in any cloud can save you a lot of headaches despite the money that you must pay for the cloud service (which nowadays almost every company does).</span>

<span style="font-size: 16px;">So, within a Backup policy select the Archival option and then you add as many external targets to store your long term backups.</span>

&nbsp;

## **<span style="font-family: Didact Gothic;">Restore</span>**

<span style="font-size: 16px;">Your backup strategy is useless unless you can restore from it&#8230;</span>

<span style="font-size: 16px;">I<span style="font-family: Didact Gothic;"> do like some points about this section that makes so simple to restore, from a single file (even download it) to restore tons of virtual machines to your virtual environment.</span></span>

#### **<span style="font-family: Didact Gothic;">&#8211; Single file restore</span>**

<span style="font-size: 16px; font-family: Didact Gothic;">If you want to <strong>recover a file</strong>, you don&#8217;t have to search for the date, where it was, etc. As simple as searching for the name of the file (or the portion you remember) and it will be searched in the entire cluster for you:<img loading="lazy" class="alignnone size-large wp-image-889" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Single-File-Restore-1024x324.png" alt="" width="656" height="208" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Single-File-Restore-1024x324.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Single-File-Restore-300x95.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Single-File-Restore-768x243.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Single-File-Restore-1536x486.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Single-File-Restore-2048x648.png 2048w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Single-File-Restore-1568x496.png 1568w" sizes="(max-width: 656px) 100vw, 656px" /></span>

<span style="font-size: 16px; font-family: Didact Gothic;">And then, when you found that file, look at the options that we have:<img loading="lazy" class="alignnone size-large wp-image-890" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Single-File-Restore_download-1024x424.png" alt="" width="656" height="272" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Single-File-Restore_download-1024x424.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Single-File-Restore_download-300x124.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Single-File-Restore_download-768x318.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Single-File-Restore_download-1536x635.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Single-File-Restore_download-1568x649.png 1568w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Single-File-Restore_download.png 1888w" sizes="(max-width: 656px) 100vw, 656px" /></span>

First<span style="font-size: 16px; font-family: Didact Gothic;">, search for the date and then,</span> you <span style="font-size: 16px; font-family: Didact Gothic;">can choose the usual </span>option <span style="font-size: 16px; font-family: Didact Gothic;">(Recover to Server) or &#8230; download it at the moment (a cool option there).</span>

<span style="font-family: Didact Gothic;"><span style="font-size: 16px;">It looks like a painless and </span>simple<span style="font-size: 16px;"> way to restore files that probably a non-tech person could do.</span></span>

#### **<span style="font-family: Didact Gothic;">&#8211; Instant mass restore</span>**

<span style="font-size: 16px; font-family: Didact Gothic;">Now, going bigger, let&#8217;s talk about the <strong><a href="https://www.cohesity.com/blog/cohesity-instant-mass-restore-better-solution-to-an-old-problem/">Cohesity instant mass restore</a></strong> of virtual machines. As the Cohesity platform is designed in a <strong>distributed architecture</strong> where there isn&#8217;t a centralized bottleneck, they can restore tons of VMs quite faster than other products.</span>

<span style="font-size: 16px; font-family: Didact Gothic;"><img loading="lazy" class="alignnone size-large wp-image-891" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-IMR-1024x454.png" alt="" width="656" height="291" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-IMR-1024x454.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-IMR-300x133.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-IMR-768x340.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-IMR-1536x680.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-IMR-2048x907.png 2048w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-IMR-1568x695.png 1568w" sizes="(max-width: 656px) 100vw, 656px" />When recovering a lot of VMs, in the background (you could look at your vSphere environment) it will mount </span><span style="font-size: 16px;">an NFS</span> <span style="font-size: 16px; font-family: Didact Gothic;">datastore and bring up all you requested VMs (quite fast to be honest).</span>

#### **<span style="font-family: Didact Gothic;">&#8211; Office 365</span>**

<span style="font-size: 16px;"><span style="font-family: Didact Gothic;">Finally, the last thing to show you is the</span> option to <strong>backup your Office 365</strong> environment. You can integrate Cohesity with your Office 365 and perform protection jobs that will be associated with a policy and consolidate all the data within the same platform.</span>

<img loading="lazy" class="alignnone size-large wp-image-892" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-0365-1024x431.png" alt="" width="656" height="276" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-0365-1024x431.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-0365-300x126.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-0365-768x323.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-0365-1536x646.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-0365-2048x861.png 2048w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-0365-1568x659.png 1568w" sizes="(max-width: 656px) 100vw, 656px" /> 

## **<span style="font-family: Didact Gothic;">Upgrading</span>**

<span style="font-size: 16px;">The process is straightforward, selecting a package from your local computer or getting it from the Internet, this makes it so easy to do it for yourself.</span>

<span style="font-size: 16px;"><span style="font-family: Didact Gothic;">One thing that </span>stuck<span style="font-family: Didact Gothic;"> in my mind was that, while there were running some protection jobs you are able to upgrade the whole cluster (node by node) </span>non-disruptively.<span style="font-family: Didact Gothic;"><br /> </span></span>

<span style="font-family: Didact Gothic; font-size: 16px;">As the entire solution is designed to tolerate one node failure (N+1 redundancy) thus, you can upgrade one node without disruption in the service.</span>

<span style="font-size: 16px;">As we said before, the Cohesity platform i<span style="font-family: Didact Gothic;">s based in a <strong>distributed architecture</strong> so, in case a reboot is required after upgrading one of the nodes, you will only lose the </span>bandwidth<span style="font-family: Didact Gothic;"> coming from that node and not impacting the rest of the environment.</span></span>

## **<span style="font-family: Didact Gothic;">Helios</span>**

<span style="font-size: 16px;"><span style="font-family: Didact Gothic;"><strong>Cohesity Helios</strong> is the console that lets you manage and view all your clusters from one console. As it&#8217;s in the cloud, you only have to register your Cohesity appliance and at the </span>end<span style="font-family: Didact Gothic;">, it will show up in the Helios console.</span></span>

<span style="font-size: 16px;">Helios Dashboard is similar to a Cohesity management dashboard but with the ability to manage all your clusters from that single pane of glass.</span>

<img loading="lazy" class="alignnone wp-image-887 size-large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Helios-Dashboard-1024x489.png" alt="" width="656" height="313" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Helios-Dashboard-1024x489.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Helios-Dashboard-300x143.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Helios-Dashboard-768x367.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Helios-Dashboard-1536x734.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Helios-Dashboard-2048x979.png 2048w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Helios-Dashboard-1568x749.png 1568w" sizes="(max-width: 656px) 100vw, 656px" /> 

<span style="font-size: 16px;">And it&#8217;s just not that&#8230; Helios lets you install applications!</span>

<img loading="lazy" class="alignnone wp-image-886 size-large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Apps-1024x422.png" alt="" width="656" height="270" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Apps-1024x422.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Apps-300x124.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Apps-768x316.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Apps-1536x633.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Apps-2048x844.png 2048w, http://wp.docker.localhost:8000/wp-content/uploads/2019/05/Cohesity-–-Apps-1568x646.png 1568w" sizes="(max-width: 656px) 100vw, 656px" /> 

<span style="font-size: 16px;">Yes, you can choose to install applications in one of your clusters without anything else. What Helios will do is to deploy an app within a container (using Kubernetes) in that cluster without having to worry about the underlying infrastructure.</span>

 <span style="font-size: 16px;">Just install, configure and run your app (as it sounds).</span>

<span style="font-size: 16px;">For example, running Splunk to gather data analytics in your clusters without having to worry about to deploy it is really a nice feature to look at it. </span>

<span style="font-size: 16px;">I&#8217;ve never seen a </span>feature <span style="font-size: 16px;">like that and it really surprised me when I saw it. A nice additional value that you can consider when using Helios with your Cohesity platform.</span>

## **<span style="font-family: Didact Gothic;">Other use cases</span>**

<span style="font-size: 16px;">As the Cohesity platform is cloud and hypervisor agnostic, you can protect objects on any cloud Azure/GCP/AWS or any hypervisor Hyper-V/VMware/Nutanix but, do you imagine what else can <span style="font-family: Didact Gothic;">you do?</span></span>

<span style="font-size: 16px; font-family: Didact Gothic;">Well, you can use it to migrate VMs between different environments! It&#8217;s a great use case where you can choose to backup all your vSphere environment and move it to Nutanix for example or moving it to Azure. </span>

<span style="font-size: 16px; font-family: Didact Gothic;">Obviously, there is work to do after it but, the amount of simplicity that gives you with that, for me, it&#8217;s massive.</span>

## **<span style="font-family: Didact Gothic;">That&#8217;s all&#8230;</span>**

<span style="font-size: 16px;">We saw a lot of things from the Cohesity platform, how can help your company to achieve that data consolidation by:</span><span style="font-size: 16px;"><strong> backing up</strong> from different clouds and environments (cloud and hypervisor agnostic) , <strong>establishing an SLA</strong> in your services (configuring policies),<strong> recovering tons of VMs</strong> and other features like <strong>Helios</strong>, a cloud console that brings you a <strong>unified view for your Cohesity environment</strong>, analytics for all your data and even the ability to deploy applications without needing any kind of resources.</span>

<span style="font-size: 16px;">If you are interested in more content, check the Cohesity Build Day Live <a href="https://builddaylive.com/cohesity/">web page</a> or the official web page from <a href="https://www.cohesity.com/">Cohesity</a>.<br /> </span>

&nbsp;