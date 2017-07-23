From: Kushal Gautam <kushal.gautam@gmail.com>
Date: Sun, 23 Jul 2017 04:21:08 +0200
Subject: [Intel-wired-lan] Issue with Flow Director
Message-ID: <CAGv3bDc7ssoTaM8_bKv4fSJHNvr7jiqwZFbCGXr2R0JEsuCCwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi:

I am using Intel X710 NIC, and i40e driver.

I have been trying to use ethtool to add a flow rule to the incoming
packets. The command that I have been using is:

ethtool -U ens1f0 flow-type udp4 dst-port 319 action 3 loc 1
ethtool -U ens1f1 flow-type udp4 dst-port 319 action 3 loc 1

As per my understanding, this should be forwarding all the matched packets
to Queue #3. But, these packets are directed to somewhere else (the queue
number usually changes). I could see this will /proc/interrupts.

Also, upon inspection, I saw that atr was enabled even when I added a rule.
So, I somehow replicated the code from i40e_add_del_fdir_tcpv4() in
i40e_add_del_fdir_udp4()
to disable atr whenever there is a rule for UDP as well.

Despite several tweaks, I am still not able to funnel my packets to a
particular queue. Am I doing something wrong here ?

I can provide further information, if needed.

Thanks,
Kushal.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170723/ab1b6b5f/attachment.html>
