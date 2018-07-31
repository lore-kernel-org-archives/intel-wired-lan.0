From: Alice Michael <alice.michael@intel.com>
Date: Tue, 31 Jul 2018 03:41:47 -0700
Subject: [Intel-wired-lan] [next PATCH S93 10/11] i40e: Add AQ command for
 rearrange NVM structure
In-Reply-To: <20180731104148.11896-1-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
Message-ID: <20180731104148.11896-10-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Azarewicz <piotr.azarewicz@intel.com>

During switching between old NVM structure approach (called structured
NVM) to new one (called flat NVM) or backward flash needs to be
rearranged to required NVM structure. This is a part of transition from
one NVM structure to another. The function is introduced to command
firmware to start rearrangement process.

Signed-off-by: Piotr Azarewicz <piotr.azarewicz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_common.c      | 35 ++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  3 ++
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  2 ++
 4 files changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 7d888e0..80e3eec 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -2247,6 +2247,8 @@ I40E_CHECK_CMD_LENGTH(i40e_aqc_phy_register_access);
 struct i40e_aqc_nvm_update {
 	u8	command_flags;
 #define I40E_AQ_NVM_LAST_CMD			0x01
+#define I40E_AQ_NVM_REARRANGE_TO_FLAT		0x20
+#define I40E_AQ_NVM_REARRANGE_TO_STRUCT		0x40
 #define I40E_AQ_NVM_FLASH_ONLY			0x80
 #define I40E_AQ_NVM_PRESERVATION_FLAGS_SHIFT	1
 #define I40E_AQ_NVM_PRESERVATION_FLAGS_MASK	0x03
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index ad710b2..cc196de 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -3545,6 +3545,41 @@ i40e_status i40e_aq_update_nvm(struct i40e_hw *hw, u8 module_pointer,
 }
 
 /**
+ * i40e_aq_rearrange_nvm
+ * @hw: pointer to the hw struct
+ * @rearrange_nvm: defines direction of rearrangement
+ * @cmd_details: pointer to command details structure or NULL
+ *
+ * Rearrange NVM structure, available only for transition FW
+ **/
+i40e_status i40e_aq_rearrange_nvm(struct i40e_hw *hw,
+				  u8 rearrange_nvm,
+				  struct i40e_asq_cmd_details *cmd_details)
+{
+	struct i40e_aqc_nvm_update *cmd;
+	i40e_status status;
+	struct i40e_aq_desc desc;
+
+	cmd = (struct i40e_aqc_nvm_update *)&desc.params.raw;
+
+	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_nvm_update);
+
+	rearrange_nvm &= (I40E_AQ_NVM_REARRANGE_TO_FLAT |
+			 I40E_AQ_NVM_REARRANGE_TO_STRUCT);
+
+	if (!rearrange_nvm) {
+		status = I40E_ERR_PARAM;
+		goto i40e_aq_rearrange_nvm_exit;
+	}
+
+	cmd->command_flags |= rearrange_nvm;
+	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
+
+i40e_aq_rearrange_nvm_exit:
+	return status;
+}
+
+/**
  * i40e_aq_get_lldp_mib
  * @hw: pointer to the hw struct
  * @bridge_type: type of bridge requested
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 3170655..e08d754 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -193,6 +193,9 @@ i40e_status i40e_aq_update_nvm(struct i40e_hw *hw, u8 module_pointer,
 				u32 offset, u16 length, void *data,
 				bool last_command, u8 preservation_flags,
 				struct i40e_asq_cmd_details *cmd_details);
+i40e_status i40e_aq_rearrange_nvm(struct i40e_hw *hw,
+				  u8 rearrange_nvm,
+				  struct i40e_asq_cmd_details *cmd_details);
 i40e_status i40e_aq_get_lldp_mib(struct i40e_hw *hw, u8 bridge_type,
 				u8 mib_type, void *buff, u16 buff_size,
 				u16 *local_len, u16 *remote_len,
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index aa81e87..5fd8529 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -2175,6 +2175,8 @@ I40E_CHECK_CMD_LENGTH(i40e_aqc_phy_register_access);
 struct i40e_aqc_nvm_update {
 	u8	command_flags;
 #define I40E_AQ_NVM_LAST_CMD			0x01
+#define I40E_AQ_NVM_REARRANGE_TO_FLAT		0x20
+#define I40E_AQ_NVM_REARRANGE_TO_STRUCT		0x40
 #define I40E_AQ_NVM_FLASH_ONLY			0x80
 #define I40E_AQ_NVM_PRESERVATION_FLAGS_SHIFT	1
 #define I40E_AQ_NVM_PRESERVATION_FLAGS_MASK	0x03
-- 
2.9.5

