From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Wed, 1 Aug 2018 23:03:17 +0000
Subject: [Intel-wired-lan] [PATCH v3 08/13] ice: Don't explicitly set
 port_vlan_bits to 0
In-Reply-To: <20180801034729.3864-9-anirudh.venkataramanan@intel.com>
References: <20180801034729.3864-1-anirudh.venkataramanan@intel.com>
 <20180801034729.3864-9-anirudh.venkataramanan@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A184F23DD7B4@ORSMSX105.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 08/13] ice: Don't explicitly set
> port_vlan_bits to 0
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> This patch fixes the following smatch warning originally reported by
> Dan Carpenter:
> ice_set_dflt_vsi_ctx() warn: odd binop '0x0 & 0x18'
> 
> In ice_set_dflt_vsi_ctx() we clear bits 3 and 4 for legacy behavior
> (i.e. show VLAN, DEI and UP in the receive descriptors). However
> the logic to do this generated the above mentioned smatch warning.
> 
> Bits 3 and 4 in port_vlan_flags are anyway set to zero by the memset on
> ctxt->info field, so remove the logic to set these explicitly to 0. This
> fixes the smatch warning as well.
> 
> CC: Shannon Nelson <shannon.nelson@oracle.com>

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote
> commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index d4f1f92faf65..3eff1d2d1543 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -1367,14 +1367,13 @@ static void ice_set_dflt_vsi_ctx(struct ice_vsi_ctx
> *ctxt)
>  	ctxt->info.sw_flags = ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
>  	/* Traffic from VSI can be sent to LAN */
>  	ctxt->info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
> -	/* Allow all packets untagged/tagged */
> +	/* By default bits 3 and 4 in port_vlan_flags are 0's which results in
> +	 * legacy behavior (show VLAN, DEI, and UP) in descriptor. Also, allow
> +	 * all packets untagged/tagged.
> +	 */
>  	ctxt->info.port_vlan_flags = ((ICE_AQ_VSI_PVLAN_MODE_ALL &
>  				       ICE_AQ_VSI_PVLAN_MODE_M) >>
>  				      ICE_AQ_VSI_PVLAN_MODE_S);
> -	/* Show VLAN/UP from packets in Rx descriptors */
> -	ctxt->info.port_vlan_flags |= ((ICE_AQ_VSI_PVLAN_EMOD_STR_BOTH
> &
> -					ICE_AQ_VSI_PVLAN_EMOD_M) >>
> -				       ICE_AQ_VSI_PVLAN_EMOD_S);
>  	/* Have 1:1 UP mapping for both ingress/egress tables */
>  	table |= ICE_UP_TABLE_TRANSLATE(0, 0);
>  	table |= ICE_UP_TABLE_TRANSLATE(1, 1);
> --
> 2.17.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
