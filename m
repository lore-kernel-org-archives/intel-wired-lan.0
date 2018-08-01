From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Wed, 1 Aug 2018 23:02:10 +0000
Subject: [Intel-wired-lan] [PATCH v3 07/13] ice: Use order_base_2 to
 calculate higher power of 2
In-Reply-To: <20180801034729.3864-8-anirudh.venkataramanan@intel.com>
References: <20180801034729.3864-1-anirudh.venkataramanan@intel.com>
 <20180801034729.3864-8-anirudh.venkataramanan@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A184F23DD78F@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Anirudh Venkataramanan
> Sent: Tuesday, July 31, 2018 8:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 07/13] ice: Use order_base_2 to calculate
> higher power of 2
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Currently, we use a combination of ilog2 and is_power_of_2() to
> calculate the next power of 2 for the qcount. This appears to be causing
> a warning on some combinations of GCC and the Linux kernel:
> 
> MODPOST 1 modules
> WARNING: "____ilog2_NaN" [ice.ko] undefined!
> 
> This appears to because because GCC realizes that qcount could be zero
> in some circumstances and thus attempts to link against the
> intentionally undefined ___ilog2_NaN function.
> 
> The order_base_2 function is intentionally defined to return 0 when
> passed 0 as an argument, and thus will be safe to use here.
> 
> This not only fixes the warning but makes the resulting code slightly
> cleaner, and is really what we should have used originally.
> 
> Also update the comment to make it more clear that we are rounding up,
> not just incrementing the ilog2 of qcount unconditionally.
> 
> Without this patch, we get warnings when building against the upstream
> kernel.

This last sentence is unnecessary for this upstream kernel patch.

> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> minor
> cleanup for upstream submission]
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index a1524cbb15b1..d4f1f92faf65 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -1313,11 +1313,8 @@ static void ice_vsi_setup_q_map(struct ice_vsi *vsi,
> struct ice_vsi_ctx *ctxt)
>  		qcount = numq_tc;
>  	}
> 
> -	/* find higher power-of-2 of qcount */
> -	pow = ilog2(qcount);
> -
> -	if (!is_power_of_2(qcount))
> -		pow++;
> +	/* find the (rounded up) power-of-2 of qcount */
> +	pow = order_base_2(qcount);
> 
>  	for (i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
>  		if (!(vsi->tc_cfg.ena_tc & BIT(i))) {
> --
> 2.17.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
