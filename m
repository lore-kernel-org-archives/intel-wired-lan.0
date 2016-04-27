From: Jochen Henneberg <jh@henneberg-systemdesign.com>
Date: Wed, 27 Apr 2016 14:08:21 +0200
Subject: [Intel-wired-lan] issue with kernel patch
	2a3cdead8b408351fa1e3079b220fa331480ffbc
In-Reply-To: <1334573989.48186.1461685944444.JavaMail.zimbra@xes-inc.com>
References: <1461577586.24438.14.camel@maxwell>
 <9BBC4E0CF881AA4299206E2E1412B626501BC575@ORSMSX102.amr.corp.intel.com>
 <9B4A1B1917080E46B64F07F2989DADD65ABFD85F@ORSMSX114.amr.corp.intel.com>
 <1768814989.41697.1461598056358.JavaMail.zimbra@xes-inc.com>
 <1461600045.21920.10.camel@maxwell>
 <985237851.71212.1461605748986.JavaMail.zimbra@xes-inc.com>
 <1461657732.9165.8.camel@maxwell>
 <1334573989.48186.1461685944444.JavaMail.zimbra@xes-inc.com>
Message-ID: <1461758901.972.24.camel@maxwell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Aaron,

On Di, 2016-04-26 at 10:52 -0500, Aaron Sierra wrote:
> > igb: Intel(R) Gigabit Ethernet Network Driver - version 5.3.0-k
> > igb: Copyright (c) 2007-2014 Intel Corporation.
> > igb: igb_init_phy_params_82575: default page: fc
> > igb: igb_init_phy_params_82575: PHY ID: a0044e90
> > igb: probe of 0000:01:00.0 failed with error -2
> 
> [snip]
> 
> > The datasheet states that the page selection register should come up
> > with 0 after power on, but either somebody writes the register
> up-front
> > (but who) or this comes from a broken setup in the NVM?
> 
> Hmm, that's the same page, E1000_PHY_PLL_FREQ_PAGE, touched by
> igb_pll_workaround_i210() in the commit that you referenced, but
> there's
> an explicit write to reset the page to zero at the end. Do you get
> into
> that function with the external I210?

That function is not called before the issue happens. I have checked
this, reading the phy id is the first time that the phy read/write
functions are used.
So either the datasheet is wrong with respect to the power-up values of
the page select register (which I do not believe), or somebody else is
writing the chip before the kernel comes up, e. g. the BIOS.
Kontron will check the BIOS, however, even they do not know the whole
code nor will they spent unlimited time in helping me with that issue.

However, if this can happen (and it obviously does) and there is no easy
way to change the BIOS (which is often the case) what would be the
disadvantage of simply setting the page select when entering the
igb_get_phy_id() function? This works fine from what I can see and
causes almost no overhead.

Even more, my feeling is that instead of changing the page select back
and forth in some functions (such that everybody needs to now that page
select 0 is the implicit default throughout the driver), wouldn't it
make sense for each function to ensure the correct page selection?
If this causes too much overhead, page select could be encapsulated in
its own functions, keep the current register value and check if a change
is necessary or not.

Anyway, for me it would be great if the probe could at least ensure that
the assumed initial page is selected by calling page select once it is
entered or in the phy id read function.

Please let me know what you think.

Regards,
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



