---
title: 'vSphere Network I/O Control: NIC Limit bandwidth'
author: itgaiden
type: post
date: 2018-08-02T23:39:01+00:00
url: /?p=156
rank_math_primary_category:
  - 11
rank_math_description:
  - vSphere Network I/O Control (NIOC) version 3 (vSphere 6.0) is a feature in the vSphere Distributed Switch that allows you to control granularly the output/egress bandwidth from a VM network adapter level.
rank_math_focus_keyword:
  - vSphere Network I/O Control
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - Network
  - VMware
tags:
  - networking
  - NIOC
  - VMware

---
<span style="font-size: 16px; font-family: Didact Gothic;">Today let&#8217;s talk about vSphere Network I/O Control (NIOC) version 3 (vSphere 6.0), it&#8217;s a feature in the vSphere Distributed Switch that allows you to control granularly the output/egress bandwidth from a VM network adapter level. Besides there are other useful options within NIOC capabilities, today, I will focus <span style="text-decoration: underline;">only in the network adapter bandwidth limit</span> for VMs.</span>

### <span style="font-size: 24px; font-family: Didact Gothic;"><strong>Prerequisites:</strong></span>

<span style="font-family: Didact Gothic;"><span style="font-size: 12pt;">Enable the feature in the dvSwitch (in our case the one with Data Network):</span><span style="font-size: 10pt;"><img loading="lazy" class="alignnone size-full wp-image-163" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/1st_dswitchenable.png" alt="" width="954" height="242" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/1st_dswitchenable.png 954w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/1st_dswitchenable-300x76.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/1st_dswitchenable-768x195.png 768w" sizes="(max-width: 954px) 100vw, 954px" /></span><span style="font-size: 24px;"><strong>Scenario:</strong></span></span>

<span style="font-size: 12pt; font-family: Didact Gothic;">2 VMs within 2 Networks (Portgroups in dvSwitch)</span>

<span style="font-size: 10pt; font-family: Didact Gothic;"><img loading="lazy" class="alignnone size-full wp-image-175" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/LogicalNW_NIOC.png" alt="" width="1314" height="676" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/LogicalNW_NIOC.png 1314w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/LogicalNW_NIOC-300x154.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/LogicalNW_NIOC-1024x527.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/LogicalNW_NIOC-768x395.png 768w" sizes="(max-width: 1314px) 100vw, 1314px" /></span>

<span style="font-size: 12pt; font-family: Didact Gothic;"><strong>KenshiroVM</strong> is a VM with Ubuntu that simulates traffic with iperf as a client.</span>

<span style="font-size: 10pt; font-family: Didact Gothic;"><span style="font-size: 12pt;"><strong>Win10Pro</strong> is a VM with <a href="https://iperf.fr/">iperf</a> application configured as a server:</span><img loading="lazy" class="alignnone wp-image-166" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/4th_win10proiperf.png" alt="" width="551" height="431" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/4th_win10proiperf.png 947w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/4th_win10proiperf-300x235.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/4th_win10proiperf-768x601.png 768w" sizes="(max-width: 551px) 100vw, 551px" /></span>

### <span style="font-size: 24px; font-family: Didact Gothic;"><strong>Objective:</strong></span>

<span style="font-size: 12pt; font-family: Didact Gothic;">We will look in how Network I/O control (NIOC) let us limit the bandwidth granularly from a Virtual Machine (KenshiroVM), so, we will limit the bandwidth for a single NIC and see if it really works.</span>

### <span style="font-size: 24px; font-family: Didact Gothic;"><strong>Testing:</strong></span>

<span style="font-size: 12pt; font-family: Didact Gothic;">Lab time! I enabled NIOC in the dvSwitch that I have created for OS traffic (Data Network), dvSwitch is called “DSwitch_DataNW”. The other dvSwitch is “DSwitchMGMT” and NIOC is not enabled (no NIOC = no restrictions).</span>

<span style="font-size: 12pt; font-family: Didact Gothic;">As I said before we have 2 networks:</span>

  * <span style="font-size: 12pt; font-family: Didact Gothic;">Data Network: 10.10.6.0/24</span>
  * <span style="font-size: 12pt; font-family: Didact Gothic;">Management Network: 192.168.1.0/24</span>

#### **<span style="font-family: Didact Gothic; font-size: 20px;">Main steps:</span>**

<p style="padding-left: 30px;">
  <span style="font-size: 12pt; font-family: Didact Gothic;"><strong>1.</strong> Verify that the client (<strong>KenshiroVM</strong>) has no restrictions within the network.</span>
</p>

<p style="padding-left: 30px;">
  <span style="font-size: 12pt; font-family: Didact Gothic;"><strong>2. </strong>Then, we will limit the Data Network adapter from <strong>KenshiroVM</strong>, launch iperf to simulate traffic and review the limitation configured.</span>
</p>

<p style="padding-left: 30px;">
  <span style="font-size: 12pt; font-family: Didact Gothic;"><strong>3.</strong> Finally we will test iperf again but in the Management Network and review that we have no restrictions.</span>
</p>

* * *

<span style="font-size: 10pt; font-family: Didact Gothic;"><span style="font-size: 12pt;"><strong>1.</strong></span> <span style="font-size: 16px;">Currently, KenshiroVM has no restrictions configured (notice that in the blue rectangle there are no options for NIOC because that portgroup (Management) it’s located in another dvSwitch where we didn’t enable NIOC):</span></span>

<span style="font-size: 10pt; font-family: Didact Gothic;"><img loading="lazy" class="aligncenter wp-image-167" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/5th_KenshiroVM.png" alt="" width="427" height="492" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/5th_KenshiroVM.png 521w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/5th_KenshiroVM-261x300.png 261w" sizes="(max-width: 427px) 100vw, 427px" /></span>

<span style="font-size: 10pt; font-family: Didact Gothic;"><span style="font-size: 14px;"><span style="font-size: 16px;">If we launch iperf command with 200Mbps on port 9999 from KenshiroVM:</span></span><img loading="lazy" class="alignnone size-full wp-image-168" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/6th_kenvm_iperf.png" alt="" width="710" height="123" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/6th_kenvm_iperf.png 710w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/6th_kenvm_iperf-300x52.png 300w" sizes="(max-width: 710px) 100vw, 710px" /></span>

<span style="font-size: 10pt; font-family: Didact Gothic;"><span style="font-size: 16px;">We can see the traffic <span style="color: #000000;">on the destination</span> (<strong>Win10Pro</strong>) on the Data Network Adapter (you can see the subnet in the screenshot):</span><img loading="lazy" class="alignnone wp-image-169" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/7th_win10proiperflimit.png" alt="" width="616" height="655" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/7th_win10proiperflimit.png 699w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/7th_win10proiperflimit-282x300.png 282w" sizes="(max-width: 616px) 100vw, 616px" /></span>

<span style="font-size: 10pt; font-family: Didact Gothic;"><span style="font-size: 16px;">Also, we can review it in vSphere Web Client (25 MBps = 200 Mbps):</span><img loading="lazy" class="alignnone size-full wp-image-170" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/8th_win10pro_monitor.png" alt="" width="888" height="558" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/8th_win10pro_monitor.png 888w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/8th_win10pro_monitor-300x189.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/8th_win10pro_monitor-768x483.png 768w" sizes="(max-width: 888px) 100vw, 888px" /></span>

<span style="font-size: 10pt; font-family: Didact Gothic;"><span style="font-size: 12pt;"><strong>2.</strong> Now we are going to <strong>set a limit</strong> on KenshiroVM Data Network adapter to 88 Mbits:</span><img loading="lazy" class="wp-image-171 aligncenter" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/9th_kenvm_limit.png" alt="" width="477" height="420" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/9th_kenvm_limit.png 518w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/9th_kenvm_limit-300x264.png 300w" sizes="(max-width: 477px) 100vw, 477px" /></span>

<span style="font-size: 12pt; font-family: Didact Gothic;">Now, we perform the same command with iperf on the client (KenshiroVM):<img loading="lazy" class="alignnone size-full wp-image-158" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/10th_kenvm200MB.png" alt="" width="699" height="108" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/10th_kenvm200MB.png 699w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/10th_kenvm200MB-300x46.png 300w" sizes="(max-width: 699px) 100vw, 699px" /></span>

<span style="font-size: 16px; font-family: Didact Gothic;"><strong>Even pushing 200 Mbits</strong> through the Data Netowork Adapter using iperf, NIOC will limit the traffic to 88 Mbits as set before. Here is the traffic seen by Win10Pro Data Network adapter:</span>

<span style="font-size: 10pt; font-family: Didact Gothic;"><img loading="lazy" class="alignnone size-full wp-image-159" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/11st_ethernet915mbps.png" alt="" width="432" height="420" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/11st_ethernet915mbps.png 432w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/11st_ethernet915mbps-300x292.png 300w" sizes="(max-width: 432px) 100vw, 432px" /></span>

<span style="font-size: 12pt; font-family: Didact Gothic;"><span style="font-size: 16px;">In KenshiroVM, </span>iperf<span style="font-size: 16px;"> performed the transfer in 88 Mbps approximately:</span><img loading="lazy" class="alignnone size-full wp-image-160" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/12nd_kenvm_iperf_report.png" alt="" width="706" height="167" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/12nd_kenvm_iperf_report.png 706w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/12nd_kenvm_iperf_report-300x71.png 300w" sizes="(max-width: 706px) 100vw, 706px" /></span>

<span style="font-size: 10pt; font-family: Didact Gothic;"><span style="font-size: 12pt;"><strong>3.</strong> Now, if we do the same experiment (150 Mbps) but in the adapter where NIOC is not enabled:</span></span>

<span style="font-size: 10pt; font-family: Didact Gothic;"><img loading="lazy" class="size-full wp-image-161 alignnone" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/13rd_win10pro_nolimitnic.png" alt="" width="541" height="535" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/13rd_win10pro_nolimitnic.png 664w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/13rd_win10pro_nolimitnic-300x297.png 300w" sizes="(max-width: 541px) 100vw, 541px" /></span>

<span style="font-size: 12pt; font-family: Didact Gothic;">KenshiroVM confirmed that it performed at 150 Mbps approximately:<img loading="lazy" class="alignnone size-full wp-image-162" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/14th_kenvm_iperf_nolimit150mbps.png" alt="" width="709" height="164" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/08/14th_kenvm_iperf_nolimit150mbps.png 709w, http://wp.docker.localhost:8000/wp-content/uploads/2018/08/14th_kenvm_iperf_nolimit150mbps-300x69.png 300w" sizes="(max-width: 709px) 100vw, 709px" /></span>

<ul style="list-style-type: square;">
  <li>
    <h3>
      <span style="font-size: 24px; font-family: Didact Gothic;"><strong>Conclusion</strong></span>
    </h3>
  </li>
</ul>

<span style="font-size: 16px; font-family: Didact Gothic;">As a result of using vSphere NIOC,  we can granularly set limits in the bandwidth in a VM network adapter and it will obey the settings configured. <strong>It only works for outbound traffic</strong>, if you set a limit in a destination VM adapter, then, NIOC will not make any restrictions regarding the inbound traffic.</span>