From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 14 Jun 2021 21:17:11 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Add check for queue
 allocation for the VF and refactor VF queue requesting
In-Reply-To: <20210614094614.64215-1-karen.sornek@intel.com>
References: <20210614094614.64215-1-karen.sornek@intel.com>
Message-ID: <5e2f4f5666dfaa8d066bb7e7480b27ab307cb261.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-06-14 at 11:46 +0200, Karen Sornek wrote:
> The change implements the search for free space in PF
> queue pair piles and refactors VF queue requesting.
> i40e_set_num_queues and i40e_request_queues_msg
> used similar logic to change number of queues for VF's.
> 
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |   1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  33 +++++
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 135 ++++++++++++++
> ----
>  3 files changed, 145 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> b/drivers/net/ethernet/intel/i40e/i40e.h
> index ea9e301c6..0f2e0e5e0 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -1154,6 +1154,7 @@ int i40e_reconfig_rss_queues(struct i40e_pf
> *pf, int queue_count);
>  struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags, u16
> uplink_seid,
>  				u16 downlink_seid, u8 enabled_tc);
>  void i40e_veb_release(struct i40e_veb *veb);
> +int i40e_max_lump_qp(struct i40e_pf *pf);
>  
>  int i40e_veb_config_tc(struct i40e_veb *veb, u8 enabled_tc);
>  int i40e_vsi_add_pvid(struct i40e_vsi *vsi, u16 vid);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index fce05ad24..5d4d323c9 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -257,6 +257,39 @@ static int i40e_put_lump(struct
> i40e_lump_tracking *pile, u16 index, u16 id)
>  	return count;
>  }
>  
> +/**
> + * i40e_max_lump_qp - find a biggest size of lump available in
> qp_pile
> + * @pf: pointer to private device data structure
> + *
> + * Returns the max size of lump in a qp_pile, or negative for error
> + */
> +int i40e_max_lump_qp(struct i40e_pf *pf)
> +{
> +        struct i40e_lump_tracking *pile = pf->qp_pile;

Please run checkpatch and fix the reported indent issues. This patch is
full of these:

ERROR: code indent should use tabs where possible
#130: FILE: drivers/net/ethernet/intel/i40e/i40e_main.c:268:
+        struct i40e_lump_tracking *pile = pf->qp_pile;$

WARNING: please, no spaces at the start of a line
#130: FILE: drivers/net/ethernet/intel/i40e/i40e_main.c:268:
+        struct i40e_lump_tracking *pile = pf->qp_pile;$

<snip>

> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -2616,6 +2616,116 @@ error_param:
>  				       aq_ret);
>  }
>  
> +/**
> + * i40e_find_enough_vf_queues - find enough VF queues
> + * @vf: pointer to the VF info
> + * @needed: the number of items needed
> + *
> + * Returns the base item index of the queue, or negative for error
> + **/
> +static int i40e_find_enough_vf_queues(struct i40e_vf *vf, u16
> needed)
> +{
> +	struct i40e_pf *pf = vf->pf;
> +	struct i40e_vsi *vsi = pf->vsi[vf->lan_vsi_idx];
> +	struct i40e_lump_tracking *pile;
> +	u16 cur_queues, more;
> +	int i, j;
> +
> +	cur_queues = vsi->alloc_queue_pairs;
> +
> +	/* if current number of allocated queues is enough */
> +	if (cur_queues >= needed)
> +		return vsi->base_queue;
> +
> +	pile = pf->qp_pile;
> +	if (cur_queues > 0) {
> +		/*
> +		 * if number of allocated queues is non-zero, just
> check if
> +		 * there are enough queues behind the allocated queues
> +		 * for more.
> +		 */

WARNING: networking block comments don't use an empty /* line, use /*
Comment...
#190: FILE: drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2643:
+               /*
+                * if number of allocated queues is non-zero, just
check if


> +		more = needed - cur_queues;
> +		for (i = vsi->base_queue + cur_queues;
> +			i < pile->num_entries; i++) {
> +			if (pile->list[i] & I40E_PILE_VALID_BIT)
> +				break;
> +
> +			/* there are enough queues */
> +			if (more-- == 1)
> +				return vsi->base_queue;
> +		}
> +		/* start the linear search with that queue behind */
> +		i++;
> +	} else {
> +		/* start the linear search with an imperfect hint */
> +		i = pile->search_hint;
> +	}
> +
> +	while (i < pile->num_entries) {
> +		/* skip already allocated entries */
> +		if (pile->list[i] & I40E_PILE_VALID_BIT) {
> +			i++;
> +			continue;
> +		}
