From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 28 Aug 2015 17:55:48 -0400
Subject: [Intel-wired-lan] [next PATCH S13 02/15] i40e/i40evf: add GetStatus
	command for nvmupdate
In-Reply-To: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440798961-17326-3-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

This adds a new GetStatus command so that the NVM update tool can query
the current status instead of doing fake write requests to probe for
readiness.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I671ec6ccd4dfc9dbac3a03b964589d693fda5cd8
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 42 ++++++++++++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  2 ++
 drivers/net/ethernet/intel/i40evf/i40e_type.h |  2 ++
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 13534b3..034e27a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -640,6 +640,7 @@ static char *i40e_nvm_update_state_str[] = {
 	"I40E_NVMUPD_CSUM_CON",
 	"I40E_NVMUPD_CSUM_SA",
 	"I40E_NVMUPD_CSUM_LCB",
+	"I40E_NVMUPD_STATUS",
 };
 
 /**
@@ -656,10 +657,34 @@ i40e_status i40e_nvmupd_command(struct i40e_hw *hw,
 				u8 *bytes, int *perrno)
 {
 	i40e_status status;
+	enum i40e_nvmupd_cmd upd_cmd;
 
 	/* assume success */
 	*perrno = 0;
 
+	/* early check for status command and debug msgs */
+	upd_cmd = i40e_nvmupd_validate_command(hw, cmd, perrno);
+
+	i40e_debug(hw, I40E_DEBUG_NVM, "%s state %d nvm_release_on_hold %d\n",
+		   i40e_nvm_update_state_str[upd_cmd],
+		   hw->nvmupd_state,
+		   hw->aq.nvm_release_on_done);
+
+	if (upd_cmd == I40E_NVMUPD_INVALID) {
+		*perrno = -EFAULT;
+		i40e_debug(hw, I40E_DEBUG_NVM,
+			   "i40e_nvmupd_validate_command returns %d errno %d\n",
+			   upd_cmd, *perrno);
+	}
+
+	/* a status request returns immediately rather than
+	 * going into the state machine
+	 */
+	if (upd_cmd == I40E_NVMUPD_STATUS) {
+		bytes[0] = hw->nvmupd_state;
+		return 0;
+	}
+
 	switch (hw->nvmupd_state) {
 	case I40E_NVMUPD_STATE_INIT:
 		status = i40e_nvmupd_state_init(hw, cmd, bytes, perrno);
@@ -956,12 +981,13 @@ static enum i40e_nvmupd_cmd i40e_nvmupd_validate_command(struct i40e_hw *hw,
 						 int *perrno)
 {
 	enum i40e_nvmupd_cmd upd_cmd;
-	u8 transaction;
+	u8 module, transaction;
 
 	/* anything that doesn't match a recognized case is an error */
 	upd_cmd = I40E_NVMUPD_INVALID;
 
 	transaction = i40e_nvmupd_get_transaction(cmd->config);
+	module = i40e_nvmupd_get_module(cmd->config);
 
 	/* limits on data size */
 	if ((cmd->data_size < 1) ||
@@ -988,6 +1014,10 @@ static enum i40e_nvmupd_cmd i40e_nvmupd_validate_command(struct i40e_hw *hw,
 		case I40E_NVM_SA:
 			upd_cmd = I40E_NVMUPD_READ_SA;
 			break;
+		case I40E_NVM_EXEC:
+			if (module == 0xf)
+				upd_cmd = I40E_NVMUPD_STATUS;
+			break;
 		}
 		break;
 
@@ -1020,17 +1050,7 @@ static enum i40e_nvmupd_cmd i40e_nvmupd_validate_command(struct i40e_hw *hw,
 		}
 		break;
 	}
-	i40e_debug(hw, I40E_DEBUG_NVM, "%s state %d nvm_release_on_hold %d\n",
-		   i40e_nvm_update_state_str[upd_cmd],
-		   hw->nvmupd_state,
-		   hw->aq.nvm_release_on_done);
 
-	if (upd_cmd == I40E_NVMUPD_INVALID) {
-		*perrno = -EFAULT;
-		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "i40e_nvmupd_validate_command returns %d errno %d\n",
-			   upd_cmd, *perrno);
-	}
 	return upd_cmd;
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index d3558e1..20e16ed 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -307,6 +307,7 @@ enum i40e_nvmupd_cmd {
 	I40E_NVMUPD_CSUM_CON,
 	I40E_NVMUPD_CSUM_SA,
 	I40E_NVMUPD_CSUM_LCB,
+	I40E_NVMUPD_STATUS,
 };
 
 enum i40e_nvmupd_state {
@@ -331,6 +332,7 @@ enum i40e_nvmupd_state {
 #define I40E_NVM_SA		(I40E_NVM_SNT | I40E_NVM_LCB)
 #define I40E_NVM_ERA		0x4
 #define I40E_NVM_CSUM		0x8
+#define I40E_NVM_EXEC		0xf
 
 #define I40E_NVM_ADAPT_SHIFT	16
 #define I40E_NVM_ADAPT_MASK	(0xffff << I40E_NVM_ADAPT_SHIFT)
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index c811081..ee02e25 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -306,6 +306,7 @@ enum i40e_nvmupd_cmd {
 	I40E_NVMUPD_CSUM_CON,
 	I40E_NVMUPD_CSUM_SA,
 	I40E_NVMUPD_CSUM_LCB,
+	I40E_NVMUPD_STATUS,
 };
 
 enum i40e_nvmupd_state {
@@ -330,6 +331,7 @@ enum i40e_nvmupd_state {
 #define I40E_NVM_SA		(I40E_NVM_SNT | I40E_NVM_LCB)
 #define I40E_NVM_ERA		0x4
 #define I40E_NVM_CSUM		0x8
+#define I40E_NVM_EXEC		0xf
 
 #define I40E_NVM_ADAPT_SHIFT	16
 #define I40E_NVM_ADAPT_MASK	(0xffff << I40E_NVM_ADAPT_SHIFT)
-- 
1.9.3

