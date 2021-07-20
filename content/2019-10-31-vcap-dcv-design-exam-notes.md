---
title: VCAP-DCV Design exam notes
author: itgaiden
type: post
date: 2019-10-31T22:47:39+00:00
url: /?p=1269
rank_math_primary_category:
  - 4
rank_math_description:
  - Review some helpful information about VCAP-DCV Design exams that will help you how to approach this kind of exams.
rank_math_focus_keyword:
  - VCAP design
rank_math_robots:
  - 'a:1:{i:0;s:5:"index";}'
categories:
  - Education
  - VCAP6.5-DCV Design
  - VMware
tags:
  - certification
  - education
  - vcap
  - VMware

---
&nbsp;

<span style="font-family: Nunito; font-size: 16px;">As the VCAP-DCV Design 2020 certification is going to be <a href="https://www.vmware.com/content/dam/digitalmarketing/vmware/en/pdf/certification/vmw-certification-retired-exams.pdf">released</a> (but the 3V0-624 exam is not scheduled to be retired yet) on Jan 1, 2020.</span>

<span style="font-size: 16px; font-family: Nunito;">Recently I made another post about my experience with this exam where I failed, check it <a href="https://wp.me/p98Ovg-js"><span style="text-decoration: underline;"><strong>here</strong></span></a>.</span>

<span style="font-size: 16px; font-family: Nunito;">For your information, at the moment the 3V0-624 is the current exam code for the <a href="https://www.vmware.com/education-services/certification/vcap6-5-dcv-design-exam.html">VCAP-DCV 6.5 Design</a> certification (Also named <a href="https://www.vmware.com/education-services/certification/vcap-dcv-design.html">VCAP-DCV Design 2019</a>), always check the code for the exam no matter which is the certification name.</span>

<span style="font-family: Nunito; font-size: 16px;">I decided to share with you some notes for this kind of exams no matter which version. </span>

<span style="font-family: Nunito; font-size: 16px;">This information will be more helpful for people that have never taken this exam rather than those who are experienced in these advanced exams.<br /> </span>

# <span style="color: #000000;"><strong><span style="font-family: Nunito; font-size: 32px;">Audience</span></strong></span>

<span style="font-family: Nunito; font-size: 16px;">The Design exams (VCAP-XXX Design) are mainly for IT Architects (sounds cool?) but, why for architects? Well, if you check the <a href="https://www.vmware.com/content/dam/digitalmarketing/vmware/en/pdf/certification/vmw-vcap65-dcv-design-3v0-624-guide.pdf">blueprint</a>, you will see a couple of sections and not many objectives. The truth is hidden inside each section, which is huge and covers many aspects.</span>

<span style="font-family: Nunito; font-size: 16px;">Could you pass this exam without being an IT architect? Of course!</span>

<img loading="lazy" class="alignnone size-medium wp-image-1288" src="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/trustme_architect-300x300.jpg" alt="trust_me_architect" width="300" height="300" srcset="http://wp.docker.localhost:8000/wp-content/uploads/2019/10/trustme_architect-300x300.jpg 300w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/trustme_architect-150x150.jpg 150w, http://wp.docker.localhost:8000/wp-content/uploads/2019/10/trustme_architect.jpg 630w" sizes="(max-width: 300px) 100vw, 300px" /> 

<span style="font-family: Nunito; font-size: 16px;">Many did it (not in my case yet) by studying and having a lot of design experience, or also helped doing designs with other peers for example. Also, you can gain all the knowledge of all areas and study your main gaps.</span>

<span style="font-family: Nunito; font-size: 16px;">The goal is to design VMware solutions to meet specific goals and requirements, ideally, you should have advanced knowledge of storage, network, compute, end-user computing environments and other components.</span>

<span style="font-family: Nunito; font-size: 16px;">You will have to develop a conceptual design given a set of customer requirements, determining which requirements needed to create a logical design and after that creating a physical design with these items.</span>

# <span style="color: #000000;"><strong><span style="font-family: Nunito; font-size: 32px;">Technical background</span></strong></span>

<span style="font-family: Nunito; font-size: 16px;">As you are aiming for a VMware certification, you must think in all solutions, features, and elements from vSphere.</span>

<span style="font-family: Nunito; font-size: 16px;">Here is a list of the solutions that appear in the Blueprint and are related to VMware of course:</span>

<ul style="list-style-type: square;">
  <li>
    <span style="font-family: Nunito; font-size: 16px;">vSphere</span>
  </li>
  <li>
    <span style="font-family: Nunito; font-size: 16px;">vSAN</span>
  </li>
  <li>
    <span style="font-family: Nunito; font-size: 16px;">SRM</span>
  </li>
  <li>
    <span class="st" style="font-family: Nunito; font-size: 16px;">vROps</span>
  </li>
  <li>
    <span style="font-family: Nunito; font-size: 16px;">VVOLs</span>
  </li>
  <li>
    <span style="font-size: 16px; font-family: Nunito;">vCenter Converter<br /> </span>
  </li>
</ul>

<span style="font-family: Nunito; font-size: 16px;">Inside each solution, you should know at least the most of the features, functionalities that they offer, dependencies between them and test them (if you can).</span>

<span style="font-family: Nunito; font-size: 16px;">Apart from knowing about these technologies related to VMware, there are obviously the core areas that compose a general IT infrastructure: Storage, networking and compute.</span>

<span style="font-family: Nunito; font-size: 16px;">So, be prepared to dig on each area and know about dependencies between each other and with other solutions.</span>

<span style="font-family: Nunito; font-size: 16px;">Advanced knowledge is desirable (and you will be tested) on each area would deserve more than post so, I am not going to explain anything right now about it 🙂</span>

# <span style="color: #000000;"><strong><span style="font-family: Nunito; font-size: 32px;">Aiming for the exam</span></strong></span>

<span style="font-family: Nunito; font-size: 16px;">Your main guide must be the blueprint, no matter what other unofficial guides say (although they are very helpful). In the blueprint you will have all the sections and objectives that will be qualified.</span>

<span style="font-family: Nunito; font-size: 16px;">This exam requires to read a lot (more if your daily job isn&#8217;t designing solutions) and not just books to gather information about how to gather requirements from the customer and match them to terminologies like RAMPS or RRAC (I will explain a bit of those later), also all the technical papers that the blueprint mention (+50).</span>

<span style="font-family: Nunito; font-size: 16px;"><strong>Conceptual, Logical and Physical Design</strong>, you will see this a lot and once you understand it, you will see why.</span>

<span style="font-family: Nunito; font-size: 16px;">You must check all the references (documents) that the blueprint mentions because most of them will appear in the exam.</span>

<span style="font-family: Nunito; font-size: 16px;">Some key points from all the features, elements or products I think will be:</span>

  * <span style="font-family: Nunito; font-size: 16px;"><strong>Dependencies:</strong> Know the dependencies between solutions. What do you need to enable vSAN, apart from at least 1 SSD/Flash and 1 SAS/SATA disk? It also requires vCenter and DNS.</span>
  * <span style="font-family: Nunito; font-size: 16px;"><strong>Advantages and disadvantages:</strong> Does SRM perform replication? Is HA better to ensure availability than FT? Which solution can achieve a 5-minute RPO? vSAN</span>
  * <span style="font-family: Nunito; font-size: 16px;"><strong>Maximums and limitations:</strong> vSphere 6.5U1 supports a maximum of 4 PSCs per site, behind an LB. Also a maximum of 10 PSCs per vSphere Domain.<br /> </span>
  * <span style="font-family: Nunito; font-size: 16px;"><strong>Upgrade paths</strong>: How would you upgrade a vSphere 6.0 environment to 6.5 with external PSC?<br /> </span>
  * <span style="font-family: Nunito; font-size: 16px;"><strong>Determine RCAR:</strong> Differentiate between requirements, constraints, assumptions, and risks.</span>
  * <span style="font-family: Nunito; font-size: 16px;"><strong>RAMPS:</strong> Build recoverability, availability, manageability, performance, and security into a vSphere Logical Design.</span>
  * <span style="font-family: Nunito; font-size: 16px;">Gather and <strong>analyze business and application</strong> requirements from customer interview data, determine customer priorities for defined objectives and categorize those requirements by infrastructure qualities.<br /> </span>

<span style="font-family: Nunito; font-size: 16px;">In the <a href="https://wp.me/p98Ovg-js">post</a>, I mentioned to you at the beginning there are some resources which are quite helpful in order to learn and improve your non-tech skills. </span>

# <span style="color: #000000; font-size: 32px;"><strong><span style="font-family: Nunito;">Summary</span></strong></span>

<span style="font-size: 16px; font-family: Nunito;">There is so much information to digest if you don&#8217;t have a certain level of knowledge in vSphere and the «art» of designing solutions, which could lead you to study a lot of products, methodologies, and features in probably, a great amount of time.</span>

<span style="font-size: 16px; font-family: Nunito;">But don&#8217;t be impatient, it will take you time but, review each section and check the concepts, products or features that you&#8217;re not familiar with. </span>

<span style="font-size: 16px; font-family: Nunito;">Check videos and other unofficial guides that probably will make other fellows from the community.</span>

<span style="font-family: Nunito; font-size: 16px;">This exam is about theory so, you will be tested as an architect who designs solutions based on customer or application requirements and how to match them to a VMware design.</span>

<span style="font-size: 16px; font-family: Nunito;">It is difficult to generalize all the things that can appear in past, present, and future VCAP-DCV Design certifications but I tried to give you as much information as I can.</span>