---
title: vCenter Server 7.0 – Fresh install
author: itgaiden
type: post
date: 2020-04-28T11:19:58+00:00
url: 2020-04-28-vcenter-server-7-0-fresh-install
rank_math_primary_category:
  - 11
rank_math_description:
  - This a step by step article about how to install vCenter Server 7.0 in your environment.
rank_math_focus_keyword:
  - vcenter server
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - vCenter
  - VMware
tags:
  - vCenter
  - VMware
  - vSphere7

---
# <span style=" font-size: 28px;"><strong><span style="font-family: Nunito;">Prologue</span></strong></span>

<span >With the release of vSphere 7 at the beginning of this month, I decided to make a post about how to install vCenter Server Appliance (vCSA) which is quite simple.</span>

<span ><strong>Which are the new features? </strong></span><span >Check this <span style="text-decoration: underline;"><a href="https://virtualg.uk/vmware-vsphere-7-0-top-5-features/"><strong>post</strong></a></span> from my friend Graham Barker to find out!<br /> </span>

&nbsp;

<span style="font-family: Nunito;">Let&#8217;s move on!</span>

<ul style="list-style-type: square;">
  <li>
    <span >Proceed to download the «VMware vCenter Server 7.0.0» ISO file from <a href="https://my.vmware.com/en/web/vmware/info/slug/datacenter_cloud_infrastructure/vmware_vsphere/7_0">my.vmware.com</a></span>
  </li>
  <li>
    <span >Mount the ISO file and execute the <strong>installer.exe</strong> file : </span>
  </li>
</ul>

<span ><img loading="lazy" class="alignnone wp-image-1692 " src="/wp-content/uploads/2020/04/0_mountISO_installer_exe-1.png" alt="" width="586" height="372" srcset="/wp-content/uploads/2020/04/0_mountISO_installer_exe-1.png 878w, /wp-content/uploads/2020/04/0_mountISO_installer_exe-1-300x191.png 300w, /wp-content/uploads/2020/04/0_mountISO_installer_exe-1-768x488.png 768w" sizes="(max-width: 586px) 100vw, 586px" /></span>

<span ><strong>Prerequisite:</strong> We <strong>need DNS</strong> if we want to deploy vCenter with an FQDN but if you don&#8217;t have it or you can&#8217;t for any reason, you can trick the installer and put the IP address as the hostname and it will work.</span>

<span >Another prerequisite will be to <strong>have an ESXi host</strong> where we&#8217;re going to install our vCenter</span>

# <span style="font-size: 28px;"><strong><span style="font-family: Nunito; ">Stage 1 &#8211; New deployment</span></strong></span>

<span ><strong>1.</strong> We will proceed to select <strong>install</strong> as we are going to perform a fresh install from the scratch of vCenter Server 7.0.</span><span ><img loading="lazy" class="alignnone wp-image-1693 size-full" style="border-style: solid; border-width: 2px;" src="/wp-content/uploads/2020/04/1_Install-1.png" alt="" width="1949" height="1183" srcset="/wp-content/uploads/2020/04/1_Install-1.png 1949w, /wp-content/uploads/2020/04/1_Install-1-300x182.png 300w, /wp-content/uploads/2020/04/1_Install-1-1024x622.png 1024w, /wp-content/uploads/2020/04/1_Install-1-768x466.png 768w, /wp-content/uploads/2020/04/1_Install-1-1536x932.png 1536w, /wp-content/uploads/2020/04/1_Install-1-1568x952.png 1568w" sizes="(max-width: 1949px) 100vw, 1949px" /></span>

<span ><strong>2.</strong> I like that it tells you that External PSC is deprecated! Continue with <strong>NEXT.</strong></span><span ><img loading="lazy" class="alignnone wp-image-1694 size-full" style="border-width: 2px; border-style: solid;" src="/wp-content/uploads/2020/04/2_extPSCdeprecated-1.png" alt="" width="1950" height="1182" srcset="/wp-content/uploads/2020/04/2_extPSCdeprecated-1.png 1950w, /wp-content/uploads/2020/04/2_extPSCdeprecated-1-300x182.png 300w, /wp-content/uploads/2020/04/2_extPSCdeprecated-1-1024x621.png 1024w, /wp-content/uploads/2020/04/2_extPSCdeprecated-1-768x466.png 768w, /wp-content/uploads/2020/04/2_extPSCdeprecated-1-1536x931.png 1536w, /wp-content/uploads/2020/04/2_extPSCdeprecated-1-1568x950.png 1568w" sizes="(max-width: 1950px) 100vw, 1950px" /></span>

<span ><strong>3.</strong> Just put the details of a vCenter (if you have one) or an ESXi host where you want to deploy this new vCenter. In my case (and probably the most if you&#8217;re doing everything from the scratch) I am using a host called «johto.pokemon.jp» to deploy the vCSA.</span><span ><img loading="lazy" class="alignnone wp-image-1695 size-full" style="border-width: 2px; border-style: solid;" src="/wp-content/uploads/2020/04/3_vCenterDeployment_target-1.png" alt="" width="1948" height="1179" srcset="/wp-content/uploads/2020/04/3_vCenterDeployment_target-1.png 1948w, /wp-content/uploads/2020/04/3_vCenterDeployment_target-1-300x182.png 300w, /wp-content/uploads/2020/04/3_vCenterDeployment_target-1-1024x620.png 1024w, /wp-content/uploads/2020/04/3_vCenterDeployment_target-1-768x465.png 768w, /wp-content/uploads/2020/04/3_vCenterDeployment_target-1-1536x930.png 1536w, /wp-content/uploads/2020/04/3_vCenterDeployment_target-1-1568x949.png 1568w" sizes="(max-width: 1948px) 100vw, 1948px" /></span>

> <span style="font-family: Nunito; font-size: 16px; ">Once you press next, accept the certificate warning if you know the fingerprint of the certificate.</span>

<span ><strong>4.</strong> Put the name of the VM and set the root password for the vCSA and continue.</span><span ><img loading="lazy" class="alignnone wp-image-1696 size-full" style="border-width: 2px; border-style: solid;" src="/wp-content/uploads/2020/04/4_vCenterVMName-1.png" alt="" width="1947" height="775" srcset="/wp-content/uploads/2020/04/4_vCenterVMName-1.png 1947w, /wp-content/uploads/2020/04/4_vCenterVMName-1-300x119.png 300w, /wp-content/uploads/2020/04/4_vCenterVMName-1-1024x408.png 1024w, /wp-content/uploads/2020/04/4_vCenterVMName-1-768x306.png 768w, /wp-content/uploads/2020/04/4_vCenterVMName-1-1536x611.png 1536w, /wp-content/uploads/2020/04/4_vCenterVMName-1-1568x624.png 1568w" sizes="(max-width: 1947px) 100vw, 1947px" /></span>

<span ><strong>5.</strong> I am going for the <strong>Tiny</strong> deployment as it is more than enough for my lab environment. In a production environment usually, you will deploy a small one that fits in many small companies (or in your lab if you&#8217;re testing it).</span><span ><img loading="lazy" class="alignnone size-full wp-image-1697" style="border-width: 2px; border-style: solid;" src="/wp-content/uploads/2020/04/5_deploymentSize-1.png" alt="" width="1950" height="1183" srcset="/wp-content/uploads/2020/04/5_deploymentSize-1.png 1950w, /wp-content/uploads/2020/04/5_deploymentSize-1-300x182.png 300w, /wp-content/uploads/2020/04/5_deploymentSize-1-1024x621.png 1024w, /wp-content/uploads/2020/04/5_deploymentSize-1-768x466.png 768w, /wp-content/uploads/2020/04/5_deploymentSize-1-1536x932.png 1536w, /wp-content/uploads/2020/04/5_deploymentSize-1-1568x951.png 1568w" sizes="(max-width: 1950px) 100vw, 1950px" /></span>

<span ><strong>6.</strong> Continue by selecting a Datastore and check » Enable Thin Disk Mode» which is usually the best deployment as it doesn&#8217;t allocate all the space and is also enabled by default. (Look even my VMFS-5 datastores work well).</span><span ><img loading="lazy" class="alignnone wp-image-1698 size-full" style="border-width: 2px; border-style: solid;" src="/wp-content/uploads/2020/04/6_SelectDatastore-1.png" alt="" width="1948" height="863" srcset="/wp-content/uploads/2020/04/6_SelectDatastore-1.png 1948w, /wp-content/uploads/2020/04/6_SelectDatastore-1-300x133.png 300w, /wp-content/uploads/2020/04/6_SelectDatastore-1-1024x454.png 1024w, /wp-content/uploads/2020/04/6_SelectDatastore-1-768x340.png 768w, /wp-content/uploads/2020/04/6_SelectDatastore-1-1536x680.png 1536w, /wp-content/uploads/2020/04/6_SelectDatastore-1-1568x695.png 1568w" sizes="(max-width: 1948px) 100vw, 1948px" /></span>

<span ><strong>7.</strong> Now, let&#8217;s configure the network settings. Here my Network you can see a portgroup «Std_mgmt» from my ESXi host. If you have an ESXi host with default portgroups, yours probably is called «<strong>VM Network</strong>«.</span><span ><img loading="lazy" class="alignnone size-full wp-image-1699" style="border-width: 2px; border-style: solid;" src="/wp-content/uploads/2020/04/7_NW_settings-1.png" alt="" width="1949" height="1171" srcset="/wp-content/uploads/2020/04/7_NW_settings-1.png 1949w, /wp-content/uploads/2020/04/7_NW_settings-1-300x180.png 300w, /wp-content/uploads/2020/04/7_NW_settings-1-1024x615.png 1024w, /wp-content/uploads/2020/04/7_NW_settings-1-768x461.png 768w, /wp-content/uploads/2020/04/7_NW_settings-1-1536x923.png 1536w, /wp-content/uploads/2020/04/7_NW_settings-1-1568x942.png 1568w" sizes="(max-width: 1949px) 100vw, 1949px" /></span>

<span >About the FQDN, as I said before (check the Prerequisite section in the beginning) you need to create an A record in your DNS in order to be able to deploy a vCenter with a name.</span>

> <span style="font-family: Nunito; font-size: 16px; ">If you don&#8217;t have DNS because you&#8217;re installing vCenter and you don&#8217;t have it, <strong>you can use the IP address as FQDN and it will work</strong>.</span>

<span ><strong>8.</strong> And that&#8217;s all for stage 1, here we have a summary saying what is going to do. Be sure to review it:</span><span ><img loading="lazy" class="alignnone size-full wp-image-1700" style="border-width: 2px; border-style: solid;" src="/wp-content/uploads/2020/04/8_Summary-1.png" alt="" width="1946" height="1416" srcset="/wp-content/uploads/2020/04/8_Summary-1.png 1946w, /wp-content/uploads/2020/04/8_Summary-1-300x218.png 300w, /wp-content/uploads/2020/04/8_Summary-1-1024x745.png 1024w, /wp-content/uploads/2020/04/8_Summary-1-768x559.png 768w, /wp-content/uploads/2020/04/8_Summary-1-1536x1118.png 1536w, /wp-content/uploads/2020/04/8_Summary-1-1568x1141.png 1568w" sizes="(max-width: 1946px) 100vw, 1946px" /> Once you&#8217;re ready, press <strong>FINISH.</strong></span>

&nbsp;

<span >It will start with Stage 1, which is the deployment of the VM where the vCenter Server resides:<img loading="lazy" class="alignnone size-full wp-image-1701" style="border-width: 2px; border-style: solid;" src="/wp-content/uploads/2020/04/9_Stage1_DeployvCenter-1.png" alt="" width="1956" height="1428" srcset="/wp-content/uploads/2020/04/9_Stage1_DeployvCenter-1.png 1956w, /wp-content/uploads/2020/04/9_Stage1_DeployvCenter-1-300x219.png 300w, /wp-content/uploads/2020/04/9_Stage1_DeployvCenter-1-1024x748.png 1024w, /wp-content/uploads/2020/04/9_Stage1_DeployvCenter-1-768x561.png 768w, /wp-content/uploads/2020/04/9_Stage1_DeployvCenter-1-1536x1121.png 1536w, /wp-content/uploads/2020/04/9_Stage1_DeployvCenter-1-1568x1145.png 1568w" sizes="(max-width: 1956px) 100vw, 1956px" /></span>

<span >After some minutes, <strong>STAGE 1 is completed</strong>, which means that the VM where the vCSA resides is deployed but not configured yet.</span><span ><img loading="lazy" class="alignnone size-full wp-image-1702" style="border-width: 2px; border-style: solid;" src="/wp-content/uploads/2020/04/10_Stage1Completed-1.png" alt="" width="978" height="323" srcset="/wp-content/uploads/2020/04/10_Stage1Completed-1.png 978w, /wp-content/uploads/2020/04/10_Stage1Completed-1-300x99.png 300w, /wp-content/uploads/2020/04/10_Stage1Completed-1-768x254.png 768w" sizes="(max-width: 978px) 100vw, 978px" /></span>

# <span style=" font-size: 28px;"><strong><span style="font-family: Nunito;">Stage 2 &#8211; Configuration</span></strong></span>

## **<span >Let&#8217;s go to STAGE 2 where the vCSA will be configured.</span>**<img loading="lazy" class="alignnone wp-image-1703" src="/wp-content/uploads/2020/04/11_Stage2_start-1.png" alt="" width="611" height="419" srcset="/wp-content/uploads/2020/04/11_Stage2_start-1.png 938w, /wp-content/uploads/2020/04/11_Stage2_start-1-300x206.png 300w, /wp-content/uploads/2020/04/11_Stage2_start-1-768x527.png 768w" sizes="(max-width: 611px) 100vw, 611px" />

<span ><strong>1.</strong> Set an NTP server or let the ESXi host also enable SSH if you want to have access to the vCSA.</span><span ><img loading="lazy" class="alignnone size-full wp-image-1704" style="border-width: 2px; border-style: solid;" src="/wp-content/uploads/2020/04/12_vCenterConfig_NTP_SSH-1.png" alt="" width="1406" height="576" srcset="/wp-content/uploads/2020/04/12_vCenterConfig_NTP_SSH-1.png 1406w, /wp-content/uploads/2020/04/12_vCenterConfig_NTP_SSH-1-300x123.png 300w, /wp-content/uploads/2020/04/12_vCenterConfig_NTP_SSH-1-1024x420.png 1024w, /wp-content/uploads/2020/04/12_vCenterConfig_NTP_SSH-1-768x315.png 768w" sizes="(max-width: 1406px) 100vw, 1406px" /></span>

<span ><strong>2.</strong> Configure the SSO, the default is the «vsphere.local» domain, in my case I created a custom one.</span><span ><img loading="lazy" class="alignnone size-full wp-image-1705" style="border-width: 2px; border-style: solid;" src="/wp-content/uploads/2020/04/13_SSO_config-1.png" alt="" width="1405" height="962" srcset="/wp-content/uploads/2020/04/13_SSO_config-1.png 1405w, /wp-content/uploads/2020/04/13_SSO_config-1-300x205.png 300w, /wp-content/uploads/2020/04/13_SSO_config-1-1024x701.png 1024w, /wp-content/uploads/2020/04/13_SSO_config-1-768x526.png 768w" sizes="(max-width: 1405px) 100vw, 1405px" /></span>

<span ><strong>3.</strong> And the last summary after we finish Stage 2 when the vCenter will be fully configured.</span><span ><img loading="lazy" class="alignnone size-full wp-image-1706" style="border-width: 2px; border-style: solid;" src="/wp-content/uploads/2020/04/14_Summary_stage2-1.png" alt="" width="1403" height="973" srcset="/wp-content/uploads/2020/04/14_Summary_stage2-1.png 1403w, /wp-content/uploads/2020/04/14_Summary_stage2-1-300x208.png 300w, /wp-content/uploads/2020/04/14_Summary_stage2-1-1024x710.png 1024w, /wp-content/uploads/2020/04/14_Summary_stage2-1-768x533.png 768w" sizes="(max-width: 1403px) 100vw, 1403px" /></span>

<span ><strong>4.</strong> After a while (15-20 min.), Stage 2 finished without errors!</span><span ><img loading="lazy" class="alignnone size-full wp-image-1707" style="border-width: 2px; border-style: solid;" src="/wp-content/uploads/2020/04/15_Stage2_complete-1.png" alt="" width="1420" height="836" srcset="/wp-content/uploads/2020/04/15_Stage2_complete-1.png 1420w, /wp-content/uploads/2020/04/15_Stage2_complete-1-300x177.png 300w, /wp-content/uploads/2020/04/15_Stage2_complete-1-1024x603.png 1024w, /wp-content/uploads/2020/04/15_Stage2_complete-1-768x452.png 768w" sizes="(max-width: 1420px) 100vw, 1420px" /></span>

<span ><strong>5.</strong> Now I access the GUI from the URL provided in the previous screenshot and I see that is working flawlessly!<br /> </span><span style="font-family: Nunito;"><img loading="lazy" class="alignnone size-full wp-image-1708" style="border-width: 2px; border-style: solid;" src="/wp-content/uploads/2020/04/16_vCenterGUI-1.png" alt="" width="2809" height="1288" srcset="/wp-content/uploads/2020/04/16_vCenterGUI-1.png 2809w, /wp-content/uploads/2020/04/16_vCenterGUI-1-300x138.png 300w, /wp-content/uploads/2020/04/16_vCenterGUI-1-1024x470.png 1024w, /wp-content/uploads/2020/04/16_vCenterGUI-1-768x352.png 768w, /wp-content/uploads/2020/04/16_vCenterGUI-1-1536x704.png 1536w, /wp-content/uploads/2020/04/16_vCenterGUI-1-2048x939.png 2048w, /wp-content/uploads/2020/04/16_vCenterGUI-1-1568x719.png 1568w" sizes="(max-width: 2809px) 100vw, 2809px" /></span>

<span style="font-size: 16px; font-family: Nunito;"><strong>6</strong>. Enjoy your new vCenter Server with the only HTML5 interface and lots of new features that were mentioned at the beginning of this post.<br /> </span>

&nbsp;

<span style="font-family: Nunito; font-size: 16px; ">We conclude this article where you can see how simple and easy is to install and deploy vCenter Server version 7.0.</span>

&nbsp;

## 

&nbsp;