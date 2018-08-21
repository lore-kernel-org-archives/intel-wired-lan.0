From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 21 Aug 2018 19:29:27 +0000
Subject: [Intel-wired-lan] [next PATCH S95 05/12] i40evf: Change a VF
 mac without reloading the VF driver
In-Reply-To: <20180820151233.14629-5-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
 <20180820151233.14629-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2E968F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Setting the VF mac to something arbitrary works, however setting it back to 00:00:00:00:00:00 does NOT set it back to all zeroes, nor does it trigger random MAC generation (dmesg shows "removing MAC on VF 0" and the message to bring the interface down and back up, however dmesg does not report "invalid MAC address, using random" and "ip ad show"
 still shows the 00:11:22:33:44:55 MAC that was set. 

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 20, 2018 8:12 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Pawe? Jab?o?ski
> <"pawel.jablonski@intel.compawel.jablonski"@intel.com>; Pawe? Jab?o?ski
> <pawel.jablonski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S95 05/12] i40evf: Change a VF mac
> without reloading the VF driver
> 
> From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> <pawel.jablonski@intel.com>
> 
> Add possibility to change a VF mac address from host side without reloading
> the VF driver on the guest side. Without this patch it is not possible to change
> the VF mac because executing i40evf_virtchnl_completion function with
> VIRTCHNL_OP_GET_VF_RESOURCES opcode resets the VF mac address to
> previous value.
> 
> Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c  |  8 +++++---
> drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 11 +++++++++--
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index c6d24ea..f56c645 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -2458,7 +2458,7 @@ static inline int i40e_check_vf_permission(struct
> i40e_vf *vf,
>  		    !is_multicast_ether_addr(addr) && vf->pf_set_mac &&
>  		    !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
>  			dev_err(&pf->pdev->dev,
> -				"VF attempting to override administratively
> set MAC address, reload the VF driver to resume normal operation\n");
> +				"VF attempting to override administratively
> set MAC address, bring
> +down and up the VF interface to resume normal operation\n");
>  			return -EPERM;
>  		}
>  	}
> @@ -3873,9 +3873,11 @@ int i40e_ndo_set_vf_mac(struct net_device
> *netdev, int vf_id, u8 *mac)
>  			 mac, vf_id);
>  	}
> 
> -	/* Force the VF driver stop so it has to reload with new MAC address
> */
> +	/* Force the VF interface down so it has to bring up with new MAC
> +	 * address
> +	 */
>  	i40e_vc_disable_vf(vf);
> -	dev_info(&pf->pdev->dev, "Reload the VF driver to make this
> change effective.\n");
> +	dev_info(&pf->pdev->dev, "Bring down and up the VF interface to
> make
> +this change effective.\n");
> 
>  error_param:
>  	return ret;
> diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
> b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
> index 565677d..79b7be8 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
> @@ -1330,8 +1330,15 @@ void i40evf_virtchnl_completion(struct
> i40evf_adapter *adapter,
>  			  sizeof(struct virtchnl_vsi_resource);
>  		memcpy(adapter->vf_res, msg, min(msglen, len));
>  		i40e_vf_parse_hw_config(&adapter->hw, adapter->vf_res);
> -		/* restore current mac address */
> -		ether_addr_copy(adapter->hw.mac.addr, netdev-
> >dev_addr);
> +		if (is_zero_ether_addr(adapter->hw.mac.addr)) {
> +			/* restore current mac address */
> +			ether_addr_copy(adapter->hw.mac.addr, netdev-
> >dev_addr);
> +		} else {
> +			/* refresh current mac address if changed */
> +			ether_addr_copy(netdev->dev_addr, adapter-
> >hw.mac.addr);
> +			ether_addr_copy(netdev->perm_addr,
> +					adapter->hw.mac.addr);
> +		}
>  		i40evf_process_config(adapter);
>  		}
>  		break;
> --
> 2.9.5
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
