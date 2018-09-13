From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 13 Sep 2018 15:31:40 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 10/14] iavf: replace
 i40e_debug with iavf version
In-Reply-To: <20180913223144.75823-1-jesse.brandeburg@intel.com>
References: <20180913223144.75823-1-jesse.brandeburg@intel.com>
Message-ID: <20180913223144.75823-11-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Change another string (i40e_debug)

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/iavf/i40e_adminq.c    | 28 ++++++++++++------------
 drivers/net/ethernet/intel/iavf/i40e_common.c    | 12 +++++-----
 drivers/net/ethernet/intel/iavf/i40e_osdep.h     |  2 +-
 drivers/net/ethernet/intel/iavf/i40e_prototype.h |  2 +-
 drivers/net/ethernet/intel/iavf/i40e_type.h      |  2 +-
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/i40e_adminq.c b/drivers/net/ethernet/intel/iavf/i40e_adminq.c
index 480c3e8c38c8..d614722fbb3d 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/iavf/i40e_adminq.c
@@ -577,7 +577,7 @@ static u16 i40e_clean_asq(struct iavf_hw *hw)
 	desc = IAVF_ADMINQ_DESC(*asq, ntc);
 	details = I40E_ADMINQ_DETAILS(*asq, ntc);
 	while (rd32(hw, hw->aq.asq.head) != ntc) {
-		i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
+		iavf_debug(hw, I40E_DEBUG_AQ_MESSAGE,
 			   "ntc %d head %d.\n", ntc, rd32(hw, hw->aq.asq.head));
 
 		if (details->callback) {
@@ -643,7 +643,7 @@ iavf_status iavf_asq_send_command(struct iavf_hw *hw, struct i40e_aq_desc *desc,
 	mutex_lock(&hw->aq.asq_mutex);
 
 	if (hw->aq.asq.count == 0) {
-		i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
+		iavf_debug(hw, I40E_DEBUG_AQ_MESSAGE,
 			   "AQTX: Admin queue not initialized.\n");
 		status = I40E_ERR_QUEUE_EMPTY;
 		goto asq_send_command_error;
@@ -653,7 +653,7 @@ iavf_status iavf_asq_send_command(struct iavf_hw *hw, struct i40e_aq_desc *desc,
 
 	val = rd32(hw, hw->aq.asq.head);
 	if (val >= hw->aq.num_asq_entries) {
-		i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
+		iavf_debug(hw, I40E_DEBUG_AQ_MESSAGE,
 			   "AQTX: head overrun at %d\n", val);
 		status = I40E_ERR_QUEUE_EMPTY;
 		goto asq_send_command_error;
@@ -682,7 +682,7 @@ iavf_status iavf_asq_send_command(struct iavf_hw *hw, struct i40e_aq_desc *desc,
 	desc->flags |= cpu_to_le16(details->flags_ena);
 
 	if (buff_size > hw->aq.asq_buf_size) {
-		i40e_debug(hw,
+		iavf_debug(hw,
 			   I40E_DEBUG_AQ_MESSAGE,
 			   "AQTX: Invalid buffer size: %d.\n",
 			   buff_size);
@@ -691,7 +691,7 @@ iavf_status iavf_asq_send_command(struct iavf_hw *hw, struct i40e_aq_desc *desc,
 	}
 
 	if (details->postpone && !details->async) {
-		i40e_debug(hw,
+		iavf_debug(hw,
 			   I40E_DEBUG_AQ_MESSAGE,
 			   "AQTX: Async flag not set along with postpone flag");
 		status = I40E_ERR_PARAM;
@@ -706,7 +706,7 @@ iavf_status iavf_asq_send_command(struct iavf_hw *hw, struct i40e_aq_desc *desc,
 	 * in case of asynchronous completions
 	 */
 	if (i40e_clean_asq(hw) == 0) {
-		i40e_debug(hw,
+		iavf_debug(hw,
 			   I40E_DEBUG_AQ_MESSAGE,
 			   "AQTX: Error queue is full.\n");
 		status = I40E_ERR_ADMIN_QUEUE_FULL;
@@ -736,7 +736,7 @@ iavf_status iavf_asq_send_command(struct iavf_hw *hw, struct i40e_aq_desc *desc,
 	}
 
 	/* bump the tail */
-	i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE, "AQTX: desc and buffer:\n");
+	iavf_debug(hw, I40E_DEBUG_AQ_MESSAGE, "AQTX: desc and buffer:\n");
 	iavf_debug_aq(hw, I40E_DEBUG_AQ_COMMAND, (void *)desc_on_ring,
 		      buff, buff_size);
 	(hw->aq.asq.next_to_use)++;
@@ -769,7 +769,7 @@ iavf_status iavf_asq_send_command(struct iavf_hw *hw, struct i40e_aq_desc *desc,
 			memcpy(buff, dma_buff->va, buff_size);
 		retval = le16_to_cpu(desc->retval);
 		if (retval != 0) {
-			i40e_debug(hw,
+			iavf_debug(hw,
 				   I40E_DEBUG_AQ_MESSAGE,
 				   "AQTX: Command completed with error 0x%X.\n",
 				   retval);
@@ -787,7 +787,7 @@ iavf_status iavf_asq_send_command(struct iavf_hw *hw, struct i40e_aq_desc *desc,
 		hw->aq.asq_last_status = (enum i40e_admin_queue_err)retval;
 	}
 
-	i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
+	iavf_debug(hw, I40E_DEBUG_AQ_MESSAGE,
 		   "AQTX: desc and buffer writeback:\n");
 	iavf_debug_aq(hw, I40E_DEBUG_AQ_COMMAND, (void *)desc, buff, buff_size);
 
@@ -799,11 +799,11 @@ iavf_status iavf_asq_send_command(struct iavf_hw *hw, struct i40e_aq_desc *desc,
 	if ((!cmd_completed) &&
 	    (!details->async && !details->postpone)) {
 		if (rd32(hw, hw->aq.asq.len) & IAVF_VF_ATQLEN1_ATQCRIT_MASK) {
-			i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
+			iavf_debug(hw, I40E_DEBUG_AQ_MESSAGE,
 				   "AQTX: AQ Critical error.\n");
 			status = I40E_ERR_ADMIN_QUEUE_CRITICAL_ERROR;
 		} else {
-			i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
+			iavf_debug(hw, I40E_DEBUG_AQ_MESSAGE,
 				   "AQTX: Writeback timeout.\n");
 			status = I40E_ERR_ADMIN_QUEUE_TIMEOUT;
 		}
@@ -859,7 +859,7 @@ iavf_status iavf_clean_arq_element(struct iavf_hw *hw,
 	mutex_lock(&hw->aq.arq_mutex);
 
 	if (hw->aq.arq.count == 0) {
-		i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
+		iavf_debug(hw, I40E_DEBUG_AQ_MESSAGE,
 			   "AQRX: Admin queue not initialized.\n");
 		ret_code = I40E_ERR_QUEUE_EMPTY;
 		goto clean_arq_element_err;
@@ -882,7 +882,7 @@ iavf_status iavf_clean_arq_element(struct iavf_hw *hw,
 	flags = le16_to_cpu(desc->flags);
 	if (flags & I40E_AQ_FLAG_ERR) {
 		ret_code = I40E_ERR_ADMIN_QUEUE_ERROR;
-		i40e_debug(hw,
+		iavf_debug(hw,
 			   I40E_DEBUG_AQ_MESSAGE,
 			   "AQRX: Event received with error 0x%X.\n",
 			   hw->aq.arq_last_status);
@@ -895,7 +895,7 @@ iavf_status iavf_clean_arq_element(struct iavf_hw *hw,
 		memcpy(e->msg_buf, hw->aq.arq.r.arq_bi[desc_idx].va,
 		       e->msg_len);
 
-	i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE, "AQRX: desc and buffer:\n");
+	iavf_debug(hw, I40E_DEBUG_AQ_MESSAGE, "AQRX: desc and buffer:\n");
 	iavf_debug_aq(hw, I40E_DEBUG_AQ_COMMAND, (void *)desc, e->msg_buf,
 		      hw->aq.arq_buf_size);
 
diff --git a/drivers/net/ethernet/intel/iavf/i40e_common.c b/drivers/net/ethernet/intel/iavf/i40e_common.c
index 97eb06616cc0..c830bb6f5943 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_common.c
+++ b/drivers/net/ethernet/intel/iavf/i40e_common.c
@@ -257,7 +257,7 @@ const char *iavf_stat_str(struct iavf_hw *hw, iavf_status stat_err)
  *
  * Dumps debug log about adminq command with descriptor contents.
  **/
-void iavf_debug_aq(struct iavf_hw *hw, enum i40e_debug_mask mask, void *desc,
+void iavf_debug_aq(struct iavf_hw *hw, enum iavf_debug_mask mask, void *desc,
 		   void *buffer, u16 buf_len)
 {
 	struct i40e_aq_desc *aq_desc = (struct i40e_aq_desc *)desc;
@@ -266,26 +266,26 @@ void iavf_debug_aq(struct iavf_hw *hw, enum i40e_debug_mask mask, void *desc,
 	if ((!(mask & hw->debug_mask)) || !desc)
 		return;
 
-	i40e_debug(hw, mask,
+	iavf_debug(hw, mask,
 		   "AQ CMD: opcode 0x%04X, flags 0x%04X, datalen 0x%04X, retval 0x%04X\n",
 		   le16_to_cpu(aq_desc->opcode),
 		   le16_to_cpu(aq_desc->flags),
 		   le16_to_cpu(aq_desc->datalen),
 		   le16_to_cpu(aq_desc->retval));
-	i40e_debug(hw, mask, "\tcookie (h,l) 0x%08X 0x%08X\n",
+	iavf_debug(hw, mask, "\tcookie (h,l) 0x%08X 0x%08X\n",
 		   le32_to_cpu(aq_desc->cookie_high),
 		   le32_to_cpu(aq_desc->cookie_low));
-	i40e_debug(hw, mask, "\tparam (0,1)  0x%08X 0x%08X\n",
+	iavf_debug(hw, mask, "\tparam (0,1)  0x%08X 0x%08X\n",
 		   le32_to_cpu(aq_desc->params.internal.param0),
 		   le32_to_cpu(aq_desc->params.internal.param1));
-	i40e_debug(hw, mask, "\taddr (h,l)   0x%08X 0x%08X\n",
+	iavf_debug(hw, mask, "\taddr (h,l)   0x%08X 0x%08X\n",
 		   le32_to_cpu(aq_desc->params.external.addr_high),
 		   le32_to_cpu(aq_desc->params.external.addr_low));
 
 	if (buffer && aq_desc->datalen) {
 		u16 len = le16_to_cpu(aq_desc->datalen);
 
-		i40e_debug(hw, mask, "AQ CMD Buffer:\n");
+		iavf_debug(hw, mask, "AQ CMD Buffer:\n");
 		if (buf_len < len)
 			len = buf_len;
 		/* write the full 16-byte chunks */
diff --git a/drivers/net/ethernet/intel/iavf/i40e_osdep.h b/drivers/net/ethernet/intel/iavf/i40e_osdep.h
index 0fceb284e54a..412d534a4bbe 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/iavf/i40e_osdep.h
@@ -44,7 +44,7 @@ struct i40e_virt_mem {
 #define i40e_allocate_virt_mem(h, m, s) iavf_allocate_virt_mem_d(h, m, s)
 #define i40e_free_virt_mem(h, m) iavf_free_virt_mem_d(h, m)
 
-#define i40e_debug(h, m, s, ...)  iavf_debug_d(h, m, s, ##__VA_ARGS__)
+#define iavf_debug(h, m, s, ...)  iavf_debug_d(h, m, s, ##__VA_ARGS__)
 extern void iavf_debug_d(void *hw, u32 mask, char *fmt_str, ...)
 	__attribute__ ((format(gnu_printf, 3, 4)));
 
diff --git a/drivers/net/ethernet/intel/iavf/i40e_prototype.h b/drivers/net/ethernet/intel/iavf/i40e_prototype.h
index 0497832bc53e..5d59104b97b9 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/iavf/i40e_prototype.h
@@ -29,7 +29,7 @@ iavf_status iavf_asq_send_command(struct iavf_hw *hw, struct i40e_aq_desc *desc,
 bool iavf_asq_done(struct iavf_hw *hw);
 
 /* debug function for adminq */
-void iavf_debug_aq(struct iavf_hw *hw, enum i40e_debug_mask mask, void *desc,
+void iavf_debug_aq(struct iavf_hw *hw, enum iavf_debug_mask mask, void *desc,
 		   void *buffer, u16 buf_len);
 
 void i40e_idle_aq(struct iavf_hw *hw);
diff --git a/drivers/net/ethernet/intel/iavf/i40e_type.h b/drivers/net/ethernet/intel/iavf/i40e_type.h
index 2ce4203cd0b6..773df7afb9ac 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_type.h
+++ b/drivers/net/ethernet/intel/iavf/i40e_type.h
@@ -35,7 +35,7 @@ typedef void (*I40E_ADMINQ_CALLBACK)(struct iavf_hw *, struct i40e_aq_desc *);
 #define I40E_QTX_CTL_PF_QUEUE	0x2
 
 /* debug masks - set these bits in hw->debug_mask to control output */
-enum i40e_debug_mask {
+enum iavf_debug_mask {
 	I40E_DEBUG_INIT			= 0x00000001,
 	I40E_DEBUG_RELEASE		= 0x00000002,
 
-- 
2.14.4

