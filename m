From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 27 Oct 2021 12:54:38 -0700
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix handling of vlan
 strip virtual channel messages
In-Reply-To: <20211027144855.53214-1-michal.maloszewski@intel.com>
References: <20211027144855.53214-1-michal.maloszewski@intel.com>
Message-ID: <3a99e26a-1649-9ea1-cdaf-a670341398a4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/27/2021 7:48 AM, Michal Maloszewski wrote:
> Modify netdev->features for vlan stripping based on virtual
> channel messages received from the PF. Change is needed
> to synchronize vlan strip status between PF sysfs and iavf ethtool.
> 
> Fixes: 310a2ad92e3f ("virtchnl: rename i40e to generic virtchnl")

good so far.

> Title: Fix handling of vlan strip virtual channel messages
> Change-type: DefectResolution
> HSDES-number: 1809974314
> HSDES-tenant: server_platf_lan.bug

remove the above lines, not needed or wanted upstream.

> Signed-off-by: Norbert Ciosek <norbertx.ciosek@intel.com>
> Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
> ---
>   .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 42 +++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index bdc6040361..dbce5c17ab 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -1456,6 +1456,24 @@ void iavf_request_reset(struct iavf_adapter *adapter)
>   	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
>   }
>   
> +/**
> + * iavf_netdev_features_vlan_strip_set
> + * @netdev: ptr to netdev being adjusted
> + * @enable: enable or disable vlan strip
> + *
> + * Helper function to change vlan strip status in netdev->features.
> + **/
> +static void iavf_netdev_features_vlan_strip_set(struct net_device *netdev,
> +						const bool enable)
> +{
> +	if (enable)
> +		netdev->features |=
> +			NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_RX;
> +	else
> +		netdev->features &=
> +			~NETIF_F_HW_VLAN_CTAG_RX & ~NETIF_F_HW_VLAN_RX;

you're forgetting a call to netdev_update_features(), and without that, 
layered devices won't know about the change.


