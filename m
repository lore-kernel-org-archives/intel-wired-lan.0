From: Rose, Gregory V <gregory.v.rose@intel.com>
Date: Tue, 7 Apr 2015 18:38:38 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next] i40e: stop VF rings
In-Reply-To: <1428431575-168522-1-git-send-email-mitch.a.williams@intel.com>
References: <1428431575-168522-1-git-send-email-mitch.a.williams@intel.com>
Message-ID: <C5551D9AAB213A418B7FD5E4A6F30A07892AEE11@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Looks good but maybe a comment too?

Your call.

ACK

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mitch Williams
> Sent: Tuesday, April 07, 2015 11:33 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 net-next] i40e: stop VF rings
> 
> Explicitly stop the rings belonging to each VF when disabling SR-IOV.
> Even though the VFs were gone, and the associated VSIs were removed, the
> rings were not stopped, and in some circumstances the hardware would
> continue to access the memory formerly used by the rings, causing memory
> corruption or DMAR errors, both of which would lead to general malaise of
> the kernel.
> 
> To relieve this condition, explicitly stop all the rings associated with
> each VF before releasing its resources.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> v2: use correct variable name (changed in a different patch)
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 4d69e1f..20ae88b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -733,6 +733,11 @@ void i40e_free_vfs(struct i40e_pf *pf)
>  	while (test_and_set_bit(__I40E_VF_DISABLE, &pf->state))
>  		usleep_range(1000, 2000);
> 
> +	for (i = 0; i < pf->num_alloc_vfs; i++)
> +		if (test_bit(I40E_VF_STAT_INIT, &pf->vf[i].vf_states))
> +			i40e_vsi_control_rings(pf->vsi[pf->vf[i].lan_vsi_idx],
> +					       false);
> +
>  	/* Disable IOV before freeing resources. This lets any VF drivers
>  	 * running in the host get themselves cleaned up before we yank
>  	 * the carpet out from underneath their feet.
> --
> 2.1.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
