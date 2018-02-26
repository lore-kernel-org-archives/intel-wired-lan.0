From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 26 Feb 2018 09:51:36 -0800
Subject: [Intel-wired-lan] [next PATCH S87 V2 2/7] i40e: rename
 i40e_vlan_rx_register to i40e_setup_vlan_stripping
In-Reply-To: <20180226083311.52442-2-alice.michael@intel.com>
References: <20180226083311.52442-1-alice.michael@intel.com>
 <20180226083311.52442-2-alice.michael@intel.com>
Message-ID: <6c3ac127-22fd-5de7-c36f-e1857f3f4812@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/26/2018 12:33 AM, Alice Michael wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We used to use the function i40e_vlan_rx_register as a way to hook
> into the now defunct .ndo_vlan_rx_register netdev hook. This was
> removed but we kept the function around because we still used it
> internally to control enabling or disabling of VLAN stripping.
> 
> Simplify this function and make its intent clear. Pass the *vsi
> pointer directly instead of the netdev pointer. Additionally, move
> it closer to the point where it is called in the file.
> 
> This helps clarify the functions use and purpose, and makes the
> code a bit easier to understand.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 31 +++++++++++++----------------
>   1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index d188ff1..9ad80d2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -2720,22 +2720,6 @@ void i40e_vlan_stripping_disable(struct i40e_vsi *vsi)
>   }
>   
>   /**
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
> -/**
>    * i40e_add_vlan_all_mac - Add a MAC/VLAN filter for each existing MAC address
>    * @vsi: the vsi being configured
>    * @vid: vlan id to be added (0 = untagged only , -1 = any)
> @@ -2900,6 +2884,19 @@ static int i40e_vlan_rx_kill_vid(struct net_device *netdev,
>   }
>   
>   /**
> + * i40e_setup_vlan_stripping - Enable or disable VLAN stripping
> + * @vsi: the vsi being configured
> + * @features: netdevice feature flags
> + **/
> +static void i40e_setup_vlan_stripping(struct i40e_vsi *vsi, u32 features)
> +{
> +	if (features & NETIF_F_HW_VLAN_CTAG_RX)
> +		i40e_vlan_stripping_enable(vsi);
> +	else
> +		i40e_vlan_stripping_disable(vsi);
> +}
> +
> +/**
>    * i40e_restore_vlan - Reinstate vlans when vsi/netdev comes back up
>    * @vsi: the vsi being brought back up
>    **/
> @@ -2910,7 +2907,7 @@ static void i40e_restore_vlan(struct i40e_vsi *vsi)
>   	if (!vsi->netdev)
>   		return;
>   
> -	i40e_vlan_rx_register(vsi->netdev, vsi->netdev->features);
> +	i40e_setup_vlan_stripping(vsi, vsi->netdev->features);

If this is the only place from which it is called, why even bother with 
a function?

sln

>   
>   	for_each_set_bit(vid, vsi->active_vlans, VLAN_N_VID)
>   		i40e_vlan_rx_add_vid(vsi->netdev, htons(ETH_P_8021Q),
> 
