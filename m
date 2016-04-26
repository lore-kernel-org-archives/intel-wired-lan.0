From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Tue, 26 Apr 2016 14:47:07 +0000
Subject: [Intel-wired-lan] issue with kernel patch
	2a3cdead8b408351fa1e3079b220fa331480ffbc
In-Reply-To: <1461657732.9165.8.camel@maxwell>
References: <1461577586.24438.14.camel@maxwell>
 <9BBC4E0CF881AA4299206E2E1412B626501BC575@ORSMSX102.amr.corp.intel.com>
 <9B4A1B1917080E46B64F07F2989DADD65ABFD85F@ORSMSX114.amr.corp.intel.com>
 <1768814989.41697.1461598056358.JavaMail.zimbra@xes-inc.com>
 <1461600045.21920.10.camel@maxwell>
 <985237851.71212.1461605748986.JavaMail.zimbra@xes-inc.com>
 <1461657732.9165.8.camel@maxwell>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD65ABFDF9C@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Have you reported this to Kontron? We may have to get them involved with this.

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565


-----Original Message-----
From: Jochen Henneberg [mailto:jh at henneberg-systemdesign.com] 
Sent: Tuesday, April 26, 2016 1:02 AM
To: Aaron Sierra <asierra@xes-inc.com>
Cc: Fujinaka, Todd <todd.fujinaka@intel.com>; intel-wired-lan at lists.osuosl.org; Wyborny, Carolyn <carolyn.wyborny@intel.com>
Subject: Re: issue with kernel patch 2a3cdead8b408351fa1e3079b220fa331480ffbc

On Mo, 2016-04-25 at 12:35 -0500, Aaron Sierra wrote:
> This is the output that I get from an external I210 device attached to 
> a Bay Trail SoC:
> 
> igb 0000:02:00.0: added PHC on eth0
> igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection igb 
> 0000:02:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 00:17:3c:02:88:56 igb 
> 0000:02:00.0: eth0: PBA No: FFFFFF-0FF igb 0000:02:00.0: Using MSI-X 
> interrupts. 2 rx queue(s), 2 tx queue(s)
> igb: igb_init_phy_params_82575: default page: 0
> igb: igb_init_phy_params_82575: PHY ID: 1410c00

And here is mine with the patch applied:

igb: Intel(R) Gigabit Ethernet Network Driver - version 5.3.0-k
igb: Copyright (c) 2007-2014 Intel Corporation.
igb: igb_init_phy_params_82575: default page: fc
igb: igb_init_phy_params_82575: PHY ID: a0044e90
igb: probe of 0000:01:00.0 failed with error -2
igb: igb_init_phy_params_82575: default page: 0
igb: igb_init_phy_params_82575: PHY ID: 1410c00 pps pps0: new PPS source ptp0 igb 0000:04:00.0: added PHC on eth0 igb 0000:04:00.0: Intel(R) Gigabit Ethernet Network Connection igb 0000:04:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 00:e0:4b:47:38:6f igb 0000:04:00.0: eth0: PBA No: FFFFFF-0FF igb 0000:04:00.0: Using MSI-X interrupts. 2 rx queue(s), 2 tx queue(s)

At PCI 0000:04:00.0 is the BYT NIC, this comes up with the correct page selection and phy id. Above it (0000:01:00.0) is the external NIC which comes up with 'anything' (but 'anything' is the same after each power cycle)!?
Some explanations to the HW setup, the BYT resides on a Kontron nanoETX board, the external controller is on the custom base board, it is not at all integrated into the BIOS setup (the BIOS should only take care of the internal NIC).
The datasheet states that the page selection register should come up with 0 after power on, but either somebody writes the register up-front (but who) or this comes from a broken setup in the NVM?

Jochen
--
Henneberg - Systemdesign
Jochen Henneberg
Loehnfeld 26
21423 Winsen (Luhe)
--
Fon: +49 4174 668 773
Mobile: +49 172 160 14 69
Fax: +49 321 210 761 64
www: www.henneberg-systemdesign.com



