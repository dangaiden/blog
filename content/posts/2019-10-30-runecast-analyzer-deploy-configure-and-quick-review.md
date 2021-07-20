---
title: 'Runecast Analyzer: Deploy, configure and quick review'
author: itgaiden
type: post
date: 2019-10-30T21:14:01+00:00
url: /?p=1241
featured_image: /wp-content/uploads/2019/10/Live_demo.png
rank_math_primary_category:
  - 76
rank_math_description:
  - 'Runecast is a solution that provides Real-time VMware SDDC issue analysis & security compliance'
rank_math_focus_keyword:
  - Runecast
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - Runecast
tags:
  - hcl
  - it admin
  - runecast
  - security guideline

---
<span style="font-family: Nunito; font-size: 16px;">Today, I&#8217;ll show you how easy is to install, configure Runecast Analyzer (v 3.1.1.0) in your environment and we will review quickly what can we offer this solution.</span>

## **<span style="font-family: Nunito; color: #000000;">Runecast?</span>**

<span style="font-family: Nunito; font-size: 16px;">Runecast is a company founded in 2014 more recognizable because the CEO is Stanimir Markov which is VCDX #74 but in his team has other virtualization veterans who help them to create this solution.</span>

<span style="font-family: Nunito; font-size: 16px;">It&#8217;s a solution made by and for IT Admins which will scan your VMware environment (vSphere, vSAN, and NSX-T and V) and inform you about issues, best practices, hardware compatibility and apply security hardening in your VMware environment.<br /> </span>

<span style="font-family: Nunito; font-size: 16px;">With all of this information it will save a great amount of time to any IT admin in order to resolve or identify a known (or not) issue, perform an upgrade of any new release of vSphere, apply the correct configurations according any Security standards (PCI-DSS, HIPAA, DISA SITG, etc.) and more&#8230;</span>

<span style="font-family: Nunito; font-size: 16px;">The main functionalities of this application are:</span>

  * <span style="font-family: Nunito; font-size: 16px;"><a href="https://www.runecast.com/vmware-issue-prevention">Proactive troubleshooting</a></span>
  * <span style="font-family: Nunito; font-size: 16px;"><a href="https://www.runecast.com/compliance-checks">Security compliance</a></span>
  * <span style="font-family: Nunito; font-size: 16px;"><a href="https://www.runecast.com/hardware-compatibility">Hardware compatibility</a></span>
  * <span style="font-family: Nunito; font-size: 16px;"><a href="https://www.runecast.com/log-analysis">Log analytics</a></span>

<span style="font-family: Nunito; font-size: 16px;">I will do another post showing and explaining in detail these features, meanwhile, you can check each one on their website.</span>

&nbsp;

## **<span style="font-family: Nunito; color: #000000;">Use it in your environment or try it in a demonstration</span>**

<span style="font-family: Nunito; font-size: 16px;">If you want to install and configure this virtual appliance to deploy in your environment, go to <a href="https://www.runecast.com/quick-and-secure-deployment">https://www.runecast.com/quick-and-secure-deployment</a> and in the upper-right menu click the <strong>Free trial</strong> button.</span>

<span style="font-size: 16px; font-family: Nunito;">You will need to create an account (it&#8217;s free) but once you created it, you will have access to the OVA file by downloading it:</span>

<span style="font-size: 16px; font-family: Nunito;"><img loading="lazy" class="alignnone wp-image-1242 " src="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/Ova_donwload.png" alt="Ova_download" width="247" height="224" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/Ova_donwload.png 459w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/Ova_donwload-300x272.png 300w" sizes="(max-width: 247px) 100vw, 247px" /></span>

&nbsp;

<span style="font-size: 16px; font-family: Nunito;">Runecast has also a <strong>Live Demo</strong> where you can try all the features without installing anything, just go to the website: <a href="https://demo.runecast.com">https://demo.runecast.com</a> and login with the credentials provided.</span>

<span style="font-size: 16px; font-family: Nunito;"><img loading="lazy" class="alignnone wp-image-1244" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/Live_demo.png" alt="live_demo" width="283" height="332" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/Live_demo.png 494w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/Live_demo-256x300.png 256w" sizes="(max-width: 283px) 100vw, 283px" /></span>

<span style="font-size: 16px; font-family: Nunito;">You will see immediately a test environment where you can check all the features that it has in just seconds, quite handy if you want to test this solution quickly.</span>

&nbsp;

## **<span style="font-family: Nunito; color: #000000;">Deploy and configure</span>**

<span style="font-family: Nunito; font-size: 16px;">Once you download the OVA file, deploy it in your virtual environment like what you will do with other virtual appliances:</span>

  1. <span style="font-family: Nunito; font-size: 16px;">Right-click in your DC and «Deploy OVF Template&#8230;»</span>
  2. <span style="font-family: Nunito; font-size: 16px;">Select the OVA file you downloaded in the previous section.</span>
  3. <span style="font-family: Nunito; font-size: 16px;">Select name, folder, compute resource</span>
  4. <span style="font-family: Nunito; font-size: 16px;">Accept the EULA, choose the deployment configuration (in my case <span style="text-decoration: underline;">Small</span>)</span>
  5. <span style="font-family: Nunito; font-size: 16px;">Configure the resources necessary for the appliance (storage, network and finally all the networking properties).</span>

<span style="font-family: Nunito; font-size: 16px;">Once the OVF package has been imported (it took 2 min approximately), it will appear a VM in your vCenter:</span>

<img loading="lazy" class="alignnone wp-image-1245" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/vm_vcenter.png" alt="vm_vcenter" width="387" height="190" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/vm_vcenter.png 505w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/vm_vcenter-300x147.png 300w" sizes="(max-width: 387px) 100vw, 387px" /> 

&nbsp;

<span style="font-size: 16px; font-family: Nunito;">Now, power on the VM and check in the VM console which is the IP that you give to the application in order to access the appliance (<strong>https://192.168.1.81</strong>):</span>

<span style="font-size: 16px; font-family: Nunito;"><img loading="lazy" class="alignnone wp-image-1250" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_vmconsole-1024x172.png" alt="runecast_vmconsole" width="513" height="86" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_vmconsole-1024x172.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_vmconsole-300x50.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_vmconsole-768x129.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_vmconsole.png 1150w" sizes="(max-width: 513px) 100vw, 513px" /></span>

&nbsp;

<span style="font-size: 16px; font-family: Nunito;">The first time you access through the website, you must use the following credentials (the same as in the Live Demo):</span>

<img loading="lazy" class="alignnone wp-image-1244" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/Live_demo.png" alt="live_demo" width="283" height="332" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/Live_demo.png 494w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/Live_demo-256x300.png 256w" sizes="(max-width: 283px) 100vw, 283px" /> 

&nbsp;

<span style="font-size: 16px; font-family: Nunito;">Now, it will ask you some information to connect to your vCenter, just enter the information (I created a new user to connect to the vCenter) and click Continue:<img loading="lazy" class="alignnone wp-image-1252" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/vcenter_info.png" alt="vcenter_info" width="447" height="247" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/vcenter_info.png 827w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/vcenter_info-300x165.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/vcenter_info-768x423.png 768w" sizes="(max-width: 447px) 100vw, 447px" /></span>

<span style="font-size: 16px; font-family: Nunito;">And provide a schedule, I let the default setting as it&#8217;s a reasonable schedule. </span><span style="font-size: 16px; font-family: Nunito;">Continue by selecting «Start analysis»:</span>

<span style="font-size: 16px; font-family: Nunito;"><img loading="lazy" class="alignnone wp-image-1251" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/schedule.png" alt="schedule" width="341" height="316" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/schedule.png 536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/schedule-300x278.png 300w" sizes="(max-width: 341px) 100vw, 341px" /></span>

<span style="font-size: 16px; font-family: Nunito;">This, will scan your VMware environment and let you know in the dashboard all kind of issues, configuration, etc.:</span>

<figure id="attachment_1253" aria-describedby="caption-attachment-1253" style="width: 656px" class="wp-caption alignnone"><img loading="lazy" class="wp-image-1253 size-large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_maindashboard-1024x830.png" alt="runecast_main" width="656" height="532" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_maindashboard-1024x830.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_maindashboard-300x243.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_maindashboard-768x623.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_maindashboard-1536x1245.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_maindashboard-2048x1661.png 2048w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_maindashboard-1568x1271.png 1568w" sizes="(max-width: 656px) 100vw, 656px" /><figcaption id="caption-attachment-1253" class="wp-caption-text"><span style="font-family: Nunito;">The screenshot was taken from the Live Demo that Runecast provides</span></figcaption></figure>

&nbsp;

## **<span style="font-family: Nunito; color: #000000;">Features</span>**

<span style="font-family: Nunito; font-size: 16px;">Here I&#8217;ll show you some screenshots from the solution and how they look:</span>

  * <span style="font-family: Nunito; font-size: 16px;"><strong>Security Hardening</strong><img loading="lazy" class="alignnone size-large wp-image-1254" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_securityhardening-1024x388.png" alt="runecast_securityhardening" width="656" height="249" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_securityhardening-1024x388.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_securityhardening-300x114.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_securityhardening-768x291.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_securityhardening-1536x582.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_securityhardening-2048x776.png 2048w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_securityhardening-1568x594.png 1568w" sizes="(max-width: 656px) 100vw, 656px" /></span>

<span style="font-family: Nunito; font-size: 16px;">It matches the security standard that you select to your environment and let you know which configuration you must apply in order to be compliant with that security standard.</span>

  * <span style="font-family: Nunito; font-size: 16px;"><strong>Best Practices</strong><img loading="lazy" class="alignnone size-large wp-image-1255" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_bestpractices-1024x396.png" alt="runecast_bestpractices" width="656" height="254" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_bestpractices-1024x396.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_bestpractices-300x116.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_bestpractices-768x297.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_bestpractices-1536x594.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_bestpractices-2048x792.png 2048w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_bestpractices-1568x607.png 1568w" sizes="(max-width: 656px) 100vw, 656px" /></span>

<span style="font-family: Nunito; font-size: 16px;">Guides you about which Best Practices can be configured in your VMware environment against the VMware Best Practices.</span>

  * <span style="font-family: Nunito; font-size: 16px;"><strong>Config KBs Discovered</strong><img loading="lazy" class="alignnone size-large wp-image-1256" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_configkbs-1024x398.png" alt="runecast_configkbs" width="656" height="255" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_configkbs-1024x398.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_configkbs-300x117.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_configkbs-768x298.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_configkbs-1536x597.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_configkbs-2048x796.png 2048w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_configkbs-1568x609.png 1568w" sizes="(max-width: 656px) 100vw, 656px" /></span>

<span style="font-family: Nunito; font-size: 16px;">One of the most pro-active features is Config KBs Discovered, it lets you know which configurations you have currently applied in your environment and the KBs that are published in the VMware DB.</span>

  * <span style="font-family: Nunito; font-size: 16px;"><strong>Hardware Compatibility</strong><img loading="lazy" class="alignnone size-large wp-image-1257" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_hcl-1024x382.png" alt="runecast_hcl" width="656" height="245" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_hcl-1024x382.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_hcl-300x112.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_hcl-768x287.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_hcl-1536x574.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_hcl-2048x765.png 2048w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_hcl-1568x586.png 1568w" sizes="(max-width: 656px) 100vw, 656px" /></span>

<span style="font-family: Nunito; font-size: 16px;">This feature will help you to deal with any kind of upgrades in just seconds, do you know if your hardware is listed in the Hardware Compatibility List for some product? It will give you all the information in just a moment.</span>

  * <span style="font-family: Nunito; font-size: 16px;"><strong>Log Inspector </strong><img loading="lazy" class="alignnone size-large wp-image-1258" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_loginspector-1024x458.png" alt="runecast_loginspector" width="656" height="293" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_loginspector-1024x458.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_loginspector-300x134.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_loginspector-768x343.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_loginspector-1536x687.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_loginspector-2048x915.png 2048w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/runecast_loginspector-1568x701.png 1568w" sizes="(max-width: 656px) 100vw, 656px" /></span>

<span style="font-family: Nunito; font-size: 16px;">Log inspector will look for patterns in your ESXi logs in real-time in order to analyze and provide a solution before anything happens. </span>

<span style="font-family: Nunito; font-size: 16px;">What a better way to apply a fix for something that you didn&#8217;t even notice?</span>

* * *

<span style="font-family: Nunito; font-size: 16px;">And that would be all for this quick post about Runecast Analyzer and how can it help in a VMware environment for vSphere, vSAN, and NSX.</span>

<span style="font-size: 16px; font-family: Nunito;">If you thought that Runecast Analyzer is a single-use tool, you&#8217;re wrong, it has many features that make it easier to manage a VMware environment in a daily-basis.</span>

<span style="font-family: Nunito; font-size: 16px;">Remember that you can try it for 30-days with all the features or use the live demo on their website.</span>

&nbsp;