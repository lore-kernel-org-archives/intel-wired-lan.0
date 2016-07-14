From: lgy <lgy.bupt@gmail.com>
Date: Thu, 14 Jul 2016 13:40:22 -0700
Subject: [Intel-wired-lan] How to enable trust for VF managed by the
	vfio-pci driver
Message-ID: <CA+BCu29zMVVKG_ORthoqMQXFo3iRi-UCeWJaEPws67UFgw7UQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,


I'd like to enable promiscuous mode for a VF and the solution I found
online is to make it trust, so I first created the VF using i40e driver
(version: 1.5.16) and use the command *ip link set eth8 vf 0 trust on* to
configure it. Then I bind this VF to vfio-pci so it can be used by DPDK
application, but the promiscuous mode is not working. My guess is when I
unbind it from i40evf and bind to vfio-pci, the trust configuration has
been reset to off, so I'm wondering how to enable promiscuous mode for a VF
not managed by i40e driver?

Thanks,
Grace
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160714/096b0873/attachment.html>
