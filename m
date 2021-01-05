From: Stefan Assmann <sassmann@redhat.com>
Date: Tue, 5 Jan 2021 09:02:39 +0100
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix setting PF MAC
 filters when changing MAC address
In-Reply-To: <20201230144255.2687-1-mateusz.palczewski@intel.com>
References: <20201230144255.2687-1-mateusz.palczewski@intel.com>
Message-ID: <20210105080239.5d3tvbjymk32iymp@p50.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-12-30 14:42, Mateusz Palczewski wrote:
> When changing PFs MAC address the old MAC filter was not removed
> due to incorrect order of copying MAC from netdev and deleting
> the old MAC filter.
> Changed how the old MAC filter is removed to remove the proper
> filter.
> 
> Fixes: 158daed16efb("i40e: fix mac filter delete when setting mac address")
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 630258e..de5e0fb 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -1561,6 +1561,7 @@ int i40e_del_mac_filter(struct i40e_vsi *vsi, const u8 *macaddr)
>  static int i40e_set_mac(struct net_device *netdev, void *p)
>  {
>  	struct i40e_netdev_priv *np = netdev_priv(netdev);
> +	struct sockaddr addr_tmp = {0};
>  	struct i40e_vsi *vsi = np->vsi;
>  	struct i40e_pf *pf = vsi->back;
>  	struct i40e_hw *hw = &pf->hw;
> @@ -1591,8 +1592,11 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
>  	 * - Copy new address
>  	 * - Add new address to MAC filter
>  	 */
> +
> +	ether_addr_copy(addr_tmp.sa_data, netdev->dev_addr);
> +
>  	spin_lock_bh(&vsi->mac_filter_hash_lock);
> -	i40e_del_mac_filter(vsi, netdev->dev_addr);
> +	i40e_del_mac_filter(vsi, addr_tmp.sa_data);
>  	ether_addr_copy(netdev->dev_addr, addr->sa_data);
>  	i40e_add_mac_filter(vsi, netdev->dev_addr);
>  	spin_unlock_bh(&vsi->mac_filter_hash_lock);

Could you please point out what exactly goes wrong in the original code
and how this patch does correct that? I fail to understand either.

  Stefan

