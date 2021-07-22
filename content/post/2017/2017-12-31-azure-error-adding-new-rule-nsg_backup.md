---
title: Azure – Error when adding new rule on NSG
author: itgaiden
type: post
date: 2017-12-31T15:50:35+00:00
url: /?p=113
featured_image: /wp-content/uploads/2017/12/123117_1550_AzureErrorw1.png
rank_math_primary_category:
  - 6
rank_math_focus_keyword:
  - azure nsg
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - Azure
  - NSG
tags:
  - azure
  - CIDR
  - nsg

---
<span style="font-size: 16px; font-family: Didact Gothic;">Hello everyone!</span>

<span style="font-size: 16px; font-family: Didact Gothic;">It&#8217;s been a while since I wrote something, but I was so busy with other things (University) and I wasn&#8217;t able to allocate time to write anything.</span>

<span style="font-size: 16px; font-family: Didact Gothic;">Today I&#8217;m going to talk about an issue I found on Azure when trying to add new rules to some NSGs.</span>

<span style="font-size: 16px; font-family: Didact Gothic;">To create rules in Azure I used this script from TechNet Gallery: <a href="https://gallery.technet.microsoft.com/scriptcenter/Create-Azure-Network-5f5c5332">https://gallery.technet.microsoft.com/scriptcenter/Create-Azure-Network-5f5c5332</a></span>

## <span style="font-family: Didact Gothic;">Problem</span>

<span style="font-size: 16px; font-family: Didact Gothic;">I was trying to add some rules in an NSG with the address <strong>193.23.120.230/30</strong> and, when I execute the code, the output was:</span>

<span style="font-size: 12pt;"><span style="font-family: Courier New;">Set-AzureRmNetworkSecurityGroup : Security rule has invalid Address prefix. Value provided: 193.23.120.230/30.<br /> StatusCode: 400<br /> ReasonPhrase: Bad Request<br /> OperationID : &#8216;b2f7-b2f7-b2f7&#8217;<br /> At line:4 char:55<br /> + &#8230; efix 193.23.120.230/30 -SourcePortRange * | Set-AzureRmNetworkSecurityGroup<br /> +                                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br /> + CategoryInfo          : CloseError: (:) [Set-AzureRmNetworkSecurityGroup], NetworkCloudException<br /> </span><span style="font-family: Courier New;"> + FullyQualifiedErrorId : Microsoft.Azure.Commands.Network.SetAzureNetworkSecurityGroupCommand</span></span><span style="font-family: Courier New; font-size: 12pt;"><br /> </span>

<span style="font-size: 12pt; font-family: Didact Gothic;">Tried again and again, and this only happened in certain NSGs, so well I thought there was a problem with the command line, I tried the same with the GUI and… the same.</span>

<span style="font-size: 12pt; font-family: Didact Gothic;"><img src="http://wp.docker.localhost:8000/wp-content/uploads/2017/12/123117_1550_AzureErrorw1.png" alt="" /></span>

## <span style="font-family: Didact Gothic;">Solution</span>

<span style="font-family: Didact Gothic;"><span style="font-size: 12pt;">Investigating the error it didn&#8217;t match with any of the new rules I was trying to add. </span><span style="font-size: 12pt;">Address 193.23.120.<strong>230</strong>/30 seems correct but if we use a subnet calculator, you will see this:</span></span>

<span style="font-size: 12pt;"><img loading="lazy" class="" src="http://wp.docker.localhost:8000/wp-content/uploads/2017/12/123117_1550_AzureErrorw2.png" alt="" width="554" height="236" /></span>

<span style="font-size: 12pt; font-family: Didact Gothic;">The right address should be deleting all ones after the netmask because it doesn&#8217;t care about what is after the netmask bits.</span>

<span style="font-size: 12pt; font-family: Didact Gothic;">This means that the new address is <strong>193.23.120.228/30 </strong>because we put zeros instead of ones after the netmask bits.</span>

<span style="font-size: 12pt; font-family: Didact Gothic;"><img src="http://wp.docker.localhost:8000/wp-content/uploads/2017/12/123117_1550_AzureErrorw3.png" alt="" /></span>

<span style="font-size: 12pt; font-family: Didact Gothic;">So, it seems a CIDN error! Seems that Azure let me add this rules in the past, but now it&#8217;s not accepting it so, if we change it the way that subnet calculator does, problem resolved!</span>

<span style="font-family: Didact Gothic;"><span style="font-size: 12pt;">Solution? Had to delete the non-compliant CIDR rules and added the new ones CIDR compliant.</span> <span style="font-size: 12pt;">Executed the same in other NSGs and worked like a charm.</span></span>  
<span style="font-size: 12pt; font-family: Didact Gothic;">All rules are finally shown in Azure Panel:</span>

<span style="font-size: 12pt;"><img loading="lazy" class="" src="http://wp.docker.localhost:8000/wp-content/uploads/2017/12/123117_1550_AzureErrorw4.png" alt="" width="681" height="55" /></span>

<span style="font-size: 12pt; font-family: Didact Gothic;">Well, seems that Azure didn&#8217;t comply with CIDR addresses in the past and now it&#8217;s mandatory if it founds any non-compliant CIDR rule. An easy mistake that we can avoid checking our addresses before we try to add them to Azure.</span>

<span style="font-size: 12pt; font-family: Didact Gothic;">And that&#8217;s all, <strong>Happy New Year</strong>!</span>