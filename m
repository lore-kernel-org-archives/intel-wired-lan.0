From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 8 Mar 2018 16:28:53 -0800
Subject: [Intel-wired-lan] [S87 v5 2/7] i40e: Cleanup
 i40e_vlan_rx_register
In-Reply-To: <20180308225211.12254-2-jeffrey.t.kirsher@intel.com>
References: <20180308225211.12254-1-jeffrey.t.kirsher@intel.com>
 <20180308225211.12254-2-jeffrey.t.kirsher@intel.com>
Message-ID: <502107a1-d3e8-2d54-c427-574310c137aa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/8/2018 2:52 PM, Jeff Kirsher wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We used to use the function i40e_vlan_rx_register as a way to hook
> into the now defunct .ndo_vlan_rx_register netdev hook. This was
> removed but we kept the function around because we still used it
> internally to control enabling or disabling of VLAN stripping.
> 
> As pointed out in upstream review, VLAN stripping is only used in a
> single location and the previous function is quite small, just inline
> it into i40e_restore_vlan() rather than carrying the function
> separately.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 21 ++++-----------------
>   1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 4b34bbc83b99..183c8b84b7ea 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -2719,22 +2719,6 @@ void i40e_vlan_stripping_disable(struct i40e_vsi *vsi)
>   	}
>   }
>   
> -/**
> - * i40e_vlan_rx_register - Setup or shutdown vlan offload
> - * @netdev: network interface to be adjusted
> - * @features: netdev features to test if VLAN offload is enabled or not
> - **/
> -static void i40e_vlan_rx_register(struct net_device *netdev, u32 features)
> -{
> -	struct i40e_netdev_priv *np = netdev_priv(netdev);
> -	struct i40e_vsi *vsi = np->vsi;
> -
> -	if (features & NETIF_F_HW_VLAN_CTAG_RX)
> -		i40e_vlan_stripping_enable(vsi);
> -	else
> -		i40e_vlan_stripping_disable(vsi);
> -}
> -
>   /**
>    * i40e_add_vlan_all_mac - Add a MAC/VLAN filter for each existing MAC address
>    * @vsi: the vsi being configured
> @@ -2910,7 +2894,10 @@ static void i40e_restore_vlan(struct i40e_vsi *vsi)
>   	if (!vsi->netdev)
>   		return;
>   
> -	i40e_vlan_rx_register(vsi->netdev, vsi->netdev->features);
> +	if (vsi->netdev->features & NETIF_F_HW_VLAN_CTAG_RX)
> +		i40e_vlan_stripping_enable(vsi);
> +	else
> +		i40e_vlan_stripping_disable(vsi);

That's better - thanks.
sln

>   
>   	for_each_set_bit(vid, vsi->active_vlans, VLAN_N_VID)
>   		i40e_vlan_rx_add_vid(vsi->netdev, htons(ETH_P_8021Q),
> 
