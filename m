From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 23 Jul 2018 10:54:42 -0700
Subject: [Intel-wired-lan] [RFC 05/13] ice: Refactor switch rule
 management structures and functions
In-Reply-To: <20180720205353.13296-6-anirudh.venkataramanan@intel.com>
References: <20180720205353.13296-1-anirudh.venkataramanan@intel.com>
 <20180720205353.13296-6-anirudh.venkataramanan@intel.com>
Message-ID: <b18032ce-4e58-a5df-0935-371fa1ea0573@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/20/2018 1:53 PM, Anirudh Venkataramanan wrote:
> This patch is an adaptation of the work originally done by Grishma
> Kotecha <grishma.kotecha@intel.com> that in summary refactors the
> switch filtering logic in the driver. More specifically,
>   - Update the recipe structure to also store list of rules
>   - Update the existing code for recipes like mac, vlan, ethtype etc to
>     use list head that is attached to switch recipe structure
>   - Add a common function to search for a rule entry and add a new rule
>     entry. Update the code to use this new function.
>   - Refactor the rem_handle_vsi_list function to simplify the logic
> 
> Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> ---

[...]

> @@ -1822,42 +1766,40 @@ ice_remove_vsi_lkup_fltr(struct ice_hw *hw, u16 vsi_id,
>   	struct ice_switch_info *sw = hw->switch_info;
>   	struct ice_fltr_list_entry *fm_entry;
>   	struct list_head remove_list_head;
> +	struct list_head *rule_head;
>   	struct ice_fltr_list_entry *tmp;
> +	struct mutex *rule_lock;	/* Lock to protect filter rule list */
>   	enum ice_status status;
>   
>   	INIT_LIST_HEAD(&remove_list_head);
> +	rule_lock = &sw->recp_list[ICE_SW_LKUP_MAC].filt_rule_lock;
> +	rule_head = &sw->recp_list[ICE_SW_LKUP_MAC].filt_rules;
> +	mutex_lock(rule_lock);
> +	status = ice_add_to_vsi_fltr_list(hw, vsi_id, rule_head,
> +					  &remove_list_head);
> +	mutex_unlock(rule_lock);
> +	if (status)
> +		goto free_fltr_list;
> +
>   	switch (lkup) {
>   	case ICE_SW_LKUP_MAC:
> -		mutex_lock(&sw->mac_list_lock);
> -		status = ice_add_to_vsi_fltr_list(hw, vsi_id,
> -						  &sw->mac_list_head,
> -						  &remove_list_head);
> -		mutex_unlock(&sw->mac_list_lock);
> -		if (!status) {
> -			ice_remove_mac(hw, &remove_list_head);
> -			goto free_fltr_list;
> -		}
> +		ice_remove_mac(hw, &remove_list_head);
>   		break;
>   	case ICE_SW_LKUP_VLAN:
> -		mutex_lock(&sw->vlan_list_lock);
> -		status = ice_add_to_vsi_fltr_list(hw, vsi_id,
> -						  &sw->vlan_list_head,
> -						  &remove_list_head);
> -		mutex_unlock(&sw->vlan_list_lock);
> -		if (!status) {
> -			ice_remove_vlan(hw, &remove_list_head);
> -			goto free_fltr_list;
> -		}
> +		ice_remove_vlan(hw, &remove_list_head);
>   		break;
>   	case ICE_SW_LKUP_MAC_VLAN:
>   	case ICE_SW_LKUP_ETHERTYPE:
>   	case ICE_SW_LKUP_ETHERTYPE_MAC:
>   	case ICE_SW_LKUP_PROMISC:
> -	case ICE_SW_LKUP_PROMISC_VLAN:
>   	case ICE_SW_LKUP_DFLT:
>   		ice_debug(hw, ICE_DBG_SW,
>   			  "Remove filters for this lookup type hasn't been implemented yet\n");

You should put the lookup type number in this message to make it a 
little easier to debug and know what got you here.

>   		break;
> +	case ICE_SW_LKUP_PROMISC_VLAN:
> +	case ICE_SW_LKUP_LAST:

add a "default:" label to catch any unexpected types

> +		ice_debug(hw, ICE_DBG_SW, "Unsupported lookup type\n");

Add lookup type number that got you here.

> +		break;
>   	}
>   
>   	return;
