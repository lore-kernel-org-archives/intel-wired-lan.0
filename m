From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 8 Aug 2018 16:46:07 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix for tx timeouts when
 interface is brought up if DCB is enabled
In-Reply-To: <20180808001123.55890-1-alice.michael@intel.com>
References: <20180808001123.55890-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2E884E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 7, 2018 5:11 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Szapar, Martyna <martyna.szapar@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: Fix for tx timeouts when interface is
> brought up if DCB is enabled
> 
> From: "Szapar, Martyna" <martyna.szapar@intel.com>
> 
> If interface is connected to switch port configured for DCB there are TX
> timeouts when bringing up interface. Problem started appearing after adding
> in i40e driver code mqprio hardware offload mode. In function
> i40e_vsi_configure_bw_alloc was added resetting BW rate which should be
> executing when mqprio qdisc is removed but was also when there was no
> mqprio qdisc added and DCB was enabled. In this patch was added additional
> check for DCB flag so now when DCB is enabled the correct DCB configs from
> before mqprio patch are restored.
> 
> Signed-off-by: Martyna Szapar <martyna.szapar@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


