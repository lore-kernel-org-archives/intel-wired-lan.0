From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 12 Mar 2018 19:05:31 -0700
Subject: [Intel-wired-lan] [PATCH 03/15] ice: Start hardware
 initialization
In-Reply-To: <20180309172136.9073-4-anirudh.venkataramanan@intel.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-4-anirudh.venkataramanan@intel.com>
Message-ID: <657f1de9-9727-6b01-1f79-957db6ef8852@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/9/2018 9:21 AM, Anirudh Venkataramanan wrote:
> This patch implements multiple pieces of the initialization flow
> as follows:
> 
> 1) A reset is issued to ensure a clean device state, followed
>     by initialization of admin queue interface.
> 
> 2) Once the admin queue interface is up, clear the PF config
>     and transition the device to non-PXE mode.
> 
> 3) Get the NVM configuration stored in the device's non-volatile
>     memory (NVM) using ice_init_nvm.
> 
> Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/Makefile         |   3 +-
>   drivers/net/ethernet/intel/ice/ice.h            |   2 +
>   drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  79 +++++
>   drivers/net/ethernet/intel/ice/ice_common.c     | 410 ++++++++++++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_common.h     |  11 +
>   drivers/net/ethernet/intel/ice/ice_controlq.h   |   3 +
>   drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  30 ++
>   drivers/net/ethernet/intel/ice/ice_main.c       |  31 ++
>   drivers/net/ethernet/intel/ice/ice_nvm.c        | 245 ++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_osdep.h      |   1 +
>   drivers/net/ethernet/intel/ice/ice_status.h     |   5 +
>   drivers/net/ethernet/intel/ice/ice_type.h       |  49 +++
>   12 files changed, 868 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/intel/ice/ice_nvm.c
> 
> diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
> index eebf619e84a8..373d481dbb25 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile
> @@ -26,4 +26,5 @@ obj-$(CONFIG_ICE) += ice.o
>   
>   ice-y := ice_main.o	\
>   	 ice_controlq.o	\
> -	 ice_common.o
> +	 ice_common.o	\
> +	 ice_nvm.o
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index ea2fb63bb095..ab2800c31906 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -30,8 +30,10 @@
>   #include <linux/bitmap.h>
>   #include "ice_devids.h"
>   #include "ice_type.h"
> +#include "ice_common.h"
>   
>   #define ICE_BAR0		0
> +#define ICE_AQ_LEN		64
>   
>   #define ICE_DFLT_NETIF_M (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK)
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index 885fa3c6fec4..05b22a1ffd70 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -50,6 +50,67 @@ struct ice_aqc_q_shutdown {
>   	u8 reserved[12];
>   };
>   
> +/* Request resource ownership (direct 0x0008)
> + * Release resource ownership (direct 0x0009)
> + */
> +struct ice_aqc_req_res {
> +	__le16 res_id;
> +#define ICE_AQC_RES_ID_NVM		1
> +#define ICE_AQC_RES_ID_SDP		2
> +#define ICE_AQC_RES_ID_CHNG_LOCK	3
> +#define ICE_AQC_RES_ID_GLBL_LOCK	4
> +	__le16 access_type;
> +#define ICE_AQC_RES_ACCESS_READ		1
> +#define ICE_AQC_RES_ACCESS_WRITE	2
> +
> +	/* Upon successful completion, FW writes this value and driver is
> +	 * expected to release resource before timeout. This value is provided
> +	 * in milliseconds.
> +	 */
> +	__le32 timeout;
> +#define ICE_AQ_RES_NVM_READ_DFLT_TIMEOUT_MS	3000
> +#define ICE_AQ_RES_NVM_WRITE_DFLT_TIMEOUT_MS	180000
> +#define ICE_AQ_RES_CHNG_LOCK_DFLT_TIMEOUT_MS	1000
> +#define ICE_AQ_RES_GLBL_LOCK_DFLT_TIMEOUT_MS	3000
> +	/* For SDP: pin id of the SDP */
> +	__le32 res_number;
> +	/* Status is only used for ICE_AQC_RES_ID_GLBL_LOCK */
> +	__le16 status;
> +#define ICE_AQ_RES_GLBL_SUCCESS		0
> +#define ICE_AQ_RES_GLBL_IN_PROG		1
> +#define ICE_AQ_RES_GLBL_DONE		2
> +	u8 reserved[2];

Since these structs all become part of the descriptor's param union, 
perhaps adding reserved space to the end is not necessary.

> +};
> +
> +/* Clear PXE Command and response (direct 0x0110) */
> +struct ice_aqc_clear_pxe {
> +	u8 rx_cnt;
> +#define ICE_AQC_CLEAR_PXE_RX_CNT		0x2
> +	u8 reserved[15];
> +};
> +
> +/* NVM Read command (indirect 0x0701)
> + * NVM Erase commands (direct 0x0702)
> + * NVM Update commands (indirect 0x0703)
> + */
> +struct ice_aqc_nvm {
> +	u8	cmd_flags;
> +#define ICE_AQC_NVM_LAST_CMD		BIT(0)
> +#define ICE_AQC_NVM_PCIR_REQ		BIT(0)	/* Used by NVM Update reply */
> +#define ICE_AQC_NVM_PRESERVATION_S	1
> +#define ICE_AQC_NVM_PRESERVATION_M	(3 << CSR_AQ_NVM_PRESERVATION_S)
> +#define ICE_AQC_NVM_NO_PRESERVATION	(0 << CSR_AQ_NVM_PRESERVATION_S)
> +#define ICE_AQC_NVM_PRESERVE_ALL	BIT(1)
> +#define ICE_AQC_NVM_PRESERVE_SELECTED	(3 << CSR_AQ_NVM_PRESERVATION_S)
> +#define ICE_AQC_NVM_FLASH_ONLY		BIT(7)
> +	u8	module_typeid;
> +	__le16	length;
> +#define ICE_AQC_NVM_ERASE_LEN	0xFFFF
> +	__le32	offset;
> +	__le32	addr_high;
> +	__le32	addr_low;
> +};
> +
>   /**
>    * struct ice_aq_desc - Admin Queue (AQ) descriptor
>    * @flags: ICE_AQ_FLAG_* flags
> @@ -79,6 +140,9 @@ struct ice_aq_desc {
>   		struct ice_aqc_generic generic;
>   		struct ice_aqc_get_ver get_ver;
>   		struct ice_aqc_q_shutdown q_shutdown;
> +		struct ice_aqc_req_res res_owner;
> +		struct ice_aqc_clear_pxe clear_pxe;
> +		struct ice_aqc_nvm nvm;
>   	} params;
>   };
>   
> @@ -96,6 +160,8 @@ struct ice_aq_desc {
>   /* error codes */
>   enum ice_aq_err {
>   	ICE_AQ_RC_OK		= 0,  /* success */
> +	ICE_AQ_RC_EBUSY		= 12, /* Device or resource busy */
> +	ICE_AQ_RC_EEXIST	= 13, /* object already exists */

Are we eventually going to get an ENOTTY error value?  :-)

>   };
>   
>   /* Admin Queue command opcodes */
> @@ -103,6 +169,19 @@ enum ice_adminq_opc {
>   	/* AQ commands */
>   	ice_aqc_opc_get_ver				= 0x0001,
>   	ice_aqc_opc_q_shutdown				= 0x0003,
> +
> +	/* resource ownership */
> +	ice_aqc_opc_req_res				= 0x0008,
> +	ice_aqc_opc_release_res				= 0x0009,
> +
> +	/* PXE */
> +	ice_aqc_opc_clear_pxe_mode			= 0x0110,
> +
> +	ice_aqc_opc_clear_pf_cfg			= 0x02A4,
> +
> +	/* NVM commands */
> +	ice_aqc_opc_nvm_read				= 0x0701,
> +
>   };
>   
>   #endif /* _ICE_ADMINQ_CMD_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index d980f0518744..eb3e06488705 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -18,6 +18,224 @@
>   #include "ice_common.h"
>   #include "ice_adminq_cmd.h"
>   
> +#define ICE_PF_RESET_WAIT_COUNT	200
> +
> +/**
> + * ice_set_mac_type - Sets MAC type
> + * @hw: pointer to the HW structure
> + *
> + * This function sets the MAC type of the adapter based on the
> + * vendor ID and device ID stored in the hw structure.
> + */
> +static enum ice_status ice_set_mac_type(struct ice_hw *hw)
> +{
> +	if (hw->vendor_id != PCI_VENDOR_ID_INTEL)
> +		return ICE_ERR_DEVICE_NOT_SUPPORTED;
> +
> +	hw->mac_type = ICE_MAC_GENERIC;
> +	return 0;
> +}
> +
> +/**
> + * ice_clear_pf_cfg - Clear PF configuration
> + * @hw: pointer to the hardware structure
> + */
> +enum ice_status ice_clear_pf_cfg(struct ice_hw *hw)
> +{
> +	struct ice_aq_desc desc;
> +
> +	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_clear_pf_cfg);
> +
> +	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
> +}
> +
> +/**
> + * ice_init_hw - main hardware initialization routine
> + * @hw: pointer to the hardware structure
> + */
> +enum ice_status ice_init_hw(struct ice_hw *hw)
> +{
> +	enum ice_status status;
> +
> +	/* Set MAC type based on DeviceID */
> +	status = ice_set_mac_type(hw);
> +	if (status)
> +		return status;
> +
> +	hw->pf_id = (u8)(rd32(hw, PF_FUNC_RID) &
> +			 PF_FUNC_RID_FUNC_NUM_M) >>
> +		PF_FUNC_RID_FUNC_NUM_S;
> +
> +	status = ice_reset(hw, ICE_RESET_PFR);
> +	if (status)
> +		return status;
> +
> +	status = ice_init_all_ctrlq(hw);
> +	if (status)
> +		goto err_unroll_cqinit;
> +
> +	status = ice_clear_pf_cfg(hw);
> +	if (status)
> +		goto err_unroll_cqinit;
> +
> +	ice_clear_pxe_mode(hw);
> +
> +	status = ice_init_nvm(hw);
> +	if (status)
> +		goto err_unroll_cqinit;
> +
> +	return 0;
> +
> +err_unroll_cqinit:
> +	ice_shutdown_all_ctrlq(hw);
> +	return status;
> +}
> +
> +/**
> + * ice_deinit_hw - unroll initialization operations done by ice_init_hw
> + * @hw: pointer to the hardware structure
> + */
> +void ice_deinit_hw(struct ice_hw *hw)
> +{
> +	ice_shutdown_all_ctrlq(hw);
> +}
> +
> +/**
> + * ice_check_reset - Check to see if a global reset is complete
> + * @hw: pointer to the hardware structure
> + */
> +enum ice_status ice_check_reset(struct ice_hw *hw)
> +{
> +	u32 cnt, reg = 0, grst_delay;
> +
> +	/* Poll for Device Active state in case a recent CORER, GLOBR,
> +	 * or EMPR has occurred. The grst delay value is in 100ms units.
> +	 * Add 1sec for outstanding AQ commands that can take a long time.
> +	 */
> +	grst_delay = ((rd32(hw, GLGEN_RSTCTL) & GLGEN_RSTCTL_GRSTDEL_M) >>
> +		      GLGEN_RSTCTL_GRSTDEL_S) + 10;

Will this be long enough for any longer-running async completion 
commands, maybe for NVM?  Or will that matter?

> +
> +	for (cnt = 0; cnt < grst_delay; cnt++) {
> +		mdelay(100);
> +		reg = rd32(hw, GLGEN_RSTAT);
> +		if (!(reg & GLGEN_RSTAT_DEVSTATE_M))
> +			break;
> +	}
> +
> +	if (cnt == grst_delay) {
> +		ice_debug(hw, ICE_DBG_INIT,
> +			  "Global reset polling failed to complete.\n");
> +		return ICE_ERR_RESET_FAILED;
> +	}
> +
> +#define ICE_RESET_DONE_MASK	(GLNVM_ULD_CORER_DONE_M | \
> +				 GLNVM_ULD_GLOBR_DONE_M)
> +
> +	/* Device is Active; check Global Reset processes are done */
> +	for (cnt = 0; cnt < ICE_PF_RESET_WAIT_COUNT; cnt++) {
> +		reg = rd32(hw, GLNVM_ULD) & ICE_RESET_DONE_MASK;
> +		if (reg == ICE_RESET_DONE_MASK) {
> +			ice_debug(hw, ICE_DBG_INIT,
> +				  "Global reset processes done. %d\n", cnt);
> +			break;
> +		}
> +		mdelay(10);
> +	}
> +
> +	if (cnt == ICE_PF_RESET_WAIT_COUNT) {
> +		ice_debug(hw, ICE_DBG_INIT,
> +			  "Wait for Reset Done timed out. GLNVM_ULD = 0x%x\n",
> +			  reg);
> +		return ICE_ERR_RESET_FAILED;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_pf_reset - Reset the PF
> + * @hw: pointer to the hardware structure
> + *
> + * If a global reset has been triggered, this function checks
> + * for its completion and then issues the PF reset
> + */
> +static enum ice_status ice_pf_reset(struct ice_hw *hw)
> +{
> +	u32 cnt, reg;
> +
> +	/* If at function entry a global reset was already in progress, i.e.
> +	 * state is not 'device active' or any of the reset done bits are not
> +	 * set in GLNVM_ULD, there is no need for a PF Reset; poll until the
> +	 * global reset is done.
> +	 */
> +	if ((rd32(hw, GLGEN_RSTAT) & GLGEN_RSTAT_DEVSTATE_M) ||
> +	    (rd32(hw, GLNVM_ULD) & ICE_RESET_DONE_MASK) ^ ICE_RESET_DONE_MASK) {
> +		/* poll on global reset currently in progress until done */
> +		if (ice_check_reset(hw))
> +			return ICE_ERR_RESET_FAILED;
> +
> +		return 0;
> +	}
> +
> +	/* Reset the PF */
> +	reg = rd32(hw, PFGEN_CTRL);
> +
> +	wr32(hw, PFGEN_CTRL, (reg | PFGEN_CTRL_PFSWR_M));
> +
> +	for (cnt = 0; cnt < ICE_PF_RESET_WAIT_COUNT; cnt++) {
> +		reg = rd32(hw, PFGEN_CTRL);
> +		if (!(reg & PFGEN_CTRL_PFSWR_M))
> +			break;
> +
> +		mdelay(1);
> +	}
> +
> +	if (cnt == ICE_PF_RESET_WAIT_COUNT) {
> +		ice_debug(hw, ICE_DBG_INIT,
> +			  "PF reset polling failed to complete.\n");
> +		return ICE_ERR_RESET_FAILED;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_reset - Perform different types of reset
> + * @hw: pointer to the hardware structure
> + * @req: reset request
> + *
> + * This function triggers a reset as specified by the req parameter.
> + *
> + * Note:
> + * If anything other than a PF reset is triggered, PXE mode is restored.
> + * This has to be cleared using ice_clear_pxe_mode again, once the AQ
> + * interface has been restored in the rebuild flow.
> + */
> +enum ice_status ice_reset(struct ice_hw *hw, enum ice_reset_req req)
> +{
> +	u32 val = 0;
> +
> +	switch (req) {
> +	case ICE_RESET_PFR:
> +		return ice_pf_reset(hw);
> +	case ICE_RESET_CORER:
> +		ice_debug(hw, ICE_DBG_INIT, "CoreR requested\n");
> +		val = GLGEN_RTRIG_CORER_M;
> +		break;
> +	case ICE_RESET_GLOBR:
> +		ice_debug(hw, ICE_DBG_INIT, "GlobalR requested\n");
> +		val = GLGEN_RTRIG_GLOBR_M;
> +		break;
> +	}
> +
> +	val |= rd32(hw, GLGEN_RTRIG);
> +	wr32(hw, GLGEN_RTRIG, val);
> +	ice_flush(hw);
> +
> +	/* wait for the FW to be ready */
> +	return ice_check_reset(hw);
> +}
> +
>   /**
>    * ice_debug_cq
>    * @hw: pointer to the hardware structure
> @@ -142,3 +360,195 @@ enum ice_status ice_aq_q_shutdown(struct ice_hw *hw, bool unloading)
>   
>   	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
>   }
> +
> +/**
> + * ice_aq_req_res
> + * @hw: pointer to the hw struct
> + * @res: resource id
> + * @access: access type
> + * @sdp_number: resource number
> + * @timeout: the maximum time in ms that the driver may hold the resource
> + * @cd: pointer to command details structure or NULL
> + *
> + * requests common resource using the admin queue commands (0x0008)
> + */
> +static enum ice_status
> +ice_aq_req_res(struct ice_hw *hw, enum ice_aq_res_ids res,
> +	       enum ice_aq_res_access_type access, u8 sdp_number, u32 *timeout,
> +	       struct ice_sq_cd *cd)
> +{
> +	struct ice_aqc_req_res *cmd_resp;
> +	struct ice_aq_desc desc;
> +	enum ice_status status;
> +
> +	cmd_resp = &desc.params.res_owner;
> +
> +	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_req_res);
> +
> +	cmd_resp->res_id = cpu_to_le16(res);
> +	cmd_resp->access_type = cpu_to_le16(access);
> +	cmd_resp->res_number = cpu_to_le32(sdp_number);
> +
> +	status = ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
> +	/* The completion specifies the maximum time in ms that the driver
> +	 * may hold the resource in the Timeout field.
> +	 * If the resource is held by someone else, the command completes with
> +	 * busy return value and the timeout field indicates the maximum time
> +	 * the current owner of the resource has to free it.
> +	 */
> +	if (!status || hw->adminq.sq_last_status == ICE_AQ_RC_EBUSY)
> +		*timeout = le32_to_cpu(cmd_resp->timeout);
> +
> +	return status;
> +}
> +
> +/**
> + * ice_aq_release_res
> + * @hw: pointer to the hw struct
> + * @res: resource id
> + * @sdp_number: resource number
> + * @cd: pointer to command details structure or NULL
> + *
> + * release common resource using the admin queue commands (0x0009)
> + */
> +static enum ice_status
> +ice_aq_release_res(struct ice_hw *hw, enum ice_aq_res_ids res, u8 sdp_number,
> +		   struct ice_sq_cd *cd)
> +{
> +	struct ice_aqc_req_res *cmd;
> +	struct ice_aq_desc desc;
> +
> +	cmd = &desc.params.res_owner;
> +
> +	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_release_res);
> +
> +	cmd->res_id = cpu_to_le16(res);
> +	cmd->res_number = cpu_to_le32(sdp_number);
> +
> +	return ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
> +}
> +
> +/**
> + * ice_acquire_res
> + * @hw: pointer to the HW structure
> + * @res: resource id
> + * @access: access type (read or write)
> + *
> + * This function will attempt to acquire the ownership of a resource.
> + */
> +enum ice_status
> +ice_acquire_res(struct ice_hw *hw, enum ice_aq_res_ids res,
> +		enum ice_aq_res_access_type access)
> +{
> +#define ICE_RES_POLLING_DELAY_MS	10
> +	u32 delay = ICE_RES_POLLING_DELAY_MS;
> +	enum ice_status status;
> +	u32 time_left = 0;
> +	u32 timeout;
> +
> +	status = ice_aq_req_res(hw, res, access, 0, &time_left, NULL);
> +
> +	/* An admin queue return code of ICE_AQ_RC_EEXIST means that another
> +	 * driver has previously acquired the resource and performed any
> +	 * necessary updates; in this case the caller does not obtain the
> +	 * resource and has no further work to do.
> +	 */
> +	if (hw->adminq.sq_last_status == ICE_AQ_RC_EEXIST) {
> +		status = ICE_ERR_AQ_NO_WORK;
> +		goto ice_acquire_res_exit;
> +	}
> +
> +	if (status)
> +		ice_debug(hw, ICE_DBG_RES,
> +			  "resource %d acquire type %d failed.\n", res, access);
> +
> +	/* If necessary, poll until the current lock owner timeouts */
> +	timeout = time_left;
> +	while (status && timeout && time_left) {
> +		mdelay(delay);
> +		timeout = (timeout > delay) ? timeout - delay : 0;
> +		status = ice_aq_req_res(hw, res, access, 0, &time_left, NULL);
> +
> +		if (hw->adminq.sq_last_status == ICE_AQ_RC_EEXIST) {
> +			/* lock free, but no work to do */
> +			status = ICE_ERR_AQ_NO_WORK;
> +			break;
> +		}
> +
> +		if (!status)
> +			/* lock acquired */
> +			break;
> +	}
> +	if (status && status != ICE_ERR_AQ_NO_WORK)
> +		ice_debug(hw, ICE_DBG_RES, "resource acquire timed out.\n");
> +
> +ice_acquire_res_exit:
> +	if (status == ICE_ERR_AQ_NO_WORK) {
> +		if (access == ICE_RES_WRITE)
> +			ice_debug(hw, ICE_DBG_RES,
> +				  "resource indicates no work to do.\n");
> +		else
> +			ice_debug(hw, ICE_DBG_RES,
> +				  "Warning: ICE_ERR_AQ_NO_WORK not expected\n");
> +	}
> +	return status;
> +}
> +
> +/**
> + * ice_release_res
> + * @hw: pointer to the HW structure
> + * @res: resource id
> + *
> + * This function will release a resource using the proper Admin Command.
> + */
> +void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res)
> +{
> +	enum ice_status status;
> +	u32 total_delay = 0;
> +
> +	status = ice_aq_release_res(hw, res, 0, NULL);
> +
> +	/* there are some rare cases when trying to release the resource
> +	 * results in an admin Q timeout, so handle them correctly
> +	 */
> +	while ((status == ICE_ERR_AQ_TIMEOUT) &&
> +	       (total_delay < hw->adminq.sq_cmd_timeout)) {
> +		mdelay(1);
> +		status = ice_aq_release_res(hw, res, 0, NULL);
> +		total_delay++;
> +	}
> +}
> +
> +/**
> + * ice_aq_clear_pxe_mode
> + * @hw: pointer to the hw struct
> + *
> + * Tell the firmware that the driver is taking over from PXE (0x0110).
> + */
> +static enum ice_status ice_aq_clear_pxe_mode(struct ice_hw *hw)
> +{
> +	struct ice_aq_desc desc;
> +	enum ice_status status;
> +
> +	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_clear_pxe_mode);
> +	desc.params.clear_pxe.rx_cnt = ICE_AQC_CLEAR_PXE_RX_CNT;
> +
> +	status = ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
> +
> +	wr32(hw, GLLAN_RCTL_0, 0x1);

So you can do this write regardless of the send_cmd() status?

> +
> +	return status;
> +}
> +
> +/**
> + * ice_clear_pxe_mode - clear pxe operations mode
> + * @hw: pointer to the hw struct
> + *
> + * Make sure all PXE mode settings are cleared, including things
> + * like descriptor fetch/write-back mode.
> + */
> +void ice_clear_pxe_mode(struct ice_hw *hw)
> +{
> +	if (ice_check_sq_alive(hw, &hw->adminq))
> +		ice_aq_clear_pxe_mode(hw);
> +}
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
> index 1e3caecc38c6..0876fd98090a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.h
> +++ b/drivers/net/ethernet/intel/ice/ice_common.h
> @@ -23,12 +23,22 @@
>   
>   void ice_debug_cq(struct ice_hw *hw, u32 mask, void *desc, void *buf,
>   		  u16 buf_len);
> +enum ice_status ice_init_hw(struct ice_hw *hw);
> +void ice_deinit_hw(struct ice_hw *hw);
> +enum ice_status ice_check_reset(struct ice_hw *hw);
> +enum ice_status ice_reset(struct ice_hw *hw, enum ice_reset_req req);
>   enum ice_status ice_init_all_ctrlq(struct ice_hw *hw);
>   void ice_shutdown_all_ctrlq(struct ice_hw *hw);
>   enum ice_status
> +ice_acquire_res(struct ice_hw *hw, enum ice_aq_res_ids res,
> +		enum ice_aq_res_access_type access);
> +void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res);
> +enum ice_status ice_init_nvm(struct ice_hw *hw);
> +enum ice_status
>   ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
>   		struct ice_aq_desc *desc, void *buf, u16 buf_size,
>   		struct ice_sq_cd *cd);
> +void ice_clear_pxe_mode(struct ice_hw *hw);
>   bool ice_check_sq_alive(struct ice_hw *hw, struct ice_ctl_q_info *cq);
>   enum ice_status ice_aq_q_shutdown(struct ice_hw *hw, bool unloading);
>   void ice_fill_dflt_direct_cmd_desc(struct ice_aq_desc *desc, u16 opcode);
> @@ -36,4 +46,5 @@ enum ice_status
>   ice_aq_send_cmd(struct ice_hw *hw, struct ice_aq_desc *desc,
>   		void *buf, u16 buf_size, struct ice_sq_cd *cd);
>   enum ice_status ice_aq_get_fw_ver(struct ice_hw *hw, struct ice_sq_cd *cd);
> +enum ice_status ice_clear_pf_cfg(struct ice_hw *hw);
>   #endif /* _ICE_COMMON_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
> index 143578d02aec..835c035419a3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_controlq.h
> +++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
> @@ -20,6 +20,9 @@
>   
>   #include "ice_adminq_cmd.h"
>   
> +/* Maximum buffer lengths for all control queue types */
> +#define ICE_AQ_MAX_BUF_LEN 4096
> +
>   #define ICE_CTL_Q_DESC(R, i) \
>   	(&(((struct ice_aq_desc *)((R).desc_buf.va))[i]))
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
> index 3d6bb273e4c8..e258a12099b8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
> +++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
> @@ -42,5 +42,35 @@
>   #define PF_FW_ATQLEN_ATQENABLE_S	31
>   #define PF_FW_ATQLEN_ATQENABLE_M	BIT(PF_FW_ATQLEN_ATQENABLE_S)
>   #define PF_FW_ATQT			0x00080400
> +#define GLGEN_RSTAT			0x000B8188
> +#define GLGEN_RSTAT_DEVSTATE_S		0
> +#define GLGEN_RSTAT_DEVSTATE_M		ICE_M(0x3, GLGEN_RSTAT_DEVSTATE_S)
> +#define GLGEN_RSTCTL			0x000B8180
> +#define GLGEN_RSTCTL_GRSTDEL_S		0
> +#define GLGEN_RSTCTL_GRSTDEL_M		ICE_M(0x3F, GLGEN_RSTCTL_GRSTDEL_S)
> +#define GLGEN_RTRIG			0x000B8190
> +#define GLGEN_RTRIG_CORER_S		0
> +#define GLGEN_RTRIG_CORER_M		BIT(GLGEN_RTRIG_CORER_S)
> +#define GLGEN_RTRIG_GLOBR_S		1
> +#define GLGEN_RTRIG_GLOBR_M		BIT(GLGEN_RTRIG_GLOBR_S)
> +#define GLGEN_STAT			0x000B612C
> +#define PFGEN_CTRL			0x00091000
> +#define PFGEN_CTRL_PFSWR_S		0
> +#define PFGEN_CTRL_PFSWR_M		BIT(PFGEN_CTRL_PFSWR_S)
> +#define GLLAN_RCTL_0			0x002941F8
> +#define GLNVM_FLA			0x000B6108
> +#define GLNVM_FLA_LOCKED_S		6
> +#define GLNVM_FLA_LOCKED_M		BIT(GLNVM_FLA_LOCKED_S)
> +#define GLNVM_GENS			0x000B6100
> +#define GLNVM_GENS_SR_SIZE_S		5
> +#define GLNVM_GENS_SR_SIZE_M		ICE_M(0x7, GLNVM_GENS_SR_SIZE_S)
> +#define GLNVM_ULD			0x000B6008
> +#define GLNVM_ULD_CORER_DONE_S		3
> +#define GLNVM_ULD_CORER_DONE_M		BIT(GLNVM_ULD_CORER_DONE_S)
> +#define GLNVM_ULD_GLOBR_DONE_S		4
> +#define GLNVM_ULD_GLOBR_DONE_M		BIT(GLNVM_ULD_GLOBR_DONE_S)
> +#define PF_FUNC_RID			0x0009E880
> +#define PF_FUNC_RID_FUNC_NUM_S		0
> +#define PF_FUNC_RID_FUNC_NUM_M		ICE_M(0x7, PF_FUNC_RID_FUNC_NUM_S)
>   
>   #endif /* _ICE_HW_AUTOGEN_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 408ae90d6562..2ee4a0547ba3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -40,6 +40,18 @@ MODULE_PARM_DESC(debug, "netif level (0=none,...,16=all), hw debug_mask (0x8XXXX
>   MODULE_PARM_DESC(debug, "netif level (0=none,...,16=all)");
>   #endif /* !CONFIG_DYNAMIC_DEBUG */
>   
> +/**
> + * ice_set_ctrlq_len - helper function to set controlq length
> + * @hw: pointer to the hw instance
> + */
> +static void ice_set_ctrlq_len(struct ice_hw *hw)
> +{
> +	hw->adminq.num_rq_entries = ICE_AQ_LEN;
> +	hw->adminq.num_sq_entries = ICE_AQ_LEN;
> +	hw->adminq.rq_buf_size = ICE_AQ_MAX_BUF_LEN;
> +	hw->adminq.sq_buf_size = ICE_AQ_MAX_BUF_LEN;
> +}
> +
>   /**
>    * ice_probe - Device initialization routine
>    * @pdev: PCI device information struct
> @@ -95,6 +107,8 @@ static int ice_probe(struct pci_dev *pdev,
>   	hw->subsystem_device_id = pdev->subsystem_device;
>   	hw->bus.device = PCI_SLOT(pdev->devfn);
>   	hw->bus.func = PCI_FUNC(pdev->devfn);
> +	ice_set_ctrlq_len(hw);
> +
>   	pf->msg_enable = netif_msg_init(debug, ICE_DFLT_NETIF_M);
>   
>   #ifndef CONFIG_DYNAMIC_DEBUG
> @@ -102,7 +116,22 @@ static int ice_probe(struct pci_dev *pdev,
>   		hw->debug_mask = debug;
>   #endif
>   
> +	err = ice_init_hw(hw);
> +	if (err) {
> +		dev_err(&pdev->dev, "ice_init_hw failed: %d\n", err);
> +		err = -EIO;
> +		goto err_exit_unroll;
> +	}
> +
> +	dev_info(&pdev->dev, "firmware %d.%d.%05d api %d.%d\n",
> +		 hw->fw_maj_ver, hw->fw_min_ver, hw->fw_build,
> +		 hw->api_maj_ver, hw->api_min_ver);
> +
>   	return 0;
> +
> +err_exit_unroll:
> +	pci_disable_pcie_error_reporting(pdev);
> +	return err;
>   }
>   
>   /**
> @@ -117,6 +146,8 @@ static void ice_remove(struct pci_dev *pdev)
>   		return;
>   
>   	set_bit(__ICE_DOWN, pf->state);
> +
> +	ice_deinit_hw(&pf->hw);
>   	pci_disable_pcie_error_reporting(pdev);
>   }
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
> new file mode 100644
> index 000000000000..565910f01290
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Intel(R) Ethernet Connection E800 Series Linux Driver
> + * Copyright (c) 2018, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * The full GNU General Public License is included in this distribution in
> + * the file called "COPYING".
> + */
> +
> +#include "ice_common.h"
> +
> +/**
> + * ice_aq_read_nvm
> + * @hw: pointer to the hw struct
> + * @module_typeid: module pointer location in words from the NVM beginning
> + * @offset: byte offset from the module beginning
> + * @length: length of the section to be read (in bytes from the offset)
> + * @data: command buffer (size [bytes] = length)
> + * @last_command: tells if this is the last command in a series
> + * @cd: pointer to command details structure or NULL
> + *
> + * Read the NVM using the admin queue commands (0x0701)
> + */
> +static enum ice_status
> +ice_aq_read_nvm(struct ice_hw *hw, u8 module_typeid, u32 offset, u16 length,
> +		void *data, bool last_command, struct ice_sq_cd *cd)
> +{
> +	struct ice_aq_desc desc;
> +	struct ice_aqc_nvm *cmd;
> +
> +	cmd = &desc.params.nvm;
> +
> +	/* In offset the highest byte must be zeroed. */
> +	if (offset & 0xFF000000)
> +		return ICE_ERR_PARAM;
> +
> +	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_nvm_read);
> +
> +	/* If this is the last command in a series, set the proper flag. */
> +	if (last_command)
> +		cmd->cmd_flags |= ICE_AQC_NVM_LAST_CMD;
> +	cmd->module_typeid = module_typeid;
> +	cmd->offset = cpu_to_le32(offset);
> +	cmd->length = cpu_to_le16(length);
> +
> +	return ice_aq_send_cmd(hw, &desc, data, length, cd);
> +}
> +
> +/**
> + * ice_check_sr_access_params - verify params for Shadow RAM R/W operations.
> + * @hw: pointer to the HW structure
> + * @offset: offset in words from module start
> + * @words: number of words to access
> + */
> +static enum ice_status
> +ice_check_sr_access_params(struct ice_hw *hw, u32 offset, u16 words)
> +{
> +	if ((offset + words) > hw->nvm.sr_words) {
> +		ice_debug(hw, ICE_DBG_NVM,
> +			  "NVM error: offset beyond SR lmt.\n");
> +		return ICE_ERR_PARAM;
> +	}
> +
> +	if (words > ICE_SR_SECTOR_SIZE_IN_WORDS) {
> +		/* We can access only up to 4KB (one sector), in one AQ write */
> +		ice_debug(hw, ICE_DBG_NVM,
> +			  "NVM error: tried to access %d words, limit is %d.\n",
> +			  words, ICE_SR_SECTOR_SIZE_IN_WORDS);
> +		return ICE_ERR_PARAM;
> +	}
> +
> +	if (((offset + (words - 1)) / ICE_SR_SECTOR_SIZE_IN_WORDS) !=
> +	    (offset / ICE_SR_SECTOR_SIZE_IN_WORDS)) {
> +		/* A single access cannot spread over two sectors */
> +		ice_debug(hw, ICE_DBG_NVM,
> +			  "NVM error: cannot spread over two sectors.\n");
> +		return ICE_ERR_PARAM;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_read_sr_aq - Read Shadow RAM.
> + * @hw: pointer to the HW structure
> + * @offset: offset in words from module start
> + * @words: number of words to read
> + * @data: buffer for words reads from Shadow RAM
> + * @last_command: tells the AdminQ that this is the last command
> + *
> + * Reads 16-bit word buffers from the Shadow RAM using the admin command.
> + */
> +static enum ice_status
> +ice_read_sr_aq(struct ice_hw *hw, u32 offset, u16 words, u16 *data,
> +	       bool last_command)
> +{
> +	enum ice_status status;
> +
> +	status = ice_check_sr_access_params(hw, offset, words);
> +	if (!status)
> +		status = ice_aq_read_nvm(hw, 0, 2 * offset, 2 * words, data,

Why the doubling of offset and words?  If this is some general 
adjustment made for the AQ interface, it should be made in 
ice_aq_read_nvm().  If not, then some explanation is needed here.

sln

