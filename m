From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 16 Dec 2021 13:14:28 +0100
Subject: [Intel-wired-lan] [PATCH net-next v2] i40e: Disable
 hw-tc-offload feature on driver load.
In-Reply-To: <20211216120852.25706-1-mateusz.palczewski@intel.com>
References: <20211216120852.25706-1-mateusz.palczewski@intel.com>
Message-ID: <YbstpK8zy4Vg4M6v@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Dec 16, 2021 at 01:08:52PM +0100, Mateusz Palczewski wrote:
> After loading driver hw-tc-offload is enabled by default.
> Change the behaviour of driver to disable hw-tc-offload by default.
> Additionaly since this impacts ntuple feature state change the way
> of checking NETIF_F_HW_TC flag.
> 
> Title: i40e: Fix hw-tc-offload state on driver load
> Change-type: FeatureImplementation
> HSDES-Number: 16014847639
> HSDES-Tenant: server_platf_lan.bug

How come you guys still make the same mistake of including the
gerrit/internal labels in upstream commits? :<

Besides that, description is not clear to me why disabling this is needed.
I could look up the hsd, but folks that will look@it in the upstream
will not have that comfort. Please try to improve the commit message.

Thanks!

> Signed-off-by: Norbert Zulinski <norbertx.zulinski@intel.com>
> Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  v2: Squashed two commits into one
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 3fd3f10..fec4d51 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -12724,7 +12724,8 @@ static int i40e_set_features(struct net_device *netdev,
>  	else
>  		i40e_vlan_stripping_disable(vsi);
>  
> -	if (!(features & NETIF_F_HW_TC) && pf->num_cloud_filters) {
> +	if (!(features & NETIF_F_HW_TC) &&
> +	    (netdev->features & NETIF_F_HW_TC) && pf->num_cloud_filters) {
>  		dev_err(&pf->pdev->dev,
>  			"Offloaded tc filters active, can't turn hw_tc_offload off");
>  		return -EINVAL;
> @@ -13476,6 +13477,8 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
>  	netdev->features |= hw_features | NETIF_F_HW_VLAN_CTAG_FILTER;
>  	netdev->hw_enc_features |= NETIF_F_TSO_MANGLEID;
>  
> +	netdev->features &= ~NETIF_F_HW_TC;
> +
>  	if (vsi->type == I40E_VSI_MAIN) {
>  		SET_NETDEV_DEV(netdev, &pf->pdev->dev);
>  		ether_addr_copy(mac_addr, hw->mac.perm_addr);
> -- 
> 2.27.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
