From: Kushal Gautam <kushal.gautam@gmail.com>
Date: Tue, 1 Aug 2017 22:51:23 +0200
Subject: [Intel-wired-lan] Issue with Flow Director in Kernel Source tree's
	i40e driver
Message-ID: <CAGv3bDevbyr_m-owXLOkHQHJKVYRc1Lxyj1PakoJ3nES-gezsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi:

I believe this is the right place to discuss this issue.

I am using Intel X710 NIC, and i40e driver extracted from the Kernel Source
tree v4.4.0.

I have been trying to use ethtool to add a flow rule to the incoming
packets. The command that I have been using is:

ethtool -U ens1f0 flow-type udp4 dst-port 319 action 3 loc 1
ethtool -U ens1f1 flow-type udp4 dst-port 319 action 3 loc 1

As per my understanding, this should be forwarding all the matched packets
to Queue #3. But, these packets are directed to somewhere else (the queue
number usually changes). I could see this with /proc/interrupts.

The increase in port.fdir_atr_match and stagnant port.fdir_sb_match
suggests that my sideband rule is not working as it should have.

Also, I have tried this with usual the official i40e driver. With this
driver, I can get the desired behaviour. Has anyone else encountered the
same issue with the driver from Kernel Source tree v4.4.0 ?

Despite several tweaks, I am still not able to funnel my packets to a
particular queue. Am I doing something wrong here ?

Any information on this would be very helpful.

I can provide further information, if needed.

Thanks,
Kushal.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170801/fc09cd4a/attachment.html>
