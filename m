From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 14 Jan 2022 23:07:19 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix handling of vlan
 strip virtual channel messages
In-Reply-To: <20220113134828.25230-1-michal.maloszewski@intel.com>
References: <20220113134828.25230-1-michal.maloszewski@intel.com>
Message-ID: <167bf4831ac49d4534866c699bb68bbb9f68747f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2022-01-13 at 13:48 +0000, Michal Maloszewski wrote:
> Modify netdev->features for vlan stripping based on virtual
> channel messages received from the PF. Change is needed
> to synchronize vlan strip status between PF sysfs and iavf ethtool.
> 
> Fixes: 310a2ad92e3f ("virtchnl: rename i40e to generic virtchnl")

Please use the commit that introduced the functional issue, not a
rename patch.

> Signed-off-by: Norbert Ciosek <norbertx.ciosek@intel.com>
> Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
> v3: NETIF_F_HW_VLAN_RX changed into NETIF_F_HW_VLAN_CTAG_RX because
> there's
> no such definition since Linux 3.10. The code is the same as the one
> from OOT.
> Code successfully passed inner review. netdev_update_features()
> function is not added 
> because it causes infinite loop.

This is a v1, but there's a v3 changelog?

> ?.../net/ethernet/intel/iavf/iavf_virtchnl.c?? | 42
> +++++++++++++++++++
> ?1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index a40e29455f7d..1805c1ae3bf4 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -1490,6 +1490,24 @@ void iavf_request_reset(struct iavf_adapter
> *adapter)
> ????????adapter->current_op = VIRTCHNL_OP_UNKNOWN;
> ?}
> ?
> +/**
> + * iavf_netdev_features_vlan_strip_set - update vlan strip status
> + * @netdev: ptr to netdev being adjusted
> + * @enable: enable or disable vlan strip
> + *
> + * Helper function to change vlan strip status in netdev->features.
> + */
> +static void iavf_netdev_features_vlan_strip_set(struct net_device
> *netdev,
> +???????????????????????????????????????????????const bool enable)
> +{
> +???????if (enable)
> +???????????????netdev->features |=
> +???????????????????????NETIF_F_HW_VLAN_CTAG_RX |
> NETIF_F_HW_VLAN_CTAG_RX;

These are the same flag.

> +???????else
> +???????????????netdev->features &=
> +???????????????????????~NETIF_F_HW_VLAN_CTAG_RX &
> ~NETIF_F_HW_VLAN_CTAG_RX;

Same here.

> +}
> +
> ?/**
> ? * iavf_virtchnl_completion
> ? * @adapter: adapter structure

