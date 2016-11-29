From: Matwey V. Kornilov <matwey@sai.msu.ru>
Date: Tue, 29 Nov 2016 20:56:00 +0300
Subject: [Intel-wired-lan] [PATCH] igb: reset the PHY before reading the
	PHY ID
In-Reply-To: <1589605144.308560.1480435436440.JavaMail.zimbra@xes-inc.com>
References: <1589605144.308560.1480435436440.JavaMail.zimbra@xes-inc.com>
Message-ID: <CAJs94EbDpHK5WoS=nFow=-yNH6G9+nV1USPdP1VGtUfvKh3bEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

2016-11-29 19:03 GMT+03:00 Aaron Sierra <asierra@xes-inc.com>:
> Several people have reported firmware leaving the I210/I211 PHY's page
> select register set to something other than the default of zero. This
> causes the first accesses, PHY_IDx register reads, to access something
> else, resulting in device probe failure:
>
>     igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
>     igb: Copyright (c) 2007-2014 Intel Corporation.
>     igb: probe of 0000:01:00.0 failed with error -2
>
> This problem began for them after a previous patch I submitted was
> applied:
>
>     commit 2a3cdead8b408351fa1e3079b220fa331480ffbc
>     Author: Aaron Sierra <asierra@xes-inc.com>
>     Date:   Tue Nov 3 12:37:09 2015 -0600
>
>         igb: Remove GS40G specific defines/functions
>
> I personally experienced this problem after attempting to PXE boot from
> I210 devices using this firmware:
>
>     Intel(R) Boot Agent GE v1.5.78
>     Copyright (C) 1997-2014, Intel Corporation

Indeed! I use Boot Agent GE v1.5.53. When I disable PCIe Boot ROM the
kernel works without this patch.
The patch fixes kernel even with PXE boot enabled.

>
> Resetting the PHY before reading from it, ensures the page select
> register is in its default state and doesn't make assumptions about
> the PHY's register set before the PHY has been probed.
>
> Cc: Matwey V. Kornilov <matwey@sai.msu.ru>

Tested-By: Matwey V. Kornilov <matwey@sai.msu.ru>

> Cc: Chris Arges <carges@vectranetworks.com>
> Cc: Jochen Henneberg <jh@henneberg-systemdesign.com>
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
> index a61447f..ee44398 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_82575.c
> +++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
> @@ -245,6 +245,17 @@ static s32 igb_init_phy_params_82575(struct e1000_hw *hw)
>         hw->bus.func = (rd32(E1000_STATUS) & E1000_STATUS_FUNC_MASK) >>
>                         E1000_STATUS_FUNC_SHIFT;
>
> +       /* Make sure the PHY is in a good state. Several people have reported
> +        * firmware leaving the PHY's page select register set to something
> +        * other than the default of zero, which causes the PHY ID read to
> +        * access something other than the intended register.
> +        */
> +       ret_val = hw->phy.ops.reset(hw);
> +       if (ret_val) {
> +               hw_dbg("Error resetting the PHY.\n");
> +               goto out;
> +       }
> +
>         /* Set phy->phy_addr and phy->id. */
>         ret_val = igb_get_phy_id_82575(hw);
>         if (ret_val)
> --
> 1.9.1
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
