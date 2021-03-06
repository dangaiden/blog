---
title: Upgrade vROps from 6.7.0 to 8.0.1
author: itgaiden
type: post
date: 2020-05-21T20:00:52+00:00
url: 2020-05-21-upgrade-vrops-from-6-7-0-to-8-0-1
rank_math_focus_keyword:
  - vROps
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - VMware
  - vRealize
tags:
  - upgrade
  - VMware
  - vROps

---
&nbsp;

<span >In this blog post, we will see how to upgrade vRealize Operations (vROps) from version 6.7.0 to <span class="fileNameHolder">8.0.1. The whole process takes about 30 minutes.</span></span>

<span style="font-size: 16px; font-family: Nunito;"><strong>Bear in mind that, you will need new license keys after updating to the later version (after 8.0 version).<br /> </strong></span>

&nbsp;

<span ><strong>Note:</strong> You will see a version mismatch in some screenshots.</span>

# <span style="font-family: Nunito;  font-size: 32px;">Download the required files</span>

  * <span >Download the Upgrade Assessment Tool available at <a href="https://my.vmware.com/group/vmware/details?downloadGroup=VROPS-801&productId=940" target="_blank" rel="noopener noreferrer">VMware Downloads</a>.</span>

<span ><strong> <img loading="lazy" class="alignnone wp-image-1750 size-full" style="border-width: 1px; border-style: solid;" src="/wp-content/uploads/2020/05/2.vROPs_upgrade_tool.png" alt="" width="1820" height="592" srcset="/wp-content/uploads/2020/05/2.vROPs_upgrade_tool.png 1820w, /wp-content/uploads/2020/05/2.vROPs_upgrade_tool-300x98.png 300w, /wp-content/uploads/2020/05/2.vROPs_upgrade_tool-1024x333.png 1024w, /wp-content/uploads/2020/05/2.vROPs_upgrade_tool-768x250.png 768w, /wp-content/uploads/2020/05/2.vROPs_upgrade_tool-1536x500.png 1536w, /wp-content/uploads/2020/05/2.vROPs_upgrade_tool-1568x510.png 1568w" sizes="(max-width: 1820px) 100vw, 1820px" /></strong></span>

<span >And a</span><span >lso, proceed to download the <em>Virtual appliance upgrade PAK</em> file, that will be used later for the real upgrade:</span>

<span style="font-size: 16px; font-family: Nunito;"><img loading="lazy" class="alignnone wp-image-1758 size-full" style="border-style: solid; border-width: 1px;" src="/wp-content/uploads/2020/05/10_Download_vROpsVAupg.png" alt="" width="2058" height="807" srcset="/wp-content/uploads/2020/05/10_Download_vROpsVAupg.png 2058w, /wp-content/uploads/2020/05/10_Download_vROpsVAupg-300x118.png 300w, /wp-content/uploads/2020/05/10_Download_vROpsVAupg-1024x402.png 1024w, /wp-content/uploads/2020/05/10_Download_vROpsVAupg-768x301.png 768w, /wp-content/uploads/2020/05/10_Download_vROpsVAupg-1536x602.png 1536w, /wp-content/uploads/2020/05/10_Download_vROpsVAupg-2048x803.png 2048w, /wp-content/uploads/2020/05/10_Download_vROpsVAupg-1568x615.png 1568w" sizes="(max-width: 2058px) 100vw, 2058px" /></span>

# <span style="font-family: Nunito;  font-size: 32px;"><strong><br /> Upgrade Assessment Tool</strong> (optional but recommended)</span>

<span ><strong>The first thing to do is to install the Upgrade Assessment Tool in order to know if there are any problems before upgrading.</strong></span>

<span >Although this is not mandatory it is highly recommended in order to know if there are any issues before running the real upgrade process.</span>

<span style="font-size: 16px; font-family: Nunito;">The steps are:</span>

  * <span style="font-size: 16px;"><span style="font-family: Nunito;">Log in to the master node vRealize Operations Manager Administrator interface of your cluster at <span style="text-decoration: underline;">https://master-node-FQDN-or-IP-address/admin</span>.</span><img loading="lazy" class="alignnone wp-image-1751 size-full" src="/wp-content/uploads/2020/05/3_DashBoardAdmin.png" alt="" width="2374" height="957" srcset="/wp-content/uploads/2020/05/3_DashBoardAdmin.png 2374w, /wp-content/uploads/2020/05/3_DashBoardAdmin-300x121.png 300w, /wp-content/uploads/2020/05/3_DashBoardAdmin-1024x413.png 1024w, /wp-content/uploads/2020/05/3_DashBoardAdmin-768x310.png 768w, /wp-content/uploads/2020/05/3_DashBoardAdmin-1536x619.png 1536w, /wp-content/uploads/2020/05/3_DashBoardAdmin-2048x826.png 2048w, /wp-content/uploads/2020/05/3_DashBoardAdmin-1568x632.png 1568w" sizes="(max-width: 2374px) 100vw, 2374px" /></span>
  * <span style="font-size: 16px;"><span style="font-family: Nunito;">Click Software Update in the left panel (you can see an attempt I made previously) and then «Install a Software Update&#8230;»:</span><img loading="lazy" class="alignnone size-full wp-image-1752" src="/wp-content/uploads/2020/05/4_Click_Software_Update.png" alt="" width="2379" height="559" srcset="/wp-content/uploads/2020/05/4_Click_Software_Update.png 2379w, /wp-content/uploads/2020/05/4_Click_Software_Update-300x70.png 300w, /wp-content/uploads/2020/05/4_Click_Software_Update-1024x241.png 1024w, /wp-content/uploads/2020/05/4_Click_Software_Update-768x180.png 768w, /wp-content/uploads/2020/05/4_Click_Software_Update-1536x361.png 1536w, /wp-content/uploads/2020/05/4_Click_Software_Update-2048x481.png 2048w, /wp-content/uploads/2020/05/4_Click_Software_Update-1568x368.png 1568w" sizes="(max-width: 2379px) 100vw, 2379px" /></span>
  * <span style="font-size: 16px;"><span style="font-family: Nunito;">Follow the steps in the wizard to locate and install your PAK file. Upload the PAK file (the first file we downloaded) and check the first checkbox if you&#8217;re not sure if there is another one installed.</span><img loading="lazy" class="alignnone size-full wp-image-1753" style="border-width: 1px; border-style: solid;" src="/wp-content/uploads/2020/05/5a_upload-the-pak-file.png" alt="" width="1289" height="667" srcset="/wp-content/uploads/2020/05/5a_upload-the-pak-file.png 1289w, /wp-content/uploads/2020/05/5a_upload-the-pak-file-300x155.png 300w, /wp-content/uploads/2020/05/5a_upload-the-pak-file-1024x530.png 1024w, /wp-content/uploads/2020/05/5a_upload-the-pak-file-768x397.png 768w" sizes="(max-width: 1289px) 100vw, 1289px" /></span>
  * <span style="font-size: 16px;"><span style="font-family: Nunito;">The PAK file will be uploaded from your local machine to <span id="GUID-224200DE-C967-4784-89B1-0AF84DE29B65__PRODUCTNAME_187D19A9B6A444C0ADC94B50C1155C9D" class="ph productname">vRealize Operations Manager</span>. Uploading may take a few minutes. Once it is uploaded you will see something like this.</span><img loading="lazy" class="alignnone wp-image-1754 " style="border-width: 1px; border-style: solid;" src="/wp-content/uploads/2020/05/5b_uploadfinished.png" alt="" width="422" height="206" srcset="/wp-content/uploads/2020/05/5b_uploadfinished.png 814w, /wp-content/uploads/2020/05/5b_uploadfinished-300x146.png 300w, /wp-content/uploads/2020/05/5b_uploadfinished-768x375.png 768w" sizes="(max-width: 422px) 100vw, 422px" /></span>
  * <span >Once the uploaded PAK file, accept the EULA (step 2) if you agree, read the Update information (step 3) and finally click «Install». You will see that the software update is being installed</span>

> <span >Don&#8217;t worry this is just installing the Pre-Upgrade to 8.0.0 Assessment Tool, the real upgrade will be performed later</span>

<span style="font-size: 16px;">      <img loading="lazy" class="alignnone wp-image-1755" src="/wp-content/uploads/2020/05/6.Installation-of-PAK-file_inprogress.png" alt="" width="587" height="179" srcset="/wp-content/uploads/2020/05/6.Installation-of-PAK-file_inprogress.png 1571w, /wp-content/uploads/2020/05/6.Installation-of-PAK-file_inprogress-300x92.png 300w, /wp-content/uploads/2020/05/6.Installation-of-PAK-file_inprogress-1024x313.png 1024w, /wp-content/uploads/2020/05/6.Installation-of-PAK-file_inprogress-768x235.png 768w, /wp-content/uploads/2020/05/6.Installation-of-PAK-file_inprogress-1536x469.png 1536w, /wp-content/uploads/2020/05/6.Installation-of-PAK-file_inprogress-1568x479.png 1568w" sizes="(max-width: 587px) 100vw, 587px" /></span>

<li id="GUID-224200DE-C967-4784-89B1-0AF84DE29B65__step_6C767DCF66E84DEE8195915855F11335" class="li step stepexpand">
  <span style="font-size: 16px;"><span id="GUID-224200DE-C967-4784-89B1-0AF84DE29B65__cmd_888C2F0717C6492592E52514217D79C7" class="ph cmd" style="font-family: Nunito;">When the process is complete, click <span id="GUID-224200DE-C967-4784-89B1-0AF84DE29B65__uicontrol_6DB0F8D253A94FA5BBEE2358EF359FFF" class="ph uicontrol">Support</span> in the left pane. </span><span style="font-family: Nunito;">The Support screen appears. </span><span id="GUID-224200DE-C967-4784-89B1-0AF84DE29B65__cmd_C88D4592ECC94F92872A48BCE63D61DA" class="ph cmd" style="font-family: Nunito;">Select the <span id="GUID-224200DE-C967-4784-89B1-0AF84DE29B65__uicontrol_F3D986C3A901418C8DB74834B43D5B9E" class="ph uicontrol">Support Bundles</span> option above the toolbar. </span><span style="font-family: Nunito;">The available support bundles are listed:</span><img loading="lazy" class="alignnone size-full wp-image-1756" src="/wp-content/uploads/2020/05/7.Download_supportbundle.png" alt="" width="1663" height="494" srcset="/wp-content/uploads/2020/05/7.Download_supportbundle.png 1663w, /wp-content/uploads/2020/05/7.Download_supportbundle-300x89.png 300w, /wp-content/uploads/2020/05/7.Download_supportbundle-1024x304.png 1024w, /wp-content/uploads/2020/05/7.Download_supportbundle-768x228.png 768w, /wp-content/uploads/2020/05/7.Download_supportbundle-1536x456.png 1536w, /wp-content/uploads/2020/05/7.Download_supportbundle-1568x466.png 1568w" sizes="(max-width: 1663px) 100vw, 1663px" /><span id="GUID-224200DE-C967-4784-89B1-0AF84DE29B65__cmd_0B77BDDB470944C29B0F98CDB02F6C11" class="ph cmd" style="font-family: Nunito;"></span></span>
</li>
<li id="GUID-224200DE-C967-4784-89B1-0AF84DE29B65__step_0F9104B98C134AF3B46298302C899C05" class="li step stepexpand">
  <span style="font-size: 16px;"><span id="GUID-224200DE-C967-4784-89B1-0AF84DE29B65__cmd_4EBD4C4C5F8740A49162792DF13B9984" class="ph cmd" style="font-family: Nunito;">To review the report, extract the files from the ZIP file and open the HTML file.<br /> The file is located in \<span style="font-family: courier new, courier;">slice_<bundlenumber>_<nodeaddress>\apuat-data\report\index.html</span>.<br /> </span><span id="GUID-224200DE-C967-4784-89B1-0AF84DE29B65__cmd_4EBD4C4C5F8740A49162792DF13B9984" class="ph cmd" style="font-family: Nunito;">This is my report, which it only gives me a warning about executing the proper Virtual appliance upgrade (we will see later)</span></span><span style="font-size: 16px; font-family: Nunito;"><img loading="lazy" class="alignnone size-full wp-image-1757" src="/wp-content/uploads/2020/05/8.reportHTML.png" alt="" width="1961" height="1900" srcset="/wp-content/uploads/2020/05/8.reportHTML.png 1961w, /wp-content/uploads/2020/05/8.reportHTML-300x291.png 300w, /wp-content/uploads/2020/05/8.reportHTML-1024x992.png 1024w, /wp-content/uploads/2020/05/8.reportHTML-768x744.png 768w, /wp-content/uploads/2020/05/8.reportHTML-1536x1488.png 1536w, /wp-content/uploads/2020/05/8.reportHTML-1568x1519.png 1568w" sizes="(max-width: 1961px) 100vw, 1961px" /></span>
</li>

  * <span >After updating my Admin account I re-run the same process and checked that there were no errors.</span>

<span >So now, let&#8217;s go to the point and update the vROps master node!</span>

&nbsp;

# <span style="font-family: Nunito;  font-size: 32px;">Upgrade process</span>

<span >Before doing anything, <strong>remember to take a snapshot of the Master node</strong> that is going to be upgraded!</span>

&nbsp;

<span >First, upload the .pak file we downloaded at the beginning of the <em>Virtual Appliance upgrade PAK</em> file (which is way larger than the <em>Upgrade Assessment Tool</em>  PAK file).</span>

<span >Once downloaded, go to the vROps admin interface (<span style="text-decoration: underline;">https://master-node-FQDN-or-IP-address/admin</span>) and then «Software Updates» :</span><span ><img loading="lazy" class="alignnone size-full wp-image-1739" src="/wp-content/uploads/2020/05/11_Install_SWUpd.png" alt="" width="1792" height="599" srcset="/wp-content/uploads/2020/05/11_Install_SWUpd.png 1792w, /wp-content/uploads/2020/05/11_Install_SWUpd-300x100.png 300w, /wp-content/uploads/2020/05/11_Install_SWUpd-1024x342.png 1024w, /wp-content/uploads/2020/05/11_Install_SWUpd-768x257.png 768w, /wp-content/uploads/2020/05/11_Install_SWUpd-1536x513.png 1536w, /wp-content/uploads/2020/05/11_Install_SWUpd-1568x524.png 1568w" sizes="(max-width: 1792px) 100vw, 1792px" /></span>

&nbsp;

<span >And then, upload the new file (which in this case is quite larger compared to the pre-upgrade assessment tool):</span><span style="font-size: 16px;"><img loading="lazy" class="alignnone size-full wp-image-1740" src="/wp-content/uploads/2020/05/12.InstallVA_pak.png" alt="" width="1306" height="702" srcset="/wp-content/uploads/2020/05/12.InstallVA_pak.png 1306w, /wp-content/uploads/2020/05/12.InstallVA_pak-300x161.png 300w, /wp-content/uploads/2020/05/12.InstallVA_pak-1024x550.png 1024w, /wp-content/uploads/2020/05/12.InstallVA_pak-768x413.png 768w" sizes="(max-width: 1306px) 100vw, 1306px" /></span>

<span >Once is staged (after you clicked upload), it will give you a warning regarding the cluster that will be restarted (obviously), just click NEXT:</span><span style="font-size: 16px;"><img loading="lazy" class="alignnone size-full wp-image-1741" src="/wp-content/uploads/2020/05/13.AfterStaging_warning.png" alt="" width="1290" height="1124" srcset="/wp-content/uploads/2020/05/13.AfterStaging_warning.png 1290w, /wp-content/uploads/2020/05/13.AfterStaging_warning-300x261.png 300w, /wp-content/uploads/2020/05/13.AfterStaging_warning-1024x892.png 1024w, /wp-content/uploads/2020/05/13.AfterStaging_warning-768x669.png 768w" sizes="(max-width: 1290px) 100vw, 1290px" /></span>

<span >Accept the EULA if you agree and read the Update information (which tells you that you must take a snapshot of the cluster you&#8217;re upgrading):</span><span style="font-size: 16px;"><img loading="lazy" class="alignnone size-full wp-image-1742" src="/wp-content/uploads/2020/05/14_ReadInformation.png" alt="" width="1270" height="769" srcset="/wp-content/uploads/2020/05/14_ReadInformation.png 1270w, /wp-content/uploads/2020/05/14_ReadInformation-300x182.png 300w, /wp-content/uploads/2020/05/14_ReadInformation-1024x620.png 1024w, /wp-content/uploads/2020/05/14_ReadInformation-768x465.png 768w" sizes="(max-width: 1270px) 100vw, 1270px" /></span>

<span >And proceed to install the update in step 4 by clicking <strong>INSTALL</strong>!</span>

<span style="font-size: 16px;"><span style="font-family: Nunito;">You will see on the same page that the upgrade is in progress:</span><img loading="lazy" class="alignnone size-full wp-image-1743" src="/wp-content/uploads/2020/05/15_Installation_Progress.png" alt="" width="1803" height="576" srcset="/wp-content/uploads/2020/05/15_Installation_Progress.png 1803w, /wp-content/uploads/2020/05/15_Installation_Progress-300x96.png 300w, /wp-content/uploads/2020/05/15_Installation_Progress-1024x327.png 1024w, /wp-content/uploads/2020/05/15_Installation_Progress-768x245.png 768w, /wp-content/uploads/2020/05/15_Installation_Progress-1536x491.png 1536w, /wp-content/uploads/2020/05/15_Installation_Progress-1568x501.png 1568w" sizes="(max-width: 1803px) 100vw, 1803px" /></span>

<span style="font-size: 16px;"><span style="font-family: Nunito;">It will take some time, and even you see that vROps is available, the cluster will still offline until the upgrade is finished. We just need to wait a bit more.</span><img loading="lazy" class="alignnone size-full wp-image-1744" src="/wp-content/uploads/2020/05/16_In_Progress.png" alt="" width="2565" height="686" srcset="/wp-content/uploads/2020/05/16_In_Progress.png 2565w, /wp-content/uploads/2020/05/16_In_Progress-300x80.png 300w, /wp-content/uploads/2020/05/16_In_Progress-1024x274.png 1024w, /wp-content/uploads/2020/05/16_In_Progress-768x205.png 768w, /wp-content/uploads/2020/05/16_In_Progress-1536x411.png 1536w, /wp-content/uploads/2020/05/16_In_Progress-2048x548.png 2048w, /wp-content/uploads/2020/05/16_In_Progress-1568x419.png 1568w" sizes="(max-width: 2565px) 100vw, 2565px" /></span>

<span style="font-size: 16px;"><span style="font-family: Nunito;">The whole upgrade took about 30 mins and it was upgraded successfully:</span><img loading="lazy" class="alignnone wp-image-1764 size-full" src="/wp-content/uploads/2020/05/18_SWupdate_end_v2.png" alt="" width="1155" height="458" srcset="/wp-content/uploads/2020/05/18_SWupdate_end_v2.png 1155w, /wp-content/uploads/2020/05/18_SWupdate_end_v2-300x119.png 300w, /wp-content/uploads/2020/05/18_SWupdate_end_v2-1024x406.png 1024w, /wp-content/uploads/2020/05/18_SWupdate_end_v2-768x305.png 768w" sizes="(max-width: 1155px) 100vw, 1155px" /></span>

<span style="font-size: 16px;"><span style="font-family: Nunito;"><br /> Finally, <strong>the cluster is online and the new version was applied correctly</strong>.</span><img loading="lazy" class="alignnone wp-image-1747 size-full" src="/wp-content/uploads/2020/05/19_All_ok_system_online.png" alt="" width="2194" height="677" srcset="/wp-content/uploads/2020/05/19_All_ok_system_online.png 2194w, /wp-content/uploads/2020/05/19_All_ok_system_online-300x93.png 300w, /wp-content/uploads/2020/05/19_All_ok_system_online-1024x316.png 1024w, /wp-content/uploads/2020/05/19_All_ok_system_online-768x237.png 768w, /wp-content/uploads/2020/05/19_All_ok_system_online-1536x474.png 1536w, /wp-content/uploads/2020/05/19_All_ok_system_online-2048x632.png 2048w, /wp-content/uploads/2020/05/19_All_ok_system_online-1568x484.png 1568w" sizes="(max-width: 2194px) 100vw, 2194px" /></span>

<span >Remember to delete the snapshot that was created before proceeding with this upgrade. I hope this has been helpful to you.</span>

&nbsp;