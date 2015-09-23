From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Wed, 23 Sep 2015 16:05:55 +0000
Subject: [Intel-wired-lan] [PATCH] Re: igb: use the correct i210
	register for EEMNGCTL
In-Reply-To: <56027EC3.9050608@siemens.com>
References: <20150918224351.5228.90499.stgit@htfujina-fc.jf.intel.com>
 <56027EC3.9050608@siemens.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD6536040D9@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I put it into a separate function so it would have minimal effect on older parts. It's hard to regression test everything as most of our testers are on to the new products.

I matched on PHY because it made sense to the function in general. I'll look at it more closely later tonight to make sure I got it right.

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565

-----Original Message-----
From: Hodek, Roman [mailto:roman.aud at siemens.com] 
Sent: Wednesday, September 23, 2015 3:28 AM
To: Fujinaka, Todd; intel-wired-lan at lists.osuosl.org
Subject: [PATCH] Re: igb: use the correct i210 register for EEMNGCTL

Hi Todd!

> +s32 igb_get_cfg_done_i210(struct e1000_hw *hw)

That's of course also a possibility.

And so, the new register is coupled to PHY ID not MAC type?

Thanks!

Roman

