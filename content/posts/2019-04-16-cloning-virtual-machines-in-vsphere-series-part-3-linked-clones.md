---
title: 'Cloning virtual machines in vSphere series – Part 3: Linked Clones'
author: itgaiden
type: post
date: 2019-04-16T10:25:55+00:00
url: /?p=593
featured_image: /wp-content/uploads/2019/04/LinkedClone.png
rank_math_primary_category:
  - 25
rank_math_description:
  - |
    Continuing with the "cloning virtual machines in vSphere" series, now it's time for Linked clones, how to use it and more useful information.
rank_math_focus_keyword:
  - Linked Clones
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - Cloning VMs series
  - VMware
  - vSphere
tags:
  - clones
  - cloning
  - linked clone
  - PowerCLI
  - VMware
  - vSphere

---
<span style="font-size: 16px;">Let&#8217;s start with part 3 in the <em>cloning virtual machines in vSphere</em> series, I am going to talk about another type of clones, <strong>linked clones</strong>!<br /> </span>

&nbsp;

<span style="font-size: 16px;">All articles regarding <strong>cloning virtual machines in vSphere</strong> series:</span>

<p style="padding-left: 40px;">
  <span style="font-size: 16px;"><a href="http://www.itgaiden.com/cloning-vms-in-vsphere-part-1/">Part 1: Types of clone</a></span><br /> <span style="font-size: 16px;"><a href="http://www.itgaiden.com/cloning-virtual-machines-in-vsphere-part-2-full-clone/">Part 2: Full Clone</a></span><br /> <span style="font-size: 16px;"><a href="http://www.itgaiden.com/cloning-virtual-machines-in-vsphere-series-part-4-instant-clones">Part 4: Instant Clones</a> (not published yet)</span>
</p>

<span style="font-size: 16px;">As said in previous articles, this series is only focused on VMware vSphere hence, VMware Horizon View is not contemplated (Linked clones are commonly used</span> <span style="font-size: 16px;">in that product).</span>

### 

### <span style="font-family: Didact Gothic;">What is a linked clone?</span>

What can you see here?

<figure id="attachment_786" aria-describedby="caption-attachment-786" style="width: 656px" class="wp-caption alignnone"><img loading="lazy" class="wp-image-786 size-medium_large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/04/LinkedClone-768x294.png" alt="KR_linked" width="656" height="251" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/04/LinkedClone-768x294.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/04/LinkedClone-300x115.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/04/LinkedClone-1024x392.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/04/LinkedClone.png 1280w" sizes="(max-width: 656px) 100vw, 656px" /><figcaption id="caption-attachment-786" class="wp-caption-text">Keanu Reeves has been linked cloned!</figcaption></figure>

<span style="font-size: 16px;">In the previous image, you can see 3 different characters but they share something in common&#8230;the actor!</span>

&nbsp;

<span style="font-size: 16px;">Linked clones are the same! A <strong>linked clone</strong> is a type of clone (a copy of a virtual machine) where the parent VM <strong>shares virtual disks</strong> with their clones.</span>

<span style="font-size: 16px;">The resulting linked clone will be <strong>created from the parent&#8217;s VM snapshot</strong> and because of being a <a href="https://pubs.vmware.com/vsphere-4-esx-vcenter/index.jsp?topic=/com.vmware.vsphere.vmadmin.doc_41/vsp_vm_guide/managing_virtual_machines/c_about_snapshots.html">snapshot</a>, it will have the same state that was the snapshot was taken.</span>

<img loading="lazy" class="alignnone wp-image-605 size-medium_large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/02/LinkedClone-768x730.png" alt="LinkedClone" width="656" height="624" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/02/LinkedClone-768x730.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/02/LinkedClone-300x285.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/02/LinkedClone.png 961w" sizes="(max-width: 656px) 100vw, 656px" /> 

<span style="font-size: 16px; font-family: Didact Gothic;">When the linked clone is created, it <strong>shares his own virtual disk</strong> (.vmdk file) with the <strong>snapshot from the parent VM</strong>, this leads to some unique features:</span>

  * <span style="font-family: Didact Gothic; font-size: 16px;">The clone will be <strong>dependent </strong>from<strong> the parent VM</strong> because they are sharing their virtual disks. If you delete the parent&#8217;s VM snapshot, it will corrupt the clone&#8217;s virtual disk.</span>
  * <span style="font-size: 16px; font-family: Didact Gothic;">Even both VMs are sharing their storage, any <strong>changes performed</strong> in the clone won&#8217;t affect the parent VM and vice-versa.</span>
  * <span style="font-size: 16px; font-family: Didact Gothic;">The linked clone will have the <strong>exact same data</strong> as the source VM because it was created from a snapshot.</span>
  * <span style="font-family: Didact Gothic; font-size: 16px;">The save spacings are obvious because the <strong>clone will only write the new modifications in </strong>its<strong> own virtual disk</strong>. So, the clone&#8217;s virtual disk size will be only the amount of data that changed after it was created!</span>

## 

### <span style="font-family: Didact Gothic;"><span style="color: #000000;">General process</span><br /> </span>

  1. <span style="font-size: 16px; font-family: Didact Gothic;">Use or prepare a VM (Parent VM) that will be used as a master/parent to deploy the linked clones</span>
  2. <span style="font-size: 16px; font-family: Didact Gothic;">Power-off the Parent VM (Recommended but not mandatory)</span>
  3. <span style="font-size: 16px; font-family: Didact Gothic;">Perform a snapshot of the VM.</span>
  4. <span style="font-size: 16px; font-family: Didact Gothic;">Time to create Linked clones referencing the snapshot we created previously.</span>
  5. <span style="font-size: 16px; font-family: Didact Gothic;">Power-on the clones and customize them (apply customization specifications for example).</span>
  6. <span style="font-size: 16px; font-family: Didact Gothic;">(Extra) Before powering-on the linked clone, perform another snapshot of the clone to use it as a rollback (if the end-user needs it).</span>
  7. <span style="font-size: 16px; font-family: Didact Gothic;">(Extra) Power-on the clone and is ready to be delivered.</span>
  8. <span style="font-size: 16px; font-family: Didact Gothic;">(Extra plus) If you decide to keep the linked clone for any reason, you can perform a full clone of it and it will become an independent VM!</span>

&nbsp;

<span style="font-size: 16px;">In the next section, I wi<span style="font-family: Didact Gothic;">ll show you how to <strong>create a linked clone with PowerCLI</strong> from a Windows VM and in my case, I will use Custom Specifications within the script to launch the clone.<br /> </span></span>

## 

### <span style="font-family: Didact Gothic;">Lab time!<br /> </span>

<span style="font-family: Didact Gothic; font-size: 16px;">Here we have the VM that we&#8217;re going to use as our Parent VM:</span>

<span style="font-family: Didact Gothic; font-size: 16px;">&#8211; <strong>Name:</strong> SQLMasterVM</span>  
<span style="font-family: Didact Gothic; font-size: 16px;">&#8211; <strong>IP:</strong> 192.168.1.174</span>  
<span style="font-family: Didact Gothic; font-size: 16px;">&#8211;<strong> Disk allocation:</strong> Around 35 GB summing both disks.</span>  
<span style="font-family: Didact Gothic; font-size: 16px;">&#8211; <strong>Domain:</strong> vmug.bcn</span>

<span style="font-family: Didact Gothic; font-size: 16px;">Inside the Guest OS:</span>

<img loading="lazy" class="alignnone size-medium_large wp-image-814" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/04/SQLMasterVM-768x662.jpg" alt="" width="656" height="565" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/04/SQLMasterVM-768x662.jpg 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/04/SQLMasterVM-300x258.jpg 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/04/SQLMasterVM-1024x882.jpg 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/04/SQLMasterVM.jpg 1112w" sizes="(max-width: 656px) 100vw, 656px" /> 

&nbsp;

<span style="font-family: Didact Gothic; font-size: 16px;">Space allocated in DS:</span>

<span style="font-family: Didact Gothic;"><img loading="lazy" class="alignnone wp-image-742 size-large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/03/SQLMasterVM_disksinDS-1024x144.png" alt="" width="656" height="92" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/03/SQLMasterVM_disksinDS-1024x144.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/03/SQLMasterVM_disksinDS-300x42.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/03/SQLMasterVM_disksinDS-768x108.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/03/SQLMasterVM_disksinDS.png 1315w" sizes="(max-width: 656px) 100vw, 656px" /></span>

&nbsp;

<span style="font-size: 16px;"><strong><span style="font-family: Didact Gothic;">What are we going to do?</span></strong></span>

  1. <span style="font-family: Didact Gothic; font-size: 16px;">Shutdown the master image VM that hosts some DBs.</span>
  2. <span style="font-family: Didact Gothic; font-size: 16px;">Create a snapshot when the VM is powered-off to ensure that is consistent (this is a VM with a SQL installed so, even more recommended)</span>
  3. <span style="font-family: Didact Gothic; font-size: 16px;">Perform the linked-clone via PowerCLI.</span>
  4. <span style="font-family: Didact Gothic; font-size: 16px;">Start the VM (We aren&#8217;t going to do the extra step of creating a snapshot of the clone) and use custom specifications to fully customize the clone.</span>

<span style="font-family: Didact Gothic; font-size: 16px;">All of this will be performed by this simple script:</span>

<div>
  <p>
    [powershell]<br /> ##Creating SQL Linked Clone from a Parent VM "SQLMasterVM"<br /> #variables<br /> $OSSpec = Get-OSCustomizationSpec -Name &#8216;Win-SQL&#8217;<br /> $BaseVM = "SQLMasterVM"<br /> $LinkedVM = "SQL-LC1"
  </p>
  
  <p>
    # Delete snapshots on the Parent VM<br /> Get-Snapshot -VM $BaseVM | Remove-Snapshot -Confirm:$falseStart-Sleep -Seconds 2
  </p>
  
  <p>
    #Create snapshot<br /> New-Snapshot -VM $BaseVM -Name "Linked-Snapshot" -Description "Snapshot for linked clones for $LinkedVM"
  </p>
  
  <p>
    #Gather information of the created snapshot<br /> $snapshotParent = Get-Snapshot -VM $BaseVM | Select Name<br /> $snapshotParent = $snapshotParent.Name<br /> Start-Sleep -Seconds 5
  </p>
  
  <p>
    #Create Linked Clone referencing snapshot and start the VM.<br /> New-VM -Name $LinkedVM -VM $BaseVM -Datastore "VMS" -ResourcePool (Get-Cluster -Name Gaiden-Cluster | Get-ResourcePool) -OSCustomizationSpec $OSSpec -LinkedClone -ReferenceSnapshot $snapshotParent -DiskStorageFormat Thin<br /> Start-VM -VM $LinkedVM<br /> [/powershell]
  </p>
</div>

<span style="font-size: 16px;"><span style="font-family: Didact Gothic;">In this </span>script<span style="font-family: Didact Gothic;">, I am also using the <em>OSCustomizationSpec</em> parameter, while using the sentence to create the linked clone,  to change the IP, name and join again to the domain the resultant clone. Also, I am changing the SQL instance name in my case because it&#8217;s a server with MSSQL server installed.</span></span>

<span style="font-size: 16px; font-family: Didact Gothic;">Once the script finished, a new linked clone is created and powered on with the name «SQL-LC1».</span>

&nbsp;

<span style="font-family: Didact Gothic;"><span style="font-size: 16px;">We can see the amount of<strong> time</strong> that takes to create a Linked clone (<strong>5 seconds</strong>):</span><span style="font-size: 16px;"><img loading="lazy" class="alignnone wp-image-741 size-large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/03/LinkedClone_tasks-1024x174.png" alt="" width="656" height="111" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/03/LinkedClone_tasks-1024x174.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/03/LinkedClone_tasks-300x51.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/03/LinkedClone_tasks-768x130.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/03/LinkedClone_tasks-1536x260.png 1536w, http://wp.docker.localhost:8000/wp-content/uploads/2019/03/LinkedClone_tasks.png 1552w" sizes="(max-width: 656px) 100vw, 656px" /></span></span>

<span style="font-size: 16px; font-family: Didact Gothic;">And now look at the <strong>storage allocated</strong> by the Linked clone (powered off), <strong>750 MB</strong> approximately:</span>

<span style="font-family: Didact Gothic;"><img loading="lazy" class="alignnone wp-image-740 size-large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/03/SQL_LC1_DSAllocation-1024x246.png" alt="" width="656" height="158" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/03/SQL_LC1_DSAllocation-1024x246.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/03/SQL_LC1_DSAllocation-300x72.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/03/SQL_LC1_DSAllocation-768x185.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/03/SQL_LC1_DSAllocation.png 1147w" sizes="(max-width: 656px) 100vw, 656px" /></span>

&nbsp;

<span style="font-size: 16px; font-family: Didact Gothic;">After the Linked clone is created and powered on, you can do whatever you want. </span>

<span style="font-size: 16px; font-family: Didact Gothic;">I had to wait some minutes (around 10 min. in my case) until the OS customization specification finish all the actions specified (power on the VM, join to the domain, reboot the VM, execute a script to update SQL instance, etc.)</span>

<span style="font-size: 16px; font-family: Didact Gothic;">Here is the «real» space allocated after the Linked clone has <strong>booted up and I logged in</strong> with a user, around <strong>4 GB</strong>:</span>

<span style="font-family: Didact Gothic;"><img loading="lazy" class="alignnone wp-image-747 size-large" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/03/SQL_LC1_DSAllocation_PowON_v2-1024x242.png" alt="" width="656" height="155" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/03/SQL_LC1_DSAllocation_PowON_v2-1024x242.png 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/03/SQL_LC1_DSAllocation_PowON_v2-300x71.png 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/03/SQL_LC1_DSAllocation_PowON_v2-768x182.png 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/03/SQL_LC1_DSAllocation_PowON_v2.png 1179w" sizes="(max-width: 656px) 100vw, 656px" /></span>

&nbsp;

<span style="font-family: Didact Gothic; font-size: 16px;">A look inside the Guest OS of the <strong>linked clone</strong> (new hostname, IP and has the same storage as the Parent VM:</span>

<span style="font-family: Didact Gothic;"><img loading="lazy" class="alignnone size-medium_large wp-image-813" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/04/SQL-LC1-768x739.jpg" alt="" width="656" height="631" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/04/SQL-LC1-768x739.jpg 768w, http://wp.docker.localhost:8000/wp-content/uploads/2019/04/SQL-LC1-300x289.jpg 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/04/SQL-LC1-1024x985.jpg 1024w, http://wp.docker.localhost:8000/wp-content/uploads/2019/04/SQL-LC1.jpg 1056w" sizes="(max-width: 656px) 100vw, 656px" /></span>

### 

### <span style="font-family: Didact Gothic;">Use cases</span>

<span style="font-size: 16px;">It&#8217;s commonly used in VDI and DEV environments but here are some examples:</span>

  * <span style="font-family: Didact Gothic; font-size: 16px;">Desktop Deployment<br /> </span>
  * <span style="font-family: Didact Gothic; font-size: 16px;">QA</span>
  * <span style="font-size: 16px; font-family: Didact Gothic;">Bug testing</span>
  * <span style="font-family: Didact Gothic; font-size: 16px;">DB server testing</span>
  * <span style="font-family: Didact Gothic; font-size: 16px;">File server testing</span>
  * <span style="font-family: Didact Gothic; font-size: 16px;">General testing</span>

&nbsp;

### <span style="font-family: Didact Gothic;">Benefits and limits<br /> </span>

<span style="font-family: Didact Gothic; font-size: 16px;">Let&#8217;s summarize which are the benefits and limits that we can find in linked clones:<br /> </span>

**<span style="color: #339966; font-family: Didact Gothic; font-size: 16px;">Pros</span>**

  * <span style="font-family: Didact Gothic; font-size: 16px;"><strong>Superfast cloning compared to a Full/Normal clone</strong>, it takes seconds instead of minutes to clone large VMs.<br /> </span>
  * <span style="font-family: Didact Gothic; font-size: 16px;"><strong>Space savings</strong> due to changes are stored in a separate disk (clone&#8217;s flat disk).</span>
  * <span style="font-family: Didact Gothic; font-size: 16px;">Useful for development environments or if you want to keep the clone just, <strong>perform a full clone</strong> of it!</span>
  * <span style="font-family: Didact Gothic; font-size: 16px;">Deploy as many linked clones as you want, they will reference the snapshot in the Parent VM hence, there is no disk chain on that (except for the snapshot you created of course) and the benefits of replicating.</span>
  * <span style="font-family: Didact Gothic; font-size: 16px;">Ongoing changes made in the virtual disk of the <strong>source VM don&#8217;t affect the linked clones</strong> and <strong>changes to the disk of the linked don&#8217;t affect the parent</strong>.</span>
  * <span style="font-size: 16px;"><span style="font-family: Didact Gothic;">It can be performed with the parent VM powered on but, it will have some performance degradation and probably inconsistent data (if for </span>example<span style="font-family: Didact Gothic;">, the parent VM hosts a DB).</span></span>

**<span style="color: #ff0000; font-family: Didact Gothic; font-size: 16px;">Cons</span>**

  * <span style="font-family: Didact Gothic; font-size: 16px;">Recommended but not mandatory that the parent VM has to be powered off.</span>
  * <span style="font-size: 16px;"><span style="font-family: Didact Gothic;">There is a storage/disk dependency as the linked clone is created from the parent&#8217;s </span>VM<span style="font-family: Didact Gothic;"> snapshot then, if you <strong>delete that snapshot</strong>, </span><strong>inconsistencies</strong><span style="font-family: Didact Gothic;"> will occur in the clone (and at the end you will delete it).</span></span>
  * <span style="font-family: Didact Gothic; font-size: 16px;"><strong>Performance on the destination clone</strong> will be impacted (as virtual machines are sharing storage)</span>

### 

&nbsp;

### <span style="font-family: Didact Gothic;">To conclude</span>

<span style="font-size: 16px;">Linked clones have multiple benefits compared to full clones and it has many use cases as we saw before.</span>

<span style="font-size: 16px;">You can easily replicate the status of a VM (snapshot) and deploy linked clones to your end-users with all the benefits as for example space savings or the deployment speed. </span>

<span style="font-size: 16px;">To end this series, we will look at instant clones, another type of clone that is even faster than linked clones but, with some particularities.</span>