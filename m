From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 5 Aug 2021 08:51:07 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: don't remove
 netdev->dev_addr from uc sync list
In-Reply-To: <20210728203457.325482-1-brett.creeley@intel.com>
References: <20210728203457.325482-1-brett.creeley@intel.com>
Message-ID: <5a641af5-e3fc-3b7c-6ddd-ef25e3f4a1ad@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Brett,


Am 28.07.21 um 22:34 schrieb Brett Creeley:
> In some circumstances, such as with bridging, it's possible that the
> stack will add the device's own MAC address to its unicast address list.
> 
> If, later, the stack deletes this address, the driver will receive a
> request to remove this address.
> 
> The driver stores its current MAC address as part of the VSI MAC filter
> list instead of separately. So, this causes a problem when the device's
> MAC address is deleted unexpectedly, which results in traffic failure
> in some cases.
> 
> Fix this by making sure to not delete the netdev->dev_addr during
> MAC address sync.

Is it easy to reproduce?

> There is a possibility of a race condition between .set_mac and
> .set_rx_mode. Fix this by calling netif_addr_lock_bh() and
> netif_addr_unlock_bh() on the device's netdev when the netdev->dev_addr
> is going to be updated in .set_mac.
> 
> Also, change the netdev_warn() to netdev_dbg() when the device is
> already using the requested mac in .set_mac. The dev_warn() was causing
> a lot of unnecessary noise when configuring/unconfiguring bridging and
> provides no benefit.
> 
> Lastly, instead of using memcpy() to save the netdev->dev_addr, use
> ether_addr_copy() in .set_mac.

It?d be great, if you split the three items out into separate patches, 
and submit it in a patch series.


Kind regards,

Paul


> Fixes: e94d44786693 ("ice: Implement filter sync, NDO operations and bump version")
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 25 +++++++++++++++--------
>   1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index ef8d1815af56..259d73e353bb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -191,6 +191,14 @@ static int ice_add_mac_to_unsync_list(struct net_device *netdev, const u8 *addr)
>   	struct ice_netdev_priv *np = netdev_priv(netdev);
>   	struct ice_vsi *vsi = np->vsi;
>   
> +	/* Under some circumstances, we might receive a request to delete our
> +	 * own device address from our uc list. Because we store the device
> +	 * address in the VSI's MAC filter list, we need to ignore such
> +	 * requests and not delete our device address from this list.
> +	 */
> +	if (ether_addr_equal(addr, netdev->dev_addr))
> +		return 0;
> +
>   	if (ice_fltr_add_mac_to_list(vsi, &vsi->tmp_unsync_list, addr,
>   				     ICE_FWD_TO_VSI))
>   		return -EINVAL;
> @@ -5119,7 +5127,7 @@ static int ice_set_mac_address(struct net_device *netdev, void *pi)
>   		return -EADDRNOTAVAIL;
>   
>   	if (ether_addr_equal(netdev->dev_addr, mac)) {
> -		netdev_warn(netdev, "already using mac %pM\n", mac);
> +		netdev_dbg(netdev, "already using mac %pM\n", mac);
>   		return 0;
>   	}
>   
> @@ -5130,6 +5138,7 @@ static int ice_set_mac_address(struct net_device *netdev, void *pi)
>   		return -EBUSY;
>   	}
>   
> +	netif_addr_lock_bh(netdev);
>   	/* Clean up old MAC filter. Not an error if old filter doesn't exist */
>   	status = ice_fltr_remove_mac(vsi, netdev->dev_addr, ICE_FWD_TO_VSI);
>   	if (status && status != ICE_ERR_DOES_NOT_EXIST) {
> @@ -5139,30 +5148,28 @@ static int ice_set_mac_address(struct net_device *netdev, void *pi)
>   
>   	/* Add filter for new MAC. If filter exists, return success */
>   	status = ice_fltr_add_mac(vsi, mac, ICE_FWD_TO_VSI);
> -	if (status == ICE_ERR_ALREADY_EXISTS) {
> +	if (status == ICE_ERR_ALREADY_EXISTS)
>   		/* Although this MAC filter is already present in hardware it's
>   		 * possible in some cases (e.g. bonding) that dev_addr was
>   		 * modified outside of the driver and needs to be restored back
>   		 * to this value.
>   		 */
> -		memcpy(netdev->dev_addr, mac, netdev->addr_len);
>   		netdev_dbg(netdev, "filter for MAC %pM already exists\n", mac);
> -		return 0;
> -	}
> -
> -	/* error if the new filter addition failed */
> -	if (status)
> +	else if (status)
> +		/* error if the new filter addition failed */
>   		err = -EADDRNOTAVAIL;
>   
>   err_update_filters:
>   	if (err) {
>   		netdev_err(netdev, "can't set MAC %pM. filter update failed\n",
>   			   mac);
> +		netif_addr_unlock_bh(netdev);
>   		return err;
>   	}
>   
>   	/* change the netdev's MAC address */
> -	memcpy(netdev->dev_addr, mac, netdev->addr_len);
> +	ether_addr_copy(netdev->dev_addr, mac);
> +	netif_addr_unlock_bh(netdev);
>   	netdev_dbg(vsi->netdev, "updated MAC address to %pM\n",
>   		   netdev->dev_addr);
>   
> 
