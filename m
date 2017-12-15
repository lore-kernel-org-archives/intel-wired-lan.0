From: Alice Michael <alice.michael@intel.com>
Date: Fri, 15 Dec 2017 10:25:31 -0500
Subject: [Intel-wired-lan] [next PATCH S83-V5 1/9] i40e/i40evf: Enable
 NVMUpdate to retrieve AdminQ and add preservation flags for NVM update
Message-ID: <20171215152539.49695-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Pawel Jablonski <pawel.jablonski@intel.com>

This patch adds new I40E_NVMUPD_GET_AQ_EVENT state to allow
retrieval of AdminQ events as a result of AdminQ commands sent
to firmware.

Add preservation flags support on X722 devices for NVM update
AdminQ function wrapper. Add new parameter and handling to nvm
update admin queue function intended to allow nvmupdate tool to
configure the preservation flags in the AdminQ command.

This is required to implement FlatNVM on X722 devices.

Signed-off-by: Pawel Jablonski <pawel.jablonski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  13 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         | 141 ++++++++++++++++-----
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        |  26 ++--
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |   8 +-
 drivers/net/ethernet/intel/i40evf/i40e_type.h      |  26 ++--
 9 files changed, 173 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 9af7425..d9670cd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -1027,7 +1027,7 @@ i40e_status i40e_clean_arq_element(struct i40e_hw *hw,
 	hw->aq.arq.next_to_clean = ntc;
 	hw->aq.arq.next_to_use = ntu;
 
-	i40e_nvmupd_check_wait_event(hw, le16_to_cpu(e->desc.opcode));
+	i40e_nvmupd_check_wait_event(hw, le16_to_cpu(e->desc.opcode), &e->desc);
 clean_arq_element_out:
 	/* Set pending if needed, unlock and return */
 	if (pending)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index c577634..0d471b0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -2231,8 +2231,12 @@ I40E_CHECK_CMD_LENGTH(i40e_aqc_phy_register_access);
  */
 struct i40e_aqc_nvm_update {
 	u8	command_flags;
-#define I40E_AQ_NVM_LAST_CMD	0x01
-#define I40E_AQ_NVM_FLASH_ONLY	0x80
+#define I40E_AQ_NVM_LAST_CMD			0x01
+#define I40E_AQ_NVM_FLASH_ONLY			0x80
+#define I40E_AQ_NVM_PRESERVATION_FLAGS_SHIFT	1
+#define I40E_AQ_NVM_PRESERVATION_FLAGS_MASK	0x03
+#define I40E_AQ_NVM_PRESERVATION_FLAGS_SELECTED	0x03
+#define I40E_AQ_NVM_PRESERVATION_FLAGS_ALL	0x01
 	u8	module_pointer;
 	__le16	length;
 	__le32	offset;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 40c5f76..cf929cc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -3465,13 +3465,14 @@ i40e_status i40e_aq_discover_capabilities(struct i40e_hw *hw,
  * @length: length of the section to be written (in bytes from the offset)
  * @data: command buffer (size [bytes] = length)
  * @last_command: tells if this is the last command in a series
+ * @preservation_flags: Preservation mode flags
  * @cmd_details: pointer to command details structure or NULL
  *
  * Update the NVM using the admin queue commands
  **/
 i40e_status i40e_aq_update_nvm(struct i40e_hw *hw, u8 module_pointer,
 			       u32 offset, u16 length, void *data,
-			       bool last_command,
+				bool last_command, u8 preservation_flags,
 			       struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
@@ -3490,6 +3491,16 @@ i40e_status i40e_aq_update_nvm(struct i40e_hw *hw, u8 module_pointer,
 	/* If this is the last command in a series, set the proper flag. */
 	if (last_command)
 		cmd->command_flags |= I40E_AQ_NVM_LAST_CMD;
+	if (hw->mac.type == I40E_MAC_X722) {
+		if (preservation_flags == I40E_NVM_PRESERVATION_FLAGS_SELECTED)
+			cmd->command_flags |=
+				(I40E_AQ_NVM_PRESERVATION_FLAGS_SELECTED <<
+				 I40E_AQ_NVM_PRESERVATION_FLAGS_SHIFT);
+		else if (preservation_flags == I40E_NVM_PRESERVATION_FLAGS_ALL)
+			cmd->command_flags |=
+				(I40E_AQ_NVM_PRESERVATION_FLAGS_ALL <<
+				 I40E_AQ_NVM_PRESERVATION_FLAGS_SHIFT);
+	}
 	cmd->module_pointer = module_pointer;
 	cmd->offset = cpu_to_le32(offset);
 	cmd->length = cpu_to_le16(length);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e63a48f..4f74156 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11028,7 +11028,7 @@ i40e_status i40e_commit_partition_bw_setting(struct i40e_pf *pf)
 	ret = i40e_aq_update_nvm(&pf->hw,
 				 I40E_SR_NVM_CONTROL_WORD,
 				 0x10, sizeof(nvm_word),
-				 &nvm_word, true, NULL);
+				 &nvm_word, true, 0, NULL);
 	/* Save off last admin queue command status before releasing
 	 * the NVM
 	 */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 425713f..76a5cb0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -239,8 +239,9 @@ static i40e_status i40e_read_nvm_word_srctl(struct i40e_hw *hw, u16 offset,
  *
  * Writes a 16 bit words buffer to the Shadow RAM using the admin command.
  **/
-static i40e_status i40e_read_nvm_aq(struct i40e_hw *hw, u8 module_pointer,
-				    u32 offset, u16 words, void *data,
+static i40e_status i40e_read_nvm_aq(struct i40e_hw *hw,
+				    u8 module_pointer, u32 offset,
+				    u16 words, void *data,
 				    bool last_command)
 {
 	i40e_status ret_code = I40E_ERR_NVM;
@@ -496,7 +497,8 @@ static i40e_status i40e_write_nvm_aq(struct i40e_hw *hw, u8 module_pointer,
 		ret_code = i40e_aq_update_nvm(hw, module_pointer,
 					      2 * offset,  /*bytes*/
 					      2 * words,   /*bytes*/
-					      data, last_command, &cmd_details);
+					      data, last_command, 0,
+					      &cmd_details);
 
 	return ret_code;
 }
@@ -677,6 +679,9 @@ static i40e_status i40e_nvmupd_exec_aq(struct i40e_hw *hw,
 static i40e_status i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
 					     struct i40e_nvm_access *cmd,
 					     u8 *bytes, int *perrno);
+static i40e_status i40e_nvmupd_get_aq_event(struct i40e_hw *hw,
+					    struct i40e_nvm_access *cmd,
+					    u8 *bytes, int *perrno);
 static inline u8 i40e_nvmupd_get_module(u32 val)
 {
 	return (u8)(val & I40E_NVM_MOD_PNT_MASK);
@@ -686,6 +691,12 @@ static inline u8 i40e_nvmupd_get_transaction(u32 val)
 	return (u8)((val & I40E_NVM_TRANS_MASK) >> I40E_NVM_TRANS_SHIFT);
 }
 
+static inline u8 i40e_nvmupd_get_preservation_flags(u32 val)
+{
+	return (u8)((val & I40E_NVM_PRESERVATION_FLAGS_MASK) >>
+		    I40E_NVM_PRESERVATION_FLAGS_SHIFT);
+}
+
 static const char * const i40e_nvm_update_state_str[] = {
 	"I40E_NVMUPD_INVALID",
 	"I40E_NVMUPD_READ_CON",
@@ -703,6 +714,7 @@ static const char * const i40e_nvm_update_state_str[] = {
 	"I40E_NVMUPD_STATUS",
 	"I40E_NVMUPD_EXEC_AQ",
 	"I40E_NVMUPD_GET_AQ_RESULT",
+	"I40E_NVMUPD_GET_AQ_EVENT",
 };
 
 /**
@@ -798,9 +810,9 @@ i40e_status i40e_nvmupd_command(struct i40e_hw *hw,
 		 * the wait info and return before doing anything else
 		 */
 		if (cmd->offset == 0xffff) {
-			i40e_nvmupd_check_wait_event(hw, hw->nvm_wait_opcode);
+			i40e_nvmupd_clear_wait_state(hw);
 			status = 0;
-			goto exit;
+			break;
 		}
 
 		status = I40E_ERR_NOT_READY;
@@ -815,7 +827,7 @@ i40e_status i40e_nvmupd_command(struct i40e_hw *hw,
 		*perrno = -ESRCH;
 		break;
 	}
-exit:
+
 	mutex_unlock(&hw->aq.arq_mutex);
 	return status;
 }
@@ -944,6 +956,10 @@ static i40e_status i40e_nvmupd_state_init(struct i40e_hw *hw,
 		status = i40e_nvmupd_get_aq_result(hw, cmd, bytes, perrno);
 		break;
 
+	case I40E_NVMUPD_GET_AQ_EVENT:
+		status = i40e_nvmupd_get_aq_event(hw, cmd, bytes, perrno);
+		break;
+
 	default:
 		i40e_debug(hw, I40E_DEBUG_NVM,
 			   "NVMUPD: bad cmd %s in init state\n",
@@ -1118,38 +1134,53 @@ static i40e_status i40e_nvmupd_state_writing(struct i40e_hw *hw,
 }
 
 /**
- * i40e_nvmupd_check_wait_event - handle NVM update operation events
+ * i40e_nvmupd_clear_wait_state - clear wait state on hw
  * @hw: pointer to the hardware structure
- * @opcode: the event that just happened
  **/
-void i40e_nvmupd_check_wait_event(struct i40e_hw *hw, u16 opcode)
+void i40e_nvmupd_clear_wait_state(struct i40e_hw *hw)
 {
-	if (opcode == hw->nvm_wait_opcode) {
-		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVMUPD: clearing wait on opcode 0x%04x\n", opcode);
-		if (hw->nvm_release_on_done) {
-			i40e_release_nvm(hw);
-			hw->nvm_release_on_done = false;
-		}
-		hw->nvm_wait_opcode = 0;
+	i40e_debug(hw, I40E_DEBUG_NVM,
+		   "NVMUPD: clearing wait on opcode 0x%04x\n",
+		   hw->nvm_wait_opcode);
 
-		if (hw->aq.arq_last_status) {
-			hw->nvmupd_state = I40E_NVMUPD_STATE_ERROR;
-			return;
-		}
+	if (hw->nvm_release_on_done) {
+		i40e_release_nvm(hw);
+		hw->nvm_release_on_done = false;
+	}
+	hw->nvm_wait_opcode = 0;
 
-		switch (hw->nvmupd_state) {
-		case I40E_NVMUPD_STATE_INIT_WAIT:
-			hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
-			break;
+	if (hw->aq.arq_last_status) {
+		hw->nvmupd_state = I40E_NVMUPD_STATE_ERROR;
+		return;
+	}
 
-		case I40E_NVMUPD_STATE_WRITE_WAIT:
-			hw->nvmupd_state = I40E_NVMUPD_STATE_WRITING;
-			break;
+	switch (hw->nvmupd_state) {
+	case I40E_NVMUPD_STATE_INIT_WAIT:
+		hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
+		break;
 
-		default:
-			break;
-		}
+	case I40E_NVMUPD_STATE_WRITE_WAIT:
+		hw->nvmupd_state = I40E_NVMUPD_STATE_WRITING;
+		break;
+
+	default:
+		break;
+	}
+}
+
+/**
+ * i40e_nvmupd_check_wait_event - handle NVM update operation events
+ * @hw: pointer to the hardware structure
+ * @opcode: the event that just happened
+ **/
+void i40e_nvmupd_check_wait_event(struct i40e_hw *hw, u16 opcode,
+				  struct i40e_aq_desc *desc)
+{
+	u32 aq_desc_len = sizeof(struct i40e_aq_desc);
+
+	if (opcode == hw->nvm_wait_opcode) {
+		memcpy(&hw->nvm_aq_event_desc, desc, aq_desc_len);
+		i40e_nvmupd_clear_wait_state(hw);
 	}
 }
 
@@ -1205,6 +1236,9 @@ static enum i40e_nvmupd_cmd i40e_nvmupd_validate_command(struct i40e_hw *hw,
 			else if (module == 0)
 				upd_cmd = I40E_NVMUPD_GET_AQ_RESULT;
 			break;
+		case I40E_NVM_AQE:
+			upd_cmd = I40E_NVMUPD_GET_AQ_EVENT;
+			break;
 		}
 		break;
 
@@ -1267,6 +1301,9 @@ static i40e_status i40e_nvmupd_exec_aq(struct i40e_hw *hw,
 	u32 aq_data_len;
 
 	i40e_debug(hw, I40E_DEBUG_NVM, "NVMUPD: %s\n", __func__);
+	if (cmd->offset == 0xffff)
+		return 0;
+
 	memset(&cmd_details, 0, sizeof(cmd_details));
 	cmd_details.wb_desc = &hw->nvm_wb_desc;
 
@@ -1302,6 +1339,9 @@ static i40e_status i40e_nvmupd_exec_aq(struct i40e_hw *hw,
 		}
 	}
 
+	if (cmd->offset)
+		memset(&hw->nvm_aq_event_desc, 0, aq_desc_len);
+
 	/* and away we go! */
 	status = i40e_asq_send_command(hw, aq_desc, buff,
 				       buff_size, &cmd_details);
@@ -1311,6 +1351,7 @@ static i40e_status i40e_nvmupd_exec_aq(struct i40e_hw *hw,
 			   i40e_stat_str(hw, status),
 			   i40e_aq_str(hw, hw->aq.asq_last_status));
 		*perrno = i40e_aq_rc_to_posix(status, hw->aq.asq_last_status);
+		return status;
 	}
 
 	/* should we wait for a followup event? */
@@ -1392,6 +1433,40 @@ static i40e_status i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
 }
 
 /**
+ * i40e_nvmupd_get_aq_event - Get the Admin Queue event from previous exec_aq
+ * @hw: pointer to hardware structure
+ * @cmd: pointer to nvm update command buffer
+ * @bytes: pointer to the data buffer
+ * @perrno: pointer to return error code
+ *
+ * cmd structure contains identifiers and data buffer
+ **/
+static i40e_status i40e_nvmupd_get_aq_event(struct i40e_hw *hw,
+					    struct i40e_nvm_access *cmd,
+					    u8 *bytes, int *perrno)
+{
+	u32 aq_total_len;
+	u32 aq_desc_len;
+
+	i40e_debug(hw, I40E_DEBUG_NVM, "NVMUPD: %s\n", __func__);
+
+	aq_desc_len = sizeof(struct i40e_aq_desc);
+	aq_total_len = aq_desc_len + le16_to_cpu(hw->nvm_aq_event_desc.datalen);
+
+	/* check copylength range */
+	if (cmd->data_size > aq_total_len) {
+		i40e_debug(hw, I40E_DEBUG_NVM,
+			   "%s: copy length %d too big, trimming to %d\n",
+			   __func__, cmd->data_size, aq_total_len);
+		cmd->data_size = aq_total_len;
+	}
+
+	memcpy(bytes, &hw->nvm_aq_event_desc, cmd->data_size);
+
+	return 0;
+}
+
+/**
  * i40e_nvmupd_nvm_read - Read NVM
  * @hw: pointer to hardware structure
  * @cmd: pointer to nvm update command buffer
@@ -1486,18 +1561,20 @@ static i40e_status i40e_nvmupd_nvm_write(struct i40e_hw *hw,
 	i40e_status status = 0;
 	struct i40e_asq_cmd_details cmd_details;
 	u8 module, transaction;
+	u8 preservation_flags;
 	bool last;
 
 	transaction = i40e_nvmupd_get_transaction(cmd->config);
 	module = i40e_nvmupd_get_module(cmd->config);
 	last = (transaction & I40E_NVM_LCB);
+	preservation_flags = i40e_nvmupd_get_preservation_flags(cmd->config);
 
 	memset(&cmd_details, 0, sizeof(cmd_details));
 	cmd_details.wb_desc = &hw->nvm_wb_desc;
 
 	status = i40e_aq_update_nvm(hw, module, cmd->offset,
 				    (u16)cmd->data_size, bytes, last,
-				    &cmd_details);
+				    preservation_flags, &cmd_details);
 	if (status) {
 		i40e_debug(hw, I40E_DEBUG_NVM,
 			   "i40e_nvmupd_nvm_write mod 0x%x off 0x%x len 0x%x\n",
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index b3cc89c..187dd53 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -214,7 +214,7 @@ i40e_status i40e_aq_discover_capabilities(struct i40e_hw *hw,
 				struct i40e_asq_cmd_details *cmd_details);
 i40e_status i40e_aq_update_nvm(struct i40e_hw *hw, u8 module_pointer,
 				u32 offset, u16 length, void *data,
-				bool last_command,
+				bool last_command, u8 preservation_flags,
 				struct i40e_asq_cmd_details *cmd_details);
 i40e_status i40e_aq_get_lldp_mib(struct i40e_hw *hw, u8 bridge_type,
 				u8 mib_type, void *buff, u16 buff_size,
@@ -333,7 +333,9 @@ i40e_status i40e_validate_nvm_checksum(struct i40e_hw *hw,
 i40e_status i40e_nvmupd_command(struct i40e_hw *hw,
 				struct i40e_nvm_access *cmd,
 				u8 *bytes, int *);
-void i40e_nvmupd_check_wait_event(struct i40e_hw *hw, u16 opcode);
+void i40e_nvmupd_check_wait_event(struct i40e_hw *hw, u16 opcode,
+				  struct i40e_aq_desc *desc);
+void i40e_nvmupd_clear_wait_state(struct i40e_hw *hw);
 void i40e_set_pci_config_data(struct i40e_hw *hw, u16 link_status);
 
 extern struct i40e_rx_ptype_decoded i40e_ptype_lookup[];
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 5a708c3..cd294e6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -402,6 +402,7 @@ enum i40e_nvmupd_cmd {
 	I40E_NVMUPD_STATUS,
 	I40E_NVMUPD_EXEC_AQ,
 	I40E_NVMUPD_GET_AQ_RESULT,
+	I40E_NVMUPD_GET_AQ_EVENT,
 };
 
 enum i40e_nvmupd_state {
@@ -421,15 +422,21 @@ enum i40e_nvmupd_state {
 
 #define I40E_NVM_MOD_PNT_MASK 0xFF
 
-#define I40E_NVM_TRANS_SHIFT	8
-#define I40E_NVM_TRANS_MASK	(0xf << I40E_NVM_TRANS_SHIFT)
-#define I40E_NVM_CON		0x0
-#define I40E_NVM_SNT		0x1
-#define I40E_NVM_LCB		0x2
-#define I40E_NVM_SA		(I40E_NVM_SNT | I40E_NVM_LCB)
-#define I40E_NVM_ERA		0x4
-#define I40E_NVM_CSUM		0x8
-#define I40E_NVM_EXEC		0xf
+#define I40E_NVM_TRANS_SHIFT			8
+#define I40E_NVM_TRANS_MASK			(0xf << I40E_NVM_TRANS_SHIFT)
+#define I40E_NVM_PRESERVATION_FLAGS_SHIFT	12
+#define I40E_NVM_PRESERVATION_FLAGS_MASK \
+				(0x3 << I40E_NVM_PRESERVATION_FLAGS_SHIFT)
+#define I40E_NVM_PRESERVATION_FLAGS_SELECTED	0x01
+#define I40E_NVM_PRESERVATION_FLAGS_ALL		0x02
+#define I40E_NVM_CON				0x0
+#define I40E_NVM_SNT				0x1
+#define I40E_NVM_LCB				0x2
+#define I40E_NVM_SA				(I40E_NVM_SNT | I40E_NVM_LCB)
+#define I40E_NVM_ERA				0x4
+#define I40E_NVM_CSUM				0x8
+#define I40E_NVM_AQE				0xe
+#define I40E_NVM_EXEC				0xf
 
 #define I40E_NVM_ADAPT_SHIFT	16
 #define I40E_NVM_ADAPT_MASK	(0xffff << I40E_NVM_ADAPT_SHIFT)
@@ -611,6 +618,7 @@ struct i40e_hw {
 	/* state of nvm update process */
 	enum i40e_nvmupd_state nvmupd_state;
 	struct i40e_aq_desc nvm_wb_desc;
+	struct i40e_aq_desc nvm_aq_event_desc;
 	struct i40e_virt_mem nvm_buff;
 	bool nvm_release_on_done;
 	u16 nvm_wait_opcode;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index 435a112..b0e6454 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -2196,8 +2196,12 @@ I40E_CHECK_CMD_LENGTH(i40e_aqc_phy_register_access);
  */
 struct i40e_aqc_nvm_update {
 	u8	command_flags;
-#define I40E_AQ_NVM_LAST_CMD	0x01
-#define I40E_AQ_NVM_FLASH_ONLY	0x80
+#define I40E_AQ_NVM_LAST_CMD			0x01
+#define I40E_AQ_NVM_FLASH_ONLY			0x80
+#define I40E_AQ_NVM_PRESERVATION_FLAGS_SHIFT	1
+#define I40E_AQ_NVM_PRESERVATION_FLAGS_MASK	0x03
+#define I40E_AQ_NVM_PRESERVATION_FLAGS_SELECTED	0x03
+#define I40E_AQ_NVM_PRESERVATION_FLAGS_ALL	0x01
 	u8	module_pointer;
 	__le16	length;
 	__le32	offset;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index 6afc316..54951c8 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -361,6 +361,7 @@ enum i40e_nvmupd_cmd {
 	I40E_NVMUPD_STATUS,
 	I40E_NVMUPD_EXEC_AQ,
 	I40E_NVMUPD_GET_AQ_RESULT,
+	I40E_NVMUPD_GET_AQ_EVENT,
 };
 
 enum i40e_nvmupd_state {
@@ -380,15 +381,21 @@ enum i40e_nvmupd_state {
 
 #define I40E_NVM_MOD_PNT_MASK 0xFF
 
-#define I40E_NVM_TRANS_SHIFT	8
-#define I40E_NVM_TRANS_MASK	(0xf << I40E_NVM_TRANS_SHIFT)
-#define I40E_NVM_CON		0x0
-#define I40E_NVM_SNT		0x1
-#define I40E_NVM_LCB		0x2
-#define I40E_NVM_SA		(I40E_NVM_SNT | I40E_NVM_LCB)
-#define I40E_NVM_ERA		0x4
-#define I40E_NVM_CSUM		0x8
-#define I40E_NVM_EXEC		0xf
+#define I40E_NVM_TRANS_SHIFT			8
+#define I40E_NVM_TRANS_MASK			(0xf << I40E_NVM_TRANS_SHIFT)
+#define I40E_NVM_PRESERVATION_FLAGS_SHIFT	12
+#define I40E_NVM_PRESERVATION_FLAGS_MASK \
+				(0x3 << I40E_NVM_PRESERVATION_FLAGS_SHIFT)
+#define I40E_NVM_PRESERVATION_FLAGS_SELECTED	0x01
+#define I40E_NVM_PRESERVATION_FLAGS_ALL		0x02
+#define I40E_NVM_CON				0x0
+#define I40E_NVM_SNT				0x1
+#define I40E_NVM_LCB				0x2
+#define I40E_NVM_SA				(I40E_NVM_SNT | I40E_NVM_LCB)
+#define I40E_NVM_ERA				0x4
+#define I40E_NVM_CSUM				0x8
+#define I40E_NVM_AQE				0xe
+#define I40E_NVM_EXEC				0xf
 
 #define I40E_NVM_ADAPT_SHIFT	16
 #define I40E_NVM_ADAPT_MASK	(0xffff << I40E_NVM_ADAPT_SHIFT)
@@ -561,6 +568,7 @@ struct i40e_hw {
 	/* state of nvm update process */
 	enum i40e_nvmupd_state nvmupd_state;
 	struct i40e_aq_desc nvm_wb_desc;
+	struct i40e_aq_desc nvm_aq_event_desc;
 	struct i40e_virt_mem nvm_buff;
 	bool nvm_release_on_done;
 	u16 nvm_wait_opcode;
-- 
2.9.5

