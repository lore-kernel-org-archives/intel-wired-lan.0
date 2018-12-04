From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 4 Dec 2018 18:44:53 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: fix mac filter delete when
 setting mac address
In-Reply-To: <20181204141852.13893-1-sassmann@kpanic.de>
References: <20181204141852.13893-1-sassmann@kpanic.de>
Message-ID: <02874ECE860811409154E81DA85FBB588D52C543@ORSMSX122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Stefan Assmann [mailto:sassmann at kpanic.de]
> Sent: Tuesday, December 04, 2018 6:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> sassmann at kpanic.de
> Subject: [PATCH] i40e: fix mac filter delete when setting mac address
> 
> A previous commit moved the ether_addr_copy() in i40e_set_mac() before
> the mac filter del/add to avoid a race. However it wasn't taken into
> account that this alters the mac address being handed to
> i40e_del_mac_filter().

Woops!

> 
> Also changed i40e_add_mac_filter() to operate on netdev->dev_addr,
> hopefully that makes the code easier to read.
> 

Makes sense.

> Fixes: 458867b2ca0c ("i40e: don't remove netdev->dev_addr when syncing uc list")
> 

Good catch. This looks correct to me.

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 6d5b13f69dec..901ef799d2ad 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -1546,17 +1546,17 @@ static int i40e_set_mac(struct net_device *netdev, void
> *p)
>  		netdev_info(netdev, "set new mac address %pM\n", addr->sa_data);
> 
>  	/* Copy the address first, so that we avoid a possible race with
> -	 * .set_rx_mode(). If we copy after changing the address in the filter
> -	 * list, we might open ourselves to a narrow race window where
> -	 * .set_rx_mode could delete our dev_addr filter and prevent traffic
> -	 * from passing.
> +	 * .set_rx_mode().
> +	 * - Remove old address from MAC filter
> +	 * - Copy new address
> +	 * - Add new address to MAC filter
>  	 */
> -	ether_addr_copy(netdev->dev_addr, addr->sa_data);
> -
>  	spin_lock_bh(&vsi->mac_filter_hash_lock);
>  	i40e_del_mac_filter(vsi, netdev->dev_addr);
> -	i40e_add_mac_filter(vsi, addr->sa_data);
> +	ether_addr_copy(netdev->dev_addr, addr->sa_data);
> +	i40e_add_mac_filter(vsi, netdev->dev_addr);
>  	spin_unlock_bh(&vsi->mac_filter_hash_lock);
> +
>  	if (vsi->type == I40E_VSI_MAIN) {
>  		i40e_status ret;
> 
> --
> 2.19.2

