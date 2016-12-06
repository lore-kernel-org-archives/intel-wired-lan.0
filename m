From: Ruth Christen <RuthC@Radware.com>
Date: Tue, 6 Dec 2016 16:29:56 +0000
Subject: [Intel-wired-lan] pmd-fm10k sriov port initialization issues
Message-ID: <3C2AE3A004FB424A9D4DB093543E06A90107710334@ILMB1.corp.radware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all!

I'm running a dpdk-based application which already supports different drivers (mellanux, ixgbe, sriov on ixgbe, enic,etc..)

Now I'm trying to integrate the fm10k card with 2X100G ports.



Below is some relevant information from my system:

The server I'm using is Ubuntu 14.04.4 LTS, kernel is 3.13.0-96-generic

Fm10k driver version is: fm10k-0.19.3 (I've tried to work also fm10k-0.20.1 but didn't help)

For the Switch manager I'm using rdif-5.0.4



When I run my application the Switch Manager doesn't enter the mac for the ports in its table, hence I have no traffic received in my vm.

I've tried running l2fwd from the vm and made sure that traffic works ok.

Next step was to compare the events in the fm10k driver during port initialization by l2fwd and by my application, which I did by adding prints in the fm10k module.



I suspect that I'm facing some issue with the mailbox between vf/pf. My application calls the same functions that l2fwd does, but not all the messages are received in pf.

After adding a print in mailbox reset functions I noticed that I have a mailbox reset going on all the time, and this is probably why the port isn't initialized correctly.



Do you have any idea why this could be happening ? Or advice on how to continue debugging this?

Maybe there's some problem with the registers while running in my application?



Thanks for your time!







Ruth Christen
SW Engineer
Email: ruthc at radware.com<mailto:ruthc@radware.com>

T:
M:0545619166
F:


[Check out the latest and greatest from Radware]<http://www.radware.com/Resources/CampaignRedirector.html>


www.radware.com<http://www.radware.com>



[Blog]<http://blog.radware.com/>  <http://www.linkedin.com/companies/165642> <http://twitter.com/radware>   <http://www.youtube.com/user/radwareinc>


Confidentiality note: This message, and any attachments to it, contains privileged/confidential information of RADWARE Ltd./RADWARE Inc. and may not be disclosed, used, copied, or transmitted in any form or by any means without prior written permission from RADWARE. If you are not the intended recipient, delete the message and any attachments from your system without reading or copying it, and kindly notify the sender by e-mail. Thank you.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161206/98d2343f/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image001.jpg
Type: image/jpeg
Size: 11411 bytes
Desc: image001.jpg
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161206/98d2343f/attachment-0001.jpg>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image002.png
Type: image/png
Size: 2338 bytes
Desc: image002.png
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161206/98d2343f/attachment-0001.png>
