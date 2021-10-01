From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 1 Oct 2021 21:58:58 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Add support for
 VIRTCHNL_VF_OFFLOAD_VLAN_V2
In-Reply-To: <20210929134410.93953-1-karen.sornek@intel.com>
References: <20210929134410.93953-1-karen.sornek@intel.com>
Message-ID: <SN6PR11MB32294EED767A5B10B6668DF0C6AB9@SN6PR11MB3229.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Karen
> Sornek
> Sent: Wednesday, September 29, 2021 6:44 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sornek, Karen <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Add support for
> VIRTCHNL_VF_OFFLOAD_VLAN_V2
> 
> Restrict maximum VLAN filters for VIRTCHNL_VF_OFFLOAD_VLAN_V2
> 
> For VIRTCHNL_VF_OFFLOAD_VLAN, PF's would limit the number of VLAN
> filters a VF was allowed to add. However, by the time the opcode failed,
> the VLAN netdev had already been added. VIRTCHNL_VF_OFFLOAD_VLAN_V2
> added the ability for a PF to tell the VF how many VLAN filters it's
> allowed to add. Make changes to support that functionality.
> 
> Add support for VIRTCHNL_VF_OFFLOAD_VLAN_V2 offload enable/disable
> 
> The new VIRTCHNL_VF_OFFLOAD_VLAN_V2 capability adds support that allows
> the VF to support 802.1Q and 802.1ad VLAN insertion and stripping if
> successfully negotiated via VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS.
> Multiple changes were needed to support this new functionality.
> 
> 1. Add new aq_required flags to support any kind of VLAN stripping and
>    insertion offload requests via virtchnl.
> 
> 2. Add the new method iavf_set_vlan_offload_features() that's
>    used during VF initialization, VF reset, and iavf_set_features() to
>    set the aq_required bits based on the current VLAN offload
>    configuration of the VF's netdev.
> 
> 3. Add virtchnl handling for VIRTCHNL_OP_ENABLE_STRIPPING_V2,
>    VIRTCHNL_OP_DISABLE_STRIPPING_V2,
> VIRTCHNL_OP_ENABLE_INSERTION_V2,
>    and VIRTCHNL_OP_ENABLE_INSERTION_V2.
> 
> Add support for VIRTCHNL_VF_OFFLOAD_VLAN_V2 hotpath
> 
> The new VIRTCHNL_VF_OFFLOAD_VLAN_V2 capability added support that
> allows
> the PF to set the location of the Tx and Rx VLAN tag for insertion and
> stripping offloads. In order to support this functionality a few changes
> are needed.
> 
> 1. Add a new method to cache the VLAN tag location based on negotiated
>    capabilities for the Tx and Rx ring flags. This needs to be called in
>    the initialization and reset paths.
> 
> 2. Refactor the transmit hotpath to account for the new Tx ring flags.
>    When IAVF_TXR_FLAGS_VLAN_LOC_L2TAG2 is set, then the driver needs to
>    insert the VLAN tag in the L2TAG2 field of the transmit descriptor.
>    When the IAVF_TXRX_FLAGS_VLAN_LOC_L2TAG1 is set, then the driver needs
>    to use the l2tag1 field of the data descriptor (same behavior as
>    before).
> 
> 3. Refactor the iavf_tx_prepare_vlan_flags() function to simplify
>    transmit hardware VLAN offload functionality by only depending on the
>    skb_vlan_tag_present() function. This can be done because the OS
>    won't request transmit offload for a VLAN unless the driver told the
>    OS it's supported and enabled.
> 
> 4. Refactor the receive hotpath to account for the new Rx ring flags and
>    VLAN ethertypes. This requires checking the Rx ring flags and
>    descriptor status bits to determine the location of the VLAN tag.
>    Also, since only a single ethertype can be supported at a time, check
>    the enabled netdev features before specifying a VLAN ethertype in
>    __vlan_hwaccel_put_tag().
> 
> Add support for VIRTCHNL_OP_[ADD|DEL]_VLAN_V2
> 
> In order to support adding/deleting VLAN filters when the VF
> successfully negotiates VIRTCHNL_VF_OFFLOAD_VLAN_V2, it must use the new
> virtchnl opcodes:
> 
> VIRTCHNL_OP_ADD_VLAN_V2
> VIRTCHNL_OP_DEL_VLAN_V2
> 
> Also, the VF is able to add 802.1Q and 802.1AD VLAN filters if the
> support was negotiated in VIRTCHNL_VF_OFFLOAD_VLAN_V2 and
> VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS, so add support to specify the
> VLAN
> TPID when adding/deletingn VLAN filters using these new opcodes.
> 
> Lastly, only re-add VLAN filters after VF reset if VLAN filtering is
> allowed instead of just blindly re-adding them over virtchnl.
> 
> Add support for VIRTCHNL_VF_OFFLOAD_VLAN_V2 negotiation
> 
> In order to support the new VIRTCHNL_VF_OFFLOAD_VLAN_V2 capability the
> VF driver needs to rework it's initialization state machine and reset
> flow. This has to be done because successful negotiation of
> VIRTCHNL_VF_OFFLOAD_VLAN_V2 requires the VF driver to perform a second
> capability request via VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS before
> configuring the adapter and its netdev.
> 
> Add the VIRTCHNL_VF_OFFLOAD_VLAN_V2 bit when sending the
> VIRTHCNL_OP_GET_VF_RESOURECES message. The underlying PF will either
> support VIRTCHNL_VF_OFFLOAD_VLAN or VIRTCHNL_VF_OFFLOAD_VLAN_V2
> or
> neither. Both of these offloads should never be supported together.
> 
> Based on this, add 2 new states to the initialization state machine:
> 
> __IAVF_INIT_GET_OFFLOAD_VLAN_V2_CAPS
> __IAVF_INIT_CONFIG_ADAPTER
> 
> The __IAVF_INIT_GET_OFFLOAD_VLAN_V2_CAPS state is used to request/store
> the new VLAN capabilities if and only if VIRTCHNL_VLAN_OFFLOAD_VLAN_V2
> was successfully negotiated in the __IAVF_INIT_GET_RESOURCES state.
> 
> The __IAVF_INIT_CONFIG_ADAPTER state is used to configure the
> adapter/netdev after the resource requests have finished. The VF will
> move into this state regardless of whether it successfully negotiated
> VIRTCHNL_VF_OFFLOAD_VLAN or VIRTCHNL_VF_OFFLOAD_VLAN_V2.
> 
> Also, add a the new flag IAVF_FLAG_AQ_GET_OFFLOAD_VLAN_V2_CAPS and set
> it during VF reset. If VIRTCHNL_VF_OFFLOAD_VLAN_V2 was successfully
> negotiated then the VF will request its VLAN capabilities via
> VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS during the reset. This is needed
> because the PF may change/modify the VF's configuration during VF reset
> (i.e. modifying the VF's port VLAN configuration).
> 
> This also, required the VF to call netdev_update_features() since its
> VLAN features may change during VF reset. Make sure to call this under
> rtnl_lock().

This commit message is hard to follow. Please reword to make it easier to follow what is being done.

Also, this patch does not apply. Please work with your team on resolving this problem; you are consistently sending patches that do not apply.

> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        | 126 ++-
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 773 ++++++++++++++----
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c   |  94 ++-
>  drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  30 +-
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 588 +++++++++++--
>  5 files changed, 1296 insertions(+), 315 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 21c957755..15b275950 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -56,6 +56,8 @@ struct iavf_vsi {
>  	struct iavf_adapter *back;
>  	struct net_device *netdev;
>  	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
> +	unsigned long active_cvlans[BITS_TO_LONGS(VLAN_N_VID)];
> +	unsigned long active_svlans[BITS_TO_LONGS(VLAN_N_VID)];
>  	u16 seid;
>  	u16 id;
>  	DECLARE_BITMAP(state, __IAVF_VSI_STATE_SIZE__);
> @@ -93,6 +95,17 @@ struct iavf_vsi {
>  #define IAVF_VIRTCHNL_VF_RESOURCE_SIZE (sizeof(struct
> virtchnl_vf_resource) + \
>  					(IAVF_MAX_VF_VSI * \
>  					 sizeof(struct virtchnl_vsi_resource)))
> +#ifdef NETIF_F_HW_VLAN_CTAG_RX
> +#define IAVF_NETIF_F_HW_VLAN_CTAG_RX	NETIF_F_HW_VLAN_CTAG_RX
> +#else
> +#define IAVF_NETIF_F_HW_VLAN_CTAG_RX	NETIF_F_HW_VLAN_RX
> +#endif
> +
> +#ifdef NETIF_F_HW_VLAN_CTAG_TX
> +#define IAVF_NETIF_F_HW_VLAN_CTAG_TX	NETIF_F_HW_VLAN_CTAG_TX
> +#else
> +#define IAVF_NETIF_F_HW_VLAN_CTAG_TX	NETIF_F_HW_VLAN_TX
> +#endif

You have these ifdef's all over the code. Why are they here?

>  /* MAX_MSIX_Q_VECTORS of these are allocated,
>   * but we only use one per queue-specific vector.

<snip>

> @@ -1700,6 +2098,39 @@ static int iavf_process_aq_command(struct
> iavf_adapter *adapter)
>  		iavf_del_adv_rss_cfg(adapter);
>  		return 0;
>  	}
> +	if (adapter->aq_required &
> IAVF_FLAG_AQ_DISABLE_CTAG_VLAN_STRIPPING) {
> +		iavf_disable_vlan_stripping_v2(adapter, ETH_P_8021Q);
> +		return IAVF_SUCCESS;
> +	}
> +	if (adapter->aq_required &
> IAVF_FLAG_AQ_DISABLE_STAG_VLAN_STRIPPING) {
> +		iavf_disable_vlan_stripping_v2(adapter, ETH_P_8021AD);
> +		return IAVF_SUCCESS;
> +	}
> +	if (adapter->aq_required &
> IAVF_FLAG_AQ_ENABLE_CTAG_VLAN_STRIPPING) {
> +		iavf_enable_vlan_stripping_v2(adapter, ETH_P_8021Q);
> +		return IAVF_SUCCESS;
> +	}
> +	if (adapter->aq_required &
> IAVF_FLAG_AQ_ENABLE_STAG_VLAN_STRIPPING) {
> +		iavf_enable_vlan_stripping_v2(adapter, ETH_P_8021AD);
> +		return IAVF_SUCCESS;
> +	}
> +	if (adapter->aq_required &
> IAVF_FLAG_AQ_DISABLE_CTAG_VLAN_INSERTION) {
> +		iavf_disable_vlan_insertion_v2(adapter, ETH_P_8021Q);
> +		return IAVF_SUCCESS;
> +	}
> +	if (adapter->aq_required &
> IAVF_FLAG_AQ_DISABLE_STAG_VLAN_INSERTION) {
> +		iavf_disable_vlan_insertion_v2(adapter, ETH_P_8021AD);
> +		return IAVF_SUCCESS;
> +	}
> +	if (adapter->aq_required &
> IAVF_FLAG_AQ_ENABLE_CTAG_VLAN_INSERTION) {
> +		iavf_enable_vlan_insertion_v2(adapter, ETH_P_8021Q);
> +		return IAVF_SUCCESS;
> +	}
> +	if (adapter->aq_required &
> IAVF_FLAG_AQ_ENABLE_STAG_VLAN_INSERTION) {
> +		iavf_enable_vlan_insertion_v2(adapter, ETH_P_8021AD);
> +		return IAVF_SUCCESS;
> +	}
> +
>  	return -EAGAIN;

You are mixing iavf_status with standard error codes.
>  }
> 
<snip>

> +/**
> + * iavf_poll_virtchnl_msg - poll for virtchnl msg matching the requested_op
> + * @hw: HW configuration structure
> + * @event: event to populate on success
> + * @op_to_poll: requested virtchnl op to poll for
> + */
> +static int
> +iavf_poll_virtchnl_msg(struct iavf_hw *hw, struct iavf_arq_event_info *event,
> +		       enum virtchnl_ops op_to_poll)

Should this be returning iavf_status?

> +{
> +	enum virtchnl_ops received_op;
> +	enum iavf_status status;
> +
> +	while (1) {
> +		/* When the AQ is empty, iavf_clean_arq_element will return
> +		 * nonzero and this loop will terminate.
> +		 */
> +		status = iavf_clean_arq_element(hw, event, NULL);
> +		if (status != IAVF_SUCCESS)
> +			return status;
> +		received_op =
> +		    (enum virtchnl_ops)le32_to_cpu(event->desc.cookie_high);
> +		if (op_to_poll == received_op)
> +			break;
> +	}
> +
> +	status = (enum iavf_status)le32_to_cpu(event->desc.cookie_low);
> +	return status;
> +}
> +
>  /**
>   * iavf_verify_api_ver
>   * @adapter: adapter structure
> @@ -134,6 +164,7 @@ int iavf_send_vf_config_msg(struct iavf_adapter
> *adapter)
>  	       VIRTCHNL_VF_OFFLOAD_RSS_AQ |
>  	       VIRTCHNL_VF_OFFLOAD_RSS_REG |
>  	       VIRTCHNL_VF_OFFLOAD_VLAN |
> +	       VIRTCHNL_VF_OFFLOAD_VLAN_V2 |
>  	       VIRTCHNL_VF_OFFLOAD_WB_ON_ITR |
>  	       VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2 |
>  	       VIRTCHNL_VF_OFFLOAD_ENCAP |
> @@ -155,6 +186,19 @@ int iavf_send_vf_config_msg(struct iavf_adapter
> *adapter)
>  					NULL, 0);
>  }
> 
> +int iavf_send_vf_offload_vlan_v2_msg(struct iavf_adapter *adapter)
> +{
> +	adapter->aq_required &=
> ~IAVF_FLAG_AQ_GET_OFFLOAD_VLAN_V2_CAPS;
> +
> +	if (!VLAN_V2_ALLOWED(adapter))
> +		return -EOPNOTSUPP;
> +
> +	adapter->current_op = VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS;
> +
> +	return iavf_send_pf_msg(adapter,
> VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS,
> +				NULL, 0);
> +}
> +
>  /**
>   * iavf_validate_num_queues
>   * @adapter: adapter structure
> @@ -235,6 +279,28 @@ out:
>  	return err;
>  }
> 
> +int iavf_get_vf_vlan_v2_caps(struct iavf_adapter *adapter)
> +{
> +	struct iavf_arq_event_info event;
> +	int err;
> +	u16 len;

RCT

> +
> +	len = sizeof(struct virtchnl_vlan_caps);
> +	event.buf_len = len;
> +	event.msg_buf = (u8 *)kzalloc(len, GFP_KERNEL);
> +	if (!event.msg_buf)
> +		return -ENOMEM;
> +

<snip>

> +
> +/**
> + * ice_set_vc_offload_ethertype - set virtchnl ethertype for offload message
> + * @adapter: adapter structure
> + * @msg: message structure used for updating offloads over virtchnl to update
> + * @tpid: VLAN TPID (i.e. 0x8100, 0x88a8, etc.)
> + * @offload_op: opcode used to determine which support structure to check
> + */
> +static int
> +iavf_set_vc_offload_ethertype(struct iavf_adapter *adapter,
> +			      struct virtchnl_vlan_setting *msg, u16 tpid,
> +			      enum virtchnl_ops offload_op)
> +{
> +	struct virtchnl_vlan_supported_caps *offload_support;
> +	u32 vc_ethertype = iavf_tpid_to_vc_ethertype(tpid);
> +
> +	/* reference the correct offload support structure */
> +	switch (offload_op) {
> +	case VIRTCHNL_OP_ENABLE_VLAN_STRIPPING_V2:
> +		/* fall-through */
> +	case VIRTCHNL_OP_DISABLE_VLAN_STRIPPING_V2:
> +		offload_support =
> +			&adapter->vlan_v2_caps->offloads.stripping_support;
> +		break;
> +	case VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2:
> +		/* fall-through */

I don't believe these fall-throughs are needed, and if they are, it should be 'fallthrough;'

> +	case VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2:
> +		offload_support =
> +			&adapter->vlan_v2_caps->offloads.insertion_support;
> +		break;
> +	default:
> +		dev_err(&adapter->pdev->dev, "Invalid opcode %d for setting

