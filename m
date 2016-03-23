From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 23 Mar 2016 13:57:07 -0700
Subject: [Intel-wired-lan] [next PATCH S31 v4 03/12] i40evf: Fix VLAN
	features
In-Reply-To: <1458328696-135941-4-git-send-email-avinash.dayanand@intel.com>
References: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
 <1458328696-135941-4-git-send-email-avinash.dayanand@intel.com>
Message-ID: <CAKgT0Ufe8YJDx4PufA5Bp9rw2d00JvY74OYKN8o=6RRvyfXY5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Mar 18, 2016 at 12:18 PM, Avinash Dayanand
<avinash.dayanand@intel.com> wrote:
> From: Mitch Williams <mitch.a.williams@intel.com>
>
> Users of ethtool were being given the mistaken impression that this
> driver was able to change its VLAN tagging features, and were
> disappointed that this was not actually the case. Implement
> ndo_fix_features method so that we can adjust these flags as needed to
> avoid false impressions.
>
> Testing Hints: Use 'ethtool -K rxvlan off' to attempt
> to change the VLAN tagging.
>
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I08584f103a4fa73d6a4128d472e4ef44dcfda57f
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> index e397368..0c99974 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> @@ -2252,6 +2252,28 @@ static int i40evf_change_mtu(struct net_device *netdev, int new_mtu)
>         return 0;
>  }
>
> +#define I40EVF_VLAN_FEATURES (NETIF_F_HW_VLAN_CTAG_TX |\
> +                              NETIF_F_HW_VLAN_CTAG_RX |\
> +                              NETIF_F_HW_VLAN_CTAG_FILTER)
> +
> +/**
> + * i40evf_fix_features - fix up the netdev feature bits
> + * @netdev: our net device
> + * @features: desired feature bits
> + *
> + * Returns fixed-up features bits
> + **/
> +static netdev_features_t i40evf_fix_features(struct net_device *netdev,
> +                                            netdev_features_t features)
> +{
> +       struct i40evf_adapter *adapter = netdev_priv(netdev);
> +
> +       features &= ~I40EVF_VLAN_FEATURES;
> +       if (adapter->vf_res->vf_offload_flags & I40E_VIRTCHNL_VF_OFFLOAD_VLAN)
> +               features |= I40EVF_VLAN_FEATURES;
> +       return features;
> +}
> +
>  static const struct net_device_ops i40evf_netdev_ops = {
>         .ndo_open               = i40evf_open,
>         .ndo_stop               = i40evf_close,
> @@ -2264,6 +2286,7 @@ static const struct net_device_ops i40evf_netdev_ops = {
>         .ndo_tx_timeout         = i40evf_tx_timeout,
>         .ndo_vlan_rx_add_vid    = i40evf_vlan_rx_add_vid,
>         .ndo_vlan_rx_kill_vid   = i40evf_vlan_rx_kill_vid,
> +       .ndo_fix_features       = i40evf_fix_features,
>  #ifdef CONFIG_NET_POLL_CONTROLLER
>         .ndo_poll_controller    = i40evf_netpoll,
>  #endif

This fix isn't correct.  If you don't support toggling a feature you
should not be setting it in hw_features.  All you are doing here is
making more confusion since now you will just ignore the user input.

Just move the code that is setting these bits down further in
i40evf_process_config so that the netdev->features portion with the
VLAN bits doesn't get written until after you have set
netdev->hw_features.

- Alex
