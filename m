From: Nelson, Shannon <shannon.nelson@intel.com>
Date: Thu, 1 Oct 2015 19:06:18 +0000
Subject: [Intel-wired-lan] [next PATCH S18 3/8] i40e: Fix VEB/VEPA
 bridge	mode mismatch issue
In-Reply-To: <1443724661-92168-4-git-send-email-catherine.sullivan@intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
 <1443724661-92168-4-git-send-email-catherine.sullivan@intel.com>
Message-ID: <FC41C24E35F18A40888AACA1A36F3E418AF91A28@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, October 01, 2015 11:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Abodunrin, Akeem G <akeem.g.abodunrin@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S18 3/8] i40e: Fix VEB/VEPA bridge
> mode mismatch issue
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> Fix i40e_is_vsi_uplink_mode_veb to check if bridge is actually
> in VEB mode before allowing LB in the add vsi routine, instead of
> unconditionally returning VEB bridge mode.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Change-ID: I162397b1bdd02367735fe9baaeb51465be2a3ce9
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index d341f56..a56aefe 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -8758,12 +8758,22 @@ int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi
> *vsi)
>  		return 1;
> 
>  	veb = pf->veb[vsi->veb_idx];
> +	if (!veb) {
> +		dev_info(&pf->pdev->dev,
> +			 "There is no veb associated with the bridge\n");
> +		return -ENOENT;
> +	}
> +

This introduces a subtle bug into the code - the caller of i40e_is_vsi_uplink_mode_veb() is looking for 0/non-0, not looking for an error condition.

sln

>  	/* Uplink is a bridge in VEPA mode */
> -	if (veb && (veb->bridge_mode & BRIDGE_MODE_VEPA))
> +	if (veb->bridge_mode & BRIDGE_MODE_VEPA) {
>  		return 0;
> +	} else {
> +		/* Uplink is a bridge in VEB mode */
> +		return 1;
> +	}
> 
> -	/* Uplink is a bridge in VEB mode */
> -	return 1;
> +	/* VEPA is now default bridge, so return 0 */
> +	return 0;
>  }
> 
>  /**
> --
> 1.9.3
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
