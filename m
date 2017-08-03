From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Thu, 3 Aug 2017 14:33:22 +0000
Subject: [Intel-wired-lan] Issue with Flow Director
In-Reply-To: <CAGv3bDc7ssoTaM8_bKv4fSJHNvr7jiqwZFbCGXr2R0JEsuCCwA@mail.gmail.com>
References: <CAGv3bDc7ssoTaM8_bKv4fSJHNvr7jiqwZFbCGXr2R0JEsuCCwA@mail.gmail.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD681D8E5D0@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I think you?re assigning the flows to queues, but you?re not pinning the queues to cores. irqbalance, etc, will try to balance the workload among the cores and you?ll see that in /proc/interrupts.

?ethtool ?S <device>? should show you what queue is running the traffic, and pinning the queues to cores should help you with keeping the flows on particular queues.

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565

From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Kushal Gautam
Sent: Saturday, July 22, 2017 7:21 PM
To: intel-wired-lan@osuosl.org
Subject: [Intel-wired-lan] Issue with Flow Director

Hi:

I am using Intel X710 NIC, and i40e driver.

I have been trying to use ethtool to add a flow rule to the incoming packets. The command that I have been using is:

ethtool -U ens1f0 flow-type udp4 dst-port 319 action 3 loc 1
ethtool -U ens1f1 flow-type udp4 dst-port 319 action 3 loc 1

As per my understanding, this should be forwarding all the matched packets to Queue #3. But, these packets are directed to somewhere else (the queue number usually changes). I could see this will /proc/interrupts.

Also, upon inspection, I saw that atr was enabled even when I added a rule. So, I somehow replicated the code from i40e_add_del_fdir_tcpv4() in i40e_add_del_fdir_udp4() to disable atr whenever there is a rule for UDP as well.

Despite several tweaks, I am still not able to funnel my packets to a particular queue. Am I doing something wrong here ?

I can provide further information, if needed.

Thanks,
Kushal.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170803/7fd2aaf0/attachment.html>
