From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Mon, 25 Apr 2016 15:07:30 +0000
Subject: [Intel-wired-lan] issue with kernel patch
	2a3cdead8b408351fa1e3079b220fa331480ffbc
In-Reply-To: <9BBC4E0CF881AA4299206E2E1412B626501BC575@ORSMSX102.amr.corp.intel.com>
References: <1461577586.24438.14.camel@maxwell>
 <9BBC4E0CF881AA4299206E2E1412B626501BC575@ORSMSX102.amr.corp.intel.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD65ABFD85F@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jochen,
This change did not come from us. You should take it to the public mailing lists for discussion. This appears to have originated with Aaron Sierra.

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565


-----Original Message-----
From: Wyborny, Carolyn 
Sent: Monday, April 25, 2016 7:50 AM
To: Jochen Henneberg <jh@henneberg-systemdesign.com>
Cc: Fujinaka, Todd <todd.fujinaka@intel.com>
Subject: RE: issue with kernel patch 2a3cdead8b408351fa1e3079b220fa331480ffbc

Adding Todd for i210 support.  Those phy functions were designed for that specific PHY.  If the PHY you have on your design identifies as the PHY id for the gs40g PHY, but does not work the way the functions expect, the failure makes sense. 

Thanks,

Carolyn

> -----Original Message-----
> From: Jochen Henneberg [mailto:jh at henneberg-systemdesign.com]
> Sent: Monday, April 25, 2016 2:46 AM
> To: Wyborny, Carolyn <carolyn.wyborny@intel.com>
> Subject: issue with kernel patch
> 2a3cdead8b408351fa1e3079b220fa331480ffbc
> 
> Hi Carolyn,
> 
> I have an embedded device here which comes with a BYT SoC and a 
> separate
> I210 ethernet controller attached to the PCIe bus.
> Before the mentioned patch everything worked fine, now reading phy id 
> fails for the external chip, the one on the SoC reports the correct 
> phy id. If I circumvent the phy id check in 
> igb_init_phy_params_82575() everything works fine again.
> From what I can see the phy id is not part of the NVM flash image, so 
> I wonder why this fails now that the special gs40g register read 
> functions have been removed.
> Could you probably give me a hint? Or does the driver after this patch 
> probably not cover all situations anymore?
> The HW vendor will contact Intel with the same issue in parallel, I 
> just wanted to know if you are aware of any corner cases where the 
> generic register reads may fail, especially for the phy id (as I 
> pointed out before, the other phy register like connection status and 
> such seem to behave as expected).
> 
> Thanks in advance,
> Jochen Henneberg
> --
> Henneberg - Systemdesign
> Jochen Henneberg
> Loehnfeld 26
> 21423 Winsen (Luhe)
> --
> Fon: +49 4174 668 773
> Mobile: +49 172 160 14 69
> Fax: +49 321 210 761 64
> www: www.henneberg-systemdesign.com
> 
> 

