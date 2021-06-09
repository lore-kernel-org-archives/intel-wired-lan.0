From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 9 Jun 2021 18:09:04 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Add placeholder for
 ndo set VLANs
In-Reply-To: <20210607064338.252336-1-karen.sornek@intel.com>
References: <20210607064338.252336-1-karen.sornek@intel.com>
Message-ID: <1f14c5099d28d4f606d1ebfd3a9af4955bb5daa6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-06-07 at 08:43 +0200, Karen Sornek wrote:
> VLANs set by ndo, were not accounted.
> Implement placeholder, by which driver can account VLANs set by
> ndo. Ensure that once PF changes trunk, every guest filter
> is removed from the list 'vm_vlan_list'.
> Implement logic for deletion/addition of guest(from VM) filters.
> 
> Signed-off-by: Przemyslaw Patynowski <
> przemyslawx.patynowski at intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 131
> ++++++++++++++++--
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |   9 ++
>  2 files changed, 130 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index edfdce5f6..0fba4f1b4 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -986,6 +986,81 @@ static void i40e_disable_vf_mappings(struct
> i40e_vf *vf)
>  	i40e_flush(hw);
>  }
>  
> +/**
> + * i40e_add_vmvlan_to_list
> + * @vf: pointer to the VF info
> + * @vfl:  pointer to the VF VLAN tag filters list
> + * @vlan_idx: vlan_id index in VLAN tag filters list
> + *
> + * add VLAN tag into the VLAN list for VM
> + **/
> +static i40e_status
> +i40e_add_vmvlan_to_list(struct i40e_vf *vf,
> +			struct virtchnl_vlan_filter_list *vfl,
> +			int vlan_idx)
> +{
> +	struct i40e_vm_vlan *vlan_elem;
> +
> +	vlan_elem = kzalloc(sizeof(*vlan_elem), GFP_KERNEL);
> +	if (!vlan_elem)
> +		return I40E_ERR_NO_MEMORY;
> +	vlan_elem->vlan = vfl->vlan_id[vlan_idx];
> +	vlan_elem->vsi_id = vfl->vsi_id;
> +	INIT_LIST_HEAD(&vlan_elem->list);
> +	vf->num_vlan++;
> +	list_add(&vlan_elem->list, &vf->vm_vlan_list);
> +	return I40E_SUCCESS;

Why are you returning i40e_status values here? I'm not see anything
preventing the use of the kernel error codes.

> +}
> +
> +/**
> + * i40e_del_vmvlan_from_list
> + * @vsi: pointer to the VSI structure
> + * @vf: pointer to the VF info
> + * @vlan: VLAN tag to be removed from the list
> + *
> + * delete VLAN tag from the VLAN list for VM
> + **/
> +static void i40e_del_vmvlan_from_list(struct i40e_vsi *vsi,
> +				      struct i40e_vf *vf, u16 vlan)
> +{
> +	struct i40e_vm_vlan *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp,
> +				 &vf->vm_vlan_list, list) {
> +		if (vlan == entry->vlan) {
> +			i40e_vsi_kill_vlan(vsi, vlan);
> +			vf->num_vlan--;
> +			list_del(&entry->list);
> +			kfree(entry);
> +			break;
> +		}
> +	}
> +}
> +
> +/**
> + * i40e_free_vmvlan_list
> + * @vsi: pointer to the VSI structure
> + * @vf: pointer to the VF info
> + *
> + * remove whole list of VLAN tags for VM
> + **/
> +static void i40e_free_vmvlan_list(struct i40e_vsi *vsi, struct
> i40e_vf *vf)
> +{
> +	struct i40e_vm_vlan *entry, *tmp;
> +
> +	if (list_empty(&vf->vm_vlan_list))
> +		return;
> +
> +	list_for_each_entry_safe(entry, tmp,
> +				 &vf->vm_vlan_list, list) {
> +		if (vsi)
> +			i40e_vsi_kill_vlan(vsi, entry->vlan);
> +		list_del(&entry->list);
> +		kfree(entry);
> +	}
> +	vf->num_vlan = 0;
> +}
> +
>  /**
>   * i40e_free_vf_res
>   * @vf: pointer to the VF info
> @@ -1061,6 +1136,10 @@ static void i40e_free_vf_res(struct i40e_vf
> *vf)
>  		wr32(hw, reg_idx, reg);
>  		i40e_flush(hw);
>  	}
> +
> +	i40e_free_vmvlan_list(NULL, vf);
> +
> +

extra newline

>  	/* reset some of the state variables keeping track of the
> resources */
>  	vf->num_queue_pairs = 0;
>  	clear_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states);
> @@ -1766,6 +1845,7 @@ int i40e_alloc_vfs(struct i40e_pf *pf, u16
> num_alloc_vfs)
>  
>  		set_bit(I40E_VF_STATE_PRE_ENABLE, &vfs[i].vf_states);
>  
> +		INIT_LIST_HEAD(&vfs[i].vm_vlan_list);
>  	}
>  	pf->num_alloc_vfs = num_alloc_vfs;
>  
> @@ -2787,6 +2867,28 @@ static inline int
> i40e_check_vf_permission(struct i40e_vf *vf,
>  	return 0;
>  }
>  
> +/**
> + * i40e_check_vf_vlan_cap
> + * @vf: pointer to the VF info
> + *
> + * Check if VF can add another VLAN filter.
> + */
> +static i40e_status
> +i40e_check_vf_vlan_cap(struct i40e_vf *vf)
> +{
> +        struct i40e_pf *pf = vf->pf;
> +
> +        if ((vf->num_vlan + 1 > I40E_VC_MAX_VLAN_PER_VF) &&
> +            !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) 
> {
> +                dev_err(&pf->pdev->dev,
> +                        "VF is not trusted, switch the VF to trusted
> to add more VLAN addresses\n");
> +
> +                return I40E_ERR_CONFIG;
> +        }
> +
> +        return I40E_SUCCESS;

Same question as above. Why i40e_status?

> +}
> +
>  /**
>   * i40e_vc_add_mac_addr_msg
>   * @vf: pointer to the VF info
> @@ -2944,10 +3046,11 @@ static int i40e_vc_add_vlan_msg(struct
> i40e_vf *vf, u8 *msg)
>  {
>  	struct virtchnl_vlan_filter_list *vfl =
>  	    (struct virtchnl_vlan_filter_list *)msg;
> +	i40e_status aq_ret = I40E_SUCCESS;
>  	struct i40e_pf *pf = vf->pf;
>  	struct i40e_vsi *vsi = NULL;
> -	i40e_status aq_ret = 0;

The convention has been to use 0 instead of I40E_SUCCESS. Is there a
reason for going away from this?

> -	int i;
> +	int ret;
> +	u16 i;
>  
>  	if ((vf->num_vlan >= I40E_VC_MAX_VLAN_PER_VF) &&
>  	    !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
> @@ -2976,12 +3079,19 @@ static int i40e_vc_add_vlan_msg(struct
> i40e_vf *vf, u8 *msg)
>  	}
>  
>  	i40e_vlan_stripping_enable(vsi);
> +
>  	for (i = 0; i < vfl->num_elements; i++) {
> -		/* add new VLAN filter */
> -		int ret = i40e_vsi_add_vlan(vsi, vfl->vlan_id[i]);
> -		if (!ret)
> -			vf->num_vlan++;
> +		aq_ret = i40e_check_vf_vlan_cap(vf);
> +		if (aq_ret)
> +			goto error_param;
> +
> +		ret = i40e_vsi_add_vlan(vsi, vfl->vlan_id[i]);
>  
> +		if (!ret && vfl->vlan_id[i]) {
> +			aq_ret = i40e_add_vmvlan_to_list(vf, vfl, i);
> +			if (aq_ret)
> +				goto error_param;
> +		}
>  		if (test_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states))
>  			i40e_aq_set_vsi_uc_promisc_on_vlan(&pf->hw,
> vsi->seid,
>  							   true,
> @@ -3015,10 +3125,10 @@ static int i40e_vc_remove_vlan_msg(struct
> i40e_vf *vf, u8 *msg)
>  {
>  	struct virtchnl_vlan_filter_list *vfl =
>  	    (struct virtchnl_vlan_filter_list *)msg;
> +	i40e_status aq_ret = I40E_SUCCESS;
>  	struct i40e_pf *pf = vf->pf;
>  	struct i40e_vsi *vsi = NULL;
> -	i40e_status aq_ret = 0;
> -	int i;
> +	u16 i;
>  
>  	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE) ||
>  	    !i40e_vc_isvalid_vsi_id(vf, vfl->vsi_id)) {
> @@ -3041,8 +3151,7 @@ static int i40e_vc_remove_vlan_msg(struct
> i40e_vf *vf, u8 *msg)
>  	}
>  
>  	for (i = 0; i < vfl->num_elements; i++) {
> -		i40e_vsi_kill_vlan(vsi, vfl->vlan_id[i]);
> -		vf->num_vlan--;
> +		i40e_del_vmvlan_from_list(vsi, vf, vfl->vlan_id[i]);
>  
>  		if (test_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states))
>  			i40e_aq_set_vsi_uc_promisc_on_vlan(&pf->hw,
> vsi->seid,
> @@ -4200,6 +4309,8 @@ int i40e_ndo_set_vf_mac(struct net_device
> *netdev, int vf_id, u8 *mac)
>  	}
>  	ether_addr_copy(vf->default_lan_addr.addr, mac);
>  
> +	i40e_free_vmvlan_list(NULL, vf);
> +
>  	if (is_zero_ether_addr(mac)) {
>  		vf->pf_set_mac = false;
>  		dev_info(&pf->pdev->dev, "Removing MAC on VF %d\n",
> vf_id);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> index 49575a640..6ba48b398 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> @@ -62,6 +62,13 @@ struct i40evf_channel {
>  	u64 max_tx_rate; /* bandwidth rate allocation for VSIs */
>  };
>  
> +/* used for VLAN list 'vm_vlan_list' by VM for trusted and untrusted
> VF */
> +struct i40e_vm_vlan {
> +	struct list_head list;
> +	s16 vlan;

Why signed? Can this have a negative value?

> +	u16 vsi_id;
> +};
> +
>  /* VF information structure */
>  struct i40e_vf {
>  	struct i40e_pf *pf;
> @@ -103,6 +110,8 @@ struct i40e_vf {
>  	bool spoofchk;
>  	u16 num_vlan;
>  
> +	/* VLAN list created by VM for trusted and untrusted VF */
> +	struct list_head vm_vlan_list;
>  	/* ADq related variables */
>  	bool adq_enabled; /* flag to enable adq */
>  	u8 num_tc;
