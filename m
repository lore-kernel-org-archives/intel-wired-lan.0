From: Alice Michael <alice.michael@intel.com>
Date: Wed, 27 Dec 2017 07:32:34 -0500
Subject: [Intel-wired-lan] [next PATCH S84-V2 05/13] i40e: Display LLDP
 information on vSphere Web Client
In-Reply-To: <20171227123242.22356-1-alice.michael@intel.com>
References: <20171227123242.22356-1-alice.michael@intel.com>
Message-ID: <20171227123242.22356-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Menon, Upasana <upasana.menon@intel.com>

This patch enables driver to display LLDP information on the vSphere Web
Client with Intel adapters (X710, XL710) and Distributed Virtual Switch.

Signed-off-by: Menon, Upasana <upasana.menon@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 12 ++++++++++
 drivers/net/ethernet/intel/i40e/i40e_common.c      | 27 ++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  4 ++++
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 12 ++++++++++
 4 files changed, 55 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 0d471b0..a852775 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -205,6 +205,7 @@ enum i40e_admin_queue_opc {
 	/* DCB commands */
 	i40e_aqc_opc_dcb_ignore_pfc	= 0x0301,
 	i40e_aqc_opc_dcb_updated	= 0x0302,
+	i40e_aqc_opc_set_dcb_parameters = 0x0303,
 
 	/* TX scheduler */
 	i40e_aqc_opc_configure_vsi_bw_limit		= 0x0400,
@@ -2496,6 +2497,17 @@ struct i40e_aqc_lldp_start {
 
 I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_start);
 
+/* Set DCB (direct 0x0303) */
+struct i40e_aqc_set_dcb_parameters {
+	u8 command;
+#define I40E_AQ_DCB_SET_AGENT	0x1
+#define I40E_DCB_VALID		0x1
+	u8 valid_flags;
+	u8 reserved[14];
+};
+
+I40E_CHECK_CMD_LENGTH(i40e_aqc_set_dcb_parameters);
+
 /* Get CEE DCBX Oper Config (0x0A07)
  * uses the generic descriptor struct
  * returns below as indirect response
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index c690e9c..ef5a868 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -3641,7 +3641,34 @@ i40e_status i40e_aq_start_lldp(struct i40e_hw *hw,
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_lldp_start);
 
 	cmd->command = I40E_AQ_LLDP_AGENT_START;
+	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
 
+	return status;
+}
+
+/**
+ * i40e_aq_set_dcb_parameters
+ * @hw: pointer to the hw struct
+ * @cmd_details: pointer to command details structure or NULL
+ * @dcb_enable: True if DCB configuration needs to be applied
+ *
+ **/
+enum i40e_status_code
+i40e_aq_set_dcb_parameters(struct i40e_hw *hw, bool dcb_enable,
+			   struct i40e_asq_cmd_details *cmd_details)
+{
+	struct i40e_aq_desc desc;
+	struct i40e_aqc_set_dcb_parameters *cmd =
+		(struct i40e_aqc_set_dcb_parameters *)&desc.params.raw;
+	i40e_status status;
+
+	i40e_fill_default_direct_cmd_desc(&desc,
+					  i40e_aqc_opc_set_dcb_parameters);
+
+	if (dcb_enable) {
+		cmd->valid_flags = I40E_DCB_VALID;
+		cmd->command = I40E_AQ_DCB_SET_AGENT;
+	}
 	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
 
 	return status;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 187dd53..83798b7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -225,6 +225,10 @@ i40e_status i40e_aq_cfg_lldp_mib_change_event(struct i40e_hw *hw,
 				struct i40e_asq_cmd_details *cmd_details);
 i40e_status i40e_aq_stop_lldp(struct i40e_hw *hw, bool shutdown_agent,
 				struct i40e_asq_cmd_details *cmd_details);
+i40e_status i40e_aq_set_dcb_parameters(struct i40e_hw *hw,
+				       bool dcb_enable,
+				       struct i40e_asq_cmd_details
+				       *cmd_details);
 i40e_status i40e_aq_start_lldp(struct i40e_hw *hw,
 				struct i40e_asq_cmd_details *cmd_details);
 i40e_status i40e_aq_get_cee_dcb_config(struct i40e_hw *hw,
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index b0e6454..815de8d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -205,6 +205,7 @@ enum i40e_admin_queue_opc {
 	/* DCB commands */
 	i40e_aqc_opc_dcb_ignore_pfc	= 0x0301,
 	i40e_aqc_opc_dcb_updated	= 0x0302,
+	i40e_aqc_opc_set_dcb_parameters = 0x0303,
 
 	/* TX scheduler */
 	i40e_aqc_opc_configure_vsi_bw_limit		= 0x0400,
@@ -2461,6 +2462,17 @@ struct i40e_aqc_lldp_start {
 
 I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_start);
 
+/* Set DCB (direct 0x0303) */
+struct i40e_aqc_set_dcb_parameters {
+	u8 command;
+#define I40E_AQ_DCB_SET_AGENT	0x1
+#define I40E_DCB_VALID		0x1
+	u8 valid_flags;
+	u8 reserved[14];
+};
+
+I40E_CHECK_CMD_LENGTH(i40e_aqc_set_dcb_parameters);
+
 /* Apply MIB changes (0x0A07)
  * uses the generic struc as it contains no data
  */
-- 
2.9.5

