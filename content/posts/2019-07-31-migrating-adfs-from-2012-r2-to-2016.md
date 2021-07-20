---
title: Migrating ADFS from 2012 R2 (3.0 v) to 2016 (4.0 v.)
author: itgaiden
type: post
date: 2019-07-31T21:12:50+00:00
url: /?p=942
rank_math_primary_category:
  - 40
rank_math_description:
  - In this post we will go through the process of migrating ADFS from 2012 R2 (3.0 v) to 2016 (4.0 v.)
rank_math_focus_keyword:
  - ADFS migration
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - Microsoft
tags:
  - ADFS

---
<span style="font-family: Nunito; font-size: 16px;">I will explain today how to migrate ADFS from 2012 R2 (3.0 v) to 2016 (4.0) without almost no downtime. The overall process consists in adding the new ADFS server to the farm, assign the primary role to the new ADFS, make some changes and then we&#8217;re done.<br /> </span>

&nbsp;

<span style="font-family: Nunito; font-size: 16px;">The current environment is:</span>

  * <span style="font-family: Nunito; font-size: 16px;">1 x WAP Server (W2012 R2)</span>
  * <span style="font-size: 16px; font-family: Nunito;"><strong>1 x ADFS Server (W2012 R2)</strong></span>

<span style="font-size: 16px; font-family: Nunito;">No applications published, just an Office 365 </span>Relying <span style="font-size: 16px; font-family: Nunito;">party trust.</span>

<span style="font-size: 16px; font-family: Nunito;">A DNS A record that points <strong>sts.teselia.com</strong> to the ADFS IP address.</span>

&nbsp;

<span style="font-family: Nunito; font-size: 16px;">And the future environment will be:</span>

  * <span style="font-family: Nunito; font-size: 16px;">1 x WAP Server (W2016) -> Not in this post<br /> </span>
  * <span style="font-size: 16px; font-family: Nunito;"><strong>1 x ADFS Server (W2016) -> In this post<br /> </strong></span>

## <span style="font-family: Nunito; color: #000000;"><strong>Planning for your ADFS Migration</strong></span>

  1. <span style="font-family: Nunito; font-size: 16px;">Active Directory schema update using ‘ADPrep’ with the Windows Server 2016 additions (not necessary in my case)</span>
  2. <span style="font-family: Nunito; font-size: 16px;">Build a Windows Server 2016 server with ADFS and join into an existing farm.</span>
  3. <span style="font-family: Nunito; font-size: 16px;">Promote one of the ADFS 2016 servers as “primary” of the farm, and point all other secondary servers to the new “primary”.</span>
  4. <span style="font-family: Nunito; font-size: 16px;">Change DNS records to the new servers&#8217;s IP address.</span>
  5. <span style="font-family: Nunito; font-size: 16px;">Raise the Farm Behavior Level feature (FBL) to ‘2016’</span>
  6. <span style="font-family: Nunito;">Test that the setup works correctly.</span>
  7. <span style="font-family: Nunito; font-size: 16px;">Remove the old ADFS server (W2012 R2) from the farm.</span>

## 

## <span style="font-family: Nunito; color: #000000;">Upgrading Schema</span>

<span style="font-family: Nunito; font-size: 16px;">Now, time to upgrade the schema of the AD:</span>

<span style="font-family: Nunito; font-size: 16px;">Put the installation media from W2016 Datacenter:</span>

<span style="font-size: 16px; font-family: Nunito;">Adprep /forestprep</span>

<span style="font-family: Nunito;"><span style="font-size: 16px;">In my </span><span style="font-size: 16px;">case, it was already updated (my domain is in W2012 R2 so it seems that I don’t need it).</span></span>

&nbsp;

## <span style="font-family: Nunito; color: #000000;">Installing and configuring ADFS</span>

<span style="font-size: 16px; font-family: Nunito;">Once we deployed a new Windows Server 2016 and it&#8217;s joined to our domain&#8230;</span>

<span style="font-family: Nunito; font-size: 16px;">Install the role of ADFS in your target server and then continue with the post-deployment config:</span>

<span style="font-family: Nunito; font-size: 16px;"><img loading="lazy" class="alignnone size-medium wp-image-987" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Post_deployment_img_1-300x98.png" alt="" width="300" height="98" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Post_deployment_img_1-300x98.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Post_deployment_img_1.png 327w" sizes="(max-width: 300px) 100vw, 300px" /></span>

&nbsp;

<span style="font-size: 16px; font-family: Nunito;">Provide can account with Domain Administrator permissions:<img loading="lazy" class="alignnone wp-image-988 size-penscratch-featured" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Post_deployment_img_2-656x300.png" alt="" width="656" height="300" /></span>

&nbsp;

<span style="font-family: Nunito;"><span style="font-size: 16px;">Provide your federation service name. You can review it in the current ADFS primary server and click Properties in the root folder of the ADFS console:</span><img loading="lazy" class="alignnone wp-image-989 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Review_fed_name_img_3.png" alt="" width="669" height="461" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Review_fed_name_img_3.png 669w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/Review_fed_name_img_3-300x207.png 300w" sizes="(max-width: 669px) 100vw, 669px" /></span>

&nbsp;

<span style="font-size: 16px; font-family: Nunito;">In our case “<strong>sts.teselia.com</strong>”:<img loading="lazy" class="alignnone wp-image-990 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/insert_fed_name_img_4.png" alt="" width="757" height="459" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/insert_fed_name_img_4.png 757w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/insert_fed_name_img_4-300x182.png 300w" sizes="(max-width: 757px) 100vw, 757px" /></span>

&nbsp;

<span style="font-family: Nunito; font-size: 16px;">Specify your SSL certificate (usually your wildcard):</span>

<span style="font-family: Nunito;"><img loading="lazy" class="alignnone size-full wp-image-979" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/specify_ssl_cert_img_6.png" alt="" width="747" height="449" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/specify_ssl_cert_img_6.png 747w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/specify_ssl_cert_img_6-300x180.png 300w" sizes="(max-width: 747px) 100vw, 747px" /></span>

&nbsp;

<span style="font-size: 16px; font-family: Nunito;">Then, I will use an account (Managed service account recommended):<img loading="lazy" class="alignnone size-full wp-image-980" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/specify_serv_acc_img_5.png" alt="" width="749" height="342" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/specify_serv_acc_img_5.png 749w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/specify_serv_acc_img_5-300x137.png 300w" sizes="(max-width: 749px) 100vw, 749px" /></span>

&nbsp;

<span style="font-family: Nunito;"><span style="font-size: 16px;">Review your configuration and after the pre-requisite checks proceed with the «Configure» button:</span><img loading="lazy" class="alignnone size-full wp-image-981" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/review-config_img_7.png" alt="" width="751" height="515" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/review-config_img_7.png 751w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/review-config_img_7-300x206.png 300w" sizes="(max-width: 751px) 100vw, 751px" /></span>

&nbsp;

<span style="font-size: 16px; font-family: Nunito;">After the server is installed you will have some warnings that will be fixed later by rebooting the server and making this new server as the primary ADFS server in the farm:<img loading="lazy" class="alignnone size-full wp-image-982" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/configured_warnings_img_8.png" alt="" width="747" height="509" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/configured_warnings_img_8.png 747w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/configured_warnings_img_8-300x204.png 300w" sizes="(max-width: 747px) 100vw, 747px" /></span>

<span style="font-family: Nunito; font-size: 16px;">Then, we will proceed to reboot our server (ADFS01.teselia.com).</span>

&nbsp;

## <span style="font-family: Nunito; color: #000000;">Configuring as a «PrimaryComputer» in the ADFS farm</span>

<span style="font-family: Nunito; font-size: 16px;">Once the machine has restarted, open the ADFS Management Console, and you’ll notice it’s not the primary federation server in the farm.</span>

<span style="font-family: Nunito; font-size: 16px;"><img loading="lazy" class="alignnone wp-image-983 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/adfs_console_warnings_img_9.png" alt="" width="564" height="213" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/adfs_console_warnings_img_9.png 564w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/adfs_console_warnings_img_9-300x113.png 300w" sizes="(max-width: 564px) 100vw, 564px" /></span>

<span style="font-family: Nunito; font-size: 16px;">Open a PS console and execute: </span>

<span style="font-family: Nunito;"><span style="font-size: 16px; font-family: courier new, courier; color: #000000;">Set-AdfsSyncProperties -Role PrimaryComputer</span><img loading="lazy" class="alignnone wp-image-984 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/pscommand_img_10.png" alt="" width="442" height="102" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/pscommand_img_10.png 442w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/pscommand_img_10-300x69.png 300w" sizes="(max-width: 442px) 100vw, 442px" /></span>

&nbsp;

<span style="font-size: 16px; font-family: Nunito;">After that, I can access the ADFS console from our new ADFS server without the warning:<img loading="lazy" class="alignnone wp-image-985 size-medium_large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/adfs_console_img_11-768x400.png" alt="" width="656" height="342" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/adfs_console_img_11-768x400.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/adfs_console_img_11-300x156.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/adfs_console_img_11.png 875w" sizes="(max-width: 656px) 100vw, 656px" /></span>

&nbsp;

<span style="font-family: Nunito; font-size: 16px;">Execute this on the other ADFS servers (we will point the new ADFS server as the PRIMARY):</span>

<span style="font-family: Nunito; font-size: 16px;">Set-AdfsSyncProperties -Role SecondaryComputer -PrimaryComputerName sts.teselia.com</span>

<span style="font-family: Nunito;"><span style="font-size: 16px;">Then, we will check that in our old ADFS server it’s correct:</span><img loading="lazy" class="alignnone wp-image-986 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/ps_commands_img_12.png" alt="" width="829" height="159" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/08/ps_commands_img_12.png 829w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/ps_commands_img_12-300x58.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/08/ps_commands_img_12-768x147.png 768w" sizes="(max-width: 829px) 100vw, 829px" /></span>

### 

### <span style="font-family: Nunito; color: #000000;">Details to bear in mind</span>

<span style="font-size: 16px; font-family: Nunito;">So, in my case, I have a DNS A record that points <strong>sts.teselia.com</strong> to an IP address (the ADFS server)</span>

<span style="font-family: Nunito; font-size: 16px;">After pointing the new, I had to modify the hosts file from the WAP server in the DMZ to point to the new server!</span>

<span style="font-family: Nunito; font-size: 16px;">Also, I modified the DNS  record from the <strong>internal DNS</strong> with the new server&#8217;s IP address.</span>

&nbsp;

&nbsp;

## <span style="font-family: Nunito; color: #000000;">Error with 0365 relying party trust</span>

<span style="font-family: Nunito; font-size: 16px;">After migrating the service from ADFS 3.0 (W2012 R2) to ADFS 4.0 (W2016), I faced a  problem when updating the O365 relying party trust.</span>

<span style="font-family: Nunito; font-size: 16px;"><img loading="lazy" class="alignnone wp-image-993 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/07/fed_metadata_error_12_bis.png" alt="" width="636" height="456" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/07/fed_metadata_error_12_bis.png 636w, http://wp.docker.localhost:8000/wp-content/uploads/2019/07/fed_metadata_error_12_bis-300x215.png 300w" sizes="(max-width: 636px) 100vw, 636px" /></span>

<span style="font-family: Nunito; font-size: 16px;">The solution was to apply a fix described by Microsoft:</span>

<span style="font-family: Nunito; font-size: 16px;"><a href="https://docs.microsoft.com/en-us/security-updates/SecurityAdvisories/2015/2960358">https://docs.microsoft.com/en-us/security-updates/SecurityAdvisories/2015/2960358</a></span>

<span style="font-family: Nunito; font-size: 16px;">Basically, what you have to do is to add a couple of registry values in this new ADFS server because it&#8217;s Windows Server 2016 and is running ADFS 4.0 version.</span>

<span style="font-family: Nunito;"><span style="font-size: 16px;">Once you applied the fix, reboot it and works flawlessly!</span><img loading="lazy" class="alignnone wp-image-995 size-full" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/07/fed_metadata_13.png" alt="" width="882" height="522" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/07/fed_metadata_13.png 882w, http://wp.docker.localhost:8000/wp-content/uploads/2019/07/fed_metadata_13-300x178.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/07/fed_metadata_13-768x455.png 768w" sizes="(max-width: 882px) 100vw, 882px" /></span>

&nbsp;

## <span style="font-family: Nunito;"><span style="color: #000000;">Testing the new setup</span><br /> </span>

<span style="font-family: Nunito;">T<span style="font-size: 16px;">o check that it&#8217;s really working, try to log into your Office 365 portal and it must show you the portal from your federation service.</span></span>

<span style="font-family: Nunito; font-size: 16px;">As the WAP service isn&#8217;t migrated yet, it should respond correctly but if the configuration is not correct, it won&#8217;t be able to gather the configuration from the ADFS service.</span>

## <span style="color: #000000; font-family: Nunito;">Removing the old ADFS server</span>

<span style="font-size: 16px; font-family: Nunito;">Once you tested that it works correctly, as both ADFS servers will have the configuration replicated, you can remove the role from the old one (that now holds the secondary role) and then remove it from the domain.</span>

<span style="font-size: 16px; font-family: Nunito;">With that done, you will have a fresh new Windows Server 2016 ADFS server and none «old» ADFS servers.</span>

&nbsp;

&nbsp;

<span style="font-size: 16px; font-family: Nunito;">And that&#8217;s all, I will do in the future another post about the WAP service migration that it&#8217;s easier than this one, I hope that this can help someone.</span>