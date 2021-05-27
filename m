From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Thu, 27 May 2021 17:27:06 +0000
Subject: [Intel-wired-lan] [PATCH S53 03/15] ice: Save VF's MAC across
 reboot
In-Reply-To: <20200917201347.81570-3-anthony.l.nguyen@intel.com>
References: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
 <20200917201347.81570-3-anthony.l.nguyen@intel.com>
Message-ID: <CY4PR11MB1576A358E7CCD6D2ECED4CA7AB239@CY4PR11MB1576.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: czwartek, 17 wrze?nia 2020 22:14
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S53 03/15] ice: Save VF's MAC across
> reboot
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> If a VM reboots and/or VF driver is unloaded, its cached hardware MAC
> address (hw_lan_addr.addr) is cleared in some cases. If the VF is trusted,
> then the PF driver allows the VF to clear its old MAC address even if this MAC
> was configured by a host administrator. If the VF is untrusted, then the PF
> driver allows the VF to clear its old MAC address only if the host admin did
> not set it.
> 
> For the trusted VF case, this is unexpected and will cause issues because the
> host configured MAC (i.e. via XML) will be cleared on VM reboot. For the
> untrusted VF case, this is done to be consistent and it will allow the VF to
> keep the same MAC across VM reboot.
> 
> Fix this by introducing dev_lan_addr to the VF structure. This will be the VF's
> MAC address when it's up and running and in most cases will be the same as
> the hw_lan_addr. However, to address the VM reboot and unload/reload
> problem, the driver will never allow the hw_lan_addr to be cleared via
> VIRTCHNL_OP_DEL_ETH_ADDR. When the VF's MAC is changed, the
> dev_lan_addr and hw_lan_addr will always be updated with the same value.
> The only ways the VF's MAC can change are the following:
> 
> - Set the VF's MAC administratively on the host via iproute2.
> - If the VF is trusted and changes/sets its own MAC.
> - If the VF is untrusted and the host has not set the MAC via iproute2.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 45 ++++++++++++-------
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  1 +
>  2 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> index 627c4e36c1bd..ed5cca603949 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> @@ -647,6 +647,8 @@ static int ice_vf_rebuild_host_mac_cfg(struct ice_vf
> *vf)
>  			return ice_status_to_errno(status);
>  		}
>  		vf->num_mac++;
> +
> +		ether_addr_copy(vf->dev_lan_addr.addr, vf-
> >hw_lan_addr.addr);
>  	}
> 
>  	return 0;
> @@ -3068,17 +3070,19 @@ ice_vfhw_mac_add(struct ice_vf *vf, struct
> virtchnl_ether_addr *vc_ether_addr)
>  	if (!is_valid_ether_addr(mac_addr))
>  		return;
> 
> -	/* only allow legacy VF drivers to set the hardware MAC if it is zero
> -	 * and allow new VF drivers to set the hardware MAC if the type was
> -	 * correctly specified over VIRTCHNL
> +	/* only allow legacy VF drivers to set the device and hardware MAC if
> it
> +	 * is zero and allow new VF drivers to set the hardware MAC if the
> type
> +	 * was correctly specified over VIRTCHNL
>  	 */
>  	if ((ice_is_vc_addr_legacy(vc_ether_addr) &&
>  	     is_zero_ether_addr(vf->hw_lan_addr.addr)) ||
> -	    ice_is_vc_addr_primary(vc_ether_addr))
> +	    ice_is_vc_addr_primary(vc_ether_addr)) {
> +		ether_addr_copy(vf->dev_lan_addr.addr, mac_addr);
>  		ether_addr_copy(vf->hw_lan_addr.addr, mac_addr);
> +	}
> 
> -	/* hardware MAC is already set, but its possible that the VF driver
> sent
> -	 * the VIRTCHNL_OP_ADD_ETH_ADDR message before the
> +	/* hardware and device MACs are already set, but its possible that
> the
> +	 * VF driver sent the VIRTCHNL_OP_ADD_ETH_ADDR message
> before the
>  	 * VIRTCHNL_OP_DEL_ETH_ADDR when trying to update its MAC, so
> save it
>  	 * away for the legacy VF driver case as it will be updated in the
>  	 * delete flow for this case
> @@ -3104,8 +3108,8 @@ ice_vc_add_mac_addr(struct ice_vf *vf, struct
> ice_vsi *vsi,
>  	u8 *mac_addr = vc_ether_addr->addr;
>  	enum ice_status status;
> 
> -	/* default unicast MAC already added */
> -	if (ether_addr_equal(mac_addr, vf->hw_lan_addr.addr))
> +	/* device MAC already added */
> +	if (ether_addr_equal(mac_addr, vf->dev_lan_addr.addr))
>  		return 0;
> 
>  	if (is_unicast_ether_addr(mac_addr) &&
> !ice_can_vf_change_mac(vf)) { @@ -3153,19 +3157,26 @@
> ice_vfhw_mac_del(struct ice_vf *vf, struct virtchnl_ether_addr
> *vc_ether_addr)
>  	u8 *mac_addr = vc_ether_addr->addr;
> 
>  	if (!is_valid_ether_addr(mac_addr) ||
> -	    !ether_addr_equal(vf->hw_lan_addr.addr, mac_addr))
> +	    !ether_addr_equal(vf->dev_lan_addr.addr, mac_addr))
>  		return;
> 
> -	/* allow the hardware MAC to be repopulated in the add flow */
> -	eth_zero_addr(vf->hw_lan_addr.addr);
> +	/* allow the device MAC to be repopulated in the add flow and don't
> +	 * clear the hardware MAC (i.e. hw_lan_addr.addr) here as that is
> meant
> +	 * to be persistent on VM reboot and across driver unload/load,
> which
> +	 * won't work if we clear the hardware MAC here
> +	 */
> +	eth_zero_addr(vf->dev_lan_addr.addr);
> 
>  	/* only update cached hardware MAC for legacy VF drivers on delete
>  	 * because we cannot guarantee order/type of MAC from the VF
> driver
>  	 */
>  	if (ice_is_vc_addr_legacy(vc_ether_addr) &&
> -	    !ice_is_legacy_umac_expired(&vf->legacy_last_added_umac))
> +	    !ice_is_legacy_umac_expired(&vf->legacy_last_added_umac)) {
> +		ether_addr_copy(vf->dev_lan_addr.addr,
> +				vf->legacy_last_added_umac.addr);
>  		ether_addr_copy(vf->hw_lan_addr.addr,
>  				vf->legacy_last_added_umac.addr);
> +	}
>  }
> 
>  /**
> @@ -3183,7 +3194,7 @@ ice_vc_del_mac_addr(struct ice_vf *vf, struct
> ice_vsi *vsi,
>  	enum ice_status status;
> 
>  	if (!ice_can_vf_change_mac(vf) &&
> -	    ether_addr_equal(mac_addr, vf->hw_lan_addr.addr))
> +	    ether_addr_equal(vf->dev_lan_addr.addr, mac_addr))
>  		return 0;
> 
>  	status = ice_fltr_remove_mac(vsi, mac_addr, ICE_FWD_TO_VSI);
> @@ -3963,7 +3974,8 @@ int ice_set_vf_mac(struct net_device *netdev, int
> vf_id, u8 *mac)
> 
>  	vf = &pf->vf[vf_id];
>  	/* nothing left to do, unicast MAC already set */
> -	if (ether_addr_equal(vf->hw_lan_addr.addr, mac))
> +	if (ether_addr_equal(vf->dev_lan_addr.addr, mac) &&
> +	    ether_addr_equal(vf->hw_lan_addr.addr, mac))
>  		return 0;
> 
>  	ret = ice_check_vf_ready_for_cfg(vf);
> @@ -3979,6 +3991,7 @@ int ice_set_vf_mac(struct net_device *netdev, int
> vf_id, u8 *mac)
>  	/* VF is notified of its new MAC via the PF's response to the
>  	 * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has
> been reset
>  	 */
> +	ether_addr_copy(vf->dev_lan_addr.addr, mac);
>  	ether_addr_copy(vf->hw_lan_addr.addr, mac);
>  	if (is_zero_ether_addr(mac)) {
>  		/* VF will send VIRTCHNL_OP_ADD_ETH_ADDR message
> with its MAC */ @@ -4132,7 +4145,7 @@ void
> ice_print_vf_rx_mdd_event(struct ice_vf *vf)
> 
>  	dev_info(dev, "%d Rx Malicious Driver Detection events detected on
> PF %d VF %d MAC %pM. mdd-auto-reset-vfs=%s\n",
>  		 vf->mdd_rx_events.count, pf->hw.pf_id, vf->vf_id,
> -		 vf->hw_lan_addr.addr,
> +		 vf->dev_lan_addr.addr,
>  		 test_bit(ICE_FLAG_MDD_AUTO_RESET_VF, pf->flags)
>  			  ? "on" : "off");
>  }
> @@ -4176,7 +4189,7 @@ void ice_print_vfs_mdd_events(struct ice_pf *pf)
> 
>  			dev_info(dev, "%d Tx Malicious Driver Detection
> events detected on PF %d VF %d MAC %pM.\n",
>  				 vf->mdd_tx_events.count, hw->pf_id, i,
> -				 vf->hw_lan_addr.addr);
> +				 vf->dev_lan_addr.addr);
>  		}
>  	}
>  }
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
> index f440b290e02e..f379d13acc97 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
> @@ -80,6 +80,7 @@ struct ice_vf {
>  	struct ice_sw *vf_sw_id;	/* switch ID the VF VSIs connect to */
>  	struct virtchnl_version_info vf_ver;
>  	u32 driver_caps;		/* reported by VF driver */
> +	struct virtchnl_ether_addr dev_lan_addr;
>  	struct virtchnl_ether_addr hw_lan_addr;
>  	struct ice_time_mac legacy_last_added_umac;
>  	DECLARE_BITMAP(txq_ena, ICE_MAX_RSS_QS_PER_VF);
> --
> 2.20.1
> 

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
