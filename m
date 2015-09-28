From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:12:38 -0400
Subject: [Intel-wired-lan] [next PATCH S16 09/15] i40e/i40evf: grab the AQ
	spinlocks before clearing registers
In-Reply-To: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443463964-148204-10-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Make sure we have the spinlocks before we clear the ARQ and ASQ management
registers.  Also, widen the locked portion and make a sanity check earlier
in the send function to be sure we're working with safe register values.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I34b56044b33461ed780f3d2de8d62826cdf933f9
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c   | 45 +++++++++++++------------
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c | 45 +++++++++++++------------
 2 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index a41945a..22c7f50 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -482,8 +482,12 @@ static i40e_status i40e_shutdown_asq(struct i40e_hw *hw)
 {
 	i40e_status ret_code = 0;
 
-	if (hw->aq.asq.count == 0)
-		return I40E_ERR_NOT_READY;
+	mutex_lock(&hw->aq.asq_mutex);
+
+	if (hw->aq.asq.count == 0) {
+		ret_code = I40E_ERR_NOT_READY;
+		goto shutdown_asq_out;
+	}
 
 	/* Stop firmware AdminQ processing */
 	wr32(hw, hw->aq.asq.head, 0);
@@ -492,16 +496,13 @@ static i40e_status i40e_shutdown_asq(struct i40e_hw *hw)
 	wr32(hw, hw->aq.asq.bal, 0);
 	wr32(hw, hw->aq.asq.bah, 0);
 
-	/* make sure lock is available */
-	mutex_lock(&hw->aq.asq_mutex);
-
 	hw->aq.asq.count = 0; /* to indicate uninitialized queue */
 
 	/* free ring buffers */
 	i40e_free_asq_bufs(hw);
 
+shutdown_asq_out:
 	mutex_unlock(&hw->aq.asq_mutex);
-
 	return ret_code;
 }
 
@@ -515,8 +516,12 @@ static i40e_status i40e_shutdown_arq(struct i40e_hw *hw)
 {
 	i40e_status ret_code = 0;
 
-	if (hw->aq.arq.count == 0)
-		return I40E_ERR_NOT_READY;
+	mutex_lock(&hw->aq.arq_mutex);
+
+	if (hw->aq.arq.count == 0) {
+		ret_code = I40E_ERR_NOT_READY;
+		goto shutdown_arq_out;
+	}
 
 	/* Stop firmware AdminQ processing */
 	wr32(hw, hw->aq.arq.head, 0);
@@ -525,16 +530,13 @@ static i40e_status i40e_shutdown_arq(struct i40e_hw *hw)
 	wr32(hw, hw->aq.arq.bal, 0);
 	wr32(hw, hw->aq.arq.bah, 0);
 
-	/* make sure lock is available */
-	mutex_lock(&hw->aq.arq_mutex);
-
 	hw->aq.arq.count = 0; /* to indicate uninitialized queue */
 
 	/* free ring buffers */
 	i40e_free_arq_bufs(hw);
 
+shutdown_arq_out:
 	mutex_unlock(&hw->aq.arq_mutex);
-
 	return ret_code;
 }
 
@@ -751,21 +753,23 @@ i40e_status i40e_asq_send_command(struct i40e_hw *hw,
 	u16  retval = 0;
 	u32  val = 0;
 
+	mutex_lock(&hw->aq.asq_mutex);
+
 	hw->aq.asq_last_status = I40E_AQ_RC_OK;
 
-	val = rd32(hw, hw->aq.asq.head);
-	if (val >= hw->aq.num_asq_entries) {
+	if (hw->aq.asq.count == 0) {
 		i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
-			   "AQTX: head overrun at %d\n", val);
+			   "AQTX: Admin queue not initialized.\n");
 		status = I40E_ERR_QUEUE_EMPTY;
-		goto asq_send_command_exit;
+		goto asq_send_command_error;
 	}
 
-	if (hw->aq.asq.count == 0) {
+	val = rd32(hw, hw->aq.asq.head);
+	if (val >= hw->aq.num_asq_entries) {
 		i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
-			   "AQTX: Admin queue not initialized.\n");
+			   "AQTX: head overrun at %d\n", val);
 		status = I40E_ERR_QUEUE_EMPTY;
-		goto asq_send_command_exit;
+		goto asq_send_command_error;
 	}
 
 	details = I40E_ADMINQ_DETAILS(hw->aq.asq, hw->aq.asq.next_to_use);
@@ -790,8 +794,6 @@ i40e_status i40e_asq_send_command(struct i40e_hw *hw,
 	desc->flags &= ~cpu_to_le16(details->flags_dis);
 	desc->flags |= cpu_to_le16(details->flags_ena);
 
-	mutex_lock(&hw->aq.asq_mutex);
-
 	if (buff_size > hw->aq.asq_buf_size) {
 		i40e_debug(hw,
 			   I40E_DEBUG_AQ_MESSAGE,
@@ -915,7 +917,6 @@ i40e_status i40e_asq_send_command(struct i40e_hw *hw,
 
 asq_send_command_error:
 	mutex_unlock(&hw->aq.asq_mutex);
-asq_send_command_exit:
 	return status;
 }
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
index 7b5993b..97a9af2 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
@@ -469,8 +469,12 @@ static i40e_status i40e_shutdown_asq(struct i40e_hw *hw)
 {
 	i40e_status ret_code = 0;
 
-	if (hw->aq.asq.count == 0)
-		return I40E_ERR_NOT_READY;
+	mutex_lock(&hw->aq.asq_mutex);
+
+	if (hw->aq.asq.count == 0) {
+		ret_code = I40E_ERR_NOT_READY;
+		goto shutdown_asq_out;
+	}
 
 	/* Stop firmware AdminQ processing */
 	wr32(hw, hw->aq.asq.head, 0);
@@ -479,16 +483,13 @@ static i40e_status i40e_shutdown_asq(struct i40e_hw *hw)
 	wr32(hw, hw->aq.asq.bal, 0);
 	wr32(hw, hw->aq.asq.bah, 0);
 
-	/* make sure lock is available */
-	mutex_lock(&hw->aq.asq_mutex);
-
 	hw->aq.asq.count = 0; /* to indicate uninitialized queue */
 
 	/* free ring buffers */
 	i40e_free_asq_bufs(hw);
 
+shutdown_asq_out:
 	mutex_unlock(&hw->aq.asq_mutex);
-
 	return ret_code;
 }
 
@@ -502,8 +503,12 @@ static i40e_status i40e_shutdown_arq(struct i40e_hw *hw)
 {
 	i40e_status ret_code = 0;
 
-	if (hw->aq.arq.count == 0)
-		return I40E_ERR_NOT_READY;
+	mutex_lock(&hw->aq.arq_mutex);
+
+	if (hw->aq.arq.count == 0) {
+		ret_code = I40E_ERR_NOT_READY;
+		goto shutdown_arq_out;
+	}
 
 	/* Stop firmware AdminQ processing */
 	wr32(hw, hw->aq.arq.head, 0);
@@ -512,16 +517,13 @@ static i40e_status i40e_shutdown_arq(struct i40e_hw *hw)
 	wr32(hw, hw->aq.arq.bal, 0);
 	wr32(hw, hw->aq.arq.bah, 0);
 
-	/* make sure lock is available */
-	mutex_lock(&hw->aq.arq_mutex);
-
 	hw->aq.arq.count = 0; /* to indicate uninitialized queue */
 
 	/* free ring buffers */
 	i40e_free_arq_bufs(hw);
 
+shutdown_arq_out:
 	mutex_unlock(&hw->aq.arq_mutex);
-
 	return ret_code;
 }
 
@@ -684,21 +686,23 @@ i40e_status i40evf_asq_send_command(struct i40e_hw *hw,
 	u16  retval = 0;
 	u32  val = 0;
 
+	mutex_lock(&hw->aq.asq_mutex);
+
 	hw->aq.asq_last_status = I40E_AQ_RC_OK;
 
-	val = rd32(hw, hw->aq.asq.head);
-	if (val >= hw->aq.num_asq_entries) {
+	if (hw->aq.asq.count == 0) {
 		i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
-			   "AQTX: head overrun at %d\n", val);
+			   "AQTX: Admin queue not initialized.\n");
 		status = I40E_ERR_QUEUE_EMPTY;
-		goto asq_send_command_exit;
+		goto asq_send_command_error;
 	}
 
-	if (hw->aq.asq.count == 0) {
+	val = rd32(hw, hw->aq.asq.head);
+	if (val >= hw->aq.num_asq_entries) {
 		i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
-			   "AQTX: Admin queue not initialized.\n");
+			   "AQTX: head overrun at %d\n", val);
 		status = I40E_ERR_QUEUE_EMPTY;
-		goto asq_send_command_exit;
+		goto asq_send_command_error;
 	}
 
 	details = I40E_ADMINQ_DETAILS(hw->aq.asq, hw->aq.asq.next_to_use);
@@ -723,8 +727,6 @@ i40e_status i40evf_asq_send_command(struct i40e_hw *hw,
 	desc->flags &= ~cpu_to_le16(details->flags_dis);
 	desc->flags |= cpu_to_le16(details->flags_ena);
 
-	mutex_lock(&hw->aq.asq_mutex);
-
 	if (buff_size > hw->aq.asq_buf_size) {
 		i40e_debug(hw,
 			   I40E_DEBUG_AQ_MESSAGE,
@@ -849,7 +851,6 @@ i40e_status i40evf_asq_send_command(struct i40e_hw *hw,
 
 asq_send_command_error:
 	mutex_unlock(&hw->aq.asq_mutex);
-asq_send_command_exit:
 	return status;
 }
 
-- 
1.9.3

