From: Alice Michael <alice.michael@intel.com>
Date: Wed, 27 Dec 2017 08:14:40 -0500
Subject: [Intel-wired-lan] [next PATCH S84-V2 01/13] i40e: Add returning AQ
 critical error to SW
Message-ID: <20171227131440.23579-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Kosiarz <michal.kosiarz@intel.com>

The FW has the ability to return a critical error on every AQ command.
When this critical error occurs then we need to send the correct response
to the caller.

Signed-off-by: Michal Kosiarz <michal.kosiarz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c   | 13 +++++++++----
 drivers/net/ethernet/intel/i40e/i40e_common.c   |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_status.h   |  1 +
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c | 13 +++++++++----
 drivers/net/ethernet/intel/i40evf/i40e_common.c |  2 ++
 drivers/net/ethernet/intel/i40evf/i40e_status.h |  1 +
 6 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index d9670cd..c4fa06d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -907,10 +907,15 @@ i40e_status i40e_asq_send_command(struct i40e_hw *hw,
 	/* update the error if time out occurred */
 	if ((!cmd_completed) &&
 	    (!details->async && !details->postpone)) {
-		i40e_debug(hw,
-			   I40E_DEBUG_AQ_MESSAGE,
-			   "AQTX: Writeback timeout.\n");
-		status = I40E_ERR_ADMIN_QUEUE_TIMEOUT;
+		if (rd32(hw, hw->aq.asq.len) & I40E_GL_ATQLEN_ATQCRIT_MASK) {
+			i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
+				   "AQTX: AQ Critical error.\n");
+			status = I40E_ERR_ADMIN_QUEUE_CRITICAL_ERROR;
+		} else {
+			i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
+				   "AQTX: Writeback timeout.\n");
+			status = I40E_ERR_ADMIN_QUEUE_TIMEOUT;
+		}
 	}
 
 asq_send_command_error:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index ee6052e..c690e9c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -278,6 +278,8 @@ const char *i40e_stat_str(struct i40e_hw *hw, i40e_status stat_err)
 		return "I40E_NOT_SUPPORTED";
 	case I40E_ERR_FIRMWARE_API_VERSION:
 		return "I40E_ERR_FIRMWARE_API_VERSION";
+	case I40E_ERR_ADMIN_QUEUE_CRITICAL_ERROR:
+		return "I40E_ERR_ADMIN_QUEUE_CRITICAL_ERROR";
 	}
 
 	snprintf(hw->err_str, sizeof(hw->err_str), "%d", stat_err);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_status.h b/drivers/net/ethernet/intel/i40e/i40e_status.h
index 5f9cac5..afb72e7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_status.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_status.h
@@ -95,6 +95,7 @@ enum i40e_status_code {
 	I40E_ERR_NOT_READY			= -63,
 	I40E_NOT_SUPPORTED			= -64,
 	I40E_ERR_FIRMWARE_API_VERSION		= -65,
+	I40E_ERR_ADMIN_QUEUE_CRITICAL_ERROR	= -66,
 };
 
 #endif /* _I40E_STATUS_H_ */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
index 8b0d4b2..ae3a740 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
@@ -837,10 +837,15 @@ i40e_status i40evf_asq_send_command(struct i40e_hw *hw,
 	/* update the error if time out occurred */
 	if ((!cmd_completed) &&
 	    (!details->async && !details->postpone)) {
-		i40e_debug(hw,
-			   I40E_DEBUG_AQ_MESSAGE,
-			   "AQTX: Writeback timeout.\n");
-		status = I40E_ERR_ADMIN_QUEUE_TIMEOUT;
+		if (rd32(hw, hw->aq.asq.len) & I40E_VF_ATQLEN1_ATQCRIT_MASK) {
+			i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
+				   "AQTX: AQ Critical error.\n");
+			status = I40E_ERR_ADMIN_QUEUE_CRITICAL_ERROR;
+		} else {
+			i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
+				   "AQTX: Writeback timeout.\n");
+			status = I40E_ERR_ADMIN_QUEUE_TIMEOUT;
+		}
 	}
 
 asq_send_command_error:
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index a946484..67bf5ce 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -284,6 +284,8 @@ const char *i40evf_stat_str(struct i40e_hw *hw, i40e_status stat_err)
 		return "I40E_NOT_SUPPORTED";
 	case I40E_ERR_FIRMWARE_API_VERSION:
 		return "I40E_ERR_FIRMWARE_API_VERSION";
+	case I40E_ERR_ADMIN_QUEUE_CRITICAL_ERROR:
+		return "I40E_ERR_ADMIN_QUEUE_CRITICAL_ERROR";
 	}
 
 	snprintf(hw->err_str, sizeof(hw->err_str), "%d", stat_err);
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_status.h b/drivers/net/ethernet/intel/i40evf/i40e_status.h
index 7fa7a41..5b22224 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_status.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_status.h
@@ -95,6 +95,7 @@ enum i40e_status_code {
 	I40E_ERR_NOT_READY			= -63,
 	I40E_NOT_SUPPORTED			= -64,
 	I40E_ERR_FIRMWARE_API_VERSION		= -65,
+	I40E_ERR_ADMIN_QUEUE_CRITICAL_ERROR	= -66,
 };
 
 #endif /* _I40E_STATUS_H_ */
-- 
2.9.5

