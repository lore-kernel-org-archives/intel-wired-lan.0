From: Thorsten Leemhuis <regressions@leemhuis.info>
Date: Thu, 24 Mar 2022 11:37:26 +0100
Subject: [Intel-wired-lan] Bug 215689 - e1000e: regression for I219-V for
 kernel 5.14 onwards
Message-ID: <6801d0ef-9620-0f61-c107-c2c5524952ef@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org that afaics nobody
acted upon since it was reported about a week ago, that's why I decided
to forward it to the lists and a few relevant people to the CC. To quote
from https://bugzilla.kernel.org/show_bug.cgi?id=215689 :

> [reply] [?] Description James 2022-03-15 13:45:38 UTC
> 
> I run Arch linux on an Intel NUC 8i3BEH which has the following network card:
> 
> 00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (6) I219-V (rev 30)
>         DeviceName:  LAN
>         Subsystem: Intel Corporation Device 2074
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 135
>         Region 0: Memory at c0b00000 (32-bit, non-prefetchable) [size=128K]
>         Capabilities: [c8] Power Management version 3
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                 Address: 00000000fee003d8  Data: 0000
>         Kernel driver in use: e1000e
>         Kernel modules: e1000e
> 
> I found a major regression since the previous few kernel versions which causes several odd issues, most noteably I use the machine to stream live tv via TVheadend and was finding this to be unusable (picture freezes and sound breaks up very badly with continuity errors in the TVheadend logfile).
> 
> I found the issue was introduced since the 5.14 kernel, and have eventually got round to performing a git bisect, which landed upon the following commit:
> 
> 44a13a5: e1000e: Fix the max snoop/no-snoop latency for 10M 
> 
> Indeed, if I revert this single commit then the problem is resolved.
> 
> To help diagnose the issue I applied the following patch to capture the values of the lat_enc, max_ltr_enc vs lat_enc_d, max_ltr_enc_d variables:
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index d60e2016d..f4e5ffbcd 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1012,6 +1012,7 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
>         u16 max_ltr_enc_d = 0;  /* maximum LTR decoded by platform */
>         u16 lat_enc_d = 0;      /* latency decoded */
>         u16 lat_enc = 0;        /* latency encoded */
> +       struct e1000_adapter *adapter = hw->adapter;
> 
>         if (link) {
>                 u16 speed, duplex, scale = 0;
> @@ -1074,6 +1075,9 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
>                                  ((max_ltr_enc & E1000_LTRV_SCALE_MASK)
>                                  >> E1000_LTRV_SCALE_SHIFT)));
> 
> +               e_info("e1000e: lat_enc=%d max_ltr_enc=%d", lat_enc, max_ltr_enc);
> +               e_info("e1000e: lat_enc_d=%u max_ltr_enc_d=%u", lat_enc_d, max_ltr_enc_d);
> +
>                 if (lat_enc_d > max_ltr_enc_d)
>                         lat_enc = max_ltr_enc;
>         }
> 
> With this in place I see the following in dmesg:
> 
> [    3.241215] e1000e: Intel(R) PRO/1000 Network Driver
> [    3.241217] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    3.243382] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [    3.749009] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
> [    3.824751] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 94:c6:91:ae:b3:7b
> [    3.824765] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
> [    3.824849] e1000e 0000:00:1f.6 eth0: MAC: 13, PHY: 12, PBA No: FFFFFF-0FF
> [    6.949327] e1000e 0000:00:1f.6 eth0: e1000e: lat_enc=2233 max_ltr_enc=4099
> [    6.949331] e1000e 0000:00:1f.6 eth0: e1000e: lat_enc_d=58368 max_ltr_enc_d=0
> [    6.951165] e1000e 0000:00:1f.6 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> 
> Notice that lat_enc_d=58368 and max_ltr_enc_d=0 !
> 
> lat_enc_d is greater than max_ltr_enc_d so it's setting snoop latency to max_ltr_enc (i.e. 4099) where it would have previously been set to 2233 in this particular example. This seems to be where the problem lies.
> 
> Prior to commit 44a13a5:
> 
> if (lat_enc > max_ltr_enc)
>   lat_enc = max_ltr_enc;
> 
> After commit 44a13a5:
> 
> if (lat_enc_d > max_ltr_enc_d)
>   lat_enc = max_ltr_enc;
> 
> 
> I'm not sure whether it was intended for this new code to take effect for an I219 since the commit message on 44a13a5 indicates it was aimed at I217/I218. Seems strange that max_ltr_enc_d is getting set to 0?
> 

BTW, that commit is from Sasha Neftin.

Could somebody take a look into this? Or was this discussed somewhere
else already? Or even fixed?

Anyway, to get this tracked:

#regzbot introduced: 44a13a5d99c71bf9e1676d9e51679daf4d7b3d73
#regzbot from: James <jahutchinson99@googlemail.com>
#regzbot title: net: e1000e: instabilities on I219-V for kernel 5.14 onwards
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215689

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.
