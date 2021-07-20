---
title: WSFC – Validate Configuration wizard error
author: itgaiden
type: post
date: 2020-06-29T09:30:08+00:00
url: /?p=1789
categories:
  - Microsoft
  - Windows Server
tags:
  - Windows Server
  - WSFC

---
<span style="font-family: Nunito;">This is a short post talking about <strong>Windows Server Failover Clustering (WSFC)</strong> and a problem I found when adding the nodes from your cluster using the <em>«Validate a Configuration»</em> wizard.</span>

<span style="font-family: Nunito;">This wizard is recommended to run after configuring your nodes and before creating the cluster in order to spot any misconfigurations.</span>

<span style="font-family: Nunito;">So now, let&#8217;s go into the problem.</span>

&nbsp;

# <span style="font-family: Nunito; font-size: 32px;">The issue</span>

<span style="font-family: Nunito;">In the wizard when trying to add (in my example) the second node shows an error:</span>

<span style="font-family: helvetica;">Failed to access remote registry on <FQDNoftheserver>. Ensure the remote registry service is running, and have remote administration enabled.</span>

<img loading="lazy" class="alignnone wp-image-1797 " src="http://wp.docker.localhost:8000/wp-content/uploads/2020/06/validate-configuration_FAIL.png" alt="" width="562" height="369" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/06/validate-configuration_FAIL.png 1002w, http://wp.docker.localhost:8000/wp-content/uploads/2020/06/validate-configuration_FAIL-300x197.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/06/validate-configuration_FAIL-768x504.png 768w" sizes="(max-width: 562px) 100vw, 562px" /> 

&nbsp;

# <span style="font-family: Nunito; color: #000000; font-size: 32px;">Possible solutions</span>

  * <span style="font-family: Nunito; font-size: 16px;">Execute in Powershell (PS): </span><span style="font-family: courier new, courier; font-size: 16px;">winrm quickconfig</span>

<span style="font-family: Nunito; font-size: 16px;">This will set up «winrm» (Windows Remote Management), more information in this <span style="text-decoration: underline;"><a href="https://docs.microsoft.com/en-us/windows/win32/winrm/installation-and-configuration-for-windows-remote-management">link</a>.</span></span>

  * <span style="font-family: Nunito; font-size: 16px;">Review the NIC settings on the affected node:</span>

<span style="font-family: Nunito; font-size: 16px;">Check the options <span lang="EN-US">“File and Print Sharing for Microsoft Networks» and «Client for Microsoft Networks» for the NIC that you&#8217;re are trying to add the node (based on what&#8217;s registered in DNS): </span></span>

<span style="font-family: Nunito; font-size: 16px;"><img loading="lazy" class="alignnone wp-image-1796 " src="http://wp.docker.localhost:8000/wp-content/uploads/2020/06/Ethernet_config.png" alt="" width="309" height="379" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/06/Ethernet_config.png 539w, http://wp.docker.localhost:8000/wp-content/uploads/2020/06/Ethernet_config-244x300.png 244w" sizes="(max-width: 309px) 100vw, 309px" /></span>

  * <span style="font-family: Nunito; font-size: 16px;"> Review the service «remote registry» is set to <strong>«automatic (trigger start)».</strong></span>

&nbsp;

<span style="font-family: Nunito; font-size: 16px;">After that, you shouldn&#8217;t have problems in order to add your nodes within the cluster from the wizard:</span>

<span style="font-family: Roboto Slab; font-size: 16px;"><img loading="lazy" class="alignnone wp-image-1798 " src="http://wp.docker.localhost:8000/wp-content/uploads/2020/06/validate-configuration_working.png" alt="" width="572" height="374" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2020/06/validate-configuration_working.png 1003w, http://wp.docker.localhost:8000/wp-content/uploads/2020/06/validate-configuration_working-300x196.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2020/06/validate-configuration_working-768x502.png 768w" sizes="(max-width: 572px) 100vw, 572px" /></span>

<span style="font-size: 16px; font-family: Nunito;">Now, you could continue with the testing options and so on but this post is only to explain the error and how to solve it.</span>

&nbsp;

<span style="font-family: Nunito; font-size: 16px; color: #666699;">That will conclude this quick post about Windows Server Failover Cluster and an issue you can find while trying to validate the configuration of your cluster from the wizard.</span>

&nbsp;

&nbsp;

&nbsp;