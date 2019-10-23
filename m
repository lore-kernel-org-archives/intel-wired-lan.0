From: Joerg.Hunsche@elektrobit.com <Joerg.Hunsche@elektrobit.com>
Date: Wed, 23 Oct 2019 13:50:02 +0000
Subject: [Intel-wired-lan] [i40e][PLP reording frame]
Message-ID: <e16b63bb-72d5-4f8c-b066-00f8611392ae@denue6es010.ebgroup.elektrobit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,
we use INTEL X710-DA2 with i40e-2.10.19.30.
Configured socket flags SOCK_RAW and socket option PACKET_QDISC_BYPASS to bypass queuing, sending single-threaded.

When sending PLP-Ethernet-frames we observe a problem, that after ~2h a PLP-Ethernet-frame is send about 250frames later than it should be.
Our assumption is, that somehow more than one TX-queue is used, what we have to avoid.

Is there any configuration of the driver possible configuring a single Tx-queue?
Is there any means to get the driver to a state that only a single Tx-queue is used?

Thank you for your support.
J?rg Hunsche

EB Driving the Future of Software
Wolfgang-Paul Str. 4, 89081 Ulm
Phone: +49913177017653
Joerg.Hunsche at elektrobit.com<mailto:Joerg.Hunsche@elektrobit.com>
http://automotive.elektrobit.com<http://automotive.elektrobit.com/>

Elektrobit Automotive GmbH, Am Wolfsmantel 46, 91058 Erlangen, Germany
Managing Directors Alexander Kocher, Gregor Zink
Register Court F?rth HRB 4886

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191023/6d51d534/attachment.html>
