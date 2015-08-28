From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 28 Aug 2015 17:55:47 -0400
Subject: [Intel-wired-lan] [next PATCH S13 01/15] i40e/i40evf: add handling
	of writeback descriptor
In-Reply-To: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440798961-17326-2-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

If the writeback descriptor buffer was previously created, this gives it
to the AQ command request to be used to save the results.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I8c8a1af81e6ebed6d0a15ed31697fe1a6c4e3708
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 26 ++++++++++++++++++++++----
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  1 +
 drivers/net/ethernet/intel/i40evf/i40e_type.h |  1 +
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 5475454..13534b3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -418,6 +418,10 @@ static i40e_status i40e_write_nvm_aq(struct i40e_hw *hw, u8 module_pointer,
 				     bool last_command)
 {
 	i40e_status ret_code = I40E_ERR_NVM;
+	struct i40e_asq_cmd_details cmd_details;
+
+	memset(&cmd_details, 0, sizeof(cmd_details));
+	cmd_details.wb_desc = &hw->nvm_wb_desc;
 
 	/* Here we are checking the SR limit only for the flat memory model.
 	 * We cannot do it for the module-based model, as we did not acquire
@@ -443,7 +447,7 @@ static i40e_status i40e_write_nvm_aq(struct i40e_hw *hw, u8 module_pointer,
 		ret_code = i40e_aq_update_nvm(hw, module_pointer,
 					      2 * offset,  /*bytes*/
 					      2 * words,   /*bytes*/
-					      data, last_command, NULL);
+					      data, last_command, &cmd_details);
 
 	return ret_code;
 }
@@ -1043,6 +1047,7 @@ static i40e_status i40e_nvmupd_nvm_read(struct i40e_hw *hw,
 					struct i40e_nvm_access *cmd,
 					u8 *bytes, int *perrno)
 {
+	struct i40e_asq_cmd_details cmd_details;
 	i40e_status status;
 	u8 module, transaction;
 	bool last;
@@ -1051,8 +1056,11 @@ static i40e_status i40e_nvmupd_nvm_read(struct i40e_hw *hw,
 	module = i40e_nvmupd_get_module(cmd->config);
 	last = (transaction == I40E_NVM_LCB) || (transaction == I40E_NVM_SA);
 
+	memset(&cmd_details, 0, sizeof(cmd_details));
+	cmd_details.wb_desc = &hw->nvm_wb_desc;
+
 	status = i40e_aq_read_nvm(hw, module, cmd->offset, (u16)cmd->data_size,
-				  bytes, last, NULL);
+				  bytes, last, &cmd_details);
 	if (status) {
 		i40e_debug(hw, I40E_DEBUG_NVM,
 			   "i40e_nvmupd_nvm_read mod 0x%x  off 0x%x  len 0x%x\n",
@@ -1079,14 +1087,19 @@ static i40e_status i40e_nvmupd_nvm_erase(struct i40e_hw *hw,
 					 int *perrno)
 {
 	i40e_status status = 0;
+	struct i40e_asq_cmd_details cmd_details;
 	u8 module, transaction;
 	bool last;
 
 	transaction = i40e_nvmupd_get_transaction(cmd->config);
 	module = i40e_nvmupd_get_module(cmd->config);
 	last = (transaction & I40E_NVM_LCB);
+
+	memset(&cmd_details, 0, sizeof(cmd_details));
+	cmd_details.wb_desc = &hw->nvm_wb_desc;
+
 	status = i40e_aq_erase_nvm(hw, module, cmd->offset, (u16)cmd->data_size,
-				   last, NULL);
+				   last, &cmd_details);
 	if (status) {
 		i40e_debug(hw, I40E_DEBUG_NVM,
 			   "i40e_nvmupd_nvm_erase mod 0x%x  off 0x%x len 0x%x\n",
@@ -1114,6 +1127,7 @@ static i40e_status i40e_nvmupd_nvm_write(struct i40e_hw *hw,
 					 u8 *bytes, int *perrno)
 {
 	i40e_status status = 0;
+	struct i40e_asq_cmd_details cmd_details;
 	u8 module, transaction;
 	bool last;
 
@@ -1121,8 +1135,12 @@ static i40e_status i40e_nvmupd_nvm_write(struct i40e_hw *hw,
 	module = i40e_nvmupd_get_module(cmd->config);
 	last = (transaction & I40E_NVM_LCB);
 
+	memset(&cmd_details, 0, sizeof(cmd_details));
+	cmd_details.wb_desc = &hw->nvm_wb_desc;
+
 	status = i40e_aq_update_nvm(hw, module, cmd->offset,
-				    (u16)cmd->data_size, bytes, last, NULL);
+				    (u16)cmd->data_size, bytes, last,
+				    &cmd_details);
 	if (status) {
 		i40e_debug(hw, I40E_DEBUG_NVM,
 			   "i40e_nvmupd_nvm_write mod 0x%x off 0x%x len 0x%x\n",
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 4d88224..d3558e1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -494,6 +494,7 @@ struct i40e_hw {
 
 	/* state of nvm update process */
 	enum i40e_nvmupd_state nvmupd_state;
+	struct i40e_aq_desc nvm_wb_desc;
 
 	/* HMC info */
 	struct i40e_hmc_info hmc; /* HMC info struct */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index b7ef8aa..c811081 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -488,6 +488,7 @@ struct i40e_hw {
 
 	/* state of nvm update process */
 	enum i40e_nvmupd_state nvmupd_state;
+	struct i40e_aq_desc nvm_wb_desc;
 
 	/* HMC info */
 	struct i40e_hmc_info hmc; /* HMC info struct */
-- 
1.9.3

