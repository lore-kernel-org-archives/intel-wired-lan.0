From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 8 Dec 2021 08:09:45 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 5/6] iavf: Add support for
 VIRTCHNL_VF_OFFLOAD_VLAN_V2 offload enable/disable
In-Reply-To: <20211130001604.22112-6-anthony.l.nguyen@intel.com>
References: <20211130001604.22112-1-anthony.l.nguyen@intel.com>
 <20211130001604.22112-6-anthony.l.nguyen@intel.com>
Message-ID: <DM8PR11MB5621B98E2A0295F0D04E31A7AB6F9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: wtorek, 30 listopada 2021 01:16
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 5/6] iavf: Add support for
> VIRTCHNL_VF_OFFLOAD_VLAN_V2 offload enable/disable
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> The new VIRTCHNL_VF_OFFLOAD_VLAN_V2 capability added support that
> allows the VF to support 802.1Q and 802.1ad VLAN insertion and stripping if
> successfully negotiated via VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS.
> Multiple changes were needed to support this new functionality.
> 
> 1. Added new aq_required flags to support any kind of VLAN stripping and
>    insertion offload requests via virtchnl.
> 
> 2. Added the new method iavf_set_vlan_offload_features() that's
>    used during VF initialization, VF reset, and iavf_set_features() to
>    set the aq_required bits based on the current VLAN offload
>    configuration of the VF's netdev.
> 
> 3. Added virtchnl handling for VIRTCHNL_OP_ENABLE_STRIPPING_V2,
>    VIRTCHNL_OP_DISABLE_STRIPPING_V2,
> VIRTCHNL_OP_ENABLE_INSERTION_V2,
>    and VIRTCHNL_OP_ENABLE_INSERTION_V2.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  80 ++++---
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 151 +++++++++++--
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 203 ++++++++++++++++++
>  3 files changed, 383 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 2660d46da1b5..59806d1f7e79 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -287,39 +287,47 @@ struct iavf_adapter {
>  /* duplicates for common code */
>  #define IAVF_FLAG_DCB_ENABLED			0
>  	/* flags for admin queue service task */
> -	u32 aq_required;
> -#define IAVF_FLAG_AQ_ENABLE_QUEUES		BIT(0)
> -#define IAVF_FLAG_AQ_DISABLE_QUEUES		BIT(1)
> -#define IAVF_FLAG_AQ_ADD_MAC_FILTER		BIT(2)
> -#define IAVF_FLAG_AQ_ADD_VLAN_FILTER		BIT(3)
> -#define IAVF_FLAG_AQ_DEL_MAC_FILTER		BIT(4)
> -#define IAVF_FLAG_AQ_DEL_VLAN_FILTER		BIT(5)
> -#define IAVF_FLAG_AQ_CONFIGURE_QUEUES		BIT(6)
> -#define IAVF_FLAG_AQ_MAP_VECTORS		BIT(7)
> -#define IAVF_FLAG_AQ_HANDLE_RESET		BIT(8)
> -#define IAVF_FLAG_AQ_CONFIGURE_RSS		BIT(9) /* direct AQ
> config */
> -#define IAVF_FLAG_AQ_GET_CONFIG		BIT(10)
> +	u64 aq_required;
> +#define IAVF_FLAG_AQ_ENABLE_QUEUES		BIT_ULL(0)
> +#define IAVF_FLAG_AQ_DISABLE_QUEUES		BIT_ULL(1)
> +#define IAVF_FLAG_AQ_ADD_MAC_FILTER		BIT_ULL(2)
> +#define IAVF_FLAG_AQ_ADD_VLAN_FILTER		BIT_ULL(3)
> +#define IAVF_FLAG_AQ_DEL_MAC_FILTER		BIT_ULL(4)
> +#define IAVF_FLAG_AQ_DEL_VLAN_FILTER		BIT_ULL(5)
> +#define IAVF_FLAG_AQ_CONFIGURE_QUEUES		BIT_ULL(6)
> +#define IAVF_FLAG_AQ_MAP_VECTORS		BIT_ULL(7)
> +#define IAVF_FLAG_AQ_HANDLE_RESET		BIT_ULL(8)
> +#define IAVF_FLAG_AQ_CONFIGURE_RSS		BIT_ULL(9) /* direct
> AQ config */
> +#define IAVF_FLAG_AQ_GET_CONFIG			BIT_ULL(10)
>  /* Newer style, RSS done by the PF so we can ignore hardware vagaries. */
> -#define IAVF_FLAG_AQ_GET_HENA			BIT(11)
> -#define IAVF_FLAG_AQ_SET_HENA			BIT(12)
> -#define IAVF_FLAG_AQ_SET_RSS_KEY		BIT(13)
> -#define IAVF_FLAG_AQ_SET_RSS_LUT		BIT(14)
> -#define IAVF_FLAG_AQ_REQUEST_PROMISC		BIT(15)
> -#define IAVF_FLAG_AQ_RELEASE_PROMISC		BIT(16)
> -#define IAVF_FLAG_AQ_REQUEST_ALLMULTI		BIT(17)
> -#define IAVF_FLAG_AQ_RELEASE_ALLMULTI		BIT(18)
> -#define IAVF_FLAG_AQ_ENABLE_VLAN_STRIPPING	BIT(19)
> -#define IAVF_FLAG_AQ_DISABLE_VLAN_STRIPPING	BIT(20)
> -#define IAVF_FLAG_AQ_ENABLE_CHANNELS		BIT(21)
> -#define IAVF_FLAG_AQ_DISABLE_CHANNELS		BIT(22)
> -#define IAVF_FLAG_AQ_ADD_CLOUD_FILTER		BIT(23)
> -#define IAVF_FLAG_AQ_DEL_CLOUD_FILTER		BIT(24)
> -#define IAVF_FLAG_AQ_ADD_FDIR_FILTER		BIT(25)
> -#define IAVF_FLAG_AQ_DEL_FDIR_FILTER		BIT(26)
> -#define IAVF_FLAG_AQ_ADD_ADV_RSS_CFG		BIT(27)
> -#define IAVF_FLAG_AQ_DEL_ADV_RSS_CFG		BIT(28)
> -#define IAVF_FLAG_AQ_REQUEST_STATS		BIT(29)
> -#define IAVF_FLAG_AQ_GET_OFFLOAD_VLAN_V2_CAPS	BIT(30)
> +#define IAVF_FLAG_AQ_GET_HENA			BIT_ULL(11)
> +#define IAVF_FLAG_AQ_SET_HENA			BIT_ULL(12)
> +#define IAVF_FLAG_AQ_SET_RSS_KEY		BIT_ULL(13)
> +#define IAVF_FLAG_AQ_SET_RSS_LUT		BIT_ULL(14)
> +#define IAVF_FLAG_AQ_REQUEST_PROMISC		BIT_ULL(15)
> +#define IAVF_FLAG_AQ_RELEASE_PROMISC		BIT_ULL(16)
> +#define IAVF_FLAG_AQ_REQUEST_ALLMULTI		BIT_ULL(17)
> +#define IAVF_FLAG_AQ_RELEASE_ALLMULTI		BIT_ULL(18)
> +#define IAVF_FLAG_AQ_ENABLE_VLAN_STRIPPING	BIT_ULL(19)
> +#define IAVF_FLAG_AQ_DISABLE_VLAN_STRIPPING	BIT_ULL(20)
> +#define IAVF_FLAG_AQ_ENABLE_CHANNELS		BIT_ULL(21)
> +#define IAVF_FLAG_AQ_DISABLE_CHANNELS		BIT_ULL(22)
> +#define IAVF_FLAG_AQ_ADD_CLOUD_FILTER		BIT_ULL(23)
> +#define IAVF_FLAG_AQ_DEL_CLOUD_FILTER		BIT_ULL(24)
> +#define IAVF_FLAG_AQ_ADD_FDIR_FILTER		BIT_ULL(25)
> +#define IAVF_FLAG_AQ_DEL_FDIR_FILTER		BIT_ULL(26)
> +#define IAVF_FLAG_AQ_ADD_ADV_RSS_CFG		BIT_ULL(27)
> +#define IAVF_FLAG_AQ_DEL_ADV_RSS_CFG		BIT_ULL(28)
> +#define IAVF_FLAG_AQ_REQUEST_STATS		BIT_ULL(29)
> +#define IAVF_FLAG_AQ_GET_OFFLOAD_VLAN_V2_CAPS	BIT_ULL(30)
> +#define IAVF_FLAG_AQ_ENABLE_CTAG_VLAN_STRIPPING
> 	BIT_ULL(31)
> +#define IAVF_FLAG_AQ_DISABLE_CTAG_VLAN_STRIPPING	BIT_ULL(32)
> +#define IAVF_FLAG_AQ_ENABLE_STAG_VLAN_STRIPPING
> 	BIT_ULL(33)
> +#define IAVF_FLAG_AQ_DISABLE_STAG_VLAN_STRIPPING	BIT_ULL(34)
> +#define IAVF_FLAG_AQ_ENABLE_CTAG_VLAN_INSERTION
> 	BIT_ULL(35)
> +#define IAVF_FLAG_AQ_DISABLE_CTAG_VLAN_INSERTION	BIT_ULL(36)
> +#define IAVF_FLAG_AQ_ENABLE_STAG_VLAN_INSERTION
> 	BIT_ULL(37)
> +#define IAVF_FLAG_AQ_DISABLE_STAG_VLAN_INSERTION	BIT_ULL(38)
> 
>  	/* OS defined structs */
>  	struct net_device *netdev;
> @@ -524,6 +532,14 @@ void iavf_enable_channels(struct iavf_adapter
> *adapter);  void iavf_disable_channels(struct iavf_adapter *adapter);  void
> iavf_add_cloud_filter(struct iavf_adapter *adapter);  void
> iavf_del_cloud_filter(struct iavf_adapter *adapter);
> +void iavf_enable_vlan_stripping_v2(struct iavf_adapter *adapter, u16
> +tpid); void iavf_disable_vlan_stripping_v2(struct iavf_adapter
> +*adapter, u16 tpid); void iavf_enable_vlan_insertion_v2(struct
> +iavf_adapter *adapter, u16 tpid); void
> +iavf_disable_vlan_insertion_v2(struct iavf_adapter *adapter, u16 tpid);
> +void iavf_set_vlan_offload_features(struct iavf_adapter *adapter,
> +			       netdev_features_t prev_features,
> +			       netdev_features_t features);
>  void iavf_add_fdir_filter(struct iavf_adapter *adapter);  void
> iavf_del_fdir_filter(struct iavf_adapter *adapter);  void
> iavf_add_adv_rss_cfg(struct iavf_adapter *adapter); diff --git
> a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 945369bbe04a..8bdadf6a3c0c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1815,6 +1815,39 @@ static int iavf_process_aq_command(struct

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
