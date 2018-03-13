From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 12 Mar 2018 19:05:35 -0700
Subject: [Intel-wired-lan] [PATCH 04/15] ice: Get switch config,
 scheduler config and device capabilities
In-Reply-To: <20180309172136.9073-5-anirudh.venkataramanan@intel.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-5-anirudh.venkataramanan@intel.com>
Message-ID: <0a836e29-d08f-d14d-3861-fd211113ee35@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/9/2018 9:21 AM, Anirudh Venkataramanan wrote:
> This patch adds to the initialization flow by getting switch
> configuration, scheduler configuration and device capabilities.
> 
> Switch configuration:
> On boot, an L2 switch element is created in the firmware per physical
> function. Each physical function is also mapped to a port, to which its
> switch element is connected. In other words, this switch can be visualized
> as an embedded vSwitch that can connect a physical functions's virtual
> station interfaces (VSIs) to the egress/ingress port. Egress/ingress
> filters will be eventually created and applied on this switch element.
> As part of the initialization flow, the driver gets configuration data
> from this switch element and stores it.
> 
> Scheduler configuration:
> The Tx scheduler is a subsystem responsible for setting and enforcing QoS.
> As part of the initialization flow, the driver queries and stores the
> default scheduler configuration for the given physical function.
> 
> Device capabilities:
> As part of initialization, the driver has to determine what the device is
> capable of (ex. max queues, VSIs, etc). This information is obtained from
> the firmware and stored by the driver.
> 
> Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/Makefile         |   4 +-
>   drivers/net/ethernet/intel/ice/ice.h            |   2 +
>   drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 209 ++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_common.c     | 223 +++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_common.h     |   2 +
>   drivers/net/ethernet/intel/ice/ice_sched.c      | 354 ++++++++++++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_sched.h      |  42 +++
>   drivers/net/ethernet/intel/ice/ice_switch.c     | 158 +++++++++++
>   drivers/net/ethernet/intel/ice/ice_switch.h     |  28 ++
>   drivers/net/ethernet/intel/ice/ice_type.h       | 109 ++++++++
>   10 files changed, 1130 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/intel/ice/ice_sched.c
>   create mode 100644 drivers/net/ethernet/intel/ice/ice_sched.h
>   create mode 100644 drivers/net/ethernet/intel/ice/ice_switch.c
>   create mode 100644 drivers/net/ethernet/intel/ice/ice_switch.h
> 
> diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
> index 373d481dbb25..809d85c04398 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile
> @@ -27,4 +27,6 @@ obj-$(CONFIG_ICE) += ice.o
>   ice-y := ice_main.o	\
>   	 ice_controlq.o	\
>   	 ice_common.o	\
> -	 ice_nvm.o
> +	 ice_nvm.o	\
> +	 ice_switch.o	\
> +	 ice_sched.o
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index ab2800c31906..f6e3339591bb 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -30,7 +30,9 @@
>   #include <linux/bitmap.h>
>   #include "ice_devids.h"
>   #include "ice_type.h"
> +#include "ice_switch.h"
>   #include "ice_common.h"
> +#include "ice_sched.h"
>   
>   #define ICE_BAR0		0
>   #define ICE_AQ_LEN		64
> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index 05b22a1ffd70..66a3f41df673 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -22,6 +22,8 @@
>    * descriptor format.  It is shared between Firmware and Software.
>    */
>   
> +#define ICE_AQC_TOPO_MAX_LEVEL_NUM	0x9
> +
>   struct ice_aqc_generic {
>   	__le32 param0;
>   	__le32 param1;
> @@ -82,6 +84,40 @@ struct ice_aqc_req_res {
>   	u8 reserved[2];
>   };
>   
> +/* Get function capabilities (indirect 0x000A)
> + * Get device capabilities (indirect 0x000B)
> + */
> +struct ice_aqc_list_caps {
> +	u8 cmd_flags;
> +	u8 pf_index;
> +	u8 reserved[2];
> +	__le32 count;
> +	__le32 addr_high;
> +	__le32 addr_low;
> +};
> +
> +/* Device/Function buffer entry, repeated per reported capability */
> +struct ice_aqc_list_caps_elem {
> +	__le16 cap;
> +#define ICE_AQC_CAPS_VSI				0x0017
> +#define ICE_AQC_CAPS_RSS				0x0040
> +#define ICE_AQC_CAPS_RXQS				0x0041
> +#define ICE_AQC_CAPS_TXQS				0x0042
> +#define ICE_AQC_CAPS_MSIX				0x0043
> +#define ICE_AQC_CAPS_MAX_MTU				0x0047
> +
> +	u8 major_ver;
> +	u8 minor_ver;
> +	/* Number of resources described by this capability */
> +	__le32 number;
> +	/* Only meaningful for some types of resources */
> +	__le32 logical_id;
> +	/* Only meaningful for some types of resources */
> +	__le32 phys_id;
> +	__le64 rsvd1;
> +	__le64 rsvd2;
> +};
> +
>   /* Clear PXE Command and response (direct 0x0110) */
>   struct ice_aqc_clear_pxe {
>   	u8 rx_cnt;
> @@ -89,6 +125,161 @@ struct ice_aqc_clear_pxe {
>   	u8 reserved[15];
>   };
>   
> +/* Get switch configuration (0x0200) */
> +struct ice_aqc_get_sw_cfg {
> +	/* Reserved for command and copy of request flags for response */
> +	__le16 flags;
> +	/* First desc in case of command and next_elem in case of response
> +	 * In case of response, if it is not zero, means all the configuration
> +	 * was not returned and new command shall be sent with this value in
> +	 * the 'first desc' field
> +	 */
> +	__le16 element;
> +	/* Reserved for command, only used for response */
> +	__le16 num_elems;
> +	__le16 rsvd;
> +	__le32 addr_high;
> +	__le32 addr_low;
> +};
> +
> +/* Each entry in the response buffer is of the following type: */
> +struct ice_aqc_get_sw_cfg_resp_elem {
> +	/* VSI/Port Number */
> +	__le16 vsi_port_num;
> +#define ICE_AQC_GET_SW_CONF_RESP_VSI_PORT_NUM_S	0
> +#define ICE_AQC_GET_SW_CONF_RESP_VSI_PORT_NUM_M	\
> +			(0x3FF << ICE_AQC_GET_SW_CONF_RESP_VSI_PORT_NUM_S)
> +#define ICE_AQC_GET_SW_CONF_RESP_TYPE_S	14
> +#define ICE_AQC_GET_SW_CONF_RESP_TYPE_M	(0x3 << ICE_AQC_GET_SW_CONF_RESP_TYPE_S)
> +#define ICE_AQC_GET_SW_CONF_RESP_PHYS_PORT	0
> +#define ICE_AQC_GET_SW_CONF_RESP_VIRT_PORT	1
> +#define ICE_AQC_GET_SW_CONF_RESP_VSI		2
> +
> +	/* SWID VSI/Port belongs to */
> +	__le16 swid;
> +
> +	/* Bit 14..0 : PF/VF number VSI belongs to
> +	 * Bit 15 : VF indication bit
> +	 */
> +	__le16 pf_vf_num;
> +#define ICE_AQC_GET_SW_CONF_RESP_FUNC_NUM_S	0
> +#define ICE_AQC_GET_SW_CONF_RESP_FUNC_NUM_M	\
> +				(0x7FFF << ICE_AQC_GET_SW_CONF_RESP_FUNC_NUM_S)
> +#define ICE_AQC_GET_SW_CONF_RESP_IS_VF		BIT(15)
> +};
> +
> +/* The response buffer is as follows. Note that the length of the
> + * elements array varies with the length of the command response.
> + */
> +struct ice_aqc_get_sw_cfg_resp {
> +	struct ice_aqc_get_sw_cfg_resp_elem elements[1];
> +};
> +
> +/* Add TSE (indirect 0x0401)
> + * Delete TSE (indirect 0x040F)
> + * Move TSE (indirect 0x0408)
> + */
> +struct ice_aqc_add_move_delete_elem {
> +	__le16 num_grps_req;
> +	__le16 num_grps_updated;
> +	__le32 reserved;
> +	__le32 addr_high;
> +	__le32 addr_low;
> +};
> +
> +struct ice_aqc_elem_info_bw {
> +	__le16 bw_profile_idx;
> +	__le16 bw_alloc;
> +};
> +
> +struct ice_aqc_txsched_elem {
> +	u8 elem_type; /* Special field, reserved for some aq calls */
> +#define ICE_AQC_ELEM_TYPE_UNDEFINED		0x0
> +#define ICE_AQC_ELEM_TYPE_ROOT_PORT		0x1
> +#define ICE_AQC_ELEM_TYPE_TC			0x2
> +#define ICE_AQC_ELEM_TYPE_SE_GENERIC		0x3
> +#define ICE_AQC_ELEM_TYPE_ENTRY_POINT		0x4
> +#define ICE_AQC_ELEM_TYPE_LEAF			0x5
> +#define ICE_AQC_ELEM_TYPE_SE_PADDED		0x6
> +	u8 valid_sections;
> +#define ICE_AQC_ELEM_VALID_GENERIC		BIT(0)
> +#define ICE_AQC_ELEM_VALID_CIR			BIT(1)
> +#define ICE_AQC_ELEM_VALID_EIR			BIT(2)
> +#define ICE_AQC_ELEM_VALID_SHARED		BIT(3)
> +	u8 generic;
> +#define ICE_AQC_ELEM_GENERIC_MODE_M		0x1
> +#define ICE_AQC_ELEM_GENERIC_PRIO_S		0x1
> +#define ICE_AQC_ELEM_GENERIC_PRIO_M	(0x7 << ICE_AQC_ELEM_GENERIC_PRIO_S)
> +#define ICE_AQC_ELEM_GENERIC_SP_S		0x4
> +#define ICE_AQC_ELEM_GENERIC_SP_M	(0x1 << ICE_AQC_ELEM_GENERIC_SP_S)
> +#define ICE_AQC_ELEM_GENERIC_ADJUST_VAL_S	0x5
> +#define ICE_AQC_ELEM_GENERIC_ADJUST_VAL_M	\
> +	(0x3 << ICE_AQC_ELEM_GENERIC_ADJUST_VAL_S)
> +	u8 flags; /* Special field, reserved for some aq calls */
> +#define ICE_AQC_ELEM_FLAG_SUSPEND_M		0x1
> +	struct ice_aqc_elem_info_bw cir_bw;
> +	struct ice_aqc_elem_info_bw eir_bw;
> +	__le16 srl_id;
> +	__le16 reserved2;
> +};
> +
> +struct ice_aqc_txsched_elem_data {
> +	__le32 parent_teid;
> +	__le32 node_teid;
> +	struct ice_aqc_txsched_elem data;
> +};
> +
> +struct ice_aqc_txsched_topo_grp_info_hdr {
> +	__le32 parent_teid;
> +	__le16 num_elems;
> +	__le16 reserved2;
> +};
> +
> +struct ice_aqc_delete_elem {
> +	struct ice_aqc_txsched_topo_grp_info_hdr hdr;
> +	__le32 teid[1];
> +};
> +
> +/* Query Scheduler Resource Allocation (indirect 0x0412)
> + * This indirect command retrieves the scheduler resources allocated by
> + * EMP Firmware to the given PF.
> + */
> +struct ice_aqc_query_txsched_res {
> +	u8 reserved[8];
> +	__le32 addr_high;
> +	__le32 addr_low;
> +};
> +
> +struct ice_aqc_generic_sched_props {
> +	__le16 phys_levels;
> +	__le16 logical_levels;
> +	u8 flattening_bitmap;
> +	u8 max_device_cgds;
> +	u8 max_pf_cgds;
> +	u8 rsvd0;
> +	__le16 rdma_qsets;
> +	u8 rsvd1[22];
> +};
> +
> +struct ice_aqc_layer_props {
> +	u8 logical_layer;
> +	u8 chunk_size;
> +	__le16 max_device_nodes;
> +	__le16 max_pf_nodes;
> +	u8 rsvd0[2];
> +	__le16 max_shared_rate_lmtr;
> +	__le16 max_children;
> +	__le16 max_cir_rl_profiles;
> +	__le16 max_eir_rl_profiles;
> +	__le16 max_srl_profiles;
> +	u8 rsvd1[14];
> +};
> +
> +struct ice_aqc_query_txsched_res_resp {
> +	struct ice_aqc_generic_sched_props sched_props;
> +	struct ice_aqc_layer_props layer_props[ICE_AQC_TOPO_MAX_LEVEL_NUM];
> +};
> +
>   /* NVM Read command (indirect 0x0701)
>    * NVM Erase commands (direct 0x0702)
>    * NVM Update commands (indirect 0x0703)
> @@ -142,6 +333,10 @@ struct ice_aq_desc {
>   		struct ice_aqc_q_shutdown q_shutdown;
>   		struct ice_aqc_req_res res_owner;
>   		struct ice_aqc_clear_pxe clear_pxe;
> +		struct ice_aqc_list_caps get_cap;
> +		struct ice_aqc_get_sw_cfg get_sw_conf;
> +		struct ice_aqc_query_txsched_res query_sched_res;
> +		struct ice_aqc_add_move_delete_elem add_move_delete_elem;
>   		struct ice_aqc_nvm nvm;
>   	} params;
>   };
> @@ -150,16 +345,19 @@ struct ice_aq_desc {
>   #define ICE_AQ_LG_BUF	512
>   
>   #define ICE_AQ_FLAG_LB_S	9
> +#define ICE_AQ_FLAG_RD_S	10
>   #define ICE_AQ_FLAG_BUF_S	12
>   #define ICE_AQ_FLAG_SI_S	13
>   
>   #define ICE_AQ_FLAG_LB		BIT(ICE_AQ_FLAG_LB_S)  /* 0x200  */
> +#define ICE_AQ_FLAG_RD		BIT(ICE_AQ_FLAG_RD_S)  /* 0x400  */
>   #define ICE_AQ_FLAG_BUF		BIT(ICE_AQ_FLAG_BUF_S) /* 0x1000 */
>   #define ICE_AQ_FLAG_SI		BIT(ICE_AQ_FLAG_SI_S)  /* 0x2000 */
>   
>   /* error codes */
>   enum ice_aq_err {
>   	ICE_AQ_RC_OK		= 0,  /* success */
> +	ICE_AQ_RC_ENOMEM	= 9,  /* Out of memory */
>   	ICE_AQ_RC_EBUSY		= 12, /* Device or resource busy */
>   	ICE_AQ_RC_EEXIST	= 13, /* object already exists */
>   };
> @@ -174,11 +372,22 @@ enum ice_adminq_opc {
>   	ice_aqc_opc_req_res				= 0x0008,
>   	ice_aqc_opc_release_res				= 0x0009,
>   
> +	/* device/function capabilities */
> +	ice_aqc_opc_list_func_caps			= 0x000A,
> +	ice_aqc_opc_list_dev_caps			= 0x000B,
> +
>   	/* PXE */
>   	ice_aqc_opc_clear_pxe_mode			= 0x0110,
>   
> +	/* internal switch commands */
> +	ice_aqc_opc_get_sw_cfg				= 0x0200,
> +
>   	ice_aqc_opc_clear_pf_cfg			= 0x02A4,
>   
> +	/* transmit scheduler commands */
> +	ice_aqc_opc_delete_sched_elems			= 0x040F,
> +	ice_aqc_opc_query_sched_res			= 0x0412,
> +
>   	/* NVM commands */
>   	ice_aqc_opc_nvm_read				= 0x0701,
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index eb3e06488705..a64e406c129a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -16,9 +16,12 @@
>    */
>   
>   #include "ice_common.h"
> +#include "ice_sched.h"
>   #include "ice_adminq_cmd.h"
>   
>   #define ICE_PF_RESET_WAIT_COUNT	200
> +#define ICE_GET_CAP_BUF_COUNT	40
> +#define ICE_GET_CAP_RETRY_COUNT	20
>   
>   /**
>    * ice_set_mac_type - Sets MAC type
> @@ -84,8 +87,37 @@ enum ice_status ice_init_hw(struct ice_hw *hw)
>   	if (status)
>   		goto err_unroll_cqinit;
>   
> +	status = ice_get_caps(hw);
> +	if (status)
> +		goto err_unroll_cqinit;
> +
> +	hw->port_info = devm_kzalloc(ice_hw_to_dev(hw),
> +				     sizeof(*hw->port_info), GFP_KERNEL);
> +	if (!hw->port_info) {
> +		status = ICE_ERR_NO_MEMORY;
> +		goto err_unroll_cqinit;
> +	}
> +
> +	/* set the back pointer to hw */
> +	hw->port_info->hw = hw;
> +
> +	/* Initialize port_info struct with switch configuration data */
> +	status = ice_get_initial_sw_cfg(hw);
> +	if (status)
> +		goto err_unroll_alloc;
> +
> +	/* Query the allocated resources for tx scheduler */
> +	status = ice_sched_query_res_alloc(hw);
> +	if (status) {
> +		ice_debug(hw, ICE_DBG_SCHED,
> +			  "Failed to get scheduler allocated resources\n");
> +		goto err_unroll_alloc;
> +	}
> +
>   	return 0;
>   
> +err_unroll_alloc:
> +	devm_kfree(ice_hw_to_dev(hw), hw->port_info);
>   err_unroll_cqinit:
>   	ice_shutdown_all_ctrlq(hw);
>   	return status;
> @@ -97,7 +129,12 @@ enum ice_status ice_init_hw(struct ice_hw *hw)
>    */
>   void ice_deinit_hw(struct ice_hw *hw)
>   {
> +	ice_sched_cleanup_all(hw);
>   	ice_shutdown_all_ctrlq(hw);
> +	if (hw->port_info) {
> +		devm_kfree(ice_hw_to_dev(hw), hw->port_info);
> +		hw->port_info = NULL;
> +	}
>   }
>   
>   /**
> @@ -519,6 +556,192 @@ void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res)
>   	}
>   }
>   
> +/**
> + * ice_parse_caps - parse function/device capabilities
> + * @hw: pointer to the hw struct
> + * @buf: pointer to a buffer containing function/device capability records
> + * @cap_count: number of capability records in the list
> + * @opc: type of capabilities list to parse
> + *
> + * Helper function to parse function(0x000a)/device(0x000b) capabilities list.
> + */
> +static void
> +ice_parse_caps(struct ice_hw *hw, void *buf, u32 cap_count,
> +	       enum ice_adminq_opc opc)
> +{
> +	struct ice_aqc_list_caps_elem *cap_resp;
> +	struct ice_hw_func_caps *func_p = NULL;
> +	struct ice_hw_dev_caps *dev_p = NULL;
> +	struct ice_hw_common_caps *caps;
> +	u32 i;
> +
> +	if (!buf)
> +		return;
> +
> +	cap_resp = (struct ice_aqc_list_caps_elem *)buf;
> +
> +	if (opc == ice_aqc_opc_list_dev_caps) {
> +		dev_p = &hw->dev_caps;
> +		caps = &dev_p->common_cap;
> +	} else if (opc == ice_aqc_opc_list_func_caps) {
> +		func_p = &hw->func_caps;
> +		caps = &func_p->common_cap;
> +	} else {
> +		ice_debug(hw, ICE_DBG_INIT, "wrong opcode\n");
> +		return;
> +	}
> +
> +	for (i = 0; caps && i < cap_count; i++, cap_resp++) {
> +		u32 logical_id = le32_to_cpu(cap_resp->logical_id);
> +		u32 phys_id = le32_to_cpu(cap_resp->phys_id);
> +		u32 number = le32_to_cpu(cap_resp->number);
> +		u16 cap = le16_to_cpu(cap_resp->cap);
> +
> +		switch (cap) {
> +		case ICE_AQC_CAPS_VSI:
> +			if (dev_p) {
> +				dev_p->num_vsi_allocd_to_host = number;
> +				ice_debug(hw, ICE_DBG_INIT,
> +					  "HW caps: Dev.VSI cnt = %d\n",
> +					  dev_p->num_vsi_allocd_to_host);
> +			} else if (func_p) {
> +				func_p->guaranteed_num_vsi = number;
> +				ice_debug(hw, ICE_DBG_INIT,
> +					  "HW caps: Func.VSI cnt = %d\n",
> +					  func_p->guaranteed_num_vsi);
> +			}
> +			break;
> +		case ICE_AQC_CAPS_RSS:
> +			caps->rss_table_size = number;
> +			caps->rss_table_entry_width = logical_id;
> +			ice_debug(hw, ICE_DBG_INIT,
> +				  "HW caps: RSS table size = %d\n",
> +				  caps->rss_table_size);
> +			ice_debug(hw, ICE_DBG_INIT,
> +				  "HW caps: RSS table width = %d\n",
> +				  caps->rss_table_entry_width);
> +			break;
> +		case ICE_AQC_CAPS_RXQS:
> +			caps->num_rxq = number;
> +			caps->rxq_first_id = phys_id;
> +			ice_debug(hw, ICE_DBG_INIT,
> +				  "HW caps: Num Rx Qs = %d\n", caps->num_rxq);
> +			ice_debug(hw, ICE_DBG_INIT,
> +				  "HW caps: Rx first queue ID = %d\n",
> +				  caps->rxq_first_id);
> +			break;
> +		case ICE_AQC_CAPS_TXQS:
> +			caps->num_txq = number;
> +			caps->txq_first_id = phys_id;
> +			ice_debug(hw, ICE_DBG_INIT,
> +				  "HW caps: Num Tx Qs = %d\n", caps->num_txq);
> +			ice_debug(hw, ICE_DBG_INIT,
> +				  "HW caps: Tx first queue ID = %d\n",
> +				  caps->txq_first_id);
> +			break;
> +		case ICE_AQC_CAPS_MSIX:
> +			caps->num_msix_vectors = number;
> +			caps->msix_vector_first_id = phys_id;
> +			ice_debug(hw, ICE_DBG_INIT,
> +				  "HW caps: MSIX vector count = %d\n",
> +				  caps->num_msix_vectors);
> +			ice_debug(hw, ICE_DBG_INIT,
> +				  "HW caps: MSIX first vector index = %d\n",
> +				  caps->msix_vector_first_id);
> +			break;
> +		case ICE_AQC_CAPS_MAX_MTU:
> +			caps->max_mtu = number;
> +			if (dev_p)
> +				ice_debug(hw, ICE_DBG_INIT,
> +					  "HW caps: Dev.MaxMTU = %d\n",
> +					  caps->max_mtu);
> +			else if (func_p)
> +				ice_debug(hw, ICE_DBG_INIT,
> +					  "HW caps: func.MaxMTU = %d\n",
> +					  caps->max_mtu);
> +			break;
> +		default:
> +			ice_debug(hw, ICE_DBG_INIT,
> +				  "HW caps: Unknown capability[%d]: 0x%x\n", i,
> +				  cap);
> +			break;
> +		}
> +	}
> +}
> +
> +/**
> + * ice_aq_discover_caps - query function/device capabilities
> + * @hw: pointer to the hw struct
> + * @buf: a virtual buffer to hold the capabilities
> + * @buf_size: Size of the virtual buffer
> + * @data_size: Size of the returned data, or buf size needed if AQ err==ENOMEM
> + * @opc: capabilities type to discover - pass in the command opcode
> + * @cd: pointer to command details structure or NULL
> + *
> + * Get the function(0x000a)/device(0x000b) capabilities description from
> + * the firmware.
> + */
> +static enum ice_status
> +ice_aq_discover_caps(struct ice_hw *hw, void *buf, u16 buf_size, u16 *data_size,
> +		     enum ice_adminq_opc opc, struct ice_sq_cd *cd)
> +{
> +	struct ice_aqc_list_caps *cmd;
> +	struct ice_aq_desc desc;
> +	enum ice_status status;
> +
> +	cmd = &desc.params.get_cap;
> +
> +	if (opc != ice_aqc_opc_list_func_caps &&
> +	    opc != ice_aqc_opc_list_dev_caps)
> +		return ICE_ERR_PARAM;
> +
> +	ice_fill_dflt_direct_cmd_desc(&desc, opc);
> +
> +	status = ice_aq_send_cmd(hw, &desc, buf, buf_size, cd);
> +	if (!status)
> +		ice_parse_caps(hw, buf, le32_to_cpu(cmd->count), opc);
> +	*data_size = le16_to_cpu(desc.datalen);
> +
> +	return status;
> +}
> +
> +/**
> + * ice_get_caps - get info about the HW
> + * @hw: pointer to the hardware structure
> + */
> +enum ice_status ice_get_caps(struct ice_hw *hw)
> +{
> +	enum ice_status status;
> +	u16 data_size = 0;
> +	u16 cbuf_len;
> +	u8 retries;
> +
> +	cbuf_len = ICE_GET_CAP_BUF_COUNT *
> +		sizeof(struct ice_aqc_list_caps_elem);
> +
> +	retries = ICE_GET_CAP_RETRY_COUNT;
> +
> +	do {
> +		void *cbuf;
> +
> +		cbuf = devm_kzalloc(ice_hw_to_dev(hw), cbuf_len, GFP_KERNEL);
> +		if (!cbuf)
> +			return ICE_ERR_NO_MEMORY;
> +
> +		status = ice_aq_discover_caps(hw, cbuf, cbuf_len, &data_size,
> +					      ice_aqc_opc_list_func_caps, NULL);
> +		devm_kfree(ice_hw_to_dev(hw), cbuf);
> +
> +		if (!status || hw->adminq.sq_last_status != ICE_AQ_RC_ENOMEM)
> +			break;
> +
> +		/* If ENOMEM is returned, try again with bigger buffer */
> +		cbuf_len = data_size;
> +	} while (--retries);

If data size is the only reason for a retry, why bother with a retries 
variable of 20?  Is there any reason you won't be given the right 
data_size hint the first time?

sln
