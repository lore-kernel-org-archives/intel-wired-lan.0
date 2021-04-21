From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 21 Apr 2021 19:17:28 +0000
Subject: [Intel-wired-lan] [PATCH net 12/13] ice: handle the VF VSI
 rebuild failure
In-Reply-To: <20210226211932.46683-12-anthony.l.nguyen@intel.com>
References: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
 <20210226211932.46683-12-anthony.l.nguyen@intel.com>
Message-ID: <CY4PR11MB1576873FD3818864321C0323AB479@CY4PR11MB1576.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: pi?tek, 26 lutego 2021 22:20
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net 12/13] ice: handle the VF VSI rebuild
> failure
> 
> From: Haiyue Wang <haiyue.wang@intel.com>
> 
> VSI rebuild can be failed for LAN queue config, then the VF's VSI will be NULL,
> the VF reset should be stopped with the VF entering into the disable state.
> 
> Fixes: 12bb018c538c ("ice: Refactor VF reset")
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> index 5a581e759111..de438aba29cd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> @@ -1377,7 +1377,12 @@ bool ice_reset_vf(struct ice_vf *vf, bool is_vflr)
>  	}
> 
>  	ice_vf_pre_vsi_rebuild(vf);
> -	ice_vf_rebuild_vsi_with_release(vf);
> +
> +	if (ice_vf_rebuild_vsi_with_release(vf)) {
> +		dev_err(dev, "Failed to release and setup the VF%u's VSI\n",
> vf->vf_id);
> +		return false;
> +	}
> +
>  	ice_vf_post_vsi_rebuild(vf);
> 
>  	return true;

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
