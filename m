From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 28 Aug 2015 17:55:49 -0400
Subject: [Intel-wired-lan] [next PATCH S13 03/15] i40e/i40evf: add wait
	states to NVM state machine
In-Reply-To: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440798961-17326-4-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

This adds wait states to the NVM update state machine to signify when
waiting for an update operation to finish, whether we're in the middle
of a set of Write operations, or we're now idle but waiting.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: Iabe91d6579ef6a2ea560647e374035656211ab43
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 13 ++++++++
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 48 ++++++++++++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  4 ++-
 drivers/net/ethernet/intel/i40evf/i40e_type.h |  4 ++-
 4 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 00404fe..8ba4b60 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -1020,6 +1020,19 @@ clean_arq_element_out:
 			i40e_release_nvm(hw);
 			hw->aq.nvm_release_on_done = false;
 		}
+
+		switch (hw->nvmupd_state) {
+		case I40E_NVMUPD_STATE_INIT_WAIT:
+			hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
+			break;
+
+		case I40E_NVMUPD_STATE_WRITE_WAIT:
+			hw->nvmupd_state = I40E_NVMUPD_STATE_WRITING;
+			break;
+
+		default:
+			break;
+		}
 	}
 
 	return ret_code;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 034e27a..d21c652 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -698,6 +698,12 @@ i40e_status i40e_nvmupd_command(struct i40e_hw *hw,
 		status = i40e_nvmupd_state_writing(hw, cmd, bytes, perrno);
 		break;
 
+	case I40E_NVMUPD_STATE_INIT_WAIT:
+	case I40E_NVMUPD_STATE_WRITE_WAIT:
+		status = I40E_ERR_NOT_READY;
+		*perrno = -EBUSY;
+		break;
+
 	default:
 		/* invalid state, should never happen */
 		i40e_debug(hw, I40E_DEBUG_NVM,
@@ -761,10 +767,12 @@ static i40e_status i40e_nvmupd_state_init(struct i40e_hw *hw,
 						     hw->aq.asq_last_status);
 		} else {
 			status = i40e_nvmupd_nvm_erase(hw, cmd, perrno);
-			if (status)
+			if (status) {
 				i40e_release_nvm(hw);
-			else
+			} else {
 				hw->aq.nvm_release_on_done = true;
+				hw->nvmupd_state = I40E_NVMUPD_STATE_INIT_WAIT;
+			}
 		}
 		break;
 
@@ -775,10 +783,12 @@ static i40e_status i40e_nvmupd_state_init(struct i40e_hw *hw,
 						     hw->aq.asq_last_status);
 		} else {
 			status = i40e_nvmupd_nvm_write(hw, cmd, bytes, perrno);
-			if (status)
+			if (status) {
 				i40e_release_nvm(hw);
-			else
+			} else {
 				hw->aq.nvm_release_on_done = true;
+				hw->nvmupd_state = I40E_NVMUPD_STATE_INIT_WAIT;
+			}
 		}
 		break;
 
@@ -792,7 +802,7 @@ static i40e_status i40e_nvmupd_state_init(struct i40e_hw *hw,
 			if (status)
 				i40e_release_nvm(hw);
 			else
-				hw->nvmupd_state = I40E_NVMUPD_STATE_WRITING;
+				hw->nvmupd_state = I40E_NVMUPD_STATE_WRITE_WAIT;
 		}
 		break;
 
@@ -811,6 +821,7 @@ static i40e_status i40e_nvmupd_state_init(struct i40e_hw *hw,
 				i40e_release_nvm(hw);
 			} else {
 				hw->aq.nvm_release_on_done = true;
+				hw->nvmupd_state = I40E_NVMUPD_STATE_INIT_WAIT;
 			}
 		}
 		break;
@@ -840,7 +851,7 @@ static i40e_status i40e_nvmupd_state_reading(struct i40e_hw *hw,
 					     struct i40e_nvm_access *cmd,
 					     u8 *bytes, int *perrno)
 {
-	i40e_status status;
+	i40e_status status = 0;
 	enum i40e_nvmupd_cmd upd_cmd;
 
 	upd_cmd = i40e_nvmupd_validate_command(hw, cmd, perrno);
@@ -882,7 +893,7 @@ static i40e_status i40e_nvmupd_state_writing(struct i40e_hw *hw,
 					     struct i40e_nvm_access *cmd,
 					     u8 *bytes, int *perrno)
 {
-	i40e_status status;
+	i40e_status status = 0;
 	enum i40e_nvmupd_cmd upd_cmd;
 	bool retry_attempt = false;
 
@@ -892,13 +903,22 @@ retry:
 	switch (upd_cmd) {
 	case I40E_NVMUPD_WRITE_CON:
 		status = i40e_nvmupd_nvm_write(hw, cmd, bytes, perrno);
+		if (!status)
+			hw->nvmupd_state = I40E_NVMUPD_STATE_WRITE_WAIT;
 		break;
 
 	case I40E_NVMUPD_WRITE_LCB:
 		status = i40e_nvmupd_nvm_write(hw, cmd, bytes, perrno);
-		if (!status)
+		if (status) {
+			*perrno = hw->aq.asq_last_status ?
+				   i40e_aq_rc_to_posix(status,
+						       hw->aq.asq_last_status) :
+				   -EIO;
+			hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
+		} else {
 			hw->aq.nvm_release_on_done = true;
-		hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
+			hw->nvmupd_state = I40E_NVMUPD_STATE_INIT_WAIT;
+		}
 		break;
 
 	case I40E_NVMUPD_CSUM_CON:
@@ -909,19 +929,23 @@ retry:
 						       hw->aq.asq_last_status) :
 				   -EIO;
 			hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
+		} else {
+			hw->nvmupd_state = I40E_NVMUPD_STATE_WRITE_WAIT;
 		}
 		break;
 
 	case I40E_NVMUPD_CSUM_LCB:
 		status = i40e_update_nvm_checksum(hw);
-		if (status)
+		if (status) {
 			*perrno = hw->aq.asq_last_status ?
 				   i40e_aq_rc_to_posix(status,
 						       hw->aq.asq_last_status) :
 				   -EIO;
-		else
+			hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
+		} else {
 			hw->aq.nvm_release_on_done = true;
-		hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
+			hw->nvmupd_state = I40E_NVMUPD_STATE_INIT_WAIT;
+		}
 		break;
 
 	default:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 20e16ed..dd0f709 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -313,7 +313,9 @@ enum i40e_nvmupd_cmd {
 enum i40e_nvmupd_state {
 	I40E_NVMUPD_STATE_INIT,
 	I40E_NVMUPD_STATE_READING,
-	I40E_NVMUPD_STATE_WRITING
+	I40E_NVMUPD_STATE_WRITING,
+	I40E_NVMUPD_STATE_INIT_WAIT,
+	I40E_NVMUPD_STATE_WRITE_WAIT,
 };
 
 /* nvm_access definition and its masks/shifts need to be accessible to
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index ee02e25..00f4956 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -312,7 +312,9 @@ enum i40e_nvmupd_cmd {
 enum i40e_nvmupd_state {
 	I40E_NVMUPD_STATE_INIT,
 	I40E_NVMUPD_STATE_READING,
-	I40E_NVMUPD_STATE_WRITING
+	I40E_NVMUPD_STATE_WRITING,
+	I40E_NVMUPD_STATE_INIT_WAIT,
+	I40E_NVMUPD_STATE_WRITE_WAIT,
 };
 
 /* nvm_access definition and its masks/shifts need to be accessible to
-- 
1.9.3

