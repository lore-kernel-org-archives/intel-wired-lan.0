From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 28 Mar 2022 17:59:35 +0000
Subject: [Intel-wired-lan] [PATCH] ice: ice_sched: fix an incorrect NULL
 check on list iterator
In-Reply-To: <20220327064344.7573-1-xiam0nd.tong@gmail.com>
References: <20220327064344.7573-1-xiam0nd.tong@gmail.com>
Message-ID: <CO1PR11MB5089C7298CC46861FF41D3E3D61D9@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> Sent: Saturday, March 26, 2022 11:44 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem at davemloft.net;
> kuba at kernel.org; pabeni at redhat.com; Raj, Victor <victor.raj@intel.com>; intel-
> wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; Xiaomeng Tong <xiam0nd.tong@gmail.com>;
> stable at vger.kernel.org
> Subject: [PATCH] ice: ice_sched: fix an incorrect NULL check on list iterator
> 
> The bugs are here:
> 	if (old_agg_vsi_info)
> 	if (old_agg_vsi_info && !old_agg_vsi_info->tc_bitmap[0]) {
> 
> The list iterator value 'old_agg_vsi_info' will *always* be set
> and non-NULL by list_for_each_entry_safe(), so it is incorrect
> to assume that the iterator value will be NULL if the list is
> empty or no element found (in this case, the check
> 'if (old_agg_vsi_info)' will always be true unexpectly).
> 
> To fix the bug, use a new variable 'iter' as the list iterator,
> while use the original variable 'old_agg_vsi_info' as a dedicated
> pointer to point to the found element.
> 

Yep. This looks correct to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake

> Cc: stable at vger.kernel.org
> Fixes: 37c592062b16d ("ice: remove the VSI info from previous agg")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c
> b/drivers/net/ethernet/intel/ice/ice_sched.c
> index 7947223536e3..fba524148a09 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sched.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sched.c
> @@ -2757,6 +2757,7 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi,
> u32 agg_id,
>  			   u16 vsi_handle, unsigned long *tc_bitmap)
>  {
>  	struct ice_sched_agg_vsi_info *agg_vsi_info, *old_agg_vsi_info = NULL;
> +	struct ice_sched_agg_vsi_info *iter;
>  	struct ice_sched_agg_info *agg_info, *old_agg_info;
>  	struct ice_hw *hw = pi->hw;
>  	int status = 0;
> @@ -2774,11 +2775,13 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info
> *pi, u32 agg_id,
>  	if (old_agg_info && old_agg_info != agg_info) {
>  		struct ice_sched_agg_vsi_info *vtmp;
> 
> -		list_for_each_entry_safe(old_agg_vsi_info, vtmp,
> +		list_for_each_entry_safe(iter, vtmp,
>  					 &old_agg_info->agg_vsi_list,
>  					 list_entry)
> -			if (old_agg_vsi_info->vsi_handle == vsi_handle)
> +			if (iter->vsi_handle == vsi_handle) {
> +				old_agg_vsi_info = iter;
>  				break;
> +			}
>  	}
> 
>  	/* check if entry already exist */
> --
> 2.17.1

