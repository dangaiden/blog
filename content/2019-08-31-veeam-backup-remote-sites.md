---
title: Veeam – Backup VMs in remote sites
author: itgaiden
type: post
date: 2019-08-31T19:00:54+00:00
url: /?p=1018
rank_math_primary_category:
  - 68
rank_math_focus_keyword:
  - backup remote site
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - Backup
  - Veeam
tags:
  - backup
  - refs
  - veeam
  - veeam proxy

---
<span style="font-size: 16px; font-family: Nunito;">I was wondering why I haven&#8217;t talked about Veeam when I use it almost every day in my job, not only administering backups but doing new implementations.</span>

<span style="font-family: Nunito;"><span style="font-size: 16px;">Recently, I had to implement a design where I need to backup VMs in remote sites but not back up them in a centralized storage, they will be backed up on each remote site storage.</span></span>

<span style="font-size: 16px; font-family: Nunito;">So, by deploying a VM with the Backup proxy service and also use it as the backup repository we can accomplish the goal. We will save bandwidth and increase the speed to restore and backup those remote virtual machines by using the local storage on each remote site.</span>

&nbsp;

### <span style="color: #000000; font-family: Nunito;">Scenario</span>

<span style="font-size: 16px; font-family: Nunito;">The scenario I am talking is the following, a dedicated VM with Windows Server 2016 Standard (a.k.a. W2016 STD) to act as a backup proxy and backup repository and Veeam B&R installed on the main site (the cloud we will say).</span>

<span style="font-size: 16px; font-family: Nunito;">This is the high level design:</span>

<img loading="lazy" class="alignnone wp-image-1022 size-large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Veeam_deployment-1024x651.png" alt="Veeam_scenario" width="656" height="417" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Veeam_deployment-1024x651.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Veeam_deployment-300x191.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Veeam_deployment-768x489.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Veeam_deployment-1536x977.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Veeam_deployment-1568x997.png 1568w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Veeam_deployment.png 1613w" sizes="(max-width: 656px) 100vw, 656px" /> 

<span style="font-size: 16px; font-family: Nunito;">So, we are going to back up all the VMs that are hosted in the remote ESXi hosts and also save the backup data in the local storage.</span>

<span style="font-size: 16px; font-family: Nunito;">As said before, in this way we save bandwidth and gain speed in the backup and restore process in case we need to perform any of it.</span>

<span style="font-size: 16px; font-family: Nunito;">We will assume that we have a vCenter deployed with Veeam B&R installed. The Veeam B&R has configured the vCenter and then all remote ESXi hosts.</span>

&nbsp;

### <span style="color: #000000; font-family: Nunito;">Implementation</span>

<span style="font-size: 16px; font-family: Nunito;">The implementation is pretty straightforward, we will have a dedicated VM to be deployed on each remote site and then perform the following high-level steps:</span>

<span style="font-size: 16px; font-family: Nunito;">&#8211; As a <strong>backup repository</strong>, we are going to add a hard disk to the remote VM and use that hard disk as the backup repository for the site. We will seize the capabilities of Windows Server 2016 and use ReFS as the filesystem for the added hard disk.</span>

<span style="font-size: 16px; font-family: Nunito;">&#8211; Install a <strong>backup proxy </strong>service, we just need to deploy the backup proxy service from the Veeam B&R console to the VM that we are using. The backup proxy will be who processes jobs and delivers backup traffic.</span>

<span style="font-size: 16px; font-family: Nunito;">So, let&#8217;s go each step!</span>

&nbsp;

### <span style="color: #000000; font-family: Nunito;">Backup proxy service</span>

<span style="font-family: Nunito;">First, our Windows Guest OS VM is joined to the domain, so we won&#8217;t have any kind of problem for resolving the name or accessing with domain account credentials.</span>

<span style="font-family: Nunito;">Let&#8217;s add the proxy by going to the Backup Infrastructure tab > Backup Proxy > <strong>Add VMware Backup Proxy&#8230;</strong></span>

<img loading="lazy" class="alignnone wp-image-1026 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Add-VMware-Backup-Proxy.png" alt="" width="653" height="587" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Add-VMware-Backup-Proxy.png 653w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Add-VMware-Backup-Proxy-300x270.png 300w" sizes="(max-width: 653px) 100vw, 653px" /> 

<span style="font-size: 16px; font-family: Nunito;">As this is a new server for Veeam, we will have to add it as a «server» by pressing «<strong>Add New&#8230;»</strong>:</span>

<span style="font-size: 16px; font-family: Nunito;"><img loading="lazy" class="alignnone wp-image-1035 size-medium_large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_default-768x545.png" alt="" width="656" height="466" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_default-768x545.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_default-300x213.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_default-1024x727.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_default.png 1125w" sizes="(max-width: 656px) 100vw, 656px" /></span>

<span style="font-size: 16px; font-family: Nunito;">Then, this window will appear, just enter the FQDN of your server:</span>

<span style="font-family: Nunito;"><img loading="lazy" class="alignnone wp-image-1029 size-medium_large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/NewWServer_1-768x545.png" alt="" width="656" height="466" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/NewWServer_1-768x545.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/NewWServer_1-300x213.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/NewWServer_1-1024x726.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/NewWServer_1.png 1128w" sizes="(max-width: 656px) 100vw, 656px" /></span>

<span style="font-family: Nunito;"><span style="font-size: 16px;">Choose credentials and </span>choose<span style="font-size: 16px;"> «<strong>Apply</strong> «to install the transport service:</span></span>

<span style="font-family: Nunito;"><img loading="lazy" class="alignnone wp-image-1030 size-medium_large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/NewWServer_2_apply-768x551.png" alt="" width="656" height="471" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/NewWServer_2_apply-768x551.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/NewWServer_2_apply-300x215.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/NewWServer_2_apply-1024x734.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/NewWServer_2_apply.png 1124w" sizes="(max-width: 656px) 100vw, 656px" /></span>

<span style="font-size: 16px; font-family: Nunito;">After that, you will be able to choose the newly added server (Proxy_EUR.itgaiden.com) from the drop-down menu:</span>

<span style="font-family: Nunito;"><img loading="lazy" class="alignnone wp-image-1034 size-large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_summary-1024x727.png" alt="" width="656" height="466" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_summary-1024x727.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_summary-300x213.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_summary-768x545.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_summary.png 1124w" sizes="(max-width: 656px) 100vw, 656px" /></span>

<span style="font-size: 16px; font-family: Nunito;">Now, let&#8217;s configure the Transport mode and Datastores for this proxy (as in the previous screenshot):</span>

<span style="font-family: Nunito;"><img loading="lazy" class="alignnone wp-image-1031 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Transport_mode.png" alt="" width="755" height="791" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Transport_mode.png 755w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Transport_mode-286x300.png 286w" sizes="(max-width: 755px) 100vw, 755px" /></span>

<span style="font-size: 16px; font-family: Nunito;">And for the datastores, choose the ones that are connected to the ESXi host where the VM is hosted by selecting <strong>Manual Selection </strong>and adding them:</span>

<span style="font-size: 16px; font-family: Nunito;"><img loading="lazy" class="alignnone size-penscratch-featured wp-image-1028" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/manual_datastores-656x300.png" alt="choose_manual_datastores" width="656" height="300" /></span>

<span style="font-size: 16px; font-family: Nunito;">After configuring that, you will have the same configuration as in this screenshot:</span>

<span style="font-family: Nunito;"><img loading="lazy" class="alignnone size-medium_large wp-image-1034" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_summary-768x545.png" alt="" width="656" height="466" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_summary-768x545.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_summary-300x213.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_summary-1024x727.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_summary.png 1124w" sizes="(max-width: 656px) 100vw, 656px" /></span>

<span style="font-size: 16px; font-family: Nunito;">Finally, just hit <strong>Next </strong>and apply any kind of traffic rule if you want:</span>

<span style="font-size: 16px; font-family: Nunito;"><img loading="lazy" class="alignnone size-medium_large wp-image-1033" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_trafficrules-768x546.png" alt="" width="656" height="466" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_trafficrules-768x546.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_trafficrules-300x213.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_trafficrules-1024x727.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/VMware_proxy_trafficrules.png 1122w" sizes="(max-width: 656px) 100vw, 656px" /></span>

<span style="font-size: 16px; font-family: Nunito;">Now, finish, and the proxy will be fully configured and ready.</span>

&nbsp;

&nbsp;

<span style="font-size: 16px; font-family: Nunito;">We configured these options because they are the best for our deployment which is using a Windows VM that will have a backup repository which will save the backups.</span>

<span style="font-size: 16px; font-family: Nunito;">For more detailed options about the Backup Proxy service go <a href="https://helpcenter.veeam.com/docs/backup/vsphere/backup_proxy.html?ver=95u4">here</a>.</span>

<span style="font-size: 16px; font-family: Nunito;">After configuring each backup proxy we will have a bunch of them in the Backup Proxies tab:</span>

<span style="font-family: Nunito;"><img loading="lazy" class="alignnone size-medium_large wp-image-1040" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backup_Proxies-768x299.png" alt="Backup_Proxies" width="656" height="255" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backup_Proxies-768x299.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backup_Proxies-300x117.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backup_Proxies.png 996w" sizes="(max-width: 656px) 100vw, 656px" /></span>

### <span style="color: #000000; font-family: Nunito;">Backup repository configuration</span>

<span style="font-family: Nunito;"><span style="font-size: 16px;">In this step, I suggest </span>fo<span style="font-size: 16px;">llowing this <a href="https://translate.google.com/translate?hl=en&sl=auto&tl=en&u=https%3A%2F%2Fwww.jorgedelacruz.es%2F2018%2F04%2F16%2Fveeam-repositorios-de-backup-usando-el-nuevo-microsoft-refs-que-viene-incluido-en-microsoft-windows-server-2016%2F">article</a> to perform this step.</span></span>

<span style="font-size: 16px; font-family: Nunito;">Basically, we just have to add a new hard disk to our dedicated VM as Thick Provision Eager Zeroed, format the disk as ReFS and finally, add the Backup Repository to the Veeam B&R Console.</span>

<span style="font-size: 16px; font-family: Nunito;">In that article, it&#8217;s also explained the benefits of ReFS so, I think it&#8217;s more detailed and easy to follow it.</span>

<span style="font-size: 16px; font-family: Nunito;">After we configure all the backup repositories, we will have the same amount as the backup proxies:</span>

<span style="font-size: 16px; font-family: Nunito;"><img loading="lazy" class="alignnone size-full wp-image-1048" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/veeam_backup_repositories.png" alt="veeam_backup_repositories" width="2336" height="944" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/veeam_backup_repositories.png 2336w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/veeam_backup_repositories-300x121.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/veeam_backup_repositories-1024x414.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/veeam_backup_repositories-768x310.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/veeam_backup_repositories-1536x621.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/veeam_backup_repositories-2048x828.png 2048w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/veeam_backup_repositories-1568x634.png 1568w" sizes="(max-width: 2336px) 100vw, 2336px" /></span>

<span style="font-size: 16px; font-family: Nunito;">As you can see in the previous screenshot, the path (D:\Backups) is the disk that we added to the VM on each remote site. We have configured the backup repository to that path because, as explained before, we have a disk formatted in ReFS and it&#8217;s explained in the <a href="https://translate.google.com/translate?hl=en&sl=auto&tl=en&u=https%3A%2F%2Fwww.jorgedelacruz.es%2F2018%2F04%2F16%2Fveeam-repositorios-de-backup-usando-el-nuevo-microsoft-refs-que-viene-incluido-en-microsoft-windows-server-2016%2F">article</a>.</span>

### 

### <span style="color: #000000; font-family: Nunito;">Backup job configuration</span>

<span style="font-size: 16px; font-family: Nunito;">After configuring the backup proxy and backup repositories on each site, we are ready to the last step, configuring the backup job to perform backups.</span>

<span style="font-size: 16px; font-family: Nunito;">Go to <strong>Home</strong> tab and then Backup&#8230; Virtual Machine:</span>

<span style="font-size: 16px; font-family: Nunito;"><img loading="lazy" class="alignnone size-medium wp-image-1050" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_start-300x79.png" alt="" width="300" height="79" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_start-300x79.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_start.png 464w" sizes="(max-width: 300px) 100vw, 300px" /></span>

<span style="font-family: Nunito;"><span style="font-size: 16px;">Now, step by step, pick a name for the job:</span><img loading="lazy" class="alignnone wp-image-1060 size-medium_large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_name-768x549.png" alt="" width="656" height="469" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_name-768x549.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_name-300x214.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_name-1024x732.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_name.png 1125w" sizes="(max-width: 656px) 100vw, 656px" /></span>

<span style="font-size: 16px; font-family: Nunito;">Proceed to select the VMs you want to backup (in our case the ones in the EUR site):</span><span style="font-family: Nunito;"><img loading="lazy" class="alignnone size-medium_large wp-image-1057" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_vm_2-768x536.png" alt="" width="656" height="458" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_vm_2-768x536.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_vm_2-300x209.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_vm_2-1024x715.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_vm_2.png 1127w" sizes="(max-width: 656px) 100vw, 656px" /></span>

&nbsp;

<span style="font-size: 16px; font-family: Nunito;">Let&#8217;s continue and in the Backup proxy, click <strong>Choose&#8230;</strong> and select the correspondent backup proxy (EUR_proxy):<img loading="lazy" class="alignnone size-medium_large wp-image-1059" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxy_3-768x547.png" alt="" width="656" height="467" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxy_3-768x547.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxy_3-300x214.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxy_3-1024x729.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxy_3.png 1128w" sizes="(max-width: 656px) 100vw, 656px" /></span>

&nbsp;

<span style="font-family: Nunito;"><span style="font-size: 16px;">Press OK and go to Advanced. Configure it like that if you want Synthetic  full backups:</span> <img loading="lazy" class="alignnone size-full wp-image-1055" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxy_adv_4.png" alt="" width="726" height="837" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxy_adv_4.png 726w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxy_adv_4-260x300.png 260w" sizes="(max-width: 726px) 100vw, 726px" /></span>

&nbsp;

<span style="font-family: Nunito;"><span style="font-size: 16px;">And then the monthly health check (recommended):</span><img loading="lazy" class="alignnone size-full wp-image-1056" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxy_adv_5.png" alt="" width="728" height="588" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxy_adv_5.png 728w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxy_adv_5-300x242.png 300w" sizes="(max-width: 728px) 100vw, 728px" /></span>

<span style="font-size: 16px; font-family: Nunito;">Accept and here is the summary for the backup proxy step (we will keep 7 restore points in our case):</span>

<span style="font-family: Nunito;"><img loading="lazy" class="alignnone size-medium_large wp-image-1058" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxysummary_6-768x544.png" alt="" width="656" height="465" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxysummary_6-768x544.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxysummary_6-300x213.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxysummary_6-1024x725.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_proxysummary_6.png 1125w" sizes="(max-width: 656px) 100vw, 656px" /></span>

<span style="font-size: 16px; font-family: Nunito;">Configure any option as you like (not in my case):</span>

<span style="font-family: Nunito;"><img loading="lazy" class="alignnone size-medium_large wp-image-1054" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_vm_guest_7-768x549.png" alt="" width="656" height="469" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_vm_guest_7-768x549.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_vm_guest_7-300x214.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_vm_guest_7-1024x732.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Backupjob_vm_guest_7.png 1121w" sizes="(max-width: 656px) 100vw, 656px" /></span>

<span style="font-family: Nunito;"><span style="font-size: 16px;">And finally, proceed with the schedule that you want after finishing the configuration for this job!</span></span>

<span style="font-size: 16px; font-family: Nunito;">And that would be all for this remote site. We had to to the same with the other remote sites and our job will be done!<br /> </span>

&nbsp;

### <span style="color: #000000; font-family: Nunito;">Conclusion</span>

<span style="font-size: 16px; font-family: Nunito;">Finally, with this design you will be able to back up remote sites and store the backups in the local storage from each site.</span>

<span style="font-size: 16px; font-family: Nunito;">If you don&#8217;t want to use a dedicated VM as a backup proxy, you can install the service on a VM that has low usage and install the backup proxy service, however, it&#8217;s recommended to use a dedicated VM which will have the backup proxy service and the backup repository (the virtual hard disk attached).</span>

### 

&nbsp;

&nbsp;