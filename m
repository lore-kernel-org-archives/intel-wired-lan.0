From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 13 Sep 2018 15:31:34 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 04/14] iavf: rename
 i40e_status to iavf_status
In-Reply-To: <20180913223144.75823-1-jesse.brandeburg@intel.com>
References: <20180913223144.75823-1-jesse.brandeburg@intel.com>
Message-ID: <20180913223144.75823-5-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is just a rename of an internal variable i40e_status, but
it was a pretty big change and so deserved it's own patch.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/iavf/i40e_adminq.c     |  94 +++++++++---------
 drivers/net/ethernet/intel/iavf/i40e_alloc.h      |   8 +-
 drivers/net/ethernet/intel/iavf/i40e_common.c     |  72 +++++++-------
 drivers/net/ethernet/intel/iavf/i40e_osdep.h      |   2 +-
 drivers/net/ethernet/intel/iavf/i40e_prototype.h  |  28 +++---
 drivers/net/ethernet/intel/iavf/i40evf.h          |   2 +-
 drivers/net/ethernet/intel/iavf/i40evf_client.c   |   6 +-
 drivers/net/ethernet/intel/iavf/i40evf_ethtool.c  |  52 ++++------
 drivers/net/ethernet/intel/iavf/i40evf_main.c     |  14 +--
 drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c | 115 +++++++++-------------
 10 files changed, 179 insertions(+), 214 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/i40e_adminq.c b/drivers/net/ethernet/intel/iavf/i40e_adminq.c
index 3d1c874f5f85..f0e6f9bbb819 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/iavf/i40e_adminq.c
@@ -34,9 +34,9 @@ static void i40e_adminq_init_regs(struct i40e_hw *hw)
  *  i40e_alloc_adminq_asq_ring - Allocate Admin Queue send rings
  *  @hw: pointer to the hardware structure
  **/
-static i40e_status i40e_alloc_adminq_asq_ring(struct i40e_hw *hw)
+static iavf_status i40e_alloc_adminq_asq_ring(struct i40e_hw *hw)
 {
-	i40e_status ret_code;
+	iavf_status ret_code;
 
 	ret_code = i40e_allocate_dma_mem(hw, &hw->aq.asq.desc_buf,
 					 i40e_mem_atq_ring,
@@ -61,9 +61,9 @@ static i40e_status i40e_alloc_adminq_asq_ring(struct i40e_hw *hw)
  *  i40e_alloc_adminq_arq_ring - Allocate Admin Queue receive rings
  *  @hw: pointer to the hardware structure
  **/
-static i40e_status i40e_alloc_adminq_arq_ring(struct i40e_hw *hw)
+static iavf_status i40e_alloc_adminq_arq_ring(struct i40e_hw *hw)
 {
-	i40e_status ret_code;
+	iavf_status ret_code;
 
 	ret_code = i40e_allocate_dma_mem(hw, &hw->aq.arq.desc_buf,
 					 i40e_mem_arq_ring,
@@ -102,9 +102,9 @@ static void i40e_free_adminq_arq(struct i40e_hw *hw)
  *  i40e_alloc_arq_bufs - Allocate pre-posted buffers for the receive queue
  *  @hw: pointer to the hardware structure
  **/
-static i40e_status i40e_alloc_arq_bufs(struct i40e_hw *hw)
+static iavf_status i40e_alloc_arq_bufs(struct i40e_hw *hw)
 {
-	i40e_status ret_code;
+	iavf_status ret_code;
 	struct i40e_aq_desc *desc;
 	struct i40e_dma_mem *bi;
 	int i;
@@ -115,7 +115,7 @@ static i40e_status i40e_alloc_arq_bufs(struct i40e_hw *hw)
 
 	/* buffer_info structures do not need alignment */
 	ret_code = i40e_allocate_virt_mem(hw, &hw->aq.arq.dma_head,
-		(hw->aq.num_arq_entries * sizeof(struct i40e_dma_mem)));
+					  (hw->aq.num_arq_entries * sizeof(struct i40e_dma_mem)));
 	if (ret_code)
 		goto alloc_arq_bufs;
 	hw->aq.arq.r.arq_bi = (struct i40e_dma_mem *)hw->aq.arq.dma_head.va;
@@ -169,15 +169,15 @@ static i40e_status i40e_alloc_arq_bufs(struct i40e_hw *hw)
  *  i40e_alloc_asq_bufs - Allocate empty buffer structs for the send queue
  *  @hw: pointer to the hardware structure
  **/
-static i40e_status i40e_alloc_asq_bufs(struct i40e_hw *hw)
+static iavf_status i40e_alloc_asq_bufs(struct i40e_hw *hw)
 {
-	i40e_status ret_code;
+	iavf_status ret_code;
 	struct i40e_dma_mem *bi;
 	int i;
 
 	/* No mapped memory needed yet, just the buffer info structures */
 	ret_code = i40e_allocate_virt_mem(hw, &hw->aq.asq.dma_head,
-		(hw->aq.num_asq_entries * sizeof(struct i40e_dma_mem)));
+					  (hw->aq.num_asq_entries * sizeof(struct i40e_dma_mem)));
 	if (ret_code)
 		goto alloc_asq_bufs;
 	hw->aq.asq.r.asq_bi = (struct i40e_dma_mem *)hw->aq.asq.dma_head.va;
@@ -253,9 +253,9 @@ static void i40e_free_asq_bufs(struct i40e_hw *hw)
  *
  *  Configure base address and length registers for the transmit queue
  **/
-static i40e_status i40e_config_asq_regs(struct i40e_hw *hw)
+static iavf_status i40e_config_asq_regs(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
+	iavf_status ret_code = 0;
 	u32 reg = 0;
 
 	/* Clear Head and Tail */
@@ -282,9 +282,9 @@ static i40e_status i40e_config_asq_regs(struct i40e_hw *hw)
  *
  * Configure base address and length registers for the receive (event queue)
  **/
-static i40e_status i40e_config_arq_regs(struct i40e_hw *hw)
+static iavf_status i40e_config_arq_regs(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
+	iavf_status ret_code = 0;
 	u32 reg = 0;
 
 	/* Clear Head and Tail */
@@ -321,9 +321,9 @@ static i40e_status i40e_config_arq_regs(struct i40e_hw *hw)
  *  Do *NOT* hold the lock when calling this as the memory allocation routines
  *  called are not going to be atomic context safe
  **/
-static i40e_status i40e_init_asq(struct i40e_hw *hw)
+static iavf_status i40e_init_asq(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
+	iavf_status ret_code = 0;
 
 	if (hw->aq.asq.count > 0) {
 		/* queue already initialized */
@@ -380,9 +380,9 @@ static i40e_status i40e_init_asq(struct i40e_hw *hw)
  *  Do *NOT* hold the lock when calling this as the memory allocation routines
  *  called are not going to be atomic context safe
  **/
-static i40e_status i40e_init_arq(struct i40e_hw *hw)
+static iavf_status i40e_init_arq(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
+	iavf_status ret_code = 0;
 
 	if (hw->aq.arq.count > 0) {
 		/* queue already initialized */
@@ -432,9 +432,9 @@ static i40e_status i40e_init_arq(struct i40e_hw *hw)
  *
  *  The main shutdown routine for the Admin Send Queue
  **/
-static i40e_status i40e_shutdown_asq(struct i40e_hw *hw)
+static iavf_status i40e_shutdown_asq(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
+	iavf_status ret_code = 0;
 
 	mutex_lock(&hw->aq.asq_mutex);
 
@@ -466,9 +466,9 @@ static i40e_status i40e_shutdown_asq(struct i40e_hw *hw)
  *
  *  The main shutdown routine for the Admin Receive Queue
  **/
-static i40e_status i40e_shutdown_arq(struct i40e_hw *hw)
+static iavf_status i40e_shutdown_arq(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
+	iavf_status ret_code = 0;
 
 	mutex_lock(&hw->aq.arq_mutex);
 
@@ -505,9 +505,9 @@ static i40e_status i40e_shutdown_arq(struct i40e_hw *hw)
  *     - hw->aq.arq_buf_size
  *     - hw->aq.asq_buf_size
  **/
-i40e_status iavf_init_adminq(struct i40e_hw *hw)
+iavf_status iavf_init_adminq(struct i40e_hw *hw)
 {
-	i40e_status ret_code;
+	iavf_status ret_code;
 
 	/* verify input for valid configuration */
 	if ((hw->aq.num_arq_entries == 0) ||
@@ -549,9 +549,9 @@ i40e_status iavf_init_adminq(struct i40e_hw *hw)
  *  iavf_shutdown_adminq - shutdown routine for the Admin Queue
  *  @hw: pointer to the hardware structure
  **/
-i40e_status iavf_shutdown_adminq(struct i40e_hw *hw)
+iavf_status iavf_shutdown_adminq(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
+	iavf_status ret_code = 0;
 
 	if (iavf_check_asq_alive(hw))
 		iavf_aq_queue_shutdown(hw, true);
@@ -570,7 +570,7 @@ i40e_status iavf_shutdown_adminq(struct i40e_hw *hw)
  **/
 static u16 i40e_clean_asq(struct i40e_hw *hw)
 {
-	struct i40e_adminq_ring *asq = &(hw->aq.asq);
+	struct i40e_adminq_ring *asq = &hw->aq.asq;
 	struct i40e_asq_cmd_details *details;
 	u16 ntc = asq->next_to_clean;
 	struct i40e_aq_desc desc_cb;
@@ -616,7 +616,6 @@ bool iavf_asq_done(struct i40e_hw *hw)
 	 * timing reliability than DD bit
 	 */
 	return rd32(hw, hw->aq.asq.head) == hw->aq.asq.next_to_use;
-
 }
 
 /**
@@ -630,17 +629,16 @@ bool iavf_asq_done(struct i40e_hw *hw)
  *  This is the main send command driver routine for the Admin Queue send
  *  queue.  It runs the queue, cleans the queue, etc
  **/
-i40e_status iavf_asq_send_command(struct i40e_hw *hw,
-				struct i40e_aq_desc *desc,
-				void *buff, /* can be NULL */
-				u16  buff_size,
-				struct i40e_asq_cmd_details *cmd_details)
+iavf_status iavf_asq_send_command(struct i40e_hw *hw, struct i40e_aq_desc *desc,
+				  void *buff, /* can be NULL */
+				  u16  buff_size,
+				  struct i40e_asq_cmd_details *cmd_details)
 {
-	i40e_status status = 0;
 	struct i40e_dma_mem *dma_buff = NULL;
 	struct i40e_asq_cmd_details *details;
 	struct i40e_aq_desc *desc_on_ring;
 	bool cmd_completed = false;
+	iavf_status status = 0;
 	u16  retval = 0;
 	u32  val = 0;
 
@@ -724,8 +722,8 @@ i40e_status iavf_asq_send_command(struct i40e_hw *hw,
 	*desc_on_ring = *desc;
 
 	/* if buff is not NULL assume indirect command */
-	if (buff != NULL) {
-		dma_buff = &(hw->aq.asq.r.asq_bi[hw->aq.asq.next_to_use]);
+	if (buff) {
+		dma_buff = &hw->aq.asq.r.asq_bi[hw->aq.asq.next_to_use];
 		/* copy the user buff into the respective DMA buff */
 		memcpy(dma_buff->va, buff, buff_size);
 		desc_on_ring->datalen = cpu_to_le16(buff_size);
@@ -742,7 +740,7 @@ i40e_status iavf_asq_send_command(struct i40e_hw *hw,
 	/* bump the tail */
 	i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE, "AQTX: desc and buffer:\n");
 	iavf_debug_aq(hw, I40E_DEBUG_AQ_COMMAND, (void *)desc_on_ring,
-			buff, buff_size);
+		      buff, buff_size);
 	(hw->aq.asq.next_to_use)++;
 	if (hw->aq.asq.next_to_use == hw->aq.asq.count)
 		hw->aq.asq.next_to_use = 0;
@@ -769,7 +767,7 @@ i40e_status iavf_asq_send_command(struct i40e_hw *hw,
 	/* if ready, copy the desc back to temp */
 	if (iavf_asq_done(hw)) {
 		*desc = *desc_on_ring;
-		if (buff != NULL)
+		if (buff)
 			memcpy(buff, dma_buff->va, buff_size);
 		retval = le16_to_cpu(desc->retval);
 		if (retval != 0) {
@@ -793,8 +791,7 @@ i40e_status iavf_asq_send_command(struct i40e_hw *hw,
 
 	i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
 		   "AQTX: desc and buffer writeback:\n");
-	iavf_debug_aq(hw, I40E_DEBUG_AQ_COMMAND, (void *)desc, buff,
-			buff_size);
+	iavf_debug_aq(hw, I40E_DEBUG_AQ_COMMAND, (void *)desc, buff, buff_size);
 
 	/* save writeback aq if requested */
 	if (details->wb_desc)
@@ -826,8 +823,7 @@ i40e_status iavf_asq_send_command(struct i40e_hw *hw,
  *
  *  Fill the desc with default values
  **/
-void iavf_fill_default_direct_cmd_desc(struct i40e_aq_desc *desc,
-				       u16 opcode)
+void iavf_fill_default_direct_cmd_desc(struct i40e_aq_desc *desc, u16 opcode)
 {
 	/* zero out the desc */
 	memset((void *)desc, 0, sizeof(struct i40e_aq_desc));
@@ -845,13 +841,13 @@ void iavf_fill_default_direct_cmd_desc(struct i40e_aq_desc *desc,
  *  the contents through e.  It can also return how many events are
  *  left to process through 'pending'
  **/
-i40e_status iavf_clean_arq_element(struct i40e_hw *hw,
-					     struct i40e_arq_event_info *e,
-					     u16 *pending)
+iavf_status iavf_clean_arq_element(struct i40e_hw *hw,
+				   struct i40e_arq_event_info *e,
+				   u16 *pending)
 {
-	i40e_status ret_code = 0;
 	u16 ntc = hw->aq.arq.next_to_clean;
 	struct i40e_aq_desc *desc;
+	iavf_status ret_code = 0;
 	struct i40e_dma_mem *bi;
 	u16 desc_idx;
 	u16 datalen;
@@ -897,13 +893,13 @@ i40e_status iavf_clean_arq_element(struct i40e_hw *hw,
 	e->desc = *desc;
 	datalen = le16_to_cpu(desc->datalen);
 	e->msg_len = min(datalen, e->buf_len);
-	if (e->msg_buf != NULL && (e->msg_len != 0))
+	if (e->msg_buf && (e->msg_len != 0))
 		memcpy(e->msg_buf, hw->aq.arq.r.arq_bi[desc_idx].va,
 		       e->msg_len);
 
 	i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE, "AQRX: desc and buffer:\n");
 	iavf_debug_aq(hw, I40E_DEBUG_AQ_COMMAND, (void *)desc, e->msg_buf,
-			hw->aq.arq_buf_size);
+		      hw->aq.arq_buf_size);
 
 	/* Restore the original datalen and buffer address in the desc,
 	 * FW updates datalen to indicate the event message
@@ -930,7 +926,7 @@ i40e_status iavf_clean_arq_element(struct i40e_hw *hw,
 
 clean_arq_element_out:
 	/* Set pending if needed, unlock and return */
-	if (pending != NULL)
+	if (pending)
 		*pending = (ntc > ntu ? hw->aq.arq.count : 0) + (ntu - ntc);
 
 clean_arq_element_err:
diff --git a/drivers/net/ethernet/intel/iavf/i40e_alloc.h b/drivers/net/ethernet/intel/iavf/i40e_alloc.h
index cb8689222c8b..de3edf3bc8a4 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_alloc.h
+++ b/drivers/net/ethernet/intel/iavf/i40e_alloc.h
@@ -20,16 +20,16 @@ enum i40e_memory_type {
 };
 
 /* prototype for functions used for dynamic memory allocation */
-i40e_status i40e_allocate_dma_mem(struct i40e_hw *hw,
+iavf_status i40e_allocate_dma_mem(struct i40e_hw *hw,
 					    struct i40e_dma_mem *mem,
 					    enum i40e_memory_type type,
 					    u64 size, u32 alignment);
-i40e_status i40e_free_dma_mem(struct i40e_hw *hw,
+iavf_status i40e_free_dma_mem(struct i40e_hw *hw,
 					struct i40e_dma_mem *mem);
-i40e_status i40e_allocate_virt_mem(struct i40e_hw *hw,
+iavf_status i40e_allocate_virt_mem(struct i40e_hw *hw,
 					     struct i40e_virt_mem *mem,
 					     u32 size);
-i40e_status i40e_free_virt_mem(struct i40e_hw *hw,
+iavf_status i40e_free_virt_mem(struct i40e_hw *hw,
 					 struct i40e_virt_mem *mem);
 
 #endif /* _I40E_ALLOC_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/i40e_common.c b/drivers/net/ethernet/intel/iavf/i40e_common.c
index cc2e229ea976..96133efddf72 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_common.c
+++ b/drivers/net/ethernet/intel/iavf/i40e_common.c
@@ -13,9 +13,9 @@
  * This function sets the mac type of the adapter based on the
  * vendor ID and device ID stored in the hw structure.
  **/
-i40e_status i40e_set_mac_type(struct i40e_hw *hw)
+iavf_status i40e_set_mac_type(struct i40e_hw *hw)
 {
-	i40e_status status = 0;
+	iavf_status status = 0;
 
 	if (hw->vendor_id == PCI_VENDOR_ID_INTEL) {
 		switch (hw->device_id) {
@@ -56,8 +56,7 @@ i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		status = I40E_ERR_DEVICE_NOT_SUPPORTED;
 	}
 
-	hw_dbg(hw, "i40e_set_mac_type found mac: %d, returns: %d\n",
-		  hw->mac.type, status);
+	hw_dbg(hw, "found mac: %d, returns: %d\n", hw->mac.type, status);
 	return status;
 }
 
@@ -126,7 +125,7 @@ const char *iavf_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err)
  * @hw: pointer to the HW structure
  * @stat_err: the status error code to convert
  **/
-const char *iavf_stat_str(struct i40e_hw *hw, i40e_status stat_err)
+const char *iavf_stat_str(struct i40e_hw *hw, iavf_status stat_err)
 {
 	switch (stat_err) {
 	case 0:
@@ -285,7 +284,7 @@ void iavf_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask, void *desc,
 	struct i40e_aq_desc *aq_desc = (struct i40e_aq_desc *)desc;
 	u8 *buf = (u8 *)buffer;
 
-	if ((!(mask & hw->debug_mask)) || (desc == NULL))
+	if ((!(mask & hw->debug_mask)) || !desc)
 		return;
 
 	i40e_debug(hw, mask,
@@ -304,7 +303,7 @@ void iavf_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask, void *desc,
 		   le32_to_cpu(aq_desc->params.external.addr_high),
 		   le32_to_cpu(aq_desc->params.external.addr_low));
 
-	if ((buffer != NULL) && (aq_desc->datalen != 0)) {
+	if (buffer && aq_desc->datalen) {
 		u16 len = le16_to_cpu(aq_desc->datalen);
 
 		i40e_debug(hw, mask, "AQ CMD Buffer:\n");
@@ -349,16 +348,14 @@ bool iavf_check_asq_alive(struct i40e_hw *hw)
  * Tell the Firmware that we're shutting down the AdminQ and whether
  * or not the driver is unloading as well.
  **/
-i40e_status iavf_aq_queue_shutdown(struct i40e_hw *hw,
-					     bool unloading)
+iavf_status iavf_aq_queue_shutdown(struct i40e_hw *hw, bool unloading)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_queue_shutdown *cmd =
 		(struct i40e_aqc_queue_shutdown *)&desc.params.raw;
-	i40e_status status;
+	iavf_status status;
 
-	iavf_fill_default_direct_cmd_desc(&desc,
-					  i40e_aqc_opc_queue_shutdown);
+	iavf_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_queue_shutdown);
 
 	if (unloading)
 		cmd->driver_unloading = cpu_to_le32(I40E_AQ_DRIVER_UNLOADING);
@@ -378,22 +375,22 @@ i40e_status iavf_aq_queue_shutdown(struct i40e_hw *hw,
  *
  * Internal function to get or set RSS look up table
  **/
-static i40e_status i40e_aq_get_set_rss_lut(struct i40e_hw *hw,
+static iavf_status i40e_aq_get_set_rss_lut(struct i40e_hw *hw,
 					   u16 vsi_id, bool pf_lut,
 					   u8 *lut, u16 lut_size,
 					   bool set)
 {
-	i40e_status status;
+	iavf_status status;
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_get_set_rss_lut *cmd_resp =
 		   (struct i40e_aqc_get_set_rss_lut *)&desc.params.raw;
 
 	if (set)
 		iavf_fill_default_direct_cmd_desc(&desc,
-						    i40e_aqc_opc_set_rss_lut);
+						  i40e_aqc_opc_set_rss_lut);
 	else
 		iavf_fill_default_direct_cmd_desc(&desc,
-						    i40e_aqc_opc_get_rss_lut);
+						  i40e_aqc_opc_get_rss_lut);
 
 	/* Indirect command */
 	desc.flags |= cpu_to_le16((u16)I40E_AQ_FLAG_BUF);
@@ -431,8 +428,8 @@ static i40e_status i40e_aq_get_set_rss_lut(struct i40e_hw *hw,
  *
  * get the RSS lookup table, PF or VSI type
  **/
-i40e_status iavf_aq_get_rss_lut(struct i40e_hw *hw, u16 vsi_id,
-				  bool pf_lut, u8 *lut, u16 lut_size)
+iavf_status iavf_aq_get_rss_lut(struct i40e_hw *hw, u16 vsi_id,
+				bool pf_lut, u8 *lut, u16 lut_size)
 {
 	return i40e_aq_get_set_rss_lut(hw, vsi_id, pf_lut, lut, lut_size,
 				       false);
@@ -448,8 +445,8 @@ i40e_status iavf_aq_get_rss_lut(struct i40e_hw *hw, u16 vsi_id,
  *
  * set the RSS lookup table, PF or VSI type
  **/
-i40e_status iavf_aq_set_rss_lut(struct i40e_hw *hw, u16 vsi_id,
-				  bool pf_lut, u8 *lut, u16 lut_size)
+iavf_status iavf_aq_set_rss_lut(struct i40e_hw *hw, u16 vsi_id,
+				bool pf_lut, u8 *lut, u16 lut_size)
 {
 	return i40e_aq_get_set_rss_lut(hw, vsi_id, pf_lut, lut, lut_size, true);
 }
@@ -463,12 +460,12 @@ i40e_status iavf_aq_set_rss_lut(struct i40e_hw *hw, u16 vsi_id,
  *
  * get the RSS key per VSI
  **/
-static i40e_status i40e_aq_get_set_rss_key(struct i40e_hw *hw,
-				      u16 vsi_id,
-				      struct i40e_aqc_get_set_rss_key_data *key,
-				      bool set)
+static
+iavf_status i40e_aq_get_set_rss_key(struct i40e_hw *hw, u16 vsi_id,
+				    struct i40e_aqc_get_set_rss_key_data *key,
+				    bool set)
 {
-	i40e_status status;
+	iavf_status status;
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_get_set_rss_key *cmd_resp =
 			(struct i40e_aqc_get_set_rss_key *)&desc.params.raw;
@@ -476,10 +473,10 @@ static i40e_status i40e_aq_get_set_rss_key(struct i40e_hw *hw,
 
 	if (set)
 		iavf_fill_default_direct_cmd_desc(&desc,
-						    i40e_aqc_opc_set_rss_key);
+						  i40e_aqc_opc_set_rss_key);
 	else
 		iavf_fill_default_direct_cmd_desc(&desc,
-						    i40e_aqc_opc_get_rss_key);
+						  i40e_aqc_opc_get_rss_key);
 
 	/* Indirect command */
 	desc.flags |= cpu_to_le16((u16)I40E_AQ_FLAG_BUF);
@@ -503,9 +500,8 @@ static i40e_status i40e_aq_get_set_rss_key(struct i40e_hw *hw,
  * @key: pointer to key info struct
  *
  **/
-i40e_status iavf_aq_get_rss_key(struct i40e_hw *hw,
-				  u16 vsi_id,
-				  struct i40e_aqc_get_set_rss_key_data *key)
+iavf_status iavf_aq_get_rss_key(struct i40e_hw *hw, u16 vsi_id,
+				struct i40e_aqc_get_set_rss_key_data *key)
 {
 	return i40e_aq_get_set_rss_key(hw, vsi_id, key, false);
 }
@@ -518,14 +514,12 @@ i40e_status iavf_aq_get_rss_key(struct i40e_hw *hw,
  *
  * set the RSS key per VSI
  **/
-i40e_status iavf_aq_set_rss_key(struct i40e_hw *hw,
-				  u16 vsi_id,
-				  struct i40e_aqc_get_set_rss_key_data *key)
+iavf_status iavf_aq_set_rss_key(struct i40e_hw *hw, u16 vsi_id,
+				struct i40e_aqc_get_set_rss_key_data *key)
 {
 	return i40e_aq_get_set_rss_key(hw, vsi_id, key, true);
 }
 
-
 /* The iavf_ptype_lookup table is used to convert from the 8-bit ptype in the
  * hardware to a bit-field that can be used by SW to more easily determine the
  * packet type.
@@ -904,14 +898,14 @@ struct i40e_rx_ptype_decoded iavf_ptype_lookup[] = {
  * is sent asynchronously, i.e. iavf_asq_send_command() does not wait for
  * completion before returning.
  **/
-i40e_status iavf_aq_send_msg_to_pf(struct i40e_hw *hw,
+iavf_status iavf_aq_send_msg_to_pf(struct i40e_hw *hw,
 				   enum virtchnl_ops v_opcode,
-				   i40e_status v_retval, u8 *msg, u16 msglen,
+				   iavf_status v_retval, u8 *msg, u16 msglen,
 				   struct i40e_asq_cmd_details *cmd_details)
 {
-	struct i40e_aq_desc desc;
 	struct i40e_asq_cmd_details details;
-	i40e_status status;
+	struct i40e_aq_desc desc;
+	iavf_status status;
 
 	iavf_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_send_msg_to_pf);
 	desc.flags |= cpu_to_le16((u16)I40E_AQ_FLAG_SI);
@@ -975,7 +969,7 @@ void iavf_vf_parse_hw_config(struct i40e_hw *hw,
  * as none will be forthcoming. Immediately after calling this function,
  * the admin queue should be shut down and (optionally) reinitialized.
  **/
-i40e_status iavf_vf_reset(struct i40e_hw *hw)
+iavf_status iavf_vf_reset(struct i40e_hw *hw)
 {
 	return iavf_aq_send_msg_to_pf(hw, VIRTCHNL_OP_RESET_VF,
 				      0, NULL, 0, NULL);
diff --git a/drivers/net/ethernet/intel/iavf/i40e_osdep.h b/drivers/net/ethernet/intel/iavf/i40e_osdep.h
index 01e6babbdcd3..788a599dc26b 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/iavf/i40e_osdep.h
@@ -48,5 +48,5 @@ struct i40e_virt_mem {
 extern void iavf_debug_d(void *hw, u32 mask, char *fmt_str, ...)
 	__attribute__ ((format(gnu_printf, 3, 4)));
 
-typedef enum i40e_status_code i40e_status;
+typedef enum i40e_status_code iavf_status;
 #endif /* _I40E_OSDEP_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/i40e_prototype.h b/drivers/net/ethernet/intel/iavf/i40e_prototype.h
index ea38aaf4a511..f2d52ec2ece0 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/iavf/i40e_prototype.h
@@ -16,13 +16,13 @@
  */
 
 /* adminq functions */
-i40e_status iavf_init_adminq(struct i40e_hw *hw);
-i40e_status iavf_shutdown_adminq(struct i40e_hw *hw);
+iavf_status iavf_init_adminq(struct i40e_hw *hw);
+iavf_status iavf_shutdown_adminq(struct i40e_hw *hw);
 void i40e_adminq_init_ring_data(struct i40e_hw *hw);
-i40e_status iavf_clean_arq_element(struct i40e_hw *hw,
+iavf_status iavf_clean_arq_element(struct i40e_hw *hw,
 					     struct i40e_arq_event_info *e,
 					     u16 *events_pending);
-i40e_status iavf_asq_send_command(struct i40e_hw *hw,
+iavf_status iavf_asq_send_command(struct i40e_hw *hw,
 				struct i40e_aq_desc *desc,
 				void *buff, /* can be NULL */
 				u16  buff_size,
@@ -36,22 +36,22 @@ void iavf_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask,
 void i40e_idle_aq(struct i40e_hw *hw);
 void iavf_resume_aq(struct i40e_hw *hw);
 bool iavf_check_asq_alive(struct i40e_hw *hw);
-i40e_status iavf_aq_queue_shutdown(struct i40e_hw *hw, bool unloading);
+iavf_status iavf_aq_queue_shutdown(struct i40e_hw *hw, bool unloading);
 const char *iavf_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err);
-const char *iavf_stat_str(struct i40e_hw *hw, i40e_status stat_err);
+const char *iavf_stat_str(struct i40e_hw *hw, iavf_status stat_err);
 
-i40e_status iavf_aq_get_rss_lut(struct i40e_hw *hw, u16 seid,
+iavf_status iavf_aq_get_rss_lut(struct i40e_hw *hw, u16 seid,
 				  bool pf_lut, u8 *lut, u16 lut_size);
-i40e_status iavf_aq_set_rss_lut(struct i40e_hw *hw, u16 seid,
+iavf_status iavf_aq_set_rss_lut(struct i40e_hw *hw, u16 seid,
 				  bool pf_lut, u8 *lut, u16 lut_size);
-i40e_status iavf_aq_get_rss_key(struct i40e_hw *hw,
+iavf_status iavf_aq_get_rss_key(struct i40e_hw *hw,
 				  u16 seid,
 				  struct i40e_aqc_get_set_rss_key_data *key);
-i40e_status iavf_aq_set_rss_key(struct i40e_hw *hw,
+iavf_status iavf_aq_set_rss_key(struct i40e_hw *hw,
 				  u16 seid,
 				  struct i40e_aqc_get_set_rss_key_data *key);
 
-i40e_status i40e_set_mac_type(struct i40e_hw *hw);
+iavf_status i40e_set_mac_type(struct i40e_hw *hw);
 
 extern struct i40e_rx_ptype_decoded iavf_ptype_lookup[];
 
@@ -63,9 +63,9 @@ static inline struct i40e_rx_ptype_decoded decode_rx_desc_ptype(u8 ptype)
 /* i40e_common for VF drivers*/
 void iavf_vf_parse_hw_config(struct i40e_hw *hw,
 			     struct virtchnl_vf_resource *msg);
-i40e_status iavf_vf_reset(struct i40e_hw *hw);
-i40e_status iavf_aq_send_msg_to_pf(struct i40e_hw *hw,
+iavf_status iavf_vf_reset(struct i40e_hw *hw);
+iavf_status iavf_aq_send_msg_to_pf(struct i40e_hw *hw,
 				   enum virtchnl_ops v_opcode,
-				   i40e_status v_retval, u8 *msg, u16 msglen,
+				   iavf_status v_retval, u8 *msg, u16 msglen,
 				   struct i40e_asq_cmd_details *cmd_details);
 #endif /* _I40E_PROTOTYPE_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/i40evf.h b/drivers/net/ethernet/intel/iavf/i40evf.h
index 15a0910a7a79..19a93bfdb65c 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf.h
+++ b/drivers/net/ethernet/intel/iavf/i40evf.h
@@ -411,7 +411,7 @@ void iavf_enable_vlan_stripping(struct iavf_adapter *adapter);
 void iavf_disable_vlan_stripping(struct iavf_adapter *adapter);
 void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 				enum virtchnl_ops v_opcode,
-				i40e_status v_retval, u8 *msg, u16 msglen);
+				iavf_status v_retval, u8 *msg, u16 msglen);
 int iavf_config_rss(struct iavf_adapter *adapter);
 int iavf_lan_add_device(struct iavf_adapter *adapter);
 int iavf_lan_del_device(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/i40evf_client.c b/drivers/net/ethernet/intel/iavf/i40evf_client.c
index 71d94cb24602..d2660659174d 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf_client.c
+++ b/drivers/net/ethernet/intel/iavf/i40evf_client.c
@@ -135,7 +135,7 @@ void iavf_notify_client_open(struct i40e_vsi *vsi)
 static int iavf_client_release_qvlist(struct i40e_info *ldev)
 {
 	struct iavf_adapter *adapter = ldev->vf;
-	i40e_status err;
+	iavf_status err;
 
 	if (adapter->aq_required)
 		return -EAGAIN;
@@ -420,7 +420,7 @@ static u32 iavf_client_virtchnl_send(struct i40e_info *ldev,
 				       u8 *msg, u16 len)
 {
 	struct iavf_adapter *adapter = ldev->vf;
-	i40e_status err;
+	iavf_status err;
 
 	if (adapter->aq_required)
 		return -EAGAIN;
@@ -449,7 +449,7 @@ static int iavf_client_setup_qvlist(struct i40e_info *ldev,
 	struct virtchnl_iwarp_qvlist_info *v_qvlist_info;
 	struct iavf_adapter *adapter = ldev->vf;
 	struct i40e_qv_info *qv_info;
-	i40e_status err;
+	iavf_status err;
 	u32 v_idx, i;
 	u32 msg_size;
 
diff --git a/drivers/net/ethernet/intel/iavf/i40evf_ethtool.c b/drivers/net/ethernet/intel/iavf/i40evf_ethtool.c
index 8eb6686eebd0..0277df40e53f 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/i40evf_ethtool.c
@@ -277,7 +277,7 @@ static const struct iavf_priv_flags iavf_gstrings_priv_flags[] = {
  * kind of link we really have, so we fake it.
  **/
 static int iavf_get_link_ksettings(struct net_device *netdev,
-				     struct ethtool_link_ksettings *cmd)
+				   struct ethtool_link_ksettings *cmd)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
@@ -344,7 +344,7 @@ static int iavf_get_sset_count(struct net_device *netdev, int sset)
  * All statistics are added to the data buffer as an array of u64.
  **/
 static void iavf_get_ethtool_stats(struct net_device *netdev,
-				     struct ethtool_stats *stats, u64 *data)
+				   struct ethtool_stats *stats, u64 *data)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	unsigned int i;
@@ -561,7 +561,7 @@ static void iavf_set_msglevel(struct net_device *netdev, u32 data)
  * Returns information about the driver and device for display to the user.
  **/
 static void iavf_get_drvinfo(struct net_device *netdev,
-			       struct ethtool_drvinfo *drvinfo)
+			     struct ethtool_drvinfo *drvinfo)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
@@ -581,7 +581,7 @@ static void iavf_get_drvinfo(struct net_device *netdev,
  * but the number of rings is not reported.
  **/
 static void iavf_get_ringparam(struct net_device *netdev,
-				 struct ethtool_ringparam *ring)
+			       struct ethtool_ringparam *ring)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
@@ -600,7 +600,7 @@ static void iavf_get_ringparam(struct net_device *netdev,
  * number of rings is not specified, so all rings get the same settings.
  **/
 static int iavf_set_ringparam(struct net_device *netdev,
-				struct ethtool_ringparam *ring)
+			      struct ethtool_ringparam *ring)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 new_rx_count, new_tx_count;
@@ -645,8 +645,7 @@ static int iavf_set_ringparam(struct net_device *netdev,
  * representative value.
  **/
 static int __iavf_get_coalesce(struct net_device *netdev,
-				 struct ethtool_coalesce *ec,
-				 int queue)
+			       struct ethtool_coalesce *ec, int queue)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	struct i40e_vsi *vsi = &adapter->vsi;
@@ -689,7 +688,7 @@ static int __iavf_get_coalesce(struct net_device *netdev,
  * only represents the settings of queue 0.
  **/
 static int iavf_get_coalesce(struct net_device *netdev,
-			       struct ethtool_coalesce *ec)
+			     struct ethtool_coalesce *ec)
 {
 	return __iavf_get_coalesce(netdev, ec, -1);
 }
@@ -702,9 +701,8 @@ static int iavf_get_coalesce(struct net_device *netdev,
  *
  * Read specific queue's coalesce settings.
  **/
-static int iavf_get_per_queue_coalesce(struct net_device *netdev,
-					 u32 queue,
-					 struct ethtool_coalesce *ec)
+static int iavf_get_per_queue_coalesce(struct net_device *netdev, u32 queue,
+				       struct ethtool_coalesce *ec)
 {
 	return __iavf_get_coalesce(netdev, ec, queue);
 }
@@ -718,8 +716,7 @@ static int iavf_get_per_queue_coalesce(struct net_device *netdev,
  * Change the ITR settings for a specific queue.
  **/
 static void iavf_set_itr_per_queue(struct iavf_adapter *adapter,
-				     struct ethtool_coalesce *ec,
-				     int queue)
+				   struct ethtool_coalesce *ec, int queue)
 {
 	struct i40e_ring *rx_ring = &adapter->rx_rings[queue];
 	struct i40e_ring *tx_ring = &adapter->tx_rings[queue];
@@ -757,8 +754,7 @@ static void iavf_set_itr_per_queue(struct iavf_adapter *adapter,
  * Sets the coalesce settings for a particular queue.
  **/
 static int __iavf_set_coalesce(struct net_device *netdev,
-				 struct ethtool_coalesce *ec,
-				 int queue)
+			       struct ethtool_coalesce *ec, int queue)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	struct i40e_vsi *vsi = &adapter->vsi;
@@ -774,10 +770,7 @@ static int __iavf_set_coalesce(struct net_device *netdev,
 		   (ec->rx_coalesce_usecs > I40E_MAX_ITR)) {
 		netif_info(adapter, drv, netdev, "Invalid value, rx-usecs range is 0-8160\n");
 		return -EINVAL;
-	}
-
-	else
-	if (ec->tx_coalesce_usecs == 0) {
+	} else if (ec->tx_coalesce_usecs == 0) {
 		if (ec->use_adaptive_tx_coalesce)
 			netif_info(adapter, drv, netdev, "tx-usecs=0, need to disable adaptive-tx for a complete disable\n");
 	} else if ((ec->tx_coalesce_usecs < I40E_MIN_ITR) ||
@@ -811,7 +804,7 @@ static int __iavf_set_coalesce(struct net_device *netdev,
  * Change current coalescing settings for every queue.
  **/
 static int iavf_set_coalesce(struct net_device *netdev,
-			       struct ethtool_coalesce *ec)
+			     struct ethtool_coalesce *ec)
 {
 	return __iavf_set_coalesce(netdev, ec, -1);
 }
@@ -824,9 +817,8 @@ static int iavf_set_coalesce(struct net_device *netdev,
  *
  * Modifies a specific queue's coalesce settings.
  */
-static int iavf_set_per_queue_coalesce(struct net_device *netdev,
-					 u32 queue,
-					 struct ethtool_coalesce *ec)
+static int iavf_set_per_queue_coalesce(struct net_device *netdev, u32 queue,
+				       struct ethtool_coalesce *ec)
 {
 	return __iavf_set_coalesce(netdev, ec, queue);
 }
@@ -840,8 +832,7 @@ static int iavf_set_per_queue_coalesce(struct net_device *netdev,
  * Returns Success if the command is supported.
  **/
 static int iavf_get_rxnfc(struct net_device *netdev,
-			    struct ethtool_rxnfc *cmd,
-			    u32 *rule_locs)
+			  struct ethtool_rxnfc *cmd, u32 *rule_locs)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	int ret = -EOPNOTSUPP;
@@ -870,7 +861,7 @@ static int iavf_get_rxnfc(struct net_device *netdev,
  * queue pair. Report one extra channel to match our "other" MSI-X vector.
  **/
 static void iavf_get_channels(struct net_device *netdev,
-				struct ethtool_channels *ch)
+			      struct ethtool_channels *ch)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
@@ -893,7 +884,7 @@ static void iavf_get_channels(struct net_device *netdev,
  * negative on failure.
  **/
 static int iavf_set_channels(struct net_device *netdev,
-			       struct ethtool_channels *ch)
+			     struct ethtool_channels *ch)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	int num_req = ch->combined_count;
@@ -960,7 +951,7 @@ static u32 iavf_get_rxfh_indir_size(struct net_device *netdev)
  * Reads the indirection table directly from the hardware. Always returns 0.
  **/
 static int iavf_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
-			   u8 *hfunc)
+			 u8 *hfunc)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u16 i;
@@ -990,7 +981,7 @@ static int iavf_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
  * returns 0 after programming the table.
  **/
 static int iavf_set_rxfh(struct net_device *netdev, const u32 *indir,
-			   const u8 *key, const u8 hfunc)
+			 const u8 *key, const u8 hfunc)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u16 i;
@@ -1002,9 +993,8 @@ static int iavf_set_rxfh(struct net_device *netdev, const u32 *indir,
 	if (!indir)
 		return 0;
 
-	if (key) {
+	if (key)
 		memcpy(adapter->rss_key, key, adapter->rss_key_size);
-	}
 
 	/* Each 32 bits pointed by 'indir' is stored with a lut entry */
 	for (i = 0; i < adapter->rss_lut_size; i++)
diff --git a/drivers/net/ethernet/intel/iavf/i40evf_main.c b/drivers/net/ethernet/intel/iavf/i40evf_main.c
index f7b4d5aacee3..600ea4040af2 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/iavf/i40evf_main.c
@@ -66,7 +66,7 @@ static struct workqueue_struct *iavf_wq;
  * @size: size of memory requested
  * @alignment: what to align the allocation to
  **/
-i40e_status iavf_allocate_dma_mem_d(struct i40e_hw *hw,
+iavf_status iavf_allocate_dma_mem_d(struct i40e_hw *hw,
 				      struct i40e_dma_mem *mem,
 				      u64 size, u32 alignment)
 {
@@ -89,7 +89,7 @@ i40e_status iavf_allocate_dma_mem_d(struct i40e_hw *hw,
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to free
  **/
-i40e_status iavf_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
+iavf_status iavf_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
 {
 	struct iavf_adapter *adapter = (struct iavf_adapter *)hw->back;
 
@@ -106,7 +106,7 @@ i40e_status iavf_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
  * @mem:  ptr to mem struct to fill out
  * @size: size of memory requested
  **/
-i40e_status iavf_allocate_virt_mem_d(struct i40e_hw *hw,
+iavf_status iavf_allocate_virt_mem_d(struct i40e_hw *hw,
 				       struct i40e_virt_mem *mem, u32 size)
 {
 	if (!mem)
@@ -126,7 +126,7 @@ i40e_status iavf_allocate_virt_mem_d(struct i40e_hw *hw,
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to free
  **/
-i40e_status iavf_free_virt_mem_d(struct i40e_hw *hw,
+iavf_status iavf_free_virt_mem_d(struct i40e_hw *hw,
 				   struct i40e_virt_mem *mem)
 {
 	if (!mem)
@@ -469,6 +469,7 @@ iavf_request_traffic_irqs(struct iavf_adapter *adapter, char *basename)
 
 	for (vector = 0; vector < q_vectors; vector++) {
 		struct i40e_q_vector *q_vector = &adapter->q_vectors[vector];
+
 		irq_num = adapter->msix_entries[vector + NONQ_VECS].vector;
 
 		if (q_vector->tx.ring && q_vector->rx.ring) {
@@ -1427,6 +1428,7 @@ static void iavf_free_q_vectors(struct iavf_adapter *adapter)
 
 	for (q_idx = 0; q_idx < num_q_vectors; q_idx++) {
 		struct i40e_q_vector *q_vector = &adapter->q_vectors[q_idx];
+
 		if (q_idx < napi_vectors)
 			netif_napi_del(&q_vector->napi);
 	}
@@ -2049,7 +2051,7 @@ static void iavf_adminq_task(struct work_struct *work)
 	struct i40e_hw *hw = &adapter->hw;
 	struct i40e_arq_event_info event;
 	enum virtchnl_ops v_op;
-	i40e_status ret, v_ret;
+	iavf_status ret, v_ret;
 	u32 val, oldval;
 	u16 pending;
 
@@ -2064,7 +2066,7 @@ static void iavf_adminq_task(struct work_struct *work)
 	do {
 		ret = iavf_clean_arq_element(hw, &event, &pending);
 		v_op = (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);
-		v_ret = (i40e_status)le32_to_cpu(event.desc.cookie_low);
+		v_ret = (iavf_status)le32_to_cpu(event.desc.cookie_low);
 
 		if (ret || !v_op)
 			break; /* No event to process or error cleaning ARQ */
diff --git a/drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c
index 4dbba07fd383..6a2bc501658c 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c
@@ -18,11 +18,11 @@
  *
  * Send message to PF and print status if failure.
  **/
-static int iavf_send_pf_msg(struct iavf_adapter *adapter,
-			      enum virtchnl_ops op, u8 *msg, u16 len)
+static int iavf_send_pf_msg(struct iavf_adapter *adapter, enum virtchnl_ops op,
+			    u8 *msg, u16 len)
 {
 	struct i40e_hw *hw = &adapter->hw;
-	i40e_status err;
+	iavf_status err;
 
 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
 		return 0; /* nothing to see here, move along */
@@ -51,7 +51,7 @@ int iavf_send_api_ver(struct iavf_adapter *adapter)
 	vvi.minor = VIRTCHNL_VERSION_MINOR;
 
 	return iavf_send_pf_msg(adapter, VIRTCHNL_OP_VERSION, (u8 *)&vvi,
-				  sizeof(vvi));
+				sizeof(vvi));
 }
 
 /**
@@ -69,7 +69,7 @@ int iavf_verify_api_ver(struct iavf_adapter *adapter)
 	struct i40e_hw *hw = &adapter->hw;
 	struct i40e_arq_event_info event;
 	enum virtchnl_ops op;
-	i40e_status err;
+	iavf_status err;
 
 	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
 	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
@@ -92,7 +92,7 @@ int iavf_verify_api_ver(struct iavf_adapter *adapter)
 	}
 
 
-	err = (i40e_status)le32_to_cpu(event.desc.cookie_low);
+	err = (iavf_status)le32_to_cpu(event.desc.cookie_low);
 	if (err)
 		goto out_alloc;
 
@@ -144,13 +144,11 @@ int iavf_send_vf_config_msg(struct iavf_adapter *adapter)
 	adapter->current_op = VIRTCHNL_OP_GET_VF_RESOURCES;
 	adapter->aq_required &= ~IAVF_FLAG_AQ_GET_CONFIG;
 	if (PF_IS_V11(adapter))
-		return iavf_send_pf_msg(adapter,
-					  VIRTCHNL_OP_GET_VF_RESOURCES,
-					  (u8 *)&caps, sizeof(caps));
+		return iavf_send_pf_msg(adapter, VIRTCHNL_OP_GET_VF_RESOURCES,
+					(u8 *)&caps, sizeof(caps));
 	else
-		return iavf_send_pf_msg(adapter,
-					  VIRTCHNL_OP_GET_VF_RESOURCES,
-					  NULL, 0);
+		return iavf_send_pf_msg(adapter, VIRTCHNL_OP_GET_VF_RESOURCES,
+					NULL, 0);
 }
 
 /**
@@ -193,7 +191,7 @@ int iavf_get_vf_config(struct iavf_adapter *adapter)
 	struct i40e_hw *hw = &adapter->hw;
 	struct i40e_arq_event_info event;
 	enum virtchnl_ops op;
-	i40e_status err;
+	iavf_status err;
 	u16 len;
 
 	len =  sizeof(struct virtchnl_vf_resource) +
@@ -218,7 +216,7 @@ int iavf_get_vf_config(struct iavf_adapter *adapter)
 			break;
 	}
 
-	err = (i40e_status)le32_to_cpu(event.desc.cookie_low);
+	err = (iavf_status)le32_to_cpu(event.desc.cookie_low);
 	memcpy(adapter->vf_res, event.msg_buf, min(event.msg_len, len));
 
 	/* some PFs send more queues than we should have so validate that
@@ -287,8 +285,8 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 	}
 
 	adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_VSI_QUEUES,
-			   (u8 *)vqci, len);
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_VSI_QUEUES, (u8 *)vqci,
+			 len);
 	kfree(vqci);
 }
 
@@ -313,8 +311,8 @@ void iavf_enable_queues(struct iavf_adapter *adapter)
 	vqs.tx_queues = BIT(adapter->num_active_queues) - 1;
 	vqs.rx_queues = vqs.tx_queues;
 	adapter->aq_required &= ~IAVF_FLAG_AQ_ENABLE_QUEUES;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ENABLE_QUEUES,
-			   (u8 *)&vqs, sizeof(vqs));
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ENABLE_QUEUES, (u8 *)&vqs,
+			 sizeof(vqs));
 }
 
 /**
@@ -338,8 +336,8 @@ void iavf_disable_queues(struct iavf_adapter *adapter)
 	vqs.tx_queues = BIT(adapter->num_active_queues) - 1;
 	vqs.rx_queues = vqs.tx_queues;
 	adapter->aq_required &= ~IAVF_FLAG_AQ_DISABLE_QUEUES;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_QUEUES,
-			   (u8 *)&vqs, sizeof(vqs));
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_QUEUES, (u8 *)&vqs,
+			 sizeof(vqs));
 }
 
 /**
@@ -394,8 +392,7 @@ void iavf_map_queues(struct iavf_adapter *adapter)
 	vecmap->rxq_map = 0;
 
 	adapter->aq_required &= ~IAVF_FLAG_AQ_MAP_VECTORS;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_IRQ_MAP,
-			   (u8 *)vimi, len);
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_IRQ_MAP, (u8 *)vimi, len);
 	kfree(vimi);
 }
 
@@ -423,7 +420,7 @@ int iavf_request_queues(struct iavf_adapter *adapter, int num)
 	adapter->current_op = VIRTCHNL_OP_REQUEST_QUEUES;
 	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
 	return iavf_send_pf_msg(adapter, VIRTCHNL_OP_REQUEST_QUEUES,
-				  (u8 *)&vfres, sizeof(vfres));
+				(u8 *)&vfres, sizeof(vfres));
 }
 
 /**
@@ -493,8 +490,7 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR,
-			   (u8 *)veal, len);
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR, (u8 *)veal, len);
 	kfree(veal);
 }
 
@@ -565,8 +561,7 @@ void iavf_del_ether_addrs(struct iavf_adapter *adapter)
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DEL_ETH_ADDR,
-			   (u8 *)veal, len);
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DEL_ETH_ADDR, (u8 *)veal, len);
 	kfree(veal);
 }
 
@@ -756,7 +751,7 @@ void iavf_set_promiscuous(struct iavf_adapter *adapter, int flags)
 	vpi.vsi_id = adapter->vsi_res->vsi_id;
 	vpi.flags = flags;
 	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE,
-			   (u8 *)&vpi, sizeof(vpi));
+			 (u8 *)&vpi, sizeof(vpi));
 }
 
 /**
@@ -776,8 +771,8 @@ void iavf_request_stats(struct iavf_adapter *adapter)
 	adapter->current_op = VIRTCHNL_OP_GET_STATS;
 	vqs.vsi_id = adapter->vsi_res->vsi_id;
 	/* queue maps are ignored for this message - only the vsi is used */
-	if (iavf_send_pf_msg(adapter, VIRTCHNL_OP_GET_STATS,
-			       (u8 *)&vqs, sizeof(vqs)))
+	if (iavf_send_pf_msg(adapter, VIRTCHNL_OP_GET_STATS, (u8 *)&vqs,
+			     sizeof(vqs)))
 		/* if the request failed, don't lock out others */
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 }
@@ -798,8 +793,7 @@ void iavf_get_hena(struct iavf_adapter *adapter)
 	}
 	adapter->current_op = VIRTCHNL_OP_GET_RSS_HENA_CAPS;
 	adapter->aq_required &= ~IAVF_FLAG_AQ_GET_HENA;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_GET_RSS_HENA_CAPS,
-			   NULL, 0);
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_GET_RSS_HENA_CAPS, NULL, 0);
 }
 
 /**
@@ -821,8 +815,8 @@ void iavf_set_hena(struct iavf_adapter *adapter)
 	vrh.hena = adapter->hena;
 	adapter->current_op = VIRTCHNL_OP_SET_RSS_HENA;
 	adapter->aq_required &= ~IAVF_FLAG_AQ_SET_HENA;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_SET_RSS_HENA,
-			   (u8 *)&vrh, sizeof(vrh));
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_SET_RSS_HENA, (u8 *)&vrh,
+			 sizeof(vrh));
 }
 
 /**
@@ -853,8 +847,7 @@ void iavf_set_rss_key(struct iavf_adapter *adapter)
 
 	adapter->current_op = VIRTCHNL_OP_CONFIG_RSS_KEY;
 	adapter->aq_required &= ~IAVF_FLAG_AQ_SET_RSS_KEY;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_RSS_KEY,
-			   (u8 *)vrk, len);
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_RSS_KEY, (u8 *)vrk, len);
 	kfree(vrk);
 }
 
@@ -885,8 +878,7 @@ void iavf_set_rss_lut(struct iavf_adapter *adapter)
 	memcpy(vrl->lut, adapter->rss_lut, adapter->rss_lut_size);
 	adapter->current_op = VIRTCHNL_OP_CONFIG_RSS_LUT;
 	adapter->aq_required &= ~IAVF_FLAG_AQ_SET_RSS_LUT;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_RSS_LUT,
-			   (u8 *)vrl, len);
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_RSS_LUT, (u8 *)vrl, len);
 	kfree(vrl);
 }
 
@@ -906,8 +898,7 @@ void iavf_enable_vlan_stripping(struct iavf_adapter *adapter)
 	}
 	adapter->current_op = VIRTCHNL_OP_ENABLE_VLAN_STRIPPING;
 	adapter->aq_required &= ~IAVF_FLAG_AQ_ENABLE_VLAN_STRIPPING;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ENABLE_VLAN_STRIPPING,
-			   NULL, 0);
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ENABLE_VLAN_STRIPPING, NULL, 0);
 }
 
 /**
@@ -926,8 +917,7 @@ void iavf_disable_vlan_stripping(struct iavf_adapter *adapter)
 	}
 	adapter->current_op = VIRTCHNL_OP_DISABLE_VLAN_STRIPPING;
 	adapter->aq_required &= ~IAVF_FLAG_AQ_DISABLE_VLAN_STRIPPING;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_VLAN_STRIPPING,
-			   NULL, 0);
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_VLAN_STRIPPING, NULL, 0);
 }
 
 /**
@@ -1011,8 +1001,7 @@ void iavf_enable_channels(struct iavf_adapter *adapter)
 	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
 	adapter->current_op = VIRTCHNL_OP_ENABLE_CHANNELS;
 	adapter->aq_required &= ~IAVF_FLAG_AQ_ENABLE_CHANNELS;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ENABLE_CHANNELS,
-			   (u8 *)vti, len);
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ENABLE_CHANNELS, (u8 *)vti, len);
 	kfree(vti);
 }
 
@@ -1035,8 +1024,7 @@ void iavf_disable_channels(struct iavf_adapter *adapter)
 	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
 	adapter->current_op = VIRTCHNL_OP_DISABLE_CHANNELS;
 	adapter->aq_required &= ~IAVF_FLAG_AQ_DISABLE_CHANNELS;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_CHANNELS,
-			   NULL, 0);
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_CHANNELS, NULL, 0);
 }
 
 /**
@@ -1047,7 +1035,7 @@ void iavf_disable_channels(struct iavf_adapter *adapter)
  * Print the cloud filter
  **/
 static void iavf_print_cloud_filter(struct iavf_adapter *adapter,
-				      struct virtchnl_filter *f)
+				    struct virtchnl_filter *f)
 {
 	switch (f->flow_type) {
 	case VIRTCHNL_TCP_V4_FLOW:
@@ -1114,9 +1102,8 @@ void iavf_add_cloud_filter(struct iavf_adapter *adapter)
 			memcpy(f, &cf->f, sizeof(struct virtchnl_filter));
 			cf->add = false;
 			cf->state = __IAVF_CF_ADD_PENDING;
-			iavf_send_pf_msg(adapter,
-					   VIRTCHNL_OP_ADD_CLOUD_FILTER,
-					   (u8 *)f, len);
+			iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_CLOUD_FILTER,
+					 (u8 *)f, len);
 		}
 	}
 	kfree(f);
@@ -1163,9 +1150,8 @@ void iavf_del_cloud_filter(struct iavf_adapter *adapter)
 			memcpy(f, &cf->f, sizeof(struct virtchnl_filter));
 			cf->del = false;
 			cf->state = __IAVF_CF_DEL_PENDING;
-			iavf_send_pf_msg(adapter,
-					   VIRTCHNL_OP_DEL_CLOUD_FILTER,
-					   (u8 *)f, len);
+			iavf_send_pf_msg(adapter, VIRTCHNL_OP_DEL_CLOUD_FILTER,
+					 (u8 *)f, len);
 		}
 	}
 	kfree(f);
@@ -1197,9 +1183,8 @@ void iavf_request_reset(struct iavf_adapter *adapter)
  * This function handles the reply messages.
  **/
 void iavf_virtchnl_completion(struct iavf_adapter *adapter,
-				enum virtchnl_ops v_opcode,
-				i40e_status v_retval,
-				u8 *msg, u16 msglen)
+			      enum virtchnl_ops v_opcode, iavf_status v_retval,
+			      u8 *msg, u16 msglen)
 {
 	struct net_device *netdev = adapter->netdev;
 
@@ -1207,6 +1192,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		struct virtchnl_pf_event *vpe =
 			(struct virtchnl_pf_event *)msg;
 		bool link_up = vpe->event_data.link_event.link_status;
+
 		switch (vpe->event) {
 		case VIRTCHNL_EVENT_LINK_CHANGE:
 			adapter->link_speed =
@@ -1304,9 +1290,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 					cf->state = __IAVF_CF_INVALID;
 					dev_info(&adapter->pdev->dev, "Failed to add cloud filter, error %s\n",
 						 iavf_stat_str(&adapter->hw,
-								 v_retval));
-					iavf_print_cloud_filter(adapter,
-								  &cf->f);
+							       v_retval));
+					iavf_print_cloud_filter(adapter, &cf->f);
 					list_del(&cf->list);
 					kfree(cf);
 					adapter->num_cloud_filters--;
@@ -1323,17 +1308,15 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 					cf->state = __IAVF_CF_ACTIVE;
 					dev_info(&adapter->pdev->dev, "Failed to del cloud filter, error %s\n",
 						 iavf_stat_str(&adapter->hw,
-								 v_retval));
-					iavf_print_cloud_filter(adapter,
-								  &cf->f);
+							       v_retval));
+					iavf_print_cloud_filter(adapter, &cf->f);
 				}
 			}
 			}
 			break;
 		default:
 			dev_err(&adapter->pdev->dev, "PF returned error %d (%s) to our request %d\n",
-				v_retval,
-				iavf_stat_str(&adapter->hw, v_retval),
+				v_retval, iavf_stat_str(&adapter->hw, v_retval),
 				v_opcode);
 		}
 	}
@@ -1402,8 +1385,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		 * care about that.
 		 */
 		if (msglen && CLIENT_ENABLED(adapter))
-			iavf_notify_client_message(&adapter->vsi,
-						     msg, msglen);
+			iavf_notify_client_message(&adapter->vsi, msg, msglen);
 		break;
 
 	case VIRTCHNL_OP_CONFIG_IWARP_IRQ_MAP:
@@ -1412,6 +1394,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		break;
 	case VIRTCHNL_OP_GET_RSS_HENA_CAPS: {
 		struct virtchnl_rss_hena *vrh = (struct virtchnl_rss_hena *)msg;
+
 		if (msglen == sizeof(*vrh))
 			adapter->hena = vrh->hena;
 		else
-- 
2.14.4

