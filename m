From: Joerg.Hunsche@elektrobit.com <Joerg.Hunsche@elektrobit.com>
Date: Wed, 30 Oct 2019 09:11:01 +0000
Subject: [Intel-wired-lan] [i40e][PLP reording frame]
In-Reply-To: <60b2847e4ed1468ea1fcc9d6f62adf71@elektrobit.com>
References: <e16b63bb-72d5-4f8c-b066-00f8611392ae@denue6es010.ebgroup.elektrobit.com>
 <8921D02A9DA62B4B803224F42216E1C14F28FC85@ORSMSX106.amr.corp.intel.com>
 <60b2847e4ed1468ea1fcc9d6f62adf71@elektrobit.com>
Message-ID: <dcb26c31-da68-47a8-b0ee-9b716c31fc0b@denue6es011.ebgroup.elektrobit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Good Morning Don,
in the meantime we figured out that compiling the driver with
#define I40E_DEFAULT_QUEUES_PER_VF      1
Did the job.

Thank you for your fast response anyhow.

The issue is solved.
Regards J?rg.

From: Buchholz, Donald <donald.buchholz at intel.com<mailto:donald.buchholz@intel.com>>
Sent: Friday, October 25, 2019 3:51 AM
To: Hunsche, J?rg <Joerg.Hunsche at elektrobit.com<mailto:Joerg.Hunsche@elektrobit.com>>
Cc: Prochownik, Adam <extern.Adam.Prochownik at elektrobit.com<mailto:extern.Adam.Prochownik@elektrobit.com>>
Subject: RE: [Intel-wired-lan] [i40e][PLP reording frame]

Hi J?rg,


1.       Please send the full complement of PCI Vendor:Device:Subdevice Vendor:SubdeviceID identifiers (or output from "lspci -nn -v" command).

2.       Please send the output of "ethtool -i  ... " for *both* ports on this NIC?

- Don Buchholz
- SW Applications Engineer
- Intel Corporation - DCG
- Ethernet Customer Services
- (503) 264-2010  [desk]
- (503) 939-0848  [cell]


From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Joerg.Hunsche at elektrobit.com<mailto:Joerg.Hunsche@elektrobit.com>
Sent: Wednesday, October 23, 2019 6:50 AM
To: intel-wired-lan@osuosl.org<mailto:intel-wired-lan@osuosl.org>
Cc: extern.Adam.Prochownik at elektrobit.com<mailto:extern.Adam.Prochownik@elektrobit.com>
Subject: [Intel-wired-lan] [i40e][PLP reording frame]

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191030/600e238f/attachment.html>
