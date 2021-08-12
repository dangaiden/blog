---
title: Simple-guide-install-and-configure-RHEL-in-VM
author: itgaiden
type: draft
date: 2021-07-27T11:27:51+00:00
url: Simple-guide-install-and-configure-RHEL-in-VM
categories:
  - rhel
  - how-to
tags:
  - rhel
  - vm
---

## Quick How-to with RHEL

1. Create an account (it's free) and download RHEL ISO from the official repository [here](https://developers.redhat.com/content-gateway/file/rhel-8.4-x86_64-dvd.iso) 
2. Create a VM in VirtualBox with the resources you want. 
I created mine with 2GB of RAM, 2 vCPU and 40 GB of disk space .
3. Follow the wizard and install the way you prefer: Minimal server, Keyboard, network, etc. 
**Recommended** to partition your disk with LVM and partition it as recommended by the [provider](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/installation_guide/s2-diskpartrecommend-x86)
4. Once is installed proceed to log as root to the OS (I used "Somred1" as hostname) and add another user (*dangaiden* as example) with a password: 
```$ useradd dangaiden & passwd dangaiden```
* 4.1 Add the user to the wheel group or to the sudoers file (as you prefer):
	- Use visudo or ```usermod -aG wheel dangaiden```
5. Register the new system to RHEL portal: 

	```$ subscription-manager register --username=<username> --password=<password>```
```markdown
You are attempting to run "subscription-manager" which requires administrative
privileges, but more information is needed in order to do so.
Authenticating as "root"
Password:
Registering to: subscription.rhsm.redhat.com:443/subscription
The system has been registered with ID: 5512e476-8ecd-4e44-a986-e4340424aa6d
The registered system name is: Somred1 
```
* 5.1 Attach a license from our newly created account in the RHEL portal.

	```$ subscription-manager attach --auto```
```markdown
You are attempting to run "subscription-manager" which requires administrative
privileges, but more information is needed in order to do so.
Authenticating as "root"
Password:
Installed Product Current Status:
Product Name: Red Hat Enterprise Linux for x86_64
Status:       Subscribed
```

* 5.2 Verify the status: 

	```$ subscription-manager status```
```markdown
You are attempting to run "subscription-manager" which requires administrative
privileges, but more information is needed in order to do so.
Authenticating as "root"
Password:
+-------------------------------------------+
   System Status Details
+-------------------------------------------+
Overall Status: Current

System Purpose Status: Not Specified
```
	
* 5.3 Verify the repositories list
	
	```$ sudo yum repolist```
```markdown
[sudo] password for dangaiden:
Updating Subscription Management repositories.
repo id                                                  repo name
rhel-8-for-x86_64-appstream-rpms                         Red Hat Enterprise Linux 8 for x86_64 - AppStream (RPMs)
rhel-8-for-x86_64-baseos-rpms                            Red Hat Enterprise Linux 8 for x86_64 - BaseOS (RPMs)
```
---
6. You're good to go, we can install for example **tree**!

	```$ sudo yum install tree```
```markdown
[sudo] password for dangaiden:
Updating Subscription Management repositories.
Red Hat Enterprise Linux 8 for x86_64 - BaseOS (RPMs)                                                     6.4 MB/s |  34 MB     00:05
Red Hat Enterprise Linux 8 for x86_64 - AppStream (RPMs)                                                  5.4 MB/s |  31 MB     00:05
Dependencies resolved.
.
. (Ommited some output)
.
Installed products updated.

Installed:
  tree-1.7.0-15.el8.x86_64

Complete!

```

7. Copy your ssh key to the server: ```ssh-copyid```
8. Shutdown and clone the newly created VM (Create a full clone and remember to change MAC address for the NICs).
9. Once it's cloned, power on the new one and proceed to:
	* 1. Change the hostname: 
 
	```# vi /etc/hostname```

	* 2. Change the ip address:
	
	``` # vi /etc/sysconfig/network-scripts/ifcfg-enp0s3```

	* 3. Reboot it and **done**!