---
title: Azure – Backup and restore SQL DB using SSMS
author: itgaiden
type: post
date: 2018-09-14T08:23:47+00:00
url: /?p=246
rank_math_primary_category:
  - 22
rank_math_description:
  - Backup and Restore SQL DB using SSMS
rank_math_focus_keyword:
  - backup and restore sql
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - Azure
  - SQL
tags:
  - azure
  - sql
  - ssms

---
<span style="font-family: Didact Gothic; font-size: 14px;">A quick post talking about how to backup and restore a SQL database on Azure using SQL Server Management Studio (SSMS).</span>

<span style="font-size: 14px; font-family: Didact Gothic;">First, you will need to install SSMS. You can download it here: <a href="https://go.microsoft.com/fwlink/?linkid=875802">https://go.microsoft.com/fwlink/?linkid=875802</a></span>

<span style="font-family: Didact Gothic;"><span style="font-size: 14px;">Once installed, in order to access the database, you will need the server name where is installed. </span><span style="font-size: 14px;">So, you will have to check the Server name in Azure Portal (you can also do it by Powershell of course):</span></span>

<span style="font-family: Didact Gothic; font-size: 14px;"><img loading="lazy" class="alignnone size-full wp-image-318" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/Azure_servername2.png" alt="" width="784" height="262" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/Azure_servername2.png 784w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/Azure_servername2-300x100.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/Azure_servername2-768x257.png 768w" sizes="(max-width: 784px) 100vw, 784px" /></span>

<span style="font-family: Didact Gothic; font-size: 14px;">Now, open SSMS and access the server name (you gathered the information before):</span>

<span style="font-family: Didact Gothic; font-size: 14px;"><img loading="lazy" class="alignnone wp-image-279" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/Azure_SSMS.png" alt="" width="400" height="261" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/Azure_SSMS.png 594w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/Azure_SSMS-300x196.png 300w" sizes="(max-width: 400px) 100vw, 400px" /></span>

## <span style="font-size: 24px;"><strong><span style="font-family: Didact Gothic;">Export/Backup Database</span></strong></span>

<span style="font-family: Didact Gothic; font-size: 14px;">Once you logged in, select the database you want to export -> Export Data-tier Application</span>

<span style="font-size: 14px; font-family: Didact Gothic;"><img loading="lazy" class="alignnone wp-image-301" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/export_db-1024x771.png" alt="" width="633" height="477" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/export_db-1024x771.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/export_db-300x226.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/export_db-768x578.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/export_db.png 1494w" sizes="(max-width: 633px) 100vw, 633px" /></span>

<span style="font-family: Didact Gothic; font-size: 14px;">In the new window > Next > Select where do you want to save the DB (you can do it locally or in a Storage Account), in our case <strong>Local Disk</strong>:</span>

<span style="font-size: 14px; font-family: Didact Gothic;"><img loading="lazy" class="alignnone wp-image-302" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/export_db_options.png" alt="" width="593" height="550" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/export_db_options.png 921w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/export_db_options-300x278.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/export_db_options-768x711.png 768w" sizes="(max-width: 593px) 100vw, 593px" /></span>

<span style="font-family: Didact Gothic; font-size: 14px;">In the Advanced tab you can choose which tables you want to export, we will <strong>Select All</strong>:</span>

<span style="font-size: 14px; font-family: Didact Gothic;"><img loading="lazy" class="alignnone wp-image-285" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/backup_export2_bd.png" alt="" width="533" height="498" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/backup_export2_bd.png 626w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/backup_export2_bd-300x280.png 300w" sizes="(max-width: 533px) 100vw, 533px" /></span>

<span style="font-size: 14px; font-family: Didact Gothic;">Finally, we have a Summary of the process before exporting the database:</span>

<span style="font-size: 14px; font-family: Didact Gothic;"><img loading="lazy" class="alignnone size-full wp-image-304" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/Export_summary.png" alt="" width="921" height="854" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/Export_summary.png 921w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/Export_summary-300x278.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/Export_summary-768x712.png 768w" sizes="(max-width: 921px) 100vw, 921px" /></span>

<span style="font-family: Didact Gothic; font-size: 14px;">Then it will start to export the database, depending on the size of your DB will take more or less time to export:</span>

<span style="font-family: Didact Gothic;"><img loading="lazy" class="alignnone size-full wp-image-306" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/export_successful.png" alt="" width="1016" height="735" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/export_successful.png 1016w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/export_successful-300x217.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/export_successful-768x556.png 768w" sizes="(max-width: 1016px) 100vw, 1016px" /></span>

<span style="font-size: 14px; font-family: Didact Gothic;">Finally, we will have a file with .bacpac extension.</span>

## <span style="font-size: 24px;"><strong><span style="font-family: Didact Gothic;">Import/Restore database</span></strong></span>

<span style="font-family: Didact Gothic; font-size: 14px;">The process is almost the same but now we select <strong>Import Data-tier Application</strong>:</span>

<span style="font-family: Didact Gothic;"><img loading="lazy" class="alignnone size-full wp-image-320" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_data_tier.png" alt="" width="612" height="438" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_data_tier.png 612w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_data_tier-300x215.png 300w" sizes="(max-width: 612px) 100vw, 612px" /></span>

<span style="font-family: Didact Gothic; font-size: 14px;">Continue selecting the file with .bacpac extension we exported before:</span>

<span style="font-family: Didact Gothic; font-size: 14px;"><img loading="lazy" class="alignnone size-large wp-image-309" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_settings-1024x571.png" alt="" width="656" height="366" />Then, with Database settings, here you can choose different options as you can do on the Azure portal:</span>

<span style="font-family: Didact Gothic; font-size: 14px;"><img loading="lazy" class="alignnone size-full wp-image-310" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_db_settings.png" alt="" width="1019" height="551" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_db_settings.png 1019w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_db_settings-300x162.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_db_settings-768x415.png 768w" sizes="(max-width: 1019px) 100vw, 1019px" /></span>

<span style="font-family: Didact Gothic; font-size: 14px;">Summary of the imported database:</span>

<span style="font-family: Didact Gothic; font-size: 14px;"><img loading="lazy" class="alignnone size-full wp-image-311" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_summary.png" alt="" width="770" height="464" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_summary.png 770w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_summary-300x181.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_summary-768x463.png 768w" sizes="(max-width: 770px) 100vw, 770px" /> Finally, it was imported successfully (it took a while for a 10 MB DB):</span>

<span style="font-family: Didact Gothic; font-size: 14px;"><img loading="lazy" class="alignnone size-full wp-image-312" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_complete.png" alt="" width="1015" height="849" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_complete.png 1015w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_complete-300x251.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/import_complete-768x642.png 768w" sizes="(max-width: 1015px) 100vw, 1015px" /></span>

<span style="font-family: Didact Gothic; font-size: 14px;">In consequence of the restore, it will appear the restored database (Restore_DB) in SSMS:</span>

<span style="font-family: Didact Gothic;"><img loading="lazy" class="alignnone size-full wp-image-317" src="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/Final_Screenshot_.png" alt="" width="614" height="388" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2018/09/Final_Screenshot_.png 614w, http://wp.docker.localhost:8000/wp-content/uploads/2018/09/Final_Screenshot_-300x190.png 300w" sizes="(max-width: 614px) 100vw, 614px" /></span>

&nbsp;

<span style="font-size: 14px; font-family: Didact Gothic;">Therefore, I posted a quick way to export and import a SQL database by using SSMS. You could use it as a backup (please, not in local) or for example, to overwrite changes from UAT to PROD.</span>

&nbsp;