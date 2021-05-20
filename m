From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 20 May 2021 09:48:45 -0700
Subject: [Intel-wired-lan] [PATCH 3/8] ice: add support for set/get of
 driver-stored firmware parameters
In-Reply-To: <20210520164850.1884656-1-jacob.e.keller@intel.com>
References: <20210520164850.1884656-1-jacob.e.keller@intel.com>
Message-ID: <20210520164850.1884656-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Depending on the device configuration, the ice hardware may share the
PTP hardware clock timer between multiple PFs. Each PF is informed by
firmware during initialization of the PTP timer association.

When bringing up PTP, only the PFs which own the timer shall allocate
a PTP hardware clock. Other PFs associated with that timer must report
the correct PTP clock index in order to allow userspace software the
ability to know which ports are connected to the same clock.

To support this, the firmware has driver shared parameters. These
parameters enable one PF to write the clock index into firmware, and
have other PFs read the associated value out. This enables the driver to
have only a single PF allocate and control the device timer registers,
while other PFs associated with that timer can report the correct clock
in the ETHTOOL_GET_TS_INFO report.

Add support for the necessary admin queue commands to enable reading and
writing of the driver shared parameters. This will be used in a future
change to enable sharing the PTP clock index between PF drivers.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 27 +++++++
 drivers/net/ethernet/intel/ice/ice_common.c   | 75 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |  6 ++
 3 files changed, 108 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 2edee746a03c..bf1bf5e6697f 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1822,6 +1822,30 @@ struct ice_aqc_get_pkg_info_resp {
 	struct ice_aqc_get_pkg_info pkg_info[];
 };
 
+/* Driver Shared Parameters (direct, 0x0C90) */
+struct ice_aqc_driver_shared_params {
+	u8 set_or_get_op;
+#define ICE_AQC_DRIVER_PARAM_OP_MASK		BIT(0)
+#define ICE_AQC_DRIVER_PARAM_SET		0
+#define ICE_AQC_DRIVER_PARAM_GET		1
+	u8 param_indx;
+#define ICE_AQC_DRIVER_PARAM_MAX_IDX		15
+	u8 rsvd[2];
+	__le32 param_val;
+	__le32 addr_high;
+	__le32 addr_low;
+};
+
+enum ice_aqc_driver_params {
+	/* OS clock index for PTP timer Domain 0 */
+	ICE_AQC_DRIVER_PARAM_CLK_IDX_TMR0 = 0,
+	/* OS clock index for PTP timer Domain 1 */
+	ICE_AQC_DRIVER_PARAM_CLK_IDX_TMR1,
+
+	/* Add new parameters above */
+	ICE_AQC_DRIVER_PARAM_MAX = 16,
+};
+
 /* Lan Queue Overflow Event (direct, 0x1001) */
 struct ice_aqc_event_lan_overflow {
 	__le32 prtdcb_ruptq;
@@ -1898,6 +1922,7 @@ struct ice_aq_desc {
 		struct ice_aqc_fw_logging fw_logging;
 		struct ice_aqc_get_clear_fw_log get_clear_fw_log;
 		struct ice_aqc_download_pkg download_pkg;
+		struct ice_aqc_driver_shared_params drv_shared_params;
 		struct ice_aqc_set_mac_lb set_mac_lb;
 		struct ice_aqc_alloc_free_res_cmd sw_res_ctrl;
 		struct ice_aqc_set_mac_cfg set_mac_cfg;
@@ -2050,6 +2075,8 @@ enum ice_adminq_opc {
 	ice_aqc_opc_update_pkg				= 0x0C42,
 	ice_aqc_opc_get_pkg_info_list			= 0x0C43,
 
+	ice_aqc_opc_driver_shared_params		= 0x0C90,
+
 	/* Standalone Commands/Events */
 	ice_aqc_opc_event_lan_overflow			= 0x1001,
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 17b57ccf2492..ae7d63ab9450 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4462,6 +4462,81 @@ ice_sched_query_elem(struct ice_hw *hw, u32 node_teid,
 	return status;
 }
 
+/**
+ * ice_aq_set_driver_param - Set driver parameter to share via firmware
+ * @hw: pointer to the HW struct
+ * @idx: parameter index to set
+ * @value: the value to set the parameter to
+ * @cd: pointer to command details structure or NULL
+ *
+ * Set the value of one of the software defined parameters. All PFs connected
+ * to this device can read the value using ice_aq_get_driver_param.
+ *
+ * Note that firmware provides no synchronization or locking, and will not
+ * save the parameter value during a device reset. It is expected that
+ * a single PF will write the parameter value, while all other PFs will only
+ * read it.
+ */
+enum ice_status
+ice_aq_set_driver_param(struct ice_hw *hw, enum ice_aqc_driver_params idx,
+			u32 value, struct ice_sq_cd *cd)
+{
+	struct ice_aqc_driver_shared_params *cmd;
+	struct ice_aq_desc desc;
+
+	if (idx >= ICE_AQC_DRIVER_PARAM_MAX)
+		return ICE_ERR_OUT_OF_RANGE;
+
+	cmd = &desc.params.drv_shared_params;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_driver_shared_params);
+
+	cmd->set_or_get_op = ICE_AQC_DRIVER_PARAM_SET;
+	cmd->param_indx = idx;
+	cmd->param_val = cpu_to_le32(value);
+
+	return ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
+}
+
+/**
+ * ice_aq_get_driver_param - Get driver parameter shared via firmware
+ * @hw: pointer to the HW struct
+ * @idx: parameter index to set
+ * @value: storage to return the shared parameter
+ * @cd: pointer to command details structure or NULL
+ *
+ * Get the value of one of the software defined parameters.
+ *
+ * Note that firmware provides no synchronization or locking. It is expected
+ * that only a single PF will write a given parameter.
+ */
+enum ice_status
+ice_aq_get_driver_param(struct ice_hw *hw, enum ice_aqc_driver_params idx,
+			u32 *value, struct ice_sq_cd *cd)
+{
+	struct ice_aqc_driver_shared_params *cmd;
+	struct ice_aq_desc desc;
+	enum ice_status status;
+
+	if (idx >= ICE_AQC_DRIVER_PARAM_MAX)
+		return ICE_ERR_OUT_OF_RANGE;
+
+	cmd = &desc.params.drv_shared_params;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_driver_shared_params);
+
+	cmd->set_or_get_op = ICE_AQC_DRIVER_PARAM_GET;
+	cmd->param_indx = idx;
+
+	status = ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
+	if (status)
+		return status;
+
+	*value = le32_to_cpu(cmd->param_val);
+
+	return 0;
+}
+
 /**
  * ice_fw_supports_link_override
  * @hw: pointer to the hardware structure
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 1df30adad337..f64a41741e54 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -177,6 +177,12 @@ enum ice_status
 ice_sched_query_elem(struct ice_hw *hw, u32 node_teid,
 		     struct ice_aqc_txsched_elem_data *buf);
 enum ice_status
+ice_aq_set_driver_param(struct ice_hw *hw, enum ice_aqc_driver_params idx,
+			u32 value, struct ice_sq_cd *cd);
+enum ice_status
+ice_aq_get_driver_param(struct ice_hw *hw, enum ice_aqc_driver_params idx,
+			u32 *value, struct ice_sq_cd *cd);
+enum ice_status
 ice_aq_set_lldp_mib(struct ice_hw *hw, u8 mib_type, void *buf, u16 buf_size,
 		    struct ice_sq_cd *cd);
 bool ice_fw_supports_lldp_fltr_ctrl(struct ice_hw *hw);
-- 
2.31.1.331.gb0c09ab8796f

