From: Mori, Naoyuki <naoyuki.mori@intel.com>
Date: Thu, 21 Jul 2016 02:59:03 +0000
Subject: [Intel-wired-lan] How to enable trust for VF managed by the
	vfio-pci driver (lgy)
Message-ID: <02CB2AF9-76D5-47B4-B185-405E2852B81B@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Grace,

Have you set ?vf-true-promisc-support on? from PF?
See https://patchwork.ozlabs.org/patch/618187/

However, you may not see broadcast packet on VF if you haven?t assign VLAN ID to VF.
Hope this help.

Regards,
Mori


Date: Thu, 14 Jul 2016 13:40:22 -0700
From: lgy <lgy.bupt@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] How to enable trust for VF managed by the
	vfio-pci driver
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


