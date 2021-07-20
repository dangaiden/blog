---
title: Troubleshooting tips for beginners in Windows Server
author: itgaiden
type: post
date: 2020-02-29T22:58:35+00:00
url: /?p=1467
rank_math_primary_category:
  - 40
rank_math_description:
  - "This is a post dedicated to people who just started administering servers with Windows Server 20xx-2019 or maybe you're curious and want to know more about how to manage Windows Servers efficiently."
rank_math_focus_keyword:
  - tips
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - Microsoft
  - Windows Server
tags:
  - microsoft
  - tips
  - Windows Server

---
<span style="font-family: Nunito; font-size: 16px;">I was thinking these days what I wish I have known when I started working with Windows servers, some basic (and some not) commands that can help me to troubleshoot servers without requiring additional software.<br /> </span>

&nbsp;

<span style="font-family: Nunito; font-size: 16px;">That&#8217;s why this is a post dedicated to people who just started administering servers with Windows Server 20xx-2019 (I expect at least 2008 although it is going end of support the next month) or maybe you&#8217;re curious and want to know more about Windows Server administration.</span>

<span style="font-size: 16px;"><strong><span style="font-family: Nunito;">We will exclude networking problems as that is another huge topic so, we assume that the server is reachable by using ping (ICMP protocol).<br /> </span></strong></span>

&nbsp;

# <span style="font-family: Nunito; color: #000000;"><span style="font-size: 32px;"><strong>RDP isn&#8217;t everything</strong></span><br /> </span>

<span style="font-family: Nunito; font-size: 16px;">First thing I notice when someone tells me: «I can&#8217;t access the server via RDP, it must be overloaded, unresponsive, etc. because I can ping it».</span>



<span style="font-family: Nunito; font-size: 16px;">As you may know (or not) RDP is the Remote Desktop protocol which usually runs in port 3389, there can be tons of reasons why you can&#8217;t access a server via RDP at the moment an alert raises (port blocked, server out of resources, user not allowed to RDP, etc.)</span>

<span style="font-family: Nunito; font-size: 16px;">Therefore, I will list some points about how to <strong>troubleshoot a server when you can&#8217;t access using RDP</strong>. In this way, you&#8217;ll be able to manage a server (Windows) without accessing it.<br /> </span>

&nbsp;

## **<span style="font-family: Nunito; color: #000000;">MMC (Microsoft Management Console)</span>**

<span style="font-family: Nunito; font-size: 16px;">MMC is everywhere, when you open the Event Viewer it is indeed an MMC that has the Snap-in «Event Viewer». Here is how would you do it manually instead of opening the Event Viewer «console»:<br /> </span>

<img loading="lazy" class="alignnone wp-image-1475 size-large" src="http://wp.docker.localhost:8000/wp-content/uploads/2020/02/evntvwr-1024x721.png" alt="event viewer" width="656" height="462" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/02/evntvwr-1024x721.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/evntvwr-300x211.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/evntvwr-768x541.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/evntvwr.png 1197w" sizes="(max-width: 656px) 100vw, 656px" /> 

<span style="font-family: Nunito; font-size: 16px;">You should try to master the MMC as it provides you the best way to manage different aspects and features from a Windows server (remote or local).</span>

&nbsp;

<span style="font-family: Nunito; font-size: 16px;">By typing «<span style="font-family: courier new, courier;">mmc</span>» in Run and pressing Enter», an empty console (MMC) will be open.</span><img loading="lazy" class="alignnone wp-image-1507 " src="http://wp.docker.localhost:8000/wp-content/uploads/2020/02/mmc_console_empty.png" alt="mmc_console_empty" width="590" height="288" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/02/mmc_console_empty.png 877w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/mmc_console_empty-300x146.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/mmc_console_empty-768x375.png 768w" sizes="(max-width: 590px) 100vw, 590px" />

<span style="font-family: Nunito; font-size: 16px;">And then, you can add a «snap-in» about any particular feature, service, etc. from Windows. Meaning that with the MMC you have at your disposal a tool to troubleshoot a remote or local server.</span>

<span style="font-family: Nunito; font-size: 16px;">Just go to <em>File</em> > <em>Add/Remove</em> snap-in and here choose what do you want! For this example,  I will add the <em>Certificates</em> snap-in in order to check which certificates are installed in my server:</span>

<span style="font-family: Nunito; font-size: 16px;"><img loading="lazy" class="alignnone wp-image-1533 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2020/03/add_snapin.png" alt="" width="1301" height="849" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/03/add_snapin.png 1301w, http://wp.docker.localhost:8000/wp-content/uploads/2020/03/add_snapin-300x196.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/03/add_snapin-1024x668.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2020/03/add_snapin-768x501.png 768w" sizes="(max-width: 1301px) 100vw, 1301px" /></span>

<span style="font-family: Nunito; font-size: 16px;">Once you press <em>Add</em>, it will ask you which account, usually you want to use the computer account because services and features related to the computer nor a user account.</span><span style="font-family: Nunito; font-size: 16px;"><img loading="lazy" class="alignnone wp-image-1530 " src="http://wp.docker.localhost:8000/wp-content/uploads/2020/03/Certificates-snap-in_computeraccount.png" alt="" width="334" height="192" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/03/Certificates-snap-in_computeraccount.png 414w, http://wp.docker.localhost:8000/wp-content/uploads/2020/03/Certificates-snap-in_computeraccount-300x172.png 300w" sizes="(max-width: 334px) 100vw, 334px" /></span>

<span style="font-family: Nunito; font-size: 16px;">Choose if you want to manage a local or remote server:</span><span style="font-family: Nunito; font-size: 16px;"><img loading="lazy" class="alignnone wp-image-1531 " src="http://wp.docker.localhost:8000/wp-content/uploads/2020/03/snapin_Select-Computer.png" alt="" width="534" height="240" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/03/snapin_Select-Computer.png 777w, http://wp.docker.localhost:8000/wp-content/uploads/2020/03/snapin_Select-Computer-300x135.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/03/snapin_Select-Computer-768x345.png 768w" sizes="(max-width: 534px) 100vw, 534px" /></span>

<span style="font-family: Nunito; font-size: 16px;">And finally, here is the final screenshot after adding the<em> Certificates</em> snap-in from my computer:</span><img loading="lazy" class="alignnone wp-image-1532 size-medium_large" src="http://wp.docker.localhost:8000/wp-content/uploads/2020/03/Console-Root_Certificates-Local-Computer-768x223.png" alt="" width="656" height="190" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/03/Console-Root_Certificates-Local-Computer-768x223.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2020/03/Console-Root_Certificates-Local-Computer-300x87.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/03/Console-Root_Certificates-Local-Computer-1024x297.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2020/03/Console-Root_Certificates-Local-Computer.png 1300w" sizes="(max-width: 656px) 100vw, 656px" />

&nbsp;

**<span style="font-size: 16px;"><span style="font-family: Nunito;">Now, imagine if you do the same with the <em>Services</em> snap-in and select <em>Another Computer</em>, you will be able to manage the services from a remote computer by just doing that and without connecting to the server using RDP!</span></span>**

<img loading="lazy" class="alignnone wp-image-1523" src="http://wp.docker.localhost:8000/wp-content/uploads/2020/02/fallout-hacking-300x300.jpg" alt="" width="335" height="335" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/02/fallout-hacking-300x300.jpg 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/fallout-hacking-150x150.jpg 150w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/fallout-hacking.jpg 620w" sizes="(max-width: 335px) 100vw, 335px" /> 

&nbsp;

## <span style="color: #000000;"><strong><span style="font-family: Nunito;">Check memory resources (RAM)</span></strong></span>

#### **<span style="font-family: Nunito; color: #000000;"><span style="color: #808080;">CMD (command prompt)</span><br /> </span>**

<span style="font-size: 16px; font-family: Nunito;">Our «old» friend <strong>CMD</strong> or command prompt interpreter which works on all versions of Windows Server, no matter which problem you have on your server that you can always run it and <strong>it is available on any Windows installation without any requirement</strong>.</span>

<span style="font-size: 16px; font-family: Nunito;">There are some useful commands to manage a remote Windows server. The first command I want to show you is the «<strong><em>tasklist</em></strong>» command, which is the equivalent of the «Task Manager» that you probably know.</span>

<span style="font-size: 16px; font-family: Nunito;">It can become very handy to check which processes are consuming more <strong>memory resources</strong>:</span>

[powershell]tasklist /s <server> | sort /R /+58[/powershell]

<img loading="lazy" class="alignnone wp-image-1476 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2020/02/tasklist_sort.png" alt="tasklist command" width="850" height="521" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/02/tasklist_sort.png 850w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/tasklist_sort-300x184.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/tasklist_sort-768x471.png 768w" sizes="(max-width: 850px) 100vw, 850px" /> 

<span style="font-family: Nunito; font-size: 16px;">The previous command is just for Memory usage (RAM) but it won&#8217;t work for CPU so, how can I check which process is <strong>consuming more CPU resources</strong>? </span>

<span style="font-family: Nunito; font-size: 16px;"><span style="text-decoration: underline;">Check the next section!</span><br /> </span>

&nbsp;

## **<span style="font-family: Nunito; color: #000000;">Check CPU resources (CPU)</span>**

#### <span style="font-family: Nunito;"><strong><span style="color: #808080;">WMIC (Windows Management Interface Console)</span><br /> </strong></span>

<span style="font-family: Nunito; font-size: 16px;">In order to check the CPU remotely, there isn&#8217;t a simple command like «tasklist» with parameters as it is harder to get the stats from the CPU perspective.</span>

<span style="font-family: Nunito; font-size: 16px;">Anyway,  this is another command that can be used within CMD, the command is <strong>wmic</strong>, here you have some examples:</span>

<span style="font-family: Nunito; font-size: 16px;">To get the CPU usage of the server:<br /> </span>

[powershell] wmic cpu get loadpercentage [/powershell]

<img loading="lazy" class="alignnone wp-image-1521 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2020/02/wmic_cpugetloadpercentage.png" alt="" width="382" height="101" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/02/wmic_cpugetloadpercentage.png 382w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/wmic_cpugetloadpercentage-300x79.png 300w" sizes="(max-width: 382px) 100vw, 382px" /> 

<span style="font-family: Nunito; font-size: 16px;">Or the processes that are consuming a particular percentage (70% in this example):</span>

[powershell] wmic path win32\_perfformatteddata\_perfproc_process where (PercentProcessorTime ^> 70) get Name, Caption, PercentProcessorTime, IDProcess /format:list [/powershell]

<img loading="lazy" class="alignnone wp-image-1522 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2020/02/wmic_get70percent.png" alt="" width="861" height="280" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/02/wmic_get70percent.png 861w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/wmic_get70percent-300x98.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/wmic_get70percent-768x250.png 768w" sizes="(max-width: 861px) 100vw, 861px" /> 

<span style="font-family: Nunito; font-size: 16px;">As you can see in this output, it says «PercentProcessorTime=100», which means that a process (mcshield) consumed 100% of his time when we asked for the processes above 50% of the server.</span>

<span style="font-family: Nunito; font-size: 16px;"><strong>So in this case, the process «mcshield» (which is related to McAfee) is consuming more than 50% of the CPU.</strong></span>

<span style="font-family: Nunito; font-size: 16px;">Obviously de «_Total» process mustn&#8217;t take into account and it&#8217;s in the output because I didn&#8217;t want to make it larger (although is a bit large).</span>

<span style="font-family: Nunito; font-size: 16px;">There is another command (typeperf) which although it can be more powerful (it uses performance counters), the output is a mess (lots of data). I won&#8217;t show it here but  I wanted to let you know.</span>

## 

## <span style="font-family: Nunito;"><strong><span style="color: #000000;">Alternate access to RDP</span></strong><br /> </span>

<span style="font-family: Nunito; font-size: 16px;">A server can be physical or virtual then, you can probably access the virtual machine using Hyper-V Manager (if you use Hyper-V) or the vSphere Web Client (vSphere) tools in order to gain access to the virtual server.<br /> </span>

<span style="font-family: Nunito; font-size: 16px;">If the server is physical, you have probably access to some remote console (iLO, iDRAC, etc.) to access the server and finally be able to log if you need to.</span>

&nbsp;

&nbsp;

<span style="font-family: Nunito; font-size: 16px;">I hope these tips helped you or at least make you remember how to do it, see you next time.</span>

<img loading="lazy" class="alignnone wp-image-1471 size-medium" src="http://wp.docker.localhost:8000/wp-content/uploads/2020/02/vault_boy_approval-204x300.png" alt="" width="204" height="300" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/02/vault_boy_approval-204x300.png 204w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/vault_boy_approval-697x1024.png 697w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/vault_boy_approval-768x1128.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/vault_boy_approval-1046x1536.png 1046w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/vault_boy_approval-1394x2048.png 1394w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/vault_boy_approval-1568x2303.png 1568w, http://wp.docker.localhost:8000/wp-content/uploads/2020/02/vault_boy_approval.png 1600w" sizes="(max-width: 204px) 100vw, 204px" />