From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 16 Dec 2021 12:20:37 -0800
Subject: [Intel-wired-lan] [PATCH net-next v3] i40e: Disable
 hw-tc-offload feature on driver load.
In-Reply-To: <20211216123113.2142-1-mateusz.palczewski@intel.com>
References: <20211216123113.2142-1-mateusz.palczewski@intel.com>
Message-ID: <253c5cfe-5cac-2eb0-e952-32417efae975@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/16/2021 4:31 AM, Mateusz Palczewski wrote:
> After loading driver hw-tc-offload is enabled by default.
> Change the behaviour of driver to disable hw-tc-offload by default as this
> is the expected state. Additionaly since this impacts ntuple feature state
> change the way of checking NETIF_F_HW_TC flag.

Again, why are you doing this? What's wrong with having it enabled by 
default? Does a user have to turn it on before programming rules after 
your change? In order for the maintainers to be interested to apply your 
patch, you have to explain why it benefits them/kernel/community.

> Signed-off-by: Norbert Zulinski <norbertx.zulinski@intel.com>
> Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>

Why are there three sign-offs? Did three people work on this patch? If 
so, did they co-develop it? Three sign-offs in a row would be what's 
done if you're just handling the patch from one user to another. And in 
that case, then usually the first person listed would be also credited 
with the patch upstream by being the From: and set as git author.


> ---
>   v3: Removed internal tags and fixed commit message
>   v2: Squashed two commits into one
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 3fd3f10..fec4d51 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -12724,7 +12724,8 @@ static int i40e_set_features(struct net_device *netdev,
>   	else
>   		i40e_vlan_stripping_disable(vsi);
>   
> -	if (!(features & NETIF_F_HW_TC) && pf->num_cloud_filters) {
> +	if (!(features & NETIF_F_HW_TC) &&
> +	    (netdev->features & NETIF_F_HW_TC) && pf->num_cloud_filters) {
>   		dev_err(&pf->pdev->dev,
>   			"Offloaded tc filters active, can't turn hw_tc_offload off");
>   		return -EINVAL;
> @@ -13476,6 +13477,8 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
>   	netdev->features |= hw_features | NETIF_F_HW_VLAN_CTAG_FILTER;
>   	netdev->hw_enc_features |= NETIF_F_TSO_MANGLEID;
>   
> +	netdev->features &= ~NETIF_F_HW_TC;
> +
>   	if (vsi->type == I40E_VSI_MAIN) {
>   		SET_NETDEV_DEV(netdev, &pf->pdev->dev);
>   		ether_addr_copy(mac_addr, hw->mac.perm_addr);

