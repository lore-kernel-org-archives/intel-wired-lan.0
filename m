From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 7 Mar 2018 21:55:28 -0800
Subject: [Intel-wired-lan] [next PATCH S87-V4 3/7] i40e: Fix permission
 check for VF MAC filters
In-Reply-To: <20180307141725.79649-3-alice.michael@intel.com>
References: <20180307141725.79649-1-alice.michael@intel.com>
 <20180307141725.79649-3-alice.michael@intel.com>
Message-ID: <aa1889ff-afde-4417-ec97-014724470e18@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/7/2018 6:17 AM, Alice Michael wrote:
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> When VF requests adding of MAC filters the checking is done against number
> of already present MAC filters not adding them at the same time. It makes
> it possible to add a bunch of filters at once possibly exceeding
> acceptable limit of I40E_VC_MAX_MAC_ADDR_PER_VF filters.
> 
> This happens because when checking vf->num_mac, we do not check how many
> filters are being requested at once. Modify the check function to ensure
> that it knows how many filters are being requested. This allows the
> check to ensure that the total number of filters in a single request
> does not cause us to go over the limit.
> 
> Additionally, move the check to within the lock to ensure that the
> vf->num_mac is checked while holding the lock to maintain consistency.
> We could have simply moved the call to i40e_vf_check_permission to
> within the loop, but this could cause a request to be non-atomic, and
> add some but not all the addresses, while reporting an error code. We
> want to avoid this behavior so that users are not confused about which
> filters have or have not been added.
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c        | 18 ++---
>   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 79 ++++++++++++++--------
>   2 files changed, 55 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 31938b2..183c8b8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -2884,19 +2884,6 @@ static int i40e_vlan_rx_kill_vid(struct net_device *netdev,
>   }
>   
>   /**
> - * i40e_setup_vlan_stripping - Enable or disable VLAN stripping
> - * @vsi: the vsi being configured
> - * @features: netdevice feature flags
> - **/
> -static void i40e_setup_vlan_stripping(struct i40e_vsi *vsi, u32 features)
> -{
> -	if (features & NETIF_F_HW_VLAN_CTAG_RX)
> -		i40e_vlan_stripping_enable(vsi);
> -	else
> -		i40e_vlan_stripping_disable(vsi);
> -}
> -
> -/**
>    * i40e_restore_vlan - Reinstate vlans when vsi/netdev comes back up
>    * @vsi: the vsi being brought back up
>    **/
> @@ -2907,7 +2894,10 @@ static void i40e_restore_vlan(struct i40e_vsi *vsi)
>   	if (!vsi->netdev)
>   		return;
>   
> -	i40e_setup_vlan_stripping(vsi, vsi->netdev->features);
> +	if (vsi->netdev->features & NETIF_F_HW_VLAN_CTAG_RX)
> +		i40e_vlan_stripping_enable(vsi);
> +	else
> +		i40e_vlan_stripping_disable(vsi);

Oh, here's Jake's change... probably doesn't belong here.
sln

>   
>   	for_each_set_bit(vid, vsi->active_vlans, VLAN_N_VID)
>   		i40e_vlan_rx_add_vid(vsi->netdev, htons(ETH_P_8021Q),
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 8559c09..8d9a456 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -2369,25 +2369,47 @@ static int i40e_vc_get_stats_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
>   /**
>    * i40e_check_vf_permission
>    * @vf: pointer to the VF info
> - * @macaddr: pointer to the MAC Address being checked
> + * @al: MAC address list from virtchnl
>    *
> - * Check if the VF has permission to add or delete unicast MAC address
> - * filters and return error code -EPERM if not.  Then check if the
> - * address filter requested is broadcast or zero and if so return
> - * an invalid MAC address error code.
> + * Check that the given list of MAC addresses is allowed. Will return -EPERM
> + * if any address in the list is not valid. Checks the following conditions:
> + *
> + * 1) broadcast and zero addresses are never valid
> + * 2) unicast addresses are not allowed if the VMM has administratively set
> + *    the VF MAC address, unless the VF is marked as privileged.
> + * 3) There is enough space to add all the addresses.
> + *
> + * Note that to guarantee consistency, it is expected this function be called
> + * while holding the mac_filter_hash_lock, as otherwise the current number of
> + * addresses might not be accurate.
>    **/
> -static inline int i40e_check_vf_permission(struct i40e_vf *vf, u8 *macaddr)
> +static inline int i40e_check_vf_permission(struct i40e_vf *vf,
> +					   struct virtchnl_ether_addr_list *al)
>   {
>   	struct i40e_pf *pf = vf->pf;
> -	int ret = 0;
> +	int i;
> +
> +	/* If this VF is not privileged, then we can't add more than a limited
> +	 * number of addresses. Check to make sure that the additions do not
> +	 * push us over the limit.
> +	 */
> +	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) &&
> +	    (vf->num_mac + al->num_elements) > I40E_VC_MAX_MAC_ADDR_PER_VF) {
> +		dev_err(&pf->pdev->dev,
> +			"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
> +		return -EPERM;
> +	}
> +
> +	for (i = 0; i < al->num_elements; i++) {
> +		u8 *addr = al->list[i].addr;
> +
> +		if (is_broadcast_ether_addr(addr) ||
> +		    is_zero_ether_addr(addr)) {
> +			dev_err(&pf->pdev->dev, "invalid VF MAC addr %pM\n",
> +				addr);
> +			return I40E_ERR_INVALID_MAC_ADDR;
> +		}
>   
> -	if (is_broadcast_ether_addr(macaddr) ||
> -		   is_zero_ether_addr(macaddr)) {
> -		dev_err(&pf->pdev->dev, "invalid VF MAC addr %pM\n", macaddr);
> -		ret = I40E_ERR_INVALID_MAC_ADDR;
> -	} else if (vf->pf_set_mac && !is_multicast_ether_addr(macaddr) &&
> -		   !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) &&
> -		   !ether_addr_equal(macaddr, vf->default_lan_addr.addr)) {
>   		/* If the host VMM administrator has set the VF MAC address
>   		 * administratively via the ndo_set_vf_mac command then deny
>   		 * permission to the VF to add or delete unicast MAC addresses.
> @@ -2395,16 +2417,16 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf, u8 *macaddr)
>   		 * The VF may request to set the MAC address filter already
>   		 * assigned to it so do not return an error in that case.
>   		 */
> -		dev_err(&pf->pdev->dev,
> -			"VF attempting to override administratively set MAC address, reload the VF driver to resume normal operation\n");
> -		ret = -EPERM;
> -	} else if ((vf->num_mac >= I40E_VC_MAX_MAC_ADDR_PER_VF) &&
> -		   !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
> -		dev_err(&pf->pdev->dev,
> -			"VF is not trusted, switch the VF to trusted to add more functionality\n");
> -		ret = -EPERM;
> +		if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) &&
> +		    !is_multicast_ether_addr(addr) && vf->pf_set_mac &&
> +		    !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
> +			dev_err(&pf->pdev->dev,
> +				"VF attempting to override administratively set MAC address, reload the VF driver to resume normal operation\n");
> +			return -EPERM;
> +		}
>   	}
> -	return ret;
> +
> +	return 0;
>   }
>   
>   /**
> @@ -2431,11 +2453,6 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
>   		goto error_param;
>   	}
>   
> -	for (i = 0; i < al->num_elements; i++) {
> -		ret = i40e_check_vf_permission(vf, al->list[i].addr);
> -		if (ret)
> -			goto error_param;
> -	}
>   	vsi = pf->vsi[vf->lan_vsi_idx];
>   
>   	/* Lock once, because all function inside for loop accesses VSI's
> @@ -2443,6 +2460,12 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
>   	 */
>   	spin_lock_bh(&vsi->mac_filter_hash_lock);
>   
> +	ret = i40e_check_vf_permission(vf, al);
> +	if (ret) {
> +		spin_unlock_bh(&vsi->mac_filter_hash_lock);
> +		goto error_param;
> +	}
> +
>   	/* add new addresses to the list */
>   	for (i = 0; i < al->num_elements; i++) {
>   		struct i40e_mac_filter *f;
> 
