From: Aaron Sierra <asierra@xes-inc.com>
Date: Tue, 26 Apr 2016 10:52:24 -0500 (CDT)
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
Message-ID: <1334573989.48186.1461685944444.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jochen,

----- Original Message -----
> From: "Jochen Henneberg" <jh@henneberg-systemdesign.com>
> Sent: Tuesday, April 26, 2016 3:02:12 AM
> 
> On Mo, 2016-04-25 at 12:35 -0500, Aaron Sierra wrote:
> > This is the output that I get from an external I210 device attached to
> > a Bay Trail SoC:
> > 
> > igb 0000:02:00.0: added PHC on eth0
> > igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
> > igb 0000:02:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 00:17:3c:02:88:56
> > igb 0000:02:00.0: eth0: PBA No: FFFFFF-0FF
> > igb 0000:02:00.0: Using MSI-X interrupts. 2 rx queue(s), 2 tx queue(s)
> > igb: igb_init_phy_params_82575: default page: 0
> > igb: igb_init_phy_params_82575: PHY ID: 1410c00
> 
> And here is mine with the patch applied:
> 
> igb: Intel(R) Gigabit Ethernet Network Driver - version 5.3.0-k
> igb: Copyright (c) 2007-2014 Intel Corporation.
> igb: igb_init_phy_params_82575: default page: fc
> igb: igb_init_phy_params_82575: PHY ID: a0044e90
> igb: probe of 0000:01:00.0 failed with error -2

[snip]

> The datasheet states that the page selection register should come up
> with 0 after power on, but either somebody writes the register up-front
> (but who) or this comes from a broken setup in the NVM?

Hmm, that's the same page, E1000_PHY_PLL_FREQ_PAGE, touched by
igb_pll_workaround_i210() in the commit that you referenced, but there's
an explicit write to reset the page to zero at the end. Do you get into
that function with the external I210?

-Aaron
 
> Jochen
