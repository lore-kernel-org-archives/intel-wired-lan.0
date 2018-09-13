From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 13 Sep 2018 15:31:33 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 03/14] iavf: rename
 functions and structs to new name
In-Reply-To: <20180913223144.75823-1-jesse.brandeburg@intel.com>
References: <20180913223144.75823-1-jesse.brandeburg@intel.com>
Message-ID: <20180913223144.75823-4-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This basically begins the rename of i40evf to iavf,
by renaming many of the functions, structs, variables and defines.

Most of the changes were made mechanically, which introduces some
alignment issues.

v3: make sure patch compiles

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/iavf/i40e_adminq.c     |   38 +-
 drivers/net/ethernet/intel/iavf/i40e_adminq.h     |    3 +-
 drivers/net/ethernet/intel/iavf/i40e_common.c     |   89 +-
 drivers/net/ethernet/intel/iavf/i40e_osdep.h      |   12 +-
 drivers/net/ethernet/intel/iavf/i40e_prototype.h  |   40 +-
 drivers/net/ethernet/intel/iavf/i40e_trace.h      |   26 +-
 drivers/net/ethernet/intel/iavf/i40e_txrx.c       |   94 +-
 drivers/net/ethernet/intel/iavf/i40e_txrx.h       |   36 +-
 drivers/net/ethernet/intel/iavf/i40evf.h          |  362 +++---
 drivers/net/ethernet/intel/iavf/i40evf_client.c   |  184 +--
 drivers/net/ethernet/intel/iavf/i40evf_client.h   |   30 +-
 drivers/net/ethernet/intel/iavf/i40evf_ethtool.c  |  364 +++---
 drivers/net/ethernet/intel/iavf/i40evf_main.c     | 1424 ++++++++++-----------
 drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c |  402 +++---
 14 files changed, 1550 insertions(+), 1554 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/i40e_adminq.c b/drivers/net/ethernet/intel/iavf/i40e_adminq.c
index 32e0e2d9cdc5..3d1c874f5f85 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/iavf/i40e_adminq.c
@@ -495,7 +495,7 @@ static i40e_status i40e_shutdown_arq(struct i40e_hw *hw)
 }
 
 /**
- *  i40evf_init_adminq - main initialization routine for Admin Queue
+ *  iavf_init_adminq - main initialization routine for Admin Queue
  *  @hw: pointer to the hardware structure
  *
  *  Prior to calling this function, drivers *MUST* set the following fields
@@ -505,7 +505,7 @@ static i40e_status i40e_shutdown_arq(struct i40e_hw *hw)
  *     - hw->aq.arq_buf_size
  *     - hw->aq.asq_buf_size
  **/
-i40e_status i40evf_init_adminq(struct i40e_hw *hw)
+i40e_status iavf_init_adminq(struct i40e_hw *hw)
 {
 	i40e_status ret_code;
 
@@ -546,15 +546,15 @@ i40e_status i40evf_init_adminq(struct i40e_hw *hw)
 }
 
 /**
- *  i40evf_shutdown_adminq - shutdown routine for the Admin Queue
+ *  iavf_shutdown_adminq - shutdown routine for the Admin Queue
  *  @hw: pointer to the hardware structure
  **/
-i40e_status i40evf_shutdown_adminq(struct i40e_hw *hw)
+i40e_status iavf_shutdown_adminq(struct i40e_hw *hw)
 {
 	i40e_status ret_code = 0;
 
-	if (i40evf_check_asq_alive(hw))
-		i40evf_aq_queue_shutdown(hw, true);
+	if (iavf_check_asq_alive(hw))
+		iavf_aq_queue_shutdown(hw, true);
 
 	i40e_shutdown_asq(hw);
 	i40e_shutdown_arq(hw);
@@ -604,13 +604,13 @@ static u16 i40e_clean_asq(struct i40e_hw *hw)
 }
 
 /**
- *  i40evf_asq_done - check if FW has processed the Admin Send Queue
+ *  iavf_asq_done - check if FW has processed the Admin Send Queue
  *  @hw: pointer to the hw struct
  *
  *  Returns true if the firmware has processed all descriptors on the
  *  admin send queue. Returns false if there are still requests pending.
  **/
-bool i40evf_asq_done(struct i40e_hw *hw)
+bool iavf_asq_done(struct i40e_hw *hw)
 {
 	/* AQ designers suggest use of head for better
 	 * timing reliability than DD bit
@@ -620,7 +620,7 @@ bool i40evf_asq_done(struct i40e_hw *hw)
 }
 
 /**
- *  i40evf_asq_send_command - send command to Admin Queue
+ *  iavf_asq_send_command - send command to Admin Queue
  *  @hw: pointer to the hw struct
  *  @desc: prefilled descriptor describing the command (non DMA mem)
  *  @buff: buffer to use for indirect commands
@@ -630,7 +630,7 @@ bool i40evf_asq_done(struct i40e_hw *hw)
  *  This is the main send command driver routine for the Admin Queue send
  *  queue.  It runs the queue, cleans the queue, etc
  **/
-i40e_status i40evf_asq_send_command(struct i40e_hw *hw,
+i40e_status iavf_asq_send_command(struct i40e_hw *hw,
 				struct i40e_aq_desc *desc,
 				void *buff, /* can be NULL */
 				u16  buff_size,
@@ -741,7 +741,7 @@ i40e_status i40evf_asq_send_command(struct i40e_hw *hw,
 
 	/* bump the tail */
 	i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE, "AQTX: desc and buffer:\n");
-	i40evf_debug_aq(hw, I40E_DEBUG_AQ_COMMAND, (void *)desc_on_ring,
+	iavf_debug_aq(hw, I40E_DEBUG_AQ_COMMAND, (void *)desc_on_ring,
 			buff, buff_size);
 	(hw->aq.asq.next_to_use)++;
 	if (hw->aq.asq.next_to_use == hw->aq.asq.count)
@@ -759,7 +759,7 @@ i40e_status i40evf_asq_send_command(struct i40e_hw *hw,
 			/* AQ designers suggest use of head for better
 			 * timing reliability than DD bit
 			 */
-			if (i40evf_asq_done(hw))
+			if (iavf_asq_done(hw))
 				break;
 			udelay(50);
 			total_delay += 50;
@@ -767,7 +767,7 @@ i40e_status i40evf_asq_send_command(struct i40e_hw *hw,
 	}
 
 	/* if ready, copy the desc back to temp */
-	if (i40evf_asq_done(hw)) {
+	if (iavf_asq_done(hw)) {
 		*desc = *desc_on_ring;
 		if (buff != NULL)
 			memcpy(buff, dma_buff->va, buff_size);
@@ -793,7 +793,7 @@ i40e_status i40evf_asq_send_command(struct i40e_hw *hw,
 
 	i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
 		   "AQTX: desc and buffer writeback:\n");
-	i40evf_debug_aq(hw, I40E_DEBUG_AQ_COMMAND, (void *)desc, buff,
+	iavf_debug_aq(hw, I40E_DEBUG_AQ_COMMAND, (void *)desc, buff,
 			buff_size);
 
 	/* save writeback aq if requested */
@@ -820,13 +820,13 @@ i40e_status i40evf_asq_send_command(struct i40e_hw *hw,
 }
 
 /**
- *  i40evf_fill_default_direct_cmd_desc - AQ descriptor helper function
+ *  iavf_fill_default_direct_cmd_desc - AQ descriptor helper function
  *  @desc:     pointer to the temp descriptor (non DMA mem)
  *  @opcode:   the opcode can be used to decide which flags to turn off or on
  *
  *  Fill the desc with default values
  **/
-void i40evf_fill_default_direct_cmd_desc(struct i40e_aq_desc *desc,
+void iavf_fill_default_direct_cmd_desc(struct i40e_aq_desc *desc,
 				       u16 opcode)
 {
 	/* zero out the desc */
@@ -836,7 +836,7 @@ void i40evf_fill_default_direct_cmd_desc(struct i40e_aq_desc *desc,
 }
 
 /**
- *  i40evf_clean_arq_element
+ *  iavf_clean_arq_element
  *  @hw: pointer to the hw struct
  *  @e: event info from the receive descriptor, includes any buffers
  *  @pending: number of events that could be left to process
@@ -845,7 +845,7 @@ void i40evf_fill_default_direct_cmd_desc(struct i40e_aq_desc *desc,
  *  the contents through e.  It can also return how many events are
  *  left to process through 'pending'
  **/
-i40e_status i40evf_clean_arq_element(struct i40e_hw *hw,
+i40e_status iavf_clean_arq_element(struct i40e_hw *hw,
 					     struct i40e_arq_event_info *e,
 					     u16 *pending)
 {
@@ -902,7 +902,7 @@ i40e_status i40evf_clean_arq_element(struct i40e_hw *hw,
 		       e->msg_len);
 
 	i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE, "AQRX: desc and buffer:\n");
-	i40evf_debug_aq(hw, I40E_DEBUG_AQ_COMMAND, (void *)desc, e->msg_buf,
+	iavf_debug_aq(hw, I40E_DEBUG_AQ_COMMAND, (void *)desc, e->msg_buf,
 			hw->aq.arq_buf_size);
 
 	/* Restore the original datalen and buffer address in the desc,
diff --git a/drivers/net/ethernet/intel/iavf/i40e_adminq.h b/drivers/net/ethernet/intel/iavf/i40e_adminq.h
index 1f264b9b6805..80b70a65028f 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/iavf/i40e_adminq.h
@@ -130,7 +130,6 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
 #define I40E_AQ_LARGE_BUF	512
 #define I40E_ASQ_CMD_TIMEOUT	250000  /* usecs */
 
-void i40evf_fill_default_direct_cmd_desc(struct i40e_aq_desc *desc,
-				       u16 opcode);
+void iavf_fill_default_direct_cmd_desc(struct i40e_aq_desc *desc, u16 opcode);
 
 #endif /* _I40E_ADMINQ_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/i40e_common.c b/drivers/net/ethernet/intel/iavf/i40e_common.c
index 6ebca11f039e..cc2e229ea976 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_common.c
+++ b/drivers/net/ethernet/intel/iavf/i40e_common.c
@@ -62,11 +62,11 @@ i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 }
 
 /**
- * i40evf_aq_str - convert AQ err code to a string
+ * iavf_aq_str - convert AQ err code to a string
  * @hw: pointer to the HW structure
  * @aq_err: the AQ error code to convert
  **/
-const char *i40evf_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err)
+const char *iavf_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err)
 {
 	switch (aq_err) {
 	case I40E_AQ_RC_OK:
@@ -122,11 +122,11 @@ const char *i40evf_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err)
 }
 
 /**
- * i40evf_stat_str - convert status err code to a string
+ * iavf_stat_str - convert status err code to a string
  * @hw: pointer to the HW structure
  * @stat_err: the status error code to convert
  **/
-const char *i40evf_stat_str(struct i40e_hw *hw, i40e_status stat_err)
+const char *iavf_stat_str(struct i40e_hw *hw, i40e_status stat_err)
 {
 	switch (stat_err) {
 	case 0:
@@ -270,7 +270,7 @@ const char *i40evf_stat_str(struct i40e_hw *hw, i40e_status stat_err)
 }
 
 /**
- * i40evf_debug_aq
+ * iavf_debug_aq
  * @hw: debug mask related to admin queue
  * @mask: debug mask
  * @desc: pointer to admin queue descriptor
@@ -279,7 +279,7 @@ const char *i40evf_stat_str(struct i40e_hw *hw, i40e_status stat_err)
  *
  * Dumps debug log about adminq command with descriptor contents.
  **/
-void i40evf_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask, void *desc,
+void iavf_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask, void *desc,
 		   void *buffer, u16 buf_len)
 {
 	struct i40e_aq_desc *aq_desc = (struct i40e_aq_desc *)desc;
@@ -315,7 +315,7 @@ void i40evf_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask, void *desc,
 			char prefix[27];
 
 			snprintf(prefix, sizeof(prefix),
-				 "i40evf %02x:%02x.%x: \t0x",
+				 "iavf %02x:%02x.%x: \t0x",
 				 hw->bus.bus_id,
 				 hw->bus.device,
 				 hw->bus.func);
@@ -327,12 +327,12 @@ void i40evf_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask, void *desc,
 }
 
 /**
- * i40evf_check_asq_alive
+ * iavf_check_asq_alive
  * @hw: pointer to the hw struct
  *
  * Returns true if Queue is enabled else false.
  **/
-bool i40evf_check_asq_alive(struct i40e_hw *hw)
+bool iavf_check_asq_alive(struct i40e_hw *hw)
 {
 	if (hw->aq.asq.len)
 		return !!(rd32(hw, hw->aq.asq.len) &
@@ -342,14 +342,14 @@ bool i40evf_check_asq_alive(struct i40e_hw *hw)
 }
 
 /**
- * i40evf_aq_queue_shutdown
+ * iavf_aq_queue_shutdown
  * @hw: pointer to the hw struct
  * @unloading: is the driver unloading itself
  *
  * Tell the Firmware that we're shutting down the AdminQ and whether
  * or not the driver is unloading as well.
  **/
-i40e_status i40evf_aq_queue_shutdown(struct i40e_hw *hw,
+i40e_status iavf_aq_queue_shutdown(struct i40e_hw *hw,
 					     bool unloading)
 {
 	struct i40e_aq_desc desc;
@@ -357,12 +357,12 @@ i40e_status i40evf_aq_queue_shutdown(struct i40e_hw *hw,
 		(struct i40e_aqc_queue_shutdown *)&desc.params.raw;
 	i40e_status status;
 
-	i40evf_fill_default_direct_cmd_desc(&desc,
+	iavf_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_queue_shutdown);
 
 	if (unloading)
 		cmd->driver_unloading = cpu_to_le32(I40E_AQ_DRIVER_UNLOADING);
-	status = i40evf_asq_send_command(hw, &desc, NULL, 0, NULL);
+	status = iavf_asq_send_command(hw, &desc, NULL, 0, NULL);
 
 	return status;
 }
@@ -389,10 +389,10 @@ static i40e_status i40e_aq_get_set_rss_lut(struct i40e_hw *hw,
 		   (struct i40e_aqc_get_set_rss_lut *)&desc.params.raw;
 
 	if (set)
-		i40evf_fill_default_direct_cmd_desc(&desc,
+		iavf_fill_default_direct_cmd_desc(&desc,
 						    i40e_aqc_opc_set_rss_lut);
 	else
-		i40evf_fill_default_direct_cmd_desc(&desc,
+		iavf_fill_default_direct_cmd_desc(&desc,
 						    i40e_aqc_opc_get_rss_lut);
 
 	/* Indirect command */
@@ -416,13 +416,13 @@ static i40e_status i40e_aq_get_set_rss_lut(struct i40e_hw *hw,
 					I40E_AQC_SET_RSS_LUT_TABLE_TYPE_SHIFT) &
 					I40E_AQC_SET_RSS_LUT_TABLE_TYPE_MASK));
 
-	status = i40evf_asq_send_command(hw, &desc, lut, lut_size, NULL);
+	status = iavf_asq_send_command(hw, &desc, lut, lut_size, NULL);
 
 	return status;
 }
 
 /**
- * i40evf_aq_get_rss_lut
+ * iavf_aq_get_rss_lut
  * @hw: pointer to the hardware structure
  * @vsi_id: vsi fw index
  * @pf_lut: for PF table set true, for VSI table set false
@@ -431,7 +431,7 @@ static i40e_status i40e_aq_get_set_rss_lut(struct i40e_hw *hw,
  *
  * get the RSS lookup table, PF or VSI type
  **/
-i40e_status i40evf_aq_get_rss_lut(struct i40e_hw *hw, u16 vsi_id,
+i40e_status iavf_aq_get_rss_lut(struct i40e_hw *hw, u16 vsi_id,
 				  bool pf_lut, u8 *lut, u16 lut_size)
 {
 	return i40e_aq_get_set_rss_lut(hw, vsi_id, pf_lut, lut, lut_size,
@@ -439,7 +439,7 @@ i40e_status i40evf_aq_get_rss_lut(struct i40e_hw *hw, u16 vsi_id,
 }
 
 /**
- * i40evf_aq_set_rss_lut
+ * iavf_aq_set_rss_lut
  * @hw: pointer to the hardware structure
  * @vsi_id: vsi fw index
  * @pf_lut: for PF table set true, for VSI table set false
@@ -448,7 +448,7 @@ i40e_status i40evf_aq_get_rss_lut(struct i40e_hw *hw, u16 vsi_id,
  *
  * set the RSS lookup table, PF or VSI type
  **/
-i40e_status i40evf_aq_set_rss_lut(struct i40e_hw *hw, u16 vsi_id,
+i40e_status iavf_aq_set_rss_lut(struct i40e_hw *hw, u16 vsi_id,
 				  bool pf_lut, u8 *lut, u16 lut_size)
 {
 	return i40e_aq_get_set_rss_lut(hw, vsi_id, pf_lut, lut, lut_size, true);
@@ -475,10 +475,10 @@ static i40e_status i40e_aq_get_set_rss_key(struct i40e_hw *hw,
 	u16 key_size = sizeof(struct i40e_aqc_get_set_rss_key_data);
 
 	if (set)
-		i40evf_fill_default_direct_cmd_desc(&desc,
+		iavf_fill_default_direct_cmd_desc(&desc,
 						    i40e_aqc_opc_set_rss_key);
 	else
-		i40evf_fill_default_direct_cmd_desc(&desc,
+		iavf_fill_default_direct_cmd_desc(&desc,
 						    i40e_aqc_opc_get_rss_key);
 
 	/* Indirect command */
@@ -491,19 +491,19 @@ static i40e_status i40e_aq_get_set_rss_key(struct i40e_hw *hw,
 					  I40E_AQC_SET_RSS_KEY_VSI_ID_MASK));
 	cmd_resp->vsi_id |= cpu_to_le16((u16)I40E_AQC_SET_RSS_KEY_VSI_VALID);
 
-	status = i40evf_asq_send_command(hw, &desc, key, key_size, NULL);
+	status = iavf_asq_send_command(hw, &desc, key, key_size, NULL);
 
 	return status;
 }
 
 /**
- * i40evf_aq_get_rss_key
+ * iavf_aq_get_rss_key
  * @hw: pointer to the hw struct
  * @vsi_id: vsi fw index
  * @key: pointer to key info struct
  *
  **/
-i40e_status i40evf_aq_get_rss_key(struct i40e_hw *hw,
+i40e_status iavf_aq_get_rss_key(struct i40e_hw *hw,
 				  u16 vsi_id,
 				  struct i40e_aqc_get_set_rss_key_data *key)
 {
@@ -511,14 +511,14 @@ i40e_status i40evf_aq_get_rss_key(struct i40e_hw *hw,
 }
 
 /**
- * i40evf_aq_set_rss_key
+ * iavf_aq_set_rss_key
  * @hw: pointer to the hw struct
  * @vsi_id: vsi fw index
  * @key: pointer to key info struct
  *
  * set the RSS key per VSI
  **/
-i40e_status i40evf_aq_set_rss_key(struct i40e_hw *hw,
+i40e_status iavf_aq_set_rss_key(struct i40e_hw *hw,
 				  u16 vsi_id,
 				  struct i40e_aqc_get_set_rss_key_data *key)
 {
@@ -526,7 +526,7 @@ i40e_status i40evf_aq_set_rss_key(struct i40e_hw *hw,
 }
 
 
-/* The i40evf_ptype_lookup table is used to convert from the 8-bit ptype in the
+/* The iavf_ptype_lookup table is used to convert from the 8-bit ptype in the
  * hardware to a bit-field that can be used by SW to more easily determine the
  * packet type.
  *
@@ -539,10 +539,10 @@ i40e_status i40evf_aq_set_rss_key(struct i40e_hw *hw,
  *
  * Typical work flow:
  *
- * IF NOT i40evf_ptype_lookup[ptype].known
+ * IF NOT iavf_ptype_lookup[ptype].known
  * THEN
  *      Packet is unknown
- * ELSE IF i40evf_ptype_lookup[ptype].outer_ip == I40E_RX_PTYPE_OUTER_IP
+ * ELSE IF iavf_ptype_lookup[ptype].outer_ip == I40E_RX_PTYPE_OUTER_IP
  *      Use the rest of the fields to look at the tunnels, inner protocols, etc
  * ELSE
  *      Use the enum i40e_rx_l2_ptype to decode the packet type
@@ -571,7 +571,7 @@ i40e_status i40evf_aq_set_rss_key(struct i40e_hw *hw,
 #define I40E_RX_PTYPE_INNER_PROT_TS	I40E_RX_PTYPE_INNER_PROT_TIMESYNC
 
 /* Lookup table mapping the HW PTYPE to the bit field for decoding */
-struct i40e_rx_ptype_decoded i40evf_ptype_lookup[] = {
+struct i40e_rx_ptype_decoded iavf_ptype_lookup[] = {
 	/* L2 Packet types */
 	I40E_PTT_UNUSED_ENTRY(0),
 	I40E_PTT(1,  L2, NONE, NOF, NONE, NONE, NOF, NONE, PAY2),
@@ -892,7 +892,7 @@ struct i40e_rx_ptype_decoded i40evf_ptype_lookup[] = {
 };
 
 /**
- * i40e_aq_send_msg_to_pf
+ * iavf_aq_send_msg_to_pf
  * @hw: pointer to the hardware structure
  * @v_opcode: opcodes for VF-PF communication
  * @v_retval: return error code
@@ -901,20 +901,19 @@ struct i40e_rx_ptype_decoded i40evf_ptype_lookup[] = {
  * @cmd_details: pointer to command details
  *
  * Send message to PF driver using admin queue. By default, this message
- * is sent asynchronously, i.e. i40evf_asq_send_command() does not wait for
+ * is sent asynchronously, i.e. iavf_asq_send_command() does not wait for
  * completion before returning.
  **/
-i40e_status i40e_aq_send_msg_to_pf(struct i40e_hw *hw,
-				enum virtchnl_ops v_opcode,
-				i40e_status v_retval,
-				u8 *msg, u16 msglen,
-				struct i40e_asq_cmd_details *cmd_details)
+i40e_status iavf_aq_send_msg_to_pf(struct i40e_hw *hw,
+				   enum virtchnl_ops v_opcode,
+				   i40e_status v_retval, u8 *msg, u16 msglen,
+				   struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_asq_cmd_details details;
 	i40e_status status;
 
-	i40evf_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_send_msg_to_pf);
+	iavf_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_send_msg_to_pf);
 	desc.flags |= cpu_to_le16((u16)I40E_AQ_FLAG_SI);
 	desc.cookie_high = cpu_to_le32(v_opcode);
 	desc.cookie_low = cpu_to_le32(v_retval);
@@ -930,19 +929,19 @@ i40e_status i40e_aq_send_msg_to_pf(struct i40e_hw *hw,
 		details.async = true;
 		cmd_details = &details;
 	}
-	status = i40evf_asq_send_command(hw, &desc, msg, msglen, cmd_details);
+	status = iavf_asq_send_command(hw, &desc, msg, msglen, cmd_details);
 	return status;
 }
 
 /**
- * i40e_vf_parse_hw_config
+ * iavf_vf_parse_hw_config
  * @hw: pointer to the hardware structure
  * @msg: pointer to the virtual channel VF resource structure
  *
  * Given a VF resource message from the PF, populate the hw struct
  * with appropriate information.
  **/
-void i40e_vf_parse_hw_config(struct i40e_hw *hw,
+void iavf_vf_parse_hw_config(struct i40e_hw *hw,
 			     struct virtchnl_vf_resource *msg)
 {
 	struct virtchnl_vsi_resource *vsi_res;
@@ -969,15 +968,15 @@ void i40e_vf_parse_hw_config(struct i40e_hw *hw,
 }
 
 /**
- * i40e_vf_reset
+ * iavf_vf_reset
  * @hw: pointer to the hardware structure
  *
  * Send a VF_RESET message to the PF. Does not wait for response from PF
  * as none will be forthcoming. Immediately after calling this function,
  * the admin queue should be shut down and (optionally) reinitialized.
  **/
-i40e_status i40e_vf_reset(struct i40e_hw *hw)
+i40e_status iavf_vf_reset(struct i40e_hw *hw)
 {
-	return i40e_aq_send_msg_to_pf(hw, VIRTCHNL_OP_RESET_VF,
+	return iavf_aq_send_msg_to_pf(hw, VIRTCHNL_OP_RESET_VF,
 				      0, NULL, 0, NULL);
 }
diff --git a/drivers/net/ethernet/intel/iavf/i40e_osdep.h b/drivers/net/ethernet/intel/iavf/i40e_osdep.h
index 3ddddb46455b..01e6babbdcd3 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/iavf/i40e_osdep.h
@@ -34,18 +34,18 @@ struct i40e_dma_mem {
 };
 
 #define i40e_allocate_dma_mem(h, m, unused, s, a) \
-	i40evf_allocate_dma_mem_d(h, m, s, a)
-#define i40e_free_dma_mem(h, m) i40evf_free_dma_mem_d(h, m)
+	iavf_allocate_dma_mem_d(h, m, s, a)
+#define i40e_free_dma_mem(h, m) iavf_free_dma_mem_d(h, m)
 
 struct i40e_virt_mem {
 	void *va;
 	u32 size;
 };
-#define i40e_allocate_virt_mem(h, m, s) i40evf_allocate_virt_mem_d(h, m, s)
-#define i40e_free_virt_mem(h, m) i40evf_free_virt_mem_d(h, m)
+#define i40e_allocate_virt_mem(h, m, s) iavf_allocate_virt_mem_d(h, m, s)
+#define i40e_free_virt_mem(h, m) iavf_free_virt_mem_d(h, m)
 
-#define i40e_debug(h, m, s, ...)  i40evf_debug_d(h, m, s, ##__VA_ARGS__)
-extern void i40evf_debug_d(void *hw, u32 mask, char *fmt_str, ...)
+#define i40e_debug(h, m, s, ...)  iavf_debug_d(h, m, s, ##__VA_ARGS__)
+extern void iavf_debug_d(void *hw, u32 mask, char *fmt_str, ...)
 	__attribute__ ((format(gnu_printf, 3, 4)));
 
 typedef enum i40e_status_code i40e_status;
diff --git a/drivers/net/ethernet/intel/iavf/i40e_prototype.h b/drivers/net/ethernet/intel/iavf/i40e_prototype.h
index ef7f74489bfc..ea38aaf4a511 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/iavf/i40e_prototype.h
@@ -16,55 +16,55 @@
  */
 
 /* adminq functions */
-i40e_status i40evf_init_adminq(struct i40e_hw *hw);
-i40e_status i40evf_shutdown_adminq(struct i40e_hw *hw);
+i40e_status iavf_init_adminq(struct i40e_hw *hw);
+i40e_status iavf_shutdown_adminq(struct i40e_hw *hw);
 void i40e_adminq_init_ring_data(struct i40e_hw *hw);
-i40e_status i40evf_clean_arq_element(struct i40e_hw *hw,
+i40e_status iavf_clean_arq_element(struct i40e_hw *hw,
 					     struct i40e_arq_event_info *e,
 					     u16 *events_pending);
-i40e_status i40evf_asq_send_command(struct i40e_hw *hw,
+i40e_status iavf_asq_send_command(struct i40e_hw *hw,
 				struct i40e_aq_desc *desc,
 				void *buff, /* can be NULL */
 				u16  buff_size,
 				struct i40e_asq_cmd_details *cmd_details);
-bool i40evf_asq_done(struct i40e_hw *hw);
+bool iavf_asq_done(struct i40e_hw *hw);
 
 /* debug function for adminq */
-void i40evf_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask,
+void iavf_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask,
 		     void *desc, void *buffer, u16 buf_len);
 
 void i40e_idle_aq(struct i40e_hw *hw);
-void i40evf_resume_aq(struct i40e_hw *hw);
-bool i40evf_check_asq_alive(struct i40e_hw *hw);
-i40e_status i40evf_aq_queue_shutdown(struct i40e_hw *hw, bool unloading);
-const char *i40evf_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err);
-const char *i40evf_stat_str(struct i40e_hw *hw, i40e_status stat_err);
+void iavf_resume_aq(struct i40e_hw *hw);
+bool iavf_check_asq_alive(struct i40e_hw *hw);
+i40e_status iavf_aq_queue_shutdown(struct i40e_hw *hw, bool unloading);
+const char *iavf_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err);
+const char *iavf_stat_str(struct i40e_hw *hw, i40e_status stat_err);
 
-i40e_status i40evf_aq_get_rss_lut(struct i40e_hw *hw, u16 seid,
+i40e_status iavf_aq_get_rss_lut(struct i40e_hw *hw, u16 seid,
 				  bool pf_lut, u8 *lut, u16 lut_size);
-i40e_status i40evf_aq_set_rss_lut(struct i40e_hw *hw, u16 seid,
+i40e_status iavf_aq_set_rss_lut(struct i40e_hw *hw, u16 seid,
 				  bool pf_lut, u8 *lut, u16 lut_size);
-i40e_status i40evf_aq_get_rss_key(struct i40e_hw *hw,
+i40e_status iavf_aq_get_rss_key(struct i40e_hw *hw,
 				  u16 seid,
 				  struct i40e_aqc_get_set_rss_key_data *key);
-i40e_status i40evf_aq_set_rss_key(struct i40e_hw *hw,
+i40e_status iavf_aq_set_rss_key(struct i40e_hw *hw,
 				  u16 seid,
 				  struct i40e_aqc_get_set_rss_key_data *key);
 
 i40e_status i40e_set_mac_type(struct i40e_hw *hw);
 
-extern struct i40e_rx_ptype_decoded i40evf_ptype_lookup[];
+extern struct i40e_rx_ptype_decoded iavf_ptype_lookup[];
 
 static inline struct i40e_rx_ptype_decoded decode_rx_desc_ptype(u8 ptype)
 {
-	return i40evf_ptype_lookup[ptype];
+	return iavf_ptype_lookup[ptype];
 }
 
 /* i40e_common for VF drivers*/
-void i40e_vf_parse_hw_config(struct i40e_hw *hw,
+void iavf_vf_parse_hw_config(struct i40e_hw *hw,
 			     struct virtchnl_vf_resource *msg);
-i40e_status i40e_vf_reset(struct i40e_hw *hw);
-i40e_status i40e_aq_send_msg_to_pf(struct i40e_hw *hw,
+i40e_status iavf_vf_reset(struct i40e_hw *hw);
+i40e_status iavf_aq_send_msg_to_pf(struct i40e_hw *hw,
 				   enum virtchnl_ops v_opcode,
 				   i40e_status v_retval, u8 *msg, u16 msglen,
 				   struct i40e_asq_cmd_details *cmd_details);
diff --git a/drivers/net/ethernet/intel/iavf/i40e_trace.h b/drivers/net/ethernet/intel/iavf/i40e_trace.h
index d7a4e68820a8..552cfbfcce71 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_trace.h
+++ b/drivers/net/ethernet/intel/iavf/i40e_trace.h
@@ -3,7 +3,7 @@
 
 /* Modeled on trace-events-sample.h */
 
-/* The trace subsystem name for i40evf will be "i40evf".
+/* The trace subsystem name for iavf will be "iavf".
  *
  * This file is named i40e_trace.h.
  *
@@ -12,7 +12,7 @@
  * of this file.
  */
 #undef TRACE_SYSTEM
-#define TRACE_SYSTEM i40evf
+#define TRACE_SYSTEM iavf
 
 /* See trace-events-sample.h for a detailed description of why this
  * guard clause is different from most normal include files.
@@ -42,7 +42,7 @@
  * Similarly, i40e_trace_enabled(trace_name) wraps references to
  * trace_i40e{,vf}_<trace_name>_enabled() functions.
  */
-#define _I40E_TRACE_NAME(trace_name) (trace_ ## i40evf ## _ ## trace_name)
+#define _I40E_TRACE_NAME(trace_name) (trace_ ## iavf ## _ ## trace_name)
 #define I40E_TRACE_NAME(trace_name) _I40E_TRACE_NAME(trace_name)
 
 #define i40e_trace(trace_name, args...) I40E_TRACE_NAME(trace_name)(args)
@@ -50,14 +50,14 @@
 #define i40e_trace_enabled(trace_name) I40E_TRACE_NAME(trace_name##_enabled)()
 
 /* Events common to PF and VF. Corresponding versions will be defined
- * for both, named trace_i40e_* and trace_i40evf_*. The i40e_trace()
+ * for both, named trace_i40e_* and trace_iavf_*. The i40e_trace()
  * macro above will select the right trace point name for the driver
  * being built from shared code.
  */
 
 /* Events related to a vsi & ring */
 DECLARE_EVENT_CLASS(
-	i40evf_tx_template,
+	iavf_tx_template,
 
 	TP_PROTO(struct i40e_ring *ring,
 		 struct i40e_tx_desc *desc,
@@ -93,7 +93,7 @@ DECLARE_EVENT_CLASS(
 );
 
 DEFINE_EVENT(
-	i40evf_tx_template, i40evf_clean_tx_irq,
+	iavf_tx_template, iavf_clean_tx_irq,
 	TP_PROTO(struct i40e_ring *ring,
 		 struct i40e_tx_desc *desc,
 		 struct i40e_tx_buffer *buf),
@@ -101,7 +101,7 @@ DEFINE_EVENT(
 	TP_ARGS(ring, desc, buf));
 
 DEFINE_EVENT(
-	i40evf_tx_template, i40evf_clean_tx_irq_unmap,
+	iavf_tx_template, iavf_clean_tx_irq_unmap,
 	TP_PROTO(struct i40e_ring *ring,
 		 struct i40e_tx_desc *desc,
 		 struct i40e_tx_buffer *buf),
@@ -109,7 +109,7 @@ DEFINE_EVENT(
 	TP_ARGS(ring, desc, buf));
 
 DECLARE_EVENT_CLASS(
-	i40evf_rx_template,
+	iavf_rx_template,
 
 	TP_PROTO(struct i40e_ring *ring,
 		 union i40e_32byte_rx_desc *desc,
@@ -138,7 +138,7 @@ DECLARE_EVENT_CLASS(
 );
 
 DEFINE_EVENT(
-	i40evf_rx_template, i40evf_clean_rx_irq,
+	iavf_rx_template, iavf_clean_rx_irq,
 	TP_PROTO(struct i40e_ring *ring,
 		 union i40e_32byte_rx_desc *desc,
 		 struct sk_buff *skb),
@@ -146,7 +146,7 @@ DEFINE_EVENT(
 	TP_ARGS(ring, desc, skb));
 
 DEFINE_EVENT(
-	i40evf_rx_template, i40evf_clean_rx_irq_rx,
+	iavf_rx_template, iavf_clean_rx_irq_rx,
 	TP_PROTO(struct i40e_ring *ring,
 		 union i40e_32byte_rx_desc *desc,
 		 struct sk_buff *skb),
@@ -154,7 +154,7 @@ DEFINE_EVENT(
 	TP_ARGS(ring, desc, skb));
 
 DECLARE_EVENT_CLASS(
-	i40evf_xmit_template,
+	iavf_xmit_template,
 
 	TP_PROTO(struct sk_buff *skb,
 		 struct i40e_ring *ring),
@@ -180,14 +180,14 @@ DECLARE_EVENT_CLASS(
 );
 
 DEFINE_EVENT(
-	i40evf_xmit_template, i40evf_xmit_frame_ring,
+	iavf_xmit_template, iavf_xmit_frame_ring,
 	TP_PROTO(struct sk_buff *skb,
 		 struct i40e_ring *ring),
 
 	TP_ARGS(skb, ring));
 
 DEFINE_EVENT(
-	i40evf_xmit_template, i40evf_xmit_frame_ring_drop,
+	iavf_xmit_template, iavf_xmit_frame_ring_drop,
 	TP_PROTO(struct sk_buff *skb,
 		 struct i40e_ring *ring),
 
diff --git a/drivers/net/ethernet/intel/iavf/i40e_txrx.c b/drivers/net/ethernet/intel/iavf/i40e_txrx.c
index a9730711e257..28892a6e730c 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/i40e_txrx.c
@@ -52,10 +52,10 @@ static void i40e_unmap_and_free_tx_resource(struct i40e_ring *ring,
 }
 
 /**
- * i40evf_clean_tx_ring - Free any empty Tx buffers
+ * iavf_clean_tx_ring - Free any empty Tx buffers
  * @tx_ring: ring to be cleaned
  **/
-void i40evf_clean_tx_ring(struct i40e_ring *tx_ring)
+void iavf_clean_tx_ring(struct i40e_ring *tx_ring)
 {
 	unsigned long bi_size;
 	u16 i;
@@ -85,14 +85,14 @@ void i40evf_clean_tx_ring(struct i40e_ring *tx_ring)
 }
 
 /**
- * i40evf_free_tx_resources - Free Tx resources per queue
+ * iavf_free_tx_resources - Free Tx resources per queue
  * @tx_ring: Tx descriptor ring for a specific queue
  *
  * Free all transmit software resources
  **/
-void i40evf_free_tx_resources(struct i40e_ring *tx_ring)
+void iavf_free_tx_resources(struct i40e_ring *tx_ring)
 {
-	i40evf_clean_tx_ring(tx_ring);
+	iavf_clean_tx_ring(tx_ring);
 	kfree(tx_ring->tx_bi);
 	tx_ring->tx_bi = NULL;
 
@@ -104,14 +104,14 @@ void i40evf_free_tx_resources(struct i40e_ring *tx_ring)
 }
 
 /**
- * i40evf_get_tx_pending - how many Tx descriptors not processed
+ * iavf_get_tx_pending - how many Tx descriptors not processed
  * @ring: the ring of descriptors
  * @in_sw: is tx_pending being checked in SW or HW
  *
  * Since there is no access to the ring head register
  * in XL710, we need to use our local copies
  **/
-u32 i40evf_get_tx_pending(struct i40e_ring *ring, bool in_sw)
+u32 iavf_get_tx_pending(struct i40e_ring *ring, bool in_sw)
 {
 	u32 head, tail;
 
@@ -126,13 +126,13 @@ u32 i40evf_get_tx_pending(struct i40e_ring *ring, bool in_sw)
 }
 
 /**
- * i40evf_detect_recover_hung - Function to detect and recover hung_queues
+ * iavf_detect_recover_hung - Function to detect and recover hung_queues
  * @vsi:  pointer to vsi struct with tx queues
  *
  * VSI has netdev and netdev has TX queues. This function is to check each of
  * those TX queues if they are hung, trigger recovery by issuing SW interrupt.
  **/
-void i40evf_detect_recover_hung(struct i40e_vsi *vsi)
+void iavf_detect_recover_hung(struct i40e_vsi *vsi)
 {
 	struct i40e_ring *tx_ring = NULL;
 	struct net_device *netdev;
@@ -164,16 +164,16 @@ void i40evf_detect_recover_hung(struct i40e_vsi *vsi)
 			 */
 			packets = tx_ring->stats.packets & INT_MAX;
 			if (tx_ring->tx_stats.prev_pkt_ctr == packets) {
-				i40evf_force_wb(vsi, tx_ring->q_vector);
+				iavf_force_wb(vsi, tx_ring->q_vector);
 				continue;
 			}
 
 			/* Memory barrier between read of packet count and call
-			 * to i40evf_get_tx_pending()
+			 * to iavf_get_tx_pending()
 			 */
 			smp_rmb();
 			tx_ring->tx_stats.prev_pkt_ctr =
-			  i40evf_get_tx_pending(tx_ring, true) ? packets : -1;
+			  iavf_get_tx_pending(tx_ring, true) ? packets : -1;
 		}
 	}
 }
@@ -292,7 +292,7 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 		 * them to be written back in case we stay in NAPI.
 		 * In this mode on X722 we do not enable Interrupt.
 		 */
-		unsigned int j = i40evf_get_tx_pending(tx_ring, false);
+		unsigned int j = iavf_get_tx_pending(tx_ring, false);
 
 		if (budget &&
 		    ((j / WB_STRIDE) == 0) && (j > 0) &&
@@ -325,7 +325,7 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 }
 
 /**
- * i40evf_enable_wb_on_itr - Arm hardware to do a wb, interrupts are not enabled
+ * iavf_enable_wb_on_itr - Arm hardware to do a wb, interrupts are not enabled
  * @vsi: the VSI we care about
  * @q_vector: the vector on which to enable writeback
  *
@@ -351,12 +351,12 @@ static void i40e_enable_wb_on_itr(struct i40e_vsi *vsi,
 }
 
 /**
- * i40evf_force_wb - Issue SW Interrupt so HW does a wb
+ * iavf_force_wb - Issue SW Interrupt so HW does a wb
  * @vsi: the VSI we care about
  * @q_vector: the vector  on which to force writeback
  *
  **/
-void i40evf_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector)
+void iavf_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector)
 {
 	u32 val = I40E_VFINT_DYN_CTLN1_INTENA_MASK |
 		  I40E_VFINT_DYN_CTLN1_ITR_INDX_MASK | /* set noitr */
@@ -607,12 +607,12 @@ static void i40e_update_itr(struct i40e_q_vector *q_vector,
 }
 
 /**
- * i40evf_setup_tx_descriptors - Allocate the Tx descriptors
+ * iavf_setup_tx_descriptors - Allocate the Tx descriptors
  * @tx_ring: the tx ring to set up
  *
  * Return 0 on success, negative on error
  **/
-int i40evf_setup_tx_descriptors(struct i40e_ring *tx_ring)
+int iavf_setup_tx_descriptors(struct i40e_ring *tx_ring)
 {
 	struct device *dev = tx_ring->dev;
 	int bi_size;
@@ -650,10 +650,10 @@ int i40evf_setup_tx_descriptors(struct i40e_ring *tx_ring)
 }
 
 /**
- * i40evf_clean_rx_ring - Free Rx buffers
+ * iavf_clean_rx_ring - Free Rx buffers
  * @rx_ring: ring to be cleaned
  **/
-void i40evf_clean_rx_ring(struct i40e_ring *rx_ring)
+void iavf_clean_rx_ring(struct i40e_ring *rx_ring)
 {
 	unsigned long bi_size;
 	u16 i;
@@ -707,14 +707,14 @@ void i40evf_clean_rx_ring(struct i40e_ring *rx_ring)
 }
 
 /**
- * i40evf_free_rx_resources - Free Rx resources
+ * iavf_free_rx_resources - Free Rx resources
  * @rx_ring: ring to clean the resources from
  *
  * Free all receive software resources
  **/
-void i40evf_free_rx_resources(struct i40e_ring *rx_ring)
+void iavf_free_rx_resources(struct i40e_ring *rx_ring)
 {
-	i40evf_clean_rx_ring(rx_ring);
+	iavf_clean_rx_ring(rx_ring);
 	kfree(rx_ring->rx_bi);
 	rx_ring->rx_bi = NULL;
 
@@ -726,12 +726,12 @@ void i40evf_free_rx_resources(struct i40e_ring *rx_ring)
 }
 
 /**
- * i40evf_setup_rx_descriptors - Allocate Rx descriptors
+ * iavf_setup_rx_descriptors - Allocate Rx descriptors
  * @rx_ring: Rx descriptor ring (for a specific queue) to setup
  *
  * Returns 0 on success, negative on failure
  **/
-int i40evf_setup_rx_descriptors(struct i40e_ring *rx_ring)
+int iavf_setup_rx_descriptors(struct i40e_ring *rx_ring)
 {
 	struct device *dev = rx_ring->dev;
 	int bi_size;
@@ -871,13 +871,13 @@ static void i40e_receive_skb(struct i40e_ring *rx_ring,
 }
 
 /**
- * i40evf_alloc_rx_buffers - Replace used receive buffers
+ * iavf_alloc_rx_buffers - Replace used receive buffers
  * @rx_ring: ring to place buffers on
  * @cleaned_count: number of buffers to replace
  *
  * Returns false if all allocations were successful, true if any fail
  **/
-bool i40evf_alloc_rx_buffers(struct i40e_ring *rx_ring, u16 cleaned_count)
+bool iavf_alloc_rx_buffers(struct i40e_ring *rx_ring, u16 cleaned_count)
 {
 	u16 ntu = rx_ring->next_to_use;
 	union i40e_rx_desc *rx_desc;
@@ -1069,7 +1069,7 @@ static inline void i40e_rx_hash(struct i40e_ring *ring,
 }
 
 /**
- * i40evf_process_skb_fields - Populate skb header fields from Rx descriptor
+ * iavf_process_skb_fields - Populate skb header fields from Rx descriptor
  * @rx_ring: rx descriptor ring packet is being transacted on
  * @rx_desc: pointer to the EOP Rx descriptor
  * @skb: pointer to current skb being populated
@@ -1080,7 +1080,7 @@ static inline void i40e_rx_hash(struct i40e_ring *ring,
  * other fields within the skb.
  **/
 static inline
-void i40evf_process_skb_fields(struct i40e_ring *rx_ring,
+void iavf_process_skb_fields(struct i40e_ring *rx_ring,
 			       union i40e_rx_desc *rx_desc, struct sk_buff *skb,
 			       u8 rx_ptype)
 {
@@ -1479,7 +1479,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		/* return some buffers to hardware, one at a time is too slow */
 		if (cleaned_count >= I40E_RX_BUFFER_WRITE) {
 			failure = failure ||
-				  i40evf_alloc_rx_buffers(rx_ring, cleaned_count);
+				  iavf_alloc_rx_buffers(rx_ring, cleaned_count);
 			cleaned_count = 0;
 		}
 
@@ -1551,7 +1551,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 			   I40E_RXD_QW1_PTYPE_SHIFT;
 
 		/* populate checksum, VLAN, and protocol */
-		i40evf_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
+		iavf_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
 
 
 		vlan_tag = (qword & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)) ?
@@ -1676,7 +1676,7 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 }
 
 /**
- * i40evf_napi_poll - NAPI polling Rx/Tx cleanup routine
+ * iavf_napi_poll - NAPI polling Rx/Tx cleanup routine
  * @napi: napi struct with our devices info in it
  * @budget: amount of work driver is allowed to do this pass, in packets
  *
@@ -1684,7 +1684,7 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
  *
  * Returns the amount of work done
  **/
-int i40evf_napi_poll(struct napi_struct *napi, int budget)
+int iavf_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct i40e_q_vector *q_vector =
 			       container_of(napi, struct i40e_q_vector, napi);
@@ -1746,7 +1746,7 @@ int i40evf_napi_poll(struct napi_struct *napi, int budget)
 			napi_complete_done(napi, work_done);
 
 			/* Force an interrupt */
-			i40evf_force_wb(vsi, q_vector);
+			iavf_force_wb(vsi, q_vector);
 
 			/* Return budget-1 so that polling stops */
 			return budget - 1;
@@ -1771,7 +1771,7 @@ int i40evf_napi_poll(struct napi_struct *napi, int budget)
 }
 
 /**
- * i40evf_tx_prepare_vlan_flags - prepare generic TX VLAN tagging flags for HW
+ * iavf_tx_prepare_vlan_flags - prepare generic TX VLAN tagging flags for HW
  * @skb:     send buffer
  * @tx_ring: ring to send buffer on
  * @flags:   the tx flags to be set
@@ -1782,7 +1782,7 @@ int i40evf_napi_poll(struct napi_struct *napi, int budget)
  * Returns error code indicate the frame should be dropped upon error and the
  * otherwise  returns 0 to indicate the flags has been set properly.
  **/
-static inline int i40evf_tx_prepare_vlan_flags(struct sk_buff *skb,
+static inline int iavf_tx_prepare_vlan_flags(struct sk_buff *skb,
 					       struct i40e_ring *tx_ring,
 					       u32 *flags)
 {
@@ -2130,7 +2130,7 @@ static void i40e_create_tx_ctx(struct i40e_ring *tx_ring,
 }
 
 /**
- * __i40evf_chk_linearize - Check if there are more than 8 buffers per packet
+ * __iavf_chk_linearize - Check if there are more than 8 buffers per packet
  * @skb:      send buffer
  *
  * Note: Our HW can't DMA more than 8 buffers to build a packet on the wire
@@ -2142,7 +2142,7 @@ static void i40e_create_tx_ctx(struct i40e_ring *tx_ring,
  * the segment payload in the first descriptor, and another 7 for the
  * fragments.
  **/
-bool __i40evf_chk_linearize(struct sk_buff *skb)
+bool __iavf_chk_linearize(struct sk_buff *skb)
 {
 	const struct skb_frag_struct *frag, *stale;
 	int nr_frags, sum;
@@ -2214,13 +2214,13 @@ bool __i40evf_chk_linearize(struct sk_buff *skb)
 }
 
 /**
- * __i40evf_maybe_stop_tx - 2nd level check for tx stop conditions
+ * __iavf_maybe_stop_tx - 2nd level check for tx stop conditions
  * @tx_ring: the ring to be checked
  * @size:    the size buffer we want to assure is available
  *
  * Returns -EBUSY if a stop is needed, else 0
  **/
-int __i40evf_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
+int __iavf_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
 {
 	netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
 	/* Memory barrier before checking head and tail */
@@ -2237,7 +2237,7 @@ int __i40evf_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
 }
 
 /**
- * i40evf_tx_map - Build the Tx descriptor
+ * iavf_tx_map - Build the Tx descriptor
  * @tx_ring:  ring to send buffer on
  * @skb:      send buffer
  * @first:    first buffer info buffer to use
@@ -2246,7 +2246,7 @@ int __i40evf_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
  * @td_cmd:   the command field in the descriptor
  * @td_offset: offset for checksum or crc
  **/
-static inline void i40evf_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
+static inline void iavf_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 				 struct i40e_tx_buffer *first, u32 tx_flags,
 				 const u8 hdr_len, u32 td_cmd, u32 td_offset)
 {
@@ -2437,7 +2437,7 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	first->gso_segs = 1;
 
 	/* prepare the xmit flags */
-	if (i40evf_tx_prepare_vlan_flags(skb, tx_ring, &tx_flags))
+	if (iavf_tx_prepare_vlan_flags(skb, tx_ring, &tx_flags))
 		goto out_drop;
 
 	/* obtain protocol of skb */
@@ -2470,7 +2470,7 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	i40e_create_tx_ctx(tx_ring, cd_type_cmd_tso_mss,
 			   cd_tunneling, cd_l2tag2);
 
-	i40evf_tx_map(tx_ring, skb, first, tx_flags, hdr_len,
+	iavf_tx_map(tx_ring, skb, first, tx_flags, hdr_len,
 		      td_cmd, td_offset);
 
 	return NETDEV_TX_OK;
@@ -2483,15 +2483,15 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 }
 
 /**
- * i40evf_xmit_frame - Selects the correct VSI and Tx queue to send buffer
+ * iavf_xmit_frame - Selects the correct VSI and Tx queue to send buffer
  * @skb:    send buffer
  * @netdev: network interface device structure
  *
  * Returns NETDEV_TX_OK if sent, else an error code
  **/
-netdev_tx_t i40evf_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
+netdev_tx_t iavf_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	struct i40e_ring *tx_ring = &adapter->tx_rings[skb->queue_mapping];
 
 	/* hardware can't handle really short frames, hardware padding works
diff --git a/drivers/net/ethernet/intel/iavf/i40e_txrx.h b/drivers/net/ethernet/intel/iavf/i40e_txrx.h
index 3b5a63b3236e..5dbb1cd52feb 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/i40e_txrx.h
@@ -380,12 +380,12 @@ struct i40e_ring {
 
 	struct rcu_head rcu;		/* to avoid race on free */
 	u16 next_to_alloc;
-	struct sk_buff *skb;		/* When i40evf_clean_rx_ring_irq() must
+	struct sk_buff *skb;		/* When iavf_clean_rx_ring_irq() must
 					 * return before it sees the EOP for
 					 * the current packet, we save that skb
 					 * here and resume receiving this
 					 * packet the next time
-					 * i40evf_clean_rx_ring_irq() is called
+					 * iavf_clean_rx_ring_irq() is called
 					 * for this ring.
 					 */
 } ____cacheline_internodealigned_in_smp;
@@ -437,20 +437,20 @@ static inline unsigned int i40e_rx_pg_order(struct i40e_ring *ring)
 
 #define i40e_rx_pg_size(_ring) (PAGE_SIZE << i40e_rx_pg_order(_ring))
 
-bool i40evf_alloc_rx_buffers(struct i40e_ring *rxr, u16 cleaned_count);
-netdev_tx_t i40evf_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
-void i40evf_clean_tx_ring(struct i40e_ring *tx_ring);
-void i40evf_clean_rx_ring(struct i40e_ring *rx_ring);
-int i40evf_setup_tx_descriptors(struct i40e_ring *tx_ring);
-int i40evf_setup_rx_descriptors(struct i40e_ring *rx_ring);
-void i40evf_free_tx_resources(struct i40e_ring *tx_ring);
-void i40evf_free_rx_resources(struct i40e_ring *rx_ring);
-int i40evf_napi_poll(struct napi_struct *napi, int budget);
-void i40evf_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector);
-u32 i40evf_get_tx_pending(struct i40e_ring *ring, bool in_sw);
-void i40evf_detect_recover_hung(struct i40e_vsi *vsi);
-int __i40evf_maybe_stop_tx(struct i40e_ring *tx_ring, int size);
-bool __i40evf_chk_linearize(struct sk_buff *skb);
+bool iavf_alloc_rx_buffers(struct i40e_ring *rxr, u16 cleaned_count);
+netdev_tx_t iavf_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
+void iavf_clean_tx_ring(struct i40e_ring *tx_ring);
+void iavf_clean_rx_ring(struct i40e_ring *rx_ring);
+int iavf_setup_tx_descriptors(struct i40e_ring *tx_ring);
+int iavf_setup_rx_descriptors(struct i40e_ring *rx_ring);
+void iavf_free_tx_resources(struct i40e_ring *tx_ring);
+void iavf_free_rx_resources(struct i40e_ring *rx_ring);
+int iavf_napi_poll(struct napi_struct *napi, int budget);
+void iavf_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector);
+u32 iavf_get_tx_pending(struct i40e_ring *ring, bool in_sw);
+void iavf_detect_recover_hung(struct i40e_vsi *vsi);
+int __iavf_maybe_stop_tx(struct i40e_ring *tx_ring, int size);
+bool __iavf_chk_linearize(struct sk_buff *skb);
 
 /**
  * i40e_xmit_descriptor_count - calculate number of Tx descriptors needed
@@ -490,7 +490,7 @@ static inline int i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
 {
 	if (likely(I40E_DESC_UNUSED(tx_ring) >= size))
 		return 0;
-	return __i40evf_maybe_stop_tx(tx_ring, size);
+	return __iavf_maybe_stop_tx(tx_ring, size);
 }
 
 /**
@@ -509,7 +509,7 @@ static inline bool i40e_chk_linearize(struct sk_buff *skb, int count)
 		return false;
 
 	if (skb_is_gso(skb))
-		return __i40evf_chk_linearize(skb);
+		return __iavf_chk_linearize(skb);
 
 	/* we can support up to 8 data buffers for a single send */
 	return count != I40E_MAX_BUFFER_TXD;
diff --git a/drivers/net/ethernet/intel/iavf/i40evf.h b/drivers/net/ethernet/intel/iavf/i40evf.h
index 96e537a35000..15a0910a7a79 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf.h
+++ b/drivers/net/ethernet/intel/iavf/i40evf.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#ifndef _I40EVF_H_
-#define _I40EVF_H_
+#ifndef _IAVF_H_
+#define _IAVF_H_
 
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -39,10 +39,10 @@
 #include "i40e_txrx.h"
 
 #define DEFAULT_DEBUG_LEVEL_SHIFT 3
-#define PFX "i40evf: "
+#define PFX "iavf: "
 
 /* VSI state flags shared with common code */
-enum i40evf_vsi_state_t {
+enum iavf_vsi_state_t {
 	__I40E_VSI_DOWN,
 	/* This must be last as it determines the size of the BITMAP */
 	__I40E_VSI_STATE_SIZE__,
@@ -50,7 +50,7 @@ enum i40evf_vsi_state_t {
 
 /* dummy struct to make common code less painful */
 struct i40e_vsi {
-	struct i40evf_adapter *back;
+	struct iavf_adapter *back;
 	struct net_device *netdev;
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	u16 seid;
@@ -63,17 +63,17 @@ struct i40e_vsi {
 };
 
 /* How many Rx Buffers do we bundle into one write to the hardware ? */
-#define I40EVF_RX_BUFFER_WRITE	16	/* Must be power of 2 */
-#define I40EVF_DEFAULT_TXD	512
-#define I40EVF_DEFAULT_RXD	512
-#define I40EVF_MAX_TXD		4096
-#define I40EVF_MIN_TXD		64
-#define I40EVF_MAX_RXD		4096
-#define I40EVF_MIN_RXD		64
-#define I40EVF_REQ_DESCRIPTOR_MULTIPLE	32
-#define I40EVF_MAX_AQ_BUF_SIZE	4096
-#define I40EVF_AQ_LEN		32
-#define I40EVF_AQ_MAX_ERR	20 /* times to try before resetting AQ */
+#define IAVF_RX_BUFFER_WRITE	16	/* Must be power of 2 */
+#define IAVF_DEFAULT_TXD	512
+#define IAVF_DEFAULT_RXD	512
+#define IAVF_MAX_TXD		4096
+#define IAVF_MIN_TXD		64
+#define IAVF_MAX_RXD		4096
+#define IAVF_MIN_RXD		64
+#define IAVF_REQ_DESCRIPTOR_MULTIPLE	32
+#define IAVF_MAX_AQ_BUF_SIZE	4096
+#define IAVF_AQ_LEN		32
+#define IAVF_AQ_MAX_ERR	20 /* times to try before resetting AQ */
 
 #define MAXIMUM_ETHERNET_VLAN_SIZE (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)
 
@@ -81,17 +81,17 @@ struct i40e_vsi {
 #define I40E_TX_DESC(R, i) (&(((struct i40e_tx_desc *)((R)->desc))[i]))
 #define I40E_TX_CTXTDESC(R, i) \
 	(&(((struct i40e_tx_context_desc *)((R)->desc))[i]))
-#define I40EVF_MAX_REQ_QUEUES 4
+#define IAVF_MAX_REQ_QUEUES 4
 
-#define I40EVF_HKEY_ARRAY_SIZE ((I40E_VFQF_HKEY_MAX_INDEX + 1) * 4)
-#define I40EVF_HLUT_ARRAY_SIZE ((I40E_VFQF_HLUT_MAX_INDEX + 1) * 4)
-#define I40EVF_MBPS_DIVISOR	125000 /* divisor to convert to Mbps */
+#define IAVF_HKEY_ARRAY_SIZE ((I40E_VFQF_HKEY_MAX_INDEX + 1) * 4)
+#define IAVF_HLUT_ARRAY_SIZE ((I40E_VFQF_HLUT_MAX_INDEX + 1) * 4)
+#define IAVF_MBPS_DIVISOR	125000 /* divisor to convert to Mbps */
 
 /* MAX_MSIX_Q_VECTORS of these are allocated,
  * but we only use one per queue-specific vector.
  */
 struct i40e_q_vector {
-	struct i40evf_adapter *adapter;
+	struct iavf_adapter *adapter;
 	struct i40e_vsi *vsi;
 	struct napi_struct napi;
 	struct i40e_ring_container rx;
@@ -115,15 +115,15 @@ struct i40e_q_vector {
 	((_eitr) ? (1000000000 / ((_eitr) * 256)) : 8)
 #define EITR_REG_TO_INTS_PER_SEC EITR_INTS_PER_SEC_TO_REG
 
-#define I40EVF_DESC_UNUSED(R) \
+#define IAVF_DESC_UNUSED(R) \
 	((((R)->next_to_clean > (R)->next_to_use) ? 0 : (R)->count) + \
 	(R)->next_to_clean - (R)->next_to_use - 1)
 
-#define I40EVF_RX_DESC_ADV(R, i)	\
+#define IAVF_RX_DESC_ADV(R, i)	\
 	(&(((union i40e_adv_rx_desc *)((R).desc))[i]))
-#define I40EVF_TX_DESC_ADV(R, i)	\
+#define IAVF_TX_DESC_ADV(R, i)	\
 	(&(((union i40e_adv_tx_desc *)((R).desc))[i]))
-#define I40EVF_TX_CTXTDESC_ADV(R, i)	\
+#define IAVF_TX_CTXTDESC_ADV(R, i)	\
 	(&(((struct i40e_adv_tx_context_desc *)((R).desc))[i]))
 
 #define OTHER_VECTOR 1
@@ -132,88 +132,88 @@ struct i40e_q_vector {
 #define MIN_MSIX_Q_VECTORS 1
 #define MIN_MSIX_COUNT (MIN_MSIX_Q_VECTORS + NONQ_VECS)
 
-#define I40EVF_QUEUE_END_OF_LIST 0x7FF
-#define I40EVF_FREE_VECTOR 0x7FFF
-struct i40evf_mac_filter {
+#define IAVF_QUEUE_END_OF_LIST 0x7FF
+#define IAVF_FREE_VECTOR 0x7FFF
+struct iavf_mac_filter {
 	struct list_head list;
 	u8 macaddr[ETH_ALEN];
 	bool remove;		/* filter needs to be removed */
 	bool add;		/* filter needs to be added */
 };
 
-struct i40evf_vlan_filter {
+struct iavf_vlan_filter {
 	struct list_head list;
 	u16 vlan;
 	bool remove;		/* filter needs to be removed */
 	bool add;		/* filter needs to be added */
 };
 
-#define I40EVF_MAX_TRAFFIC_CLASS	4
+#define IAVF_MAX_TRAFFIC_CLASS	4
 /* State of traffic class creation */
-enum i40evf_tc_state_t {
-	__I40EVF_TC_INVALID, /* no traffic class, default state */
-	__I40EVF_TC_RUNNING, /* traffic classes have been created */
+enum iavf_tc_state_t {
+	__IAVF_TC_INVALID, /* no traffic class, default state */
+	__IAVF_TC_RUNNING, /* traffic classes have been created */
 };
 
 /* channel info */
-struct i40evf_channel_config {
-	struct virtchnl_channel_info ch_info[I40EVF_MAX_TRAFFIC_CLASS];
-	enum i40evf_tc_state_t state;
+struct iavf_channel_config {
+	struct virtchnl_channel_info ch_info[IAVF_MAX_TRAFFIC_CLASS];
+	enum iavf_tc_state_t state;
 	u8 total_qps;
 };
 
 /* State of cloud filter */
-enum i40evf_cloud_filter_state_t {
-	__I40EVF_CF_INVALID,	 /* cloud filter not added */
-	__I40EVF_CF_ADD_PENDING, /* cloud filter pending add by the PF */
-	__I40EVF_CF_DEL_PENDING, /* cloud filter pending del by the PF */
-	__I40EVF_CF_ACTIVE,	 /* cloud filter is active */
+enum iavf_cloud_filter_state_t {
+	__IAVF_CF_INVALID,	 /* cloud filter not added */
+	__IAVF_CF_ADD_PENDING, /* cloud filter pending add by the PF */
+	__IAVF_CF_DEL_PENDING, /* cloud filter pending del by the PF */
+	__IAVF_CF_ACTIVE,	 /* cloud filter is active */
 };
 
 /* Driver state. The order of these is important! */
-enum i40evf_state_t {
-	__I40EVF_STARTUP,		/* driver loaded, probe complete */
-	__I40EVF_REMOVE,		/* driver is being unloaded */
-	__I40EVF_INIT_VERSION_CHECK,	/* aq msg sent, awaiting reply */
-	__I40EVF_INIT_GET_RESOURCES,	/* aq msg sent, awaiting reply */
-	__I40EVF_INIT_SW,		/* got resources, setting up structs */
-	__I40EVF_RESETTING,		/* in reset */
+enum iavf_state_t {
+	__IAVF_STARTUP,		/* driver loaded, probe complete */
+	__IAVF_REMOVE,		/* driver is being unloaded */
+	__IAVF_INIT_VERSION_CHECK,	/* aq msg sent, awaiting reply */
+	__IAVF_INIT_GET_RESOURCES,	/* aq msg sent, awaiting reply */
+	__IAVF_INIT_SW,		/* got resources, setting up structs */
+	__IAVF_RESETTING,		/* in reset */
 	/* Below here, watchdog is running */
-	__I40EVF_DOWN,			/* ready, can be opened */
-	__I40EVF_DOWN_PENDING,		/* descending, waiting for watchdog */
-	__I40EVF_TESTING,		/* in ethtool self-test */
-	__I40EVF_RUNNING,		/* opened, working */
+	__IAVF_DOWN,			/* ready, can be opened */
+	__IAVF_DOWN_PENDING,		/* descending, waiting for watchdog */
+	__IAVF_TESTING,		/* in ethtool self-test */
+	__IAVF_RUNNING,		/* opened, working */
 };
 
-enum i40evf_critical_section_t {
-	__I40EVF_IN_CRITICAL_TASK,	/* cannot be interrupted */
-	__I40EVF_IN_CLIENT_TASK,
-	__I40EVF_IN_REMOVE_TASK,	/* device being removed */
+enum iavf_critical_section_t {
+	__IAVF_IN_CRITICAL_TASK,	/* cannot be interrupted */
+	__IAVF_IN_CLIENT_TASK,
+	__IAVF_IN_REMOVE_TASK,	/* device being removed */
 };
 
-#define I40EVF_CLOUD_FIELD_OMAC		0x01
-#define I40EVF_CLOUD_FIELD_IMAC		0x02
-#define I40EVF_CLOUD_FIELD_IVLAN	0x04
-#define I40EVF_CLOUD_FIELD_TEN_ID	0x08
-#define I40EVF_CLOUD_FIELD_IIP		0x10
-
-#define I40EVF_CF_FLAGS_OMAC	I40EVF_CLOUD_FIELD_OMAC
-#define I40EVF_CF_FLAGS_IMAC	I40EVF_CLOUD_FIELD_IMAC
-#define I40EVF_CF_FLAGS_IMAC_IVLAN	(I40EVF_CLOUD_FIELD_IMAC |\
-					 I40EVF_CLOUD_FIELD_IVLAN)
-#define I40EVF_CF_FLAGS_IMAC_TEN_ID	(I40EVF_CLOUD_FIELD_IMAC |\
-					 I40EVF_CLOUD_FIELD_TEN_ID)
-#define I40EVF_CF_FLAGS_OMAC_TEN_ID_IMAC	(I40EVF_CLOUD_FIELD_OMAC |\
-						 I40EVF_CLOUD_FIELD_IMAC |\
-						 I40EVF_CLOUD_FIELD_TEN_ID)
-#define I40EVF_CF_FLAGS_IMAC_IVLAN_TEN_ID	(I40EVF_CLOUD_FIELD_IMAC |\
-						 I40EVF_CLOUD_FIELD_IVLAN |\
-						 I40EVF_CLOUD_FIELD_TEN_ID)
-#define I40EVF_CF_FLAGS_IIP	I40E_CLOUD_FIELD_IIP
+#define IAVF_CLOUD_FIELD_OMAC		0x01
+#define IAVF_CLOUD_FIELD_IMAC		0x02
+#define IAVF_CLOUD_FIELD_IVLAN	0x04
+#define IAVF_CLOUD_FIELD_TEN_ID	0x08
+#define IAVF_CLOUD_FIELD_IIP		0x10
+
+#define IAVF_CF_FLAGS_OMAC	IAVF_CLOUD_FIELD_OMAC
+#define IAVF_CF_FLAGS_IMAC	IAVF_CLOUD_FIELD_IMAC
+#define IAVF_CF_FLAGS_IMAC_IVLAN	(IAVF_CLOUD_FIELD_IMAC |\
+					 IAVF_CLOUD_FIELD_IVLAN)
+#define IAVF_CF_FLAGS_IMAC_TEN_ID	(IAVF_CLOUD_FIELD_IMAC |\
+					 IAVF_CLOUD_FIELD_TEN_ID)
+#define IAVF_CF_FLAGS_OMAC_TEN_ID_IMAC	(IAVF_CLOUD_FIELD_OMAC |\
+						 IAVF_CLOUD_FIELD_IMAC |\
+						 IAVF_CLOUD_FIELD_TEN_ID)
+#define IAVF_CF_FLAGS_IMAC_IVLAN_TEN_ID	(IAVF_CLOUD_FIELD_IMAC |\
+						 IAVF_CLOUD_FIELD_IVLAN |\
+						 IAVF_CLOUD_FIELD_TEN_ID)
+#define IAVF_CF_FLAGS_IIP	I40E_CLOUD_FIELD_IIP
 
 /* bookkeeping of cloud filters */
-struct i40evf_cloud_filter {
-	enum i40evf_cloud_filter_state_t state;
+struct iavf_cloud_filter {
+	enum iavf_cloud_filter_state_t state;
 	struct list_head list;
 	struct virtchnl_filter f;
 	unsigned long cookie;
@@ -222,7 +222,7 @@ struct i40evf_cloud_filter {
 };
 
 /* board specific private data structure */
-struct i40evf_adapter {
+struct iavf_adapter {
 	struct timer_list watchdog_timer;
 	struct work_struct reset_task;
 	struct work_struct adminq_task;
@@ -255,53 +255,53 @@ struct i40evf_adapter {
 	struct msix_entry *msix_entries;
 
 	u32 flags;
-#define I40EVF_FLAG_RX_CSUM_ENABLED		BIT(0)
-#define I40EVF_FLAG_PF_COMMS_FAILED		BIT(3)
-#define I40EVF_FLAG_RESET_PENDING		BIT(4)
-#define I40EVF_FLAG_RESET_NEEDED		BIT(5)
-#define I40EVF_FLAG_WB_ON_ITR_CAPABLE		BIT(6)
-#define I40EVF_FLAG_ADDR_SET_BY_PF		BIT(8)
-#define I40EVF_FLAG_SERVICE_CLIENT_REQUESTED	BIT(9)
-#define I40EVF_FLAG_CLIENT_NEEDS_OPEN		BIT(10)
-#define I40EVF_FLAG_CLIENT_NEEDS_CLOSE		BIT(11)
-#define I40EVF_FLAG_CLIENT_NEEDS_L2_PARAMS	BIT(12)
-#define I40EVF_FLAG_PROMISC_ON			BIT(13)
-#define I40EVF_FLAG_ALLMULTI_ON			BIT(14)
-#define I40EVF_FLAG_LEGACY_RX			BIT(15)
-#define I40EVF_FLAG_REINIT_ITR_NEEDED		BIT(16)
-#define I40EVF_FLAG_QUEUES_DISABLED		BIT(17)
+#define IAVF_FLAG_RX_CSUM_ENABLED		BIT(0)
+#define IAVF_FLAG_PF_COMMS_FAILED		BIT(3)
+#define IAVF_FLAG_RESET_PENDING		BIT(4)
+#define IAVF_FLAG_RESET_NEEDED		BIT(5)
+#define IAVF_FLAG_WB_ON_ITR_CAPABLE		BIT(6)
+#define IAVF_FLAG_ADDR_SET_BY_PF		BIT(8)
+#define IAVF_FLAG_SERVICE_CLIENT_REQUESTED	BIT(9)
+#define IAVF_FLAG_CLIENT_NEEDS_OPEN		BIT(10)
+#define IAVF_FLAG_CLIENT_NEEDS_CLOSE		BIT(11)
+#define IAVF_FLAG_CLIENT_NEEDS_L2_PARAMS	BIT(12)
+#define IAVF_FLAG_PROMISC_ON			BIT(13)
+#define IAVF_FLAG_ALLMULTI_ON			BIT(14)
+#define IAVF_FLAG_LEGACY_RX			BIT(15)
+#define IAVF_FLAG_REINIT_ITR_NEEDED		BIT(16)
+#define IAVF_FLAG_QUEUES_DISABLED		BIT(17)
 /* duplicates for common code */
 #define I40E_FLAG_DCB_ENABLED			0
-#define I40E_FLAG_RX_CSUM_ENABLED		I40EVF_FLAG_RX_CSUM_ENABLED
-#define I40E_FLAG_LEGACY_RX			I40EVF_FLAG_LEGACY_RX
+#define I40E_FLAG_RX_CSUM_ENABLED		IAVF_FLAG_RX_CSUM_ENABLED
+#define I40E_FLAG_LEGACY_RX			IAVF_FLAG_LEGACY_RX
 	/* flags for admin queue service task */
 	u32 aq_required;
-#define I40EVF_FLAG_AQ_ENABLE_QUEUES		BIT(0)
-#define I40EVF_FLAG_AQ_DISABLE_QUEUES		BIT(1)
-#define I40EVF_FLAG_AQ_ADD_MAC_FILTER		BIT(2)
-#define I40EVF_FLAG_AQ_ADD_VLAN_FILTER		BIT(3)
-#define I40EVF_FLAG_AQ_DEL_MAC_FILTER		BIT(4)
-#define I40EVF_FLAG_AQ_DEL_VLAN_FILTER		BIT(5)
-#define I40EVF_FLAG_AQ_CONFIGURE_QUEUES		BIT(6)
-#define I40EVF_FLAG_AQ_MAP_VECTORS		BIT(7)
-#define I40EVF_FLAG_AQ_HANDLE_RESET		BIT(8)
-#define I40EVF_FLAG_AQ_CONFIGURE_RSS		BIT(9) /* direct AQ config */
-#define I40EVF_FLAG_AQ_GET_CONFIG		BIT(10)
+#define IAVF_FLAG_AQ_ENABLE_QUEUES		BIT(0)
+#define IAVF_FLAG_AQ_DISABLE_QUEUES		BIT(1)
+#define IAVF_FLAG_AQ_ADD_MAC_FILTER		BIT(2)
+#define IAVF_FLAG_AQ_ADD_VLAN_FILTER		BIT(3)
+#define IAVF_FLAG_AQ_DEL_MAC_FILTER		BIT(4)
+#define IAVF_FLAG_AQ_DEL_VLAN_FILTER		BIT(5)
+#define IAVF_FLAG_AQ_CONFIGURE_QUEUES		BIT(6)
+#define IAVF_FLAG_AQ_MAP_VECTORS		BIT(7)
+#define IAVF_FLAG_AQ_HANDLE_RESET		BIT(8)
+#define IAVF_FLAG_AQ_CONFIGURE_RSS		BIT(9) /* direct AQ config */
+#define IAVF_FLAG_AQ_GET_CONFIG		BIT(10)
 /* Newer style, RSS done by the PF so we can ignore hardware vagaries. */
-#define I40EVF_FLAG_AQ_GET_HENA			BIT(11)
-#define I40EVF_FLAG_AQ_SET_HENA			BIT(12)
-#define I40EVF_FLAG_AQ_SET_RSS_KEY		BIT(13)
-#define I40EVF_FLAG_AQ_SET_RSS_LUT		BIT(14)
-#define I40EVF_FLAG_AQ_REQUEST_PROMISC		BIT(15)
-#define I40EVF_FLAG_AQ_RELEASE_PROMISC		BIT(16)
-#define I40EVF_FLAG_AQ_REQUEST_ALLMULTI		BIT(17)
-#define I40EVF_FLAG_AQ_RELEASE_ALLMULTI		BIT(18)
-#define I40EVF_FLAG_AQ_ENABLE_VLAN_STRIPPING	BIT(19)
-#define I40EVF_FLAG_AQ_DISABLE_VLAN_STRIPPING	BIT(20)
-#define I40EVF_FLAG_AQ_ENABLE_CHANNELS		BIT(21)
-#define I40EVF_FLAG_AQ_DISABLE_CHANNELS		BIT(22)
-#define I40EVF_FLAG_AQ_ADD_CLOUD_FILTER		BIT(23)
-#define I40EVF_FLAG_AQ_DEL_CLOUD_FILTER		BIT(24)
+#define IAVF_FLAG_AQ_GET_HENA			BIT(11)
+#define IAVF_FLAG_AQ_SET_HENA			BIT(12)
+#define IAVF_FLAG_AQ_SET_RSS_KEY		BIT(13)
+#define IAVF_FLAG_AQ_SET_RSS_LUT		BIT(14)
+#define IAVF_FLAG_AQ_REQUEST_PROMISC		BIT(15)
+#define IAVF_FLAG_AQ_RELEASE_PROMISC		BIT(16)
+#define IAVF_FLAG_AQ_REQUEST_ALLMULTI		BIT(17)
+#define IAVF_FLAG_AQ_RELEASE_ALLMULTI		BIT(18)
+#define IAVF_FLAG_AQ_ENABLE_VLAN_STRIPPING	BIT(19)
+#define IAVF_FLAG_AQ_DISABLE_VLAN_STRIPPING	BIT(20)
+#define IAVF_FLAG_AQ_ENABLE_CHANNELS		BIT(21)
+#define IAVF_FLAG_AQ_DISABLE_CHANNELS		BIT(22)
+#define IAVF_FLAG_AQ_ADD_CLOUD_FILTER		BIT(23)
+#define IAVF_FLAG_AQ_DEL_CLOUD_FILTER		BIT(24)
 
 	/* OS defined structs */
 	struct net_device *netdev;
@@ -309,7 +309,7 @@ struct i40evf_adapter {
 
 	struct i40e_hw hw; /* defined in i40e_type.h */
 
-	enum i40evf_state_t state;
+	enum iavf_state_t state;
 	unsigned long crit_section;
 
 	struct work_struct watchdog_task;
@@ -348,7 +348,7 @@ struct i40evf_adapter {
 	u8 *rss_key;
 	u8 *rss_lut;
 	/* ADQ related members */
-	struct i40evf_channel_config ch_config;
+	struct iavf_channel_config ch_config;
 	u8 num_tc;
 	struct list_head cloud_filter_list;
 	/* lock to protest access to the cloud filter list */
@@ -362,66 +362,66 @@ struct i40evf_adapter {
 /* lan device */
 struct i40e_device {
 	struct list_head list;
-	struct i40evf_adapter *vf;
+	struct iavf_adapter *vf;
 };
 
-/* needed by i40evf_ethtool.c */
-extern char i40evf_driver_name[];
-extern const char i40evf_driver_version[];
-
-int i40evf_up(struct i40evf_adapter *adapter);
-void i40evf_down(struct i40evf_adapter *adapter);
-int i40evf_process_config(struct i40evf_adapter *adapter);
-void i40evf_schedule_reset(struct i40evf_adapter *adapter);
-void i40evf_reset(struct i40evf_adapter *adapter);
-void i40evf_set_ethtool_ops(struct net_device *netdev);
-void i40evf_update_stats(struct i40evf_adapter *adapter);
-void i40evf_reset_interrupt_capability(struct i40evf_adapter *adapter);
-int i40evf_init_interrupt_scheme(struct i40evf_adapter *adapter);
-void i40evf_irq_enable_queues(struct i40evf_adapter *adapter, u32 mask);
-void i40evf_free_all_tx_resources(struct i40evf_adapter *adapter);
-void i40evf_free_all_rx_resources(struct i40evf_adapter *adapter);
-
-void i40e_napi_add_all(struct i40evf_adapter *adapter);
-void i40e_napi_del_all(struct i40evf_adapter *adapter);
-
-int i40evf_send_api_ver(struct i40evf_adapter *adapter);
-int i40evf_verify_api_ver(struct i40evf_adapter *adapter);
-int i40evf_send_vf_config_msg(struct i40evf_adapter *adapter);
-int i40evf_get_vf_config(struct i40evf_adapter *adapter);
-void i40evf_irq_enable(struct i40evf_adapter *adapter, bool flush);
-void i40evf_configure_queues(struct i40evf_adapter *adapter);
-void i40evf_deconfigure_queues(struct i40evf_adapter *adapter);
-void i40evf_enable_queues(struct i40evf_adapter *adapter);
-void i40evf_disable_queues(struct i40evf_adapter *adapter);
-void i40evf_map_queues(struct i40evf_adapter *adapter);
-int i40evf_request_queues(struct i40evf_adapter *adapter, int num);
-void i40evf_add_ether_addrs(struct i40evf_adapter *adapter);
-void i40evf_del_ether_addrs(struct i40evf_adapter *adapter);
-void i40evf_add_vlans(struct i40evf_adapter *adapter);
-void i40evf_del_vlans(struct i40evf_adapter *adapter);
-void i40evf_set_promiscuous(struct i40evf_adapter *adapter, int flags);
-void i40evf_request_stats(struct i40evf_adapter *adapter);
-void i40evf_request_reset(struct i40evf_adapter *adapter);
-void i40evf_get_hena(struct i40evf_adapter *adapter);
-void i40evf_set_hena(struct i40evf_adapter *adapter);
-void i40evf_set_rss_key(struct i40evf_adapter *adapter);
-void i40evf_set_rss_lut(struct i40evf_adapter *adapter);
-void i40evf_enable_vlan_stripping(struct i40evf_adapter *adapter);
-void i40evf_disable_vlan_stripping(struct i40evf_adapter *adapter);
-void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
+/* needed by iavf_ethtool.c */
+extern char iavf_driver_name[];
+extern const char iavf_driver_version[];
+
+int iavf_up(struct iavf_adapter *adapter);
+void iavf_down(struct iavf_adapter *adapter);
+int iavf_process_config(struct iavf_adapter *adapter);
+void iavf_schedule_reset(struct iavf_adapter *adapter);
+void iavf_reset(struct iavf_adapter *adapter);
+void iavf_set_ethtool_ops(struct net_device *netdev);
+void iavf_update_stats(struct iavf_adapter *adapter);
+void iavf_reset_interrupt_capability(struct iavf_adapter *adapter);
+int iavf_init_interrupt_scheme(struct iavf_adapter *adapter);
+void iavf_irq_enable_queues(struct iavf_adapter *adapter, u32 mask);
+void iavf_free_all_tx_resources(struct iavf_adapter *adapter);
+void iavf_free_all_rx_resources(struct iavf_adapter *adapter);
+
+void i40e_napi_add_all(struct iavf_adapter *adapter);
+void i40e_napi_del_all(struct iavf_adapter *adapter);
+
+int iavf_send_api_ver(struct iavf_adapter *adapter);
+int iavf_verify_api_ver(struct iavf_adapter *adapter);
+int iavf_send_vf_config_msg(struct iavf_adapter *adapter);
+int iavf_get_vf_config(struct iavf_adapter *adapter);
+void iavf_irq_enable(struct iavf_adapter *adapter, bool flush);
+void iavf_configure_queues(struct iavf_adapter *adapter);
+void iavf_deconfigure_queues(struct iavf_adapter *adapter);
+void iavf_enable_queues(struct iavf_adapter *adapter);
+void iavf_disable_queues(struct iavf_adapter *adapter);
+void iavf_map_queues(struct iavf_adapter *adapter);
+int iavf_request_queues(struct iavf_adapter *adapter, int num);
+void iavf_add_ether_addrs(struct iavf_adapter *adapter);
+void iavf_del_ether_addrs(struct iavf_adapter *adapter);
+void iavf_add_vlans(struct iavf_adapter *adapter);
+void iavf_del_vlans(struct iavf_adapter *adapter);
+void iavf_set_promiscuous(struct iavf_adapter *adapter, int flags);
+void iavf_request_stats(struct iavf_adapter *adapter);
+void iavf_request_reset(struct iavf_adapter *adapter);
+void iavf_get_hena(struct iavf_adapter *adapter);
+void iavf_set_hena(struct iavf_adapter *adapter);
+void iavf_set_rss_key(struct iavf_adapter *adapter);
+void iavf_set_rss_lut(struct iavf_adapter *adapter);
+void iavf_enable_vlan_stripping(struct iavf_adapter *adapter);
+void iavf_disable_vlan_stripping(struct iavf_adapter *adapter);
+void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 				enum virtchnl_ops v_opcode,
 				i40e_status v_retval, u8 *msg, u16 msglen);
-int i40evf_config_rss(struct i40evf_adapter *adapter);
-int i40evf_lan_add_device(struct i40evf_adapter *adapter);
-int i40evf_lan_del_device(struct i40evf_adapter *adapter);
-void i40evf_client_subtask(struct i40evf_adapter *adapter);
-void i40evf_notify_client_message(struct i40e_vsi *vsi, u8 *msg, u16 len);
-void i40evf_notify_client_l2_params(struct i40e_vsi *vsi);
-void i40evf_notify_client_open(struct i40e_vsi *vsi);
-void i40evf_notify_client_close(struct i40e_vsi *vsi, bool reset);
-void i40evf_enable_channels(struct i40evf_adapter *adapter);
-void i40evf_disable_channels(struct i40evf_adapter *adapter);
-void i40evf_add_cloud_filter(struct i40evf_adapter *adapter);
-void i40evf_del_cloud_filter(struct i40evf_adapter *adapter);
-#endif /* _I40EVF_H_ */
+int iavf_config_rss(struct iavf_adapter *adapter);
+int iavf_lan_add_device(struct iavf_adapter *adapter);
+int iavf_lan_del_device(struct iavf_adapter *adapter);
+void iavf_client_subtask(struct iavf_adapter *adapter);
+void iavf_notify_client_message(struct i40e_vsi *vsi, u8 *msg, u16 len);
+void iavf_notify_client_l2_params(struct i40e_vsi *vsi);
+void iavf_notify_client_open(struct i40e_vsi *vsi);
+void iavf_notify_client_close(struct i40e_vsi *vsi, bool reset);
+void iavf_enable_channels(struct iavf_adapter *adapter);
+void iavf_disable_channels(struct iavf_adapter *adapter);
+void iavf_add_cloud_filter(struct iavf_adapter *adapter);
+void iavf_del_cloud_filter(struct iavf_adapter *adapter);
+#endif /* _IAVF_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/i40evf_client.c b/drivers/net/ethernet/intel/iavf/i40evf_client.c
index 3cc9d60d0d72..71d94cb24602 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf_client.c
+++ b/drivers/net/ethernet/intel/iavf/i40evf_client.c
@@ -9,31 +9,31 @@
 #include "i40evf_client.h"
 
 static
-const char i40evf_client_interface_version_str[] = I40EVF_CLIENT_VERSION_STR;
+const char iavf_client_interface_version_str[] = IAVF_CLIENT_VERSION_STR;
 static struct i40e_client *vf_registered_client;
-static LIST_HEAD(i40evf_devices);
-static DEFINE_MUTEX(i40evf_device_mutex);
+static LIST_HEAD(iavf_devices);
+static DEFINE_MUTEX(iavf_device_mutex);
 
-static u32 i40evf_client_virtchnl_send(struct i40e_info *ldev,
+static u32 iavf_client_virtchnl_send(struct i40e_info *ldev,
 				       struct i40e_client *client,
 				       u8 *msg, u16 len);
 
-static int i40evf_client_setup_qvlist(struct i40e_info *ldev,
+static int iavf_client_setup_qvlist(struct i40e_info *ldev,
 				      struct i40e_client *client,
 				      struct i40e_qvlist_info *qvlist_info);
 
-static struct i40e_ops i40evf_lan_ops = {
-	.virtchnl_send = i40evf_client_virtchnl_send,
-	.setup_qvlist = i40evf_client_setup_qvlist,
+static struct i40e_ops iavf_lan_ops = {
+	.virtchnl_send = iavf_client_virtchnl_send,
+	.setup_qvlist = iavf_client_setup_qvlist,
 };
 
 /**
- * i40evf_client_get_params - retrieve relevant client parameters
+ * iavf_client_get_params - retrieve relevant client parameters
  * @vsi: VSI with parameters
  * @params: client param struct
  **/
 static
-void i40evf_client_get_params(struct i40e_vsi *vsi, struct i40e_params *params)
+void iavf_client_get_params(struct i40e_vsi *vsi, struct i40e_params *params)
 {
 	int i;
 
@@ -48,14 +48,14 @@ void i40evf_client_get_params(struct i40e_vsi *vsi, struct i40e_params *params)
 }
 
 /**
- * i40evf_notify_client_message - call the client message receive callback
+ * iavf_notify_client_message - call the client message receive callback
  * @vsi: the VSI associated with this client
  * @msg: message buffer
  * @len: length of message
  *
  * If there is a client to this VSI, call the client
  **/
-void i40evf_notify_client_message(struct i40e_vsi *vsi, u8 *msg, u16 len)
+void iavf_notify_client_message(struct i40e_vsi *vsi, u8 *msg, u16 len)
 {
 	struct i40e_client_instance *cinst;
 
@@ -74,12 +74,12 @@ void i40evf_notify_client_message(struct i40e_vsi *vsi, u8 *msg, u16 len)
 }
 
 /**
- * i40evf_notify_client_l2_params - call the client notify callback
+ * iavf_notify_client_l2_params - call the client notify callback
  * @vsi: the VSI with l2 param changes
  *
  * If there is a client to this VSI, call the client
  **/
-void i40evf_notify_client_l2_params(struct i40e_vsi *vsi)
+void iavf_notify_client_l2_params(struct i40e_vsi *vsi)
 {
 	struct i40e_client_instance *cinst;
 	struct i40e_params params;
@@ -95,21 +95,21 @@ void i40evf_notify_client_l2_params(struct i40e_vsi *vsi)
 			"Cannot locate client instance l2_param_change function\n");
 		return;
 	}
-	i40evf_client_get_params(vsi, &params);
+	iavf_client_get_params(vsi, &params);
 	cinst->lan_info.params = params;
 	cinst->client->ops->l2_param_change(&cinst->lan_info, cinst->client,
 					    &params);
 }
 
 /**
- * i40evf_notify_client_open - call the client open callback
+ * iavf_notify_client_open - call the client open callback
  * @vsi: the VSI with netdev opened
  *
  * If there is a client to this netdev, call the client with open
  **/
-void i40evf_notify_client_open(struct i40e_vsi *vsi)
+void iavf_notify_client_open(struct i40e_vsi *vsi)
 {
-	struct i40evf_adapter *adapter = vsi->back;
+	struct iavf_adapter *adapter = vsi->back;
 	struct i40e_client_instance *cinst = adapter->cinst;
 	int ret;
 
@@ -127,20 +127,20 @@ void i40evf_notify_client_open(struct i40e_vsi *vsi)
 }
 
 /**
- * i40evf_client_release_qvlist - send a message to the PF to release iwarp qv map
+ * iavf_client_release_qvlist - send a message to the PF to release iwarp qv map
  * @ldev: pointer to L2 context.
  *
  * Return 0 on success or < 0 on error
  **/
-static int i40evf_client_release_qvlist(struct i40e_info *ldev)
+static int iavf_client_release_qvlist(struct i40e_info *ldev)
 {
-	struct i40evf_adapter *adapter = ldev->vf;
+	struct iavf_adapter *adapter = ldev->vf;
 	i40e_status err;
 
 	if (adapter->aq_required)
 		return -EAGAIN;
 
-	err = i40e_aq_send_msg_to_pf(&adapter->hw,
+	err = iavf_aq_send_msg_to_pf(&adapter->hw,
 			VIRTCHNL_OP_RELEASE_IWARP_IRQ_MAP,
 			I40E_SUCCESS, NULL, 0, NULL);
 
@@ -153,15 +153,15 @@ static int i40evf_client_release_qvlist(struct i40e_info *ldev)
 }
 
 /**
- * i40evf_notify_client_close - call the client close callback
+ * iavf_notify_client_close - call the client close callback
  * @vsi: the VSI with netdev closed
  * @reset: true when close called due to reset pending
  *
  * If there is a client to this netdev, call the client with close
  **/
-void i40evf_notify_client_close(struct i40e_vsi *vsi, bool reset)
+void iavf_notify_client_close(struct i40e_vsi *vsi, bool reset)
 {
-	struct i40evf_adapter *adapter = vsi->back;
+	struct iavf_adapter *adapter = vsi->back;
 	struct i40e_client_instance *cinst = adapter->cinst;
 
 	if (!cinst || !cinst->client || !cinst->client->ops ||
@@ -171,18 +171,18 @@ void i40evf_notify_client_close(struct i40e_vsi *vsi, bool reset)
 		return;
 	}
 	cinst->client->ops->close(&cinst->lan_info, cinst->client, reset);
-	i40evf_client_release_qvlist(&cinst->lan_info);
+	iavf_client_release_qvlist(&cinst->lan_info);
 	clear_bit(__I40E_CLIENT_INSTANCE_OPENED, &cinst->state);
 }
 
 /**
- * i40evf_client_add_instance - add a client instance to the instance list
+ * iavf_client_add_instance - add a client instance to the instance list
  * @adapter: pointer to the board struct
  *
  * Returns cinst ptr on success, NULL on failure
  **/
 static struct i40e_client_instance *
-i40evf_client_add_instance(struct i40evf_adapter *adapter)
+iavf_client_add_instance(struct iavf_adapter *adapter)
 {
 	struct i40e_client_instance *cinst = NULL;
 	struct i40e_vsi *vsi = &adapter->vsi;
@@ -207,11 +207,11 @@ i40evf_client_add_instance(struct i40evf_adapter *adapter)
 	cinst->lan_info.fid = 0;
 	cinst->lan_info.ftype = I40E_CLIENT_FTYPE_VF;
 	cinst->lan_info.hw_addr = adapter->hw.hw_addr;
-	cinst->lan_info.ops = &i40evf_lan_ops;
-	cinst->lan_info.version.major = I40EVF_CLIENT_VERSION_MAJOR;
-	cinst->lan_info.version.minor = I40EVF_CLIENT_VERSION_MINOR;
-	cinst->lan_info.version.build = I40EVF_CLIENT_VERSION_BUILD;
-	i40evf_client_get_params(vsi, &params);
+	cinst->lan_info.ops = &iavf_lan_ops;
+	cinst->lan_info.version.major = IAVF_CLIENT_VERSION_MAJOR;
+	cinst->lan_info.version.minor = IAVF_CLIENT_VERSION_MINOR;
+	cinst->lan_info.version.build = IAVF_CLIENT_VERSION_BUILD;
+	iavf_client_get_params(vsi, &params);
 	cinst->lan_info.params = params;
 	set_bit(__I40E_CLIENT_INSTANCE_NONE, &cinst->state);
 
@@ -233,28 +233,28 @@ i40evf_client_add_instance(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_client_del_instance - removes a client instance from the list
+ * iavf_client_del_instance - removes a client instance from the list
  * @adapter: pointer to the board struct
  *
  **/
 static
-void i40evf_client_del_instance(struct i40evf_adapter *adapter)
+void iavf_client_del_instance(struct iavf_adapter *adapter)
 {
 	kfree(adapter->cinst);
 	adapter->cinst = NULL;
 }
 
 /**
- * i40evf_client_subtask - client maintenance work
+ * iavf_client_subtask - client maintenance work
  * @adapter: board private structure
  **/
-void i40evf_client_subtask(struct i40evf_adapter *adapter)
+void iavf_client_subtask(struct iavf_adapter *adapter)
 {
 	struct i40e_client *client = vf_registered_client;
 	struct i40e_client_instance *cinst;
 	int ret = 0;
 
-	if (adapter->state < __I40EVF_DOWN)
+	if (adapter->state < __IAVF_DOWN)
 		return;
 
 	/* first check client is registered */
@@ -262,7 +262,7 @@ void i40evf_client_subtask(struct i40evf_adapter *adapter)
 		return;
 
 	/* Add the client instance to the instance list */
-	cinst = i40evf_client_add_instance(adapter);
+	cinst = iavf_client_add_instance(adapter);
 	if (!cinst)
 		return;
 
@@ -279,23 +279,23 @@ void i40evf_client_subtask(struct i40evf_adapter *adapter)
 				&cinst->state);
 		else
 			/* remove client instance */
-			i40evf_client_del_instance(adapter);
+			iavf_client_del_instance(adapter);
 	}
 }
 
 /**
- * i40evf_lan_add_device - add a lan device struct to the list of lan devices
+ * iavf_lan_add_device - add a lan device struct to the list of lan devices
  * @adapter: pointer to the board struct
  *
  * Returns 0 on success or none 0 on error
  **/
-int i40evf_lan_add_device(struct i40evf_adapter *adapter)
+int iavf_lan_add_device(struct iavf_adapter *adapter)
 {
 	struct i40e_device *ldev;
 	int ret = 0;
 
-	mutex_lock(&i40evf_device_mutex);
-	list_for_each_entry(ldev, &i40evf_devices, list) {
+	mutex_lock(&iavf_device_mutex);
+	list_for_each_entry(ldev, &iavf_devices, list) {
 		if (ldev->vf == adapter) {
 			ret = -EEXIST;
 			goto out;
@@ -308,7 +308,7 @@ int i40evf_lan_add_device(struct i40evf_adapter *adapter)
 	}
 	ldev->vf = adapter;
 	INIT_LIST_HEAD(&ldev->list);
-	list_add(&ldev->list, &i40evf_devices);
+	list_add(&ldev->list, &iavf_devices);
 	dev_info(&adapter->pdev->dev, "Added LAN device bus=0x%02x dev=0x%02x func=0x%02x\n",
 		 adapter->hw.bus.bus_id, adapter->hw.bus.device,
 		 adapter->hw.bus.func);
@@ -316,26 +316,26 @@ int i40evf_lan_add_device(struct i40evf_adapter *adapter)
 	/* Since in some cases register may have happened before a device gets
 	 * added, we can schedule a subtask to go initiate the clients.
 	 */
-	adapter->flags |= I40EVF_FLAG_SERVICE_CLIENT_REQUESTED;
+	adapter->flags |= IAVF_FLAG_SERVICE_CLIENT_REQUESTED;
 
 out:
-	mutex_unlock(&i40evf_device_mutex);
+	mutex_unlock(&iavf_device_mutex);
 	return ret;
 }
 
 /**
- * i40evf_lan_del_device - removes a lan device from the device list
+ * iavf_lan_del_device - removes a lan device from the device list
  * @adapter: pointer to the board struct
  *
  * Returns 0 on success or non-0 on error
  **/
-int i40evf_lan_del_device(struct i40evf_adapter *adapter)
+int iavf_lan_del_device(struct iavf_adapter *adapter)
 {
 	struct i40e_device *ldev, *tmp;
 	int ret = -ENODEV;
 
-	mutex_lock(&i40evf_device_mutex);
-	list_for_each_entry_safe(ldev, tmp, &i40evf_devices, list) {
+	mutex_lock(&iavf_device_mutex);
+	list_for_each_entry_safe(ldev, tmp, &iavf_devices, list) {
 		if (ldev->vf == adapter) {
 			dev_info(&adapter->pdev->dev,
 				 "Deleted LAN device bus=0x%02x dev=0x%02x func=0x%02x\n",
@@ -348,23 +348,23 @@ int i40evf_lan_del_device(struct i40evf_adapter *adapter)
 		}
 	}
 
-	mutex_unlock(&i40evf_device_mutex);
+	mutex_unlock(&iavf_device_mutex);
 	return ret;
 }
 
 /**
- * i40evf_client_release - release client specific resources
+ * iavf_client_release - release client specific resources
  * @client: pointer to the registered client
  *
  **/
-static void i40evf_client_release(struct i40e_client *client)
+static void iavf_client_release(struct i40e_client *client)
 {
 	struct i40e_client_instance *cinst;
 	struct i40e_device *ldev;
-	struct i40evf_adapter *adapter;
+	struct iavf_adapter *adapter;
 
-	mutex_lock(&i40evf_device_mutex);
-	list_for_each_entry(ldev, &i40evf_devices, list) {
+	mutex_lock(&iavf_device_mutex);
+	list_for_each_entry(ldev, &iavf_devices, list) {
 		adapter = ldev->vf;
 		cinst = adapter->cinst;
 		if (!cinst)
@@ -373,41 +373,41 @@ static void i40evf_client_release(struct i40e_client *client)
 			if (client->ops && client->ops->close)
 				client->ops->close(&cinst->lan_info, client,
 						   false);
-			i40evf_client_release_qvlist(&cinst->lan_info);
+			iavf_client_release_qvlist(&cinst->lan_info);
 			clear_bit(__I40E_CLIENT_INSTANCE_OPENED, &cinst->state);
 
 			dev_warn(&adapter->pdev->dev,
 				 "Client %s instance closed\n", client->name);
 		}
 		/* delete the client instance */
-		i40evf_client_del_instance(adapter);
+		iavf_client_del_instance(adapter);
 		dev_info(&adapter->pdev->dev, "Deleted client instance of Client %s\n",
 			 client->name);
 	}
-	mutex_unlock(&i40evf_device_mutex);
+	mutex_unlock(&iavf_device_mutex);
 }
 
 /**
- * i40evf_client_prepare - prepare client specific resources
+ * iavf_client_prepare - prepare client specific resources
  * @client: pointer to the registered client
  *
  **/
-static void i40evf_client_prepare(struct i40e_client *client)
+static void iavf_client_prepare(struct i40e_client *client)
 {
 	struct i40e_device *ldev;
-	struct i40evf_adapter *adapter;
+	struct iavf_adapter *adapter;
 
-	mutex_lock(&i40evf_device_mutex);
-	list_for_each_entry(ldev, &i40evf_devices, list) {
+	mutex_lock(&iavf_device_mutex);
+	list_for_each_entry(ldev, &iavf_devices, list) {
 		adapter = ldev->vf;
 		/* Signal the watchdog to service the client */
-		adapter->flags |= I40EVF_FLAG_SERVICE_CLIENT_REQUESTED;
+		adapter->flags |= IAVF_FLAG_SERVICE_CLIENT_REQUESTED;
 	}
-	mutex_unlock(&i40evf_device_mutex);
+	mutex_unlock(&iavf_device_mutex);
 }
 
 /**
- * i40evf_client_virtchnl_send - send a message to the PF instance
+ * iavf_client_virtchnl_send - send a message to the PF instance
  * @ldev: pointer to L2 context.
  * @client: Client pointer.
  * @msg: pointer to message buffer
@@ -415,17 +415,17 @@ static void i40evf_client_prepare(struct i40e_client *client)
  *
  * Return 0 on success or < 0 on error
  **/
-static u32 i40evf_client_virtchnl_send(struct i40e_info *ldev,
+static u32 iavf_client_virtchnl_send(struct i40e_info *ldev,
 				       struct i40e_client *client,
 				       u8 *msg, u16 len)
 {
-	struct i40evf_adapter *adapter = ldev->vf;
+	struct iavf_adapter *adapter = ldev->vf;
 	i40e_status err;
 
 	if (adapter->aq_required)
 		return -EAGAIN;
 
-	err = i40e_aq_send_msg_to_pf(&adapter->hw, VIRTCHNL_OP_IWARP,
+	err = iavf_aq_send_msg_to_pf(&adapter->hw, VIRTCHNL_OP_IWARP,
 				     I40E_SUCCESS, msg, len, NULL);
 	if (err)
 		dev_err(&adapter->pdev->dev, "Unable to send iWarp message to PF, error %d, aq status %d\n",
@@ -435,19 +435,19 @@ static u32 i40evf_client_virtchnl_send(struct i40e_info *ldev,
 }
 
 /**
- * i40evf_client_setup_qvlist - send a message to the PF to setup iwarp qv map
+ * iavf_client_setup_qvlist - send a message to the PF to setup iwarp qv map
  * @ldev: pointer to L2 context.
  * @client: Client pointer.
  * @qvlist_info: queue and vector list
  *
  * Return 0 on success or < 0 on error
  **/
-static int i40evf_client_setup_qvlist(struct i40e_info *ldev,
+static int iavf_client_setup_qvlist(struct i40e_info *ldev,
 				      struct i40e_client *client,
 				      struct i40e_qvlist_info *qvlist_info)
 {
 	struct virtchnl_iwarp_qvlist_info *v_qvlist_info;
-	struct i40evf_adapter *adapter = ldev->vf;
+	struct iavf_adapter *adapter = ldev->vf;
 	struct i40e_qv_info *qv_info;
 	i40e_status err;
 	u32 v_idx, i;
@@ -474,7 +474,7 @@ static int i40evf_client_setup_qvlist(struct i40e_info *ldev,
 			(v_qvlist_info->num_vectors - 1));
 
 	adapter->client_pending |= BIT(VIRTCHNL_OP_CONFIG_IWARP_IRQ_MAP);
-	err = i40e_aq_send_msg_to_pf(&adapter->hw,
+	err = iavf_aq_send_msg_to_pf(&adapter->hw,
 			VIRTCHNL_OP_CONFIG_IWARP_IRQ_MAP,
 			I40E_SUCCESS, (u8 *)v_qvlist_info, msg_size, NULL);
 
@@ -499,12 +499,12 @@ static int i40evf_client_setup_qvlist(struct i40e_info *ldev,
 }
 
 /**
- * i40evf_register_client - Register a i40e client driver with the L2 driver
+ * iavf_register_client - Register a i40e client driver with the L2 driver
  * @client: pointer to the i40e_client struct
  *
  * Returns 0 on success or non-0 on error
  **/
-int i40evf_register_client(struct i40e_client *client)
+int iavf_register_client(struct i40e_client *client)
 {
 	int ret = 0;
 
@@ -514,48 +514,48 @@ int i40evf_register_client(struct i40e_client *client)
 	}
 
 	if (strlen(client->name) == 0) {
-		pr_info("i40evf: Failed to register client with no name\n");
+		pr_info("iavf: Failed to register client with no name\n");
 		ret = -EIO;
 		goto out;
 	}
 
 	if (vf_registered_client) {
-		pr_info("i40evf: Client %s has already been registered!\n",
+		pr_info("iavf: Client %s has already been registered!\n",
 			client->name);
 		ret = -EEXIST;
 		goto out;
 	}
 
-	if ((client->version.major != I40EVF_CLIENT_VERSION_MAJOR) ||
-	    (client->version.minor != I40EVF_CLIENT_VERSION_MINOR)) {
-		pr_info("i40evf: Failed to register client %s due to mismatched client interface version\n",
+	if ((client->version.major != IAVF_CLIENT_VERSION_MAJOR) ||
+	    (client->version.minor != IAVF_CLIENT_VERSION_MINOR)) {
+		pr_info("iavf: Failed to register client %s due to mismatched client interface version\n",
 			client->name);
 		pr_info("Client is using version: %02d.%02d.%02d while LAN driver supports %s\n",
 			client->version.major, client->version.minor,
 			client->version.build,
-			i40evf_client_interface_version_str);
+			iavf_client_interface_version_str);
 		ret = -EIO;
 		goto out;
 	}
 
 	vf_registered_client = client;
 
-	i40evf_client_prepare(client);
+	iavf_client_prepare(client);
 
-	pr_info("i40evf: Registered client %s with return code %d\n",
+	pr_info("iavf: Registered client %s with return code %d\n",
 		client->name, ret);
 out:
 	return ret;
 }
-EXPORT_SYMBOL(i40evf_register_client);
+EXPORT_SYMBOL(iavf_register_client);
 
 /**
- * i40evf_unregister_client - Unregister a i40e client driver with the L2 driver
+ * iavf_unregister_client - Unregister a i40e client driver with the L2 driver
  * @client: pointer to the i40e_client struct
  *
  * Returns 0 on success or non-0 on error
  **/
-int i40evf_unregister_client(struct i40e_client *client)
+int iavf_unregister_client(struct i40e_client *client)
 {
 	int ret = 0;
 
@@ -563,17 +563,17 @@ int i40evf_unregister_client(struct i40e_client *client)
 	 * a close for each of the client instances that were opened.
 	 * client_release function is called to handle this.
 	 */
-	i40evf_client_release(client);
+	iavf_client_release(client);
 
 	if (vf_registered_client != client) {
-		pr_info("i40evf: Client %s has not been registered\n",
+		pr_info("iavf: Client %s has not been registered\n",
 			client->name);
 		ret = -ENODEV;
 		goto out;
 	}
 	vf_registered_client = NULL;
-	pr_info("i40evf: Unregistered client %s\n", client->name);
+	pr_info("iavf: Unregistered client %s\n", client->name);
 out:
 	return ret;
 }
-EXPORT_SYMBOL(i40evf_unregister_client);
+EXPORT_SYMBOL(iavf_unregister_client);
diff --git a/drivers/net/ethernet/intel/iavf/i40evf_client.h b/drivers/net/ethernet/intel/iavf/i40evf_client.h
index 5585f362048a..e216fc9dfd81 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf_client.h
+++ b/drivers/net/ethernet/intel/iavf/i40evf_client.h
@@ -1,21 +1,21 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#ifndef _I40EVF_CLIENT_H_
-#define _I40EVF_CLIENT_H_
+#ifndef _IAVF_CLIENT_H_
+#define _IAVF_CLIENT_H_
 
-#define I40EVF_CLIENT_STR_LENGTH 10
+#define IAVF_CLIENT_STR_LENGTH 10
 
 /* Client interface version should be updated anytime there is a change in the
  * existing APIs or data structures.
  */
-#define I40EVF_CLIENT_VERSION_MAJOR 0
-#define I40EVF_CLIENT_VERSION_MINOR 01
-#define I40EVF_CLIENT_VERSION_BUILD 00
-#define I40EVF_CLIENT_VERSION_STR     \
-	__stringify(I40EVF_CLIENT_VERSION_MAJOR) "." \
-	__stringify(I40EVF_CLIENT_VERSION_MINOR) "." \
-	__stringify(I40EVF_CLIENT_VERSION_BUILD)
+#define IAVF_CLIENT_VERSION_MAJOR 0
+#define IAVF_CLIENT_VERSION_MINOR 01
+#define IAVF_CLIENT_VERSION_BUILD 00
+#define IAVF_CLIENT_VERSION_STR     \
+	__stringify(IAVF_CLIENT_VERSION_MAJOR) "." \
+	__stringify(IAVF_CLIENT_VERSION_MINOR) "." \
+	__stringify(IAVF_CLIENT_VERSION_BUILD)
 
 struct i40e_client_version {
 	u8 major;
@@ -90,7 +90,7 @@ struct i40e_info {
 #define I40E_CLIENT_FTYPE_PF 0
 #define I40E_CLIENT_FTYPE_VF 1
 	u8 ftype; /* function type, PF or VF */
-	void *vf; /* cast to i40evf_adapter */
+	void *vf; /* cast to iavf_adapter */
 
 	/* All L2 params that could change during the life span of the device
 	 * and needs to be communicated to the client when they change
@@ -151,7 +151,7 @@ struct i40e_client_instance {
 
 struct i40e_client {
 	struct list_head list;		/* list of registered clients */
-	char name[I40EVF_CLIENT_STR_LENGTH];
+	char name[IAVF_CLIENT_STR_LENGTH];
 	struct i40e_client_version version;
 	unsigned long state;		/* client state */
 	atomic_t ref_cnt;  /* Count of all the client devices of this kind */
@@ -164,6 +164,6 @@ struct i40e_client {
 };
 
 /* used by clients */
-int i40evf_register_client(struct i40e_client *client);
-int i40evf_unregister_client(struct i40e_client *client);
-#endif /* _I40EVF_CLIENT_H_ */
+int iavf_register_client(struct i40e_client *client);
+int iavf_unregister_client(struct i40e_client *client);
+#endif /* _IAVF_CLIENT_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/i40evf_ethtool.c b/drivers/net/ethernet/intel/iavf/i40evf_ethtool.c
index 50f65ab737c9..8eb6686eebd0 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/i40evf_ethtool.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-/* ethtool support for i40evf */
+/* ethtool support for iavf */
 #include "i40evf.h"
 
 #include <linux/uaccess.h>
@@ -63,18 +63,18 @@ static const struct i40e_stats i40e_gstrings_queue_stats[] = {
 };
 
 /**
- * i40evf_add_one_ethtool_stat - copy the stat into the supplied buffer
+ * iavf_add_one_ethtool_stat - copy the stat into the supplied buffer
  * @data: location to store the stat value
  * @pointer: basis for where to copy from
  * @stat: the stat definition
  *
  * Copies the stat data defined by the pointer and stat structure pair into
  * the memory supplied as data. Used to implement i40e_add_ethtool_stats and
- * i40evf_add_queue_stats. If the pointer is null, data will be zero'd.
+ * iavf_add_queue_stats. If the pointer is null, data will be zero'd.
  */
 static void
-i40evf_add_one_ethtool_stat(u64 *data, void *pointer,
-			    const struct i40e_stats *stat)
+iavf_add_one_ethtool_stat(u64 *data, void *pointer,
+			  const struct i40e_stats *stat)
 {
 	char *p;
 
@@ -108,7 +108,7 @@ i40evf_add_one_ethtool_stat(u64 *data, void *pointer,
 }
 
 /**
- * __i40evf_add_ethtool_stats - copy stats into the ethtool supplied buffer
+ * __iavf_add_ethtool_stats - copy stats into the ethtool supplied buffer
  * @data: ethtool stats buffer
  * @pointer: location to copy stats from
  * @stats: array of stats to copy
@@ -116,19 +116,19 @@ i40evf_add_one_ethtool_stat(u64 *data, void *pointer,
  *
  * Copy the stats defined by the stats array using the pointer as a base into
  * the data buffer supplied by ethtool. Updates the data pointer to point to
- * the next empty location for successive calls to __i40evf_add_ethtool_stats.
+ * the next empty location for successive calls to __iavf_add_ethtool_stats.
  * If pointer is null, set the data values to zero and update the pointer to
  * skip these stats.
  **/
 static void
-__i40evf_add_ethtool_stats(u64 **data, void *pointer,
-			   const struct i40e_stats stats[],
-			   const unsigned int size)
+__iavf_add_ethtool_stats(u64 **data, void *pointer,
+			 const struct i40e_stats stats[],
+			 const unsigned int size)
 {
 	unsigned int i;
 
 	for (i = 0; i < size; i++)
-		i40evf_add_one_ethtool_stat((*data)++, pointer, &stats[i]);
+		iavf_add_one_ethtool_stat((*data)++, pointer, &stats[i]);
 }
 
 /**
@@ -137,7 +137,7 @@ __i40evf_add_ethtool_stats(u64 **data, void *pointer,
  * @pointer: location where stats are stored
  * @stats: static const array of stat definitions
  *
- * Macro to ease the use of __i40evf_add_ethtool_stats by taking a static
+ * Macro to ease the use of __iavf_add_ethtool_stats by taking a static
  * constant stats array and passing the ARRAY_SIZE(). This avoids typos by
  * ensuring that we pass the size associated with the given stats array.
  *
@@ -145,10 +145,10 @@ __i40evf_add_ethtool_stats(u64 **data, void *pointer,
  * should be avoided.
  **/
 #define i40e_add_ethtool_stats(data, pointer, stats) \
-	__i40evf_add_ethtool_stats(data, pointer, stats, ARRAY_SIZE(stats))
+	__iavf_add_ethtool_stats(data, pointer, stats, ARRAY_SIZE(stats))
 
 /**
- * i40evf_add_queue_stats - copy queue statistics into supplied buffer
+ * iavf_add_queue_stats - copy queue statistics into supplied buffer
  * @data: ethtool stats buffer
  * @ring: the ring to copy
  *
@@ -162,7 +162,7 @@ __i40evf_add_ethtool_stats(u64 **data, void *pointer,
  * This function expects to be called while under rcu_read_lock().
  **/
 static void
-i40evf_add_queue_stats(u64 **data, struct i40e_ring *ring)
+iavf_add_queue_stats(u64 **data, struct i40e_ring *ring)
 {
 	const unsigned int size = ARRAY_SIZE(i40e_gstrings_queue_stats);
 	const struct i40e_stats *stats = i40e_gstrings_queue_stats;
@@ -176,10 +176,8 @@ i40evf_add_queue_stats(u64 **data, struct i40e_ring *ring)
 	 */
 	do {
 		start = !ring ? 0 : u64_stats_fetch_begin_irq(&ring->syncp);
-		for (i = 0; i < size; i++) {
-			i40evf_add_one_ethtool_stat(&(*data)[i], ring,
-						    &stats[i]);
-		}
+		for (i = 0; i < size; i++)
+			iavf_add_one_ethtool_stat(&(*data)[i], ring, &stats[i]);
 	} while (ring && u64_stats_fetch_retry_irq(&ring->syncp, start));
 
 	/* Once we successfully copy the stats in, update the data pointer */
@@ -211,7 +209,7 @@ static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
 }
 
 /**
- * 40e_add_stat_strings - copy stat strings into ethtool buffer
+ * i40e_add_stat_strings - copy stat strings into ethtool buffer
  * @p: ethtool supplied buffer
  * @stats: stat definitions array
  *
@@ -225,63 +223,63 @@ static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
 #define i40e_add_stat_strings(p, stats, ...) \
 	__i40e_add_stat_strings(p, stats, ARRAY_SIZE(stats), ## __VA_ARGS__)
 
-#define I40EVF_STAT(_name, _stat) \
-	I40E_STAT(struct i40evf_adapter, _name, _stat)
-
-static const struct i40e_stats i40evf_gstrings_stats[] = {
-	I40EVF_STAT("rx_bytes", current_stats.rx_bytes),
-	I40EVF_STAT("rx_unicast", current_stats.rx_unicast),
-	I40EVF_STAT("rx_multicast", current_stats.rx_multicast),
-	I40EVF_STAT("rx_broadcast", current_stats.rx_broadcast),
-	I40EVF_STAT("rx_discards", current_stats.rx_discards),
-	I40EVF_STAT("rx_unknown_protocol", current_stats.rx_unknown_protocol),
-	I40EVF_STAT("tx_bytes", current_stats.tx_bytes),
-	I40EVF_STAT("tx_unicast", current_stats.tx_unicast),
-	I40EVF_STAT("tx_multicast", current_stats.tx_multicast),
-	I40EVF_STAT("tx_broadcast", current_stats.tx_broadcast),
-	I40EVF_STAT("tx_discards", current_stats.tx_discards),
-	I40EVF_STAT("tx_errors", current_stats.tx_errors),
+#define IAVF_STAT(_name, _stat) \
+	I40E_STAT(struct iavf_adapter, _name, _stat)
+
+static const struct i40e_stats iavf_gstrings_stats[] = {
+	IAVF_STAT("rx_bytes", current_stats.rx_bytes),
+	IAVF_STAT("rx_unicast", current_stats.rx_unicast),
+	IAVF_STAT("rx_multicast", current_stats.rx_multicast),
+	IAVF_STAT("rx_broadcast", current_stats.rx_broadcast),
+	IAVF_STAT("rx_discards", current_stats.rx_discards),
+	IAVF_STAT("rx_unknown_protocol", current_stats.rx_unknown_protocol),
+	IAVF_STAT("tx_bytes", current_stats.tx_bytes),
+	IAVF_STAT("tx_unicast", current_stats.tx_unicast),
+	IAVF_STAT("tx_multicast", current_stats.tx_multicast),
+	IAVF_STAT("tx_broadcast", current_stats.tx_broadcast),
+	IAVF_STAT("tx_discards", current_stats.tx_discards),
+	IAVF_STAT("tx_errors", current_stats.tx_errors),
 };
 
-#define I40EVF_STATS_LEN	ARRAY_SIZE(i40evf_gstrings_stats)
+#define IAVF_STATS_LEN	ARRAY_SIZE(iavf_gstrings_stats)
 
-#define I40EVF_QUEUE_STATS_LEN	ARRAY_SIZE(i40e_gstrings_queue_stats)
+#define IAVF_QUEUE_STATS_LEN	ARRAY_SIZE(i40e_gstrings_queue_stats)
 
 /* For now we have one and only one private flag and it is only defined
  * when we have support for the SKIP_CPU_SYNC DMA attribute.  Instead
  * of leaving all this code sitting around empty we will strip it unless
  * our one private flag is actually available.
  */
-struct i40evf_priv_flags {
+struct iavf_priv_flags {
 	char flag_string[ETH_GSTRING_LEN];
 	u32 flag;
 	bool read_only;
 };
 
-#define I40EVF_PRIV_FLAG(_name, _flag, _read_only) { \
+#define IAVF_PRIV_FLAG(_name, _flag, _read_only) { \
 	.flag_string = _name, \
 	.flag = _flag, \
 	.read_only = _read_only, \
 }
 
-static const struct i40evf_priv_flags i40evf_gstrings_priv_flags[] = {
-	I40EVF_PRIV_FLAG("legacy-rx", I40EVF_FLAG_LEGACY_RX, 0),
+static const struct iavf_priv_flags iavf_gstrings_priv_flags[] = {
+	IAVF_PRIV_FLAG("legacy-rx", IAVF_FLAG_LEGACY_RX, 0),
 };
 
-#define I40EVF_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40evf_gstrings_priv_flags)
+#define IAVF_PRIV_FLAGS_STR_LEN ARRAY_SIZE(iavf_gstrings_priv_flags)
 
 /**
- * i40evf_get_link_ksettings - Get Link Speed and Duplex settings
+ * iavf_get_link_ksettings - Get Link Speed and Duplex settings
  * @netdev: network interface device structure
  * @cmd: ethtool command
  *
  * Reports speed/duplex settings. Because this is a VF, we don't know what
  * kind of link we really have, so we fake it.
  **/
-static int i40evf_get_link_ksettings(struct net_device *netdev,
+static int iavf_get_link_ksettings(struct net_device *netdev,
 				     struct ethtool_link_ksettings *cmd)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	ethtool_link_ksettings_zero_link_mode(cmd, supported);
 	cmd->base.autoneg = AUTONEG_DISABLE;
@@ -320,86 +318,86 @@ static int i40evf_get_link_ksettings(struct net_device *netdev,
 }
 
 /**
- * i40evf_get_sset_count - Get length of string set
+ * iavf_get_sset_count - Get length of string set
  * @netdev: network interface device structure
  * @sset: id of string set
  *
  * Reports size of various string tables.
  **/
-static int i40evf_get_sset_count(struct net_device *netdev, int sset)
+static int iavf_get_sset_count(struct net_device *netdev, int sset)
 {
 	if (sset == ETH_SS_STATS)
-		return I40EVF_STATS_LEN +
-			(I40EVF_QUEUE_STATS_LEN * 2 * I40EVF_MAX_REQ_QUEUES);
+		return IAVF_STATS_LEN +
+			(IAVF_QUEUE_STATS_LEN * 2 * IAVF_MAX_REQ_QUEUES);
 	else if (sset == ETH_SS_PRIV_FLAGS)
-		return I40EVF_PRIV_FLAGS_STR_LEN;
+		return IAVF_PRIV_FLAGS_STR_LEN;
 	else
 		return -EINVAL;
 }
 
 /**
- * i40evf_get_ethtool_stats - report device statistics
+ * iavf_get_ethtool_stats - report device statistics
  * @netdev: network interface device structure
  * @stats: ethtool statistics structure
  * @data: pointer to data buffer
  *
  * All statistics are added to the data buffer as an array of u64.
  **/
-static void i40evf_get_ethtool_stats(struct net_device *netdev,
+static void iavf_get_ethtool_stats(struct net_device *netdev,
 				     struct ethtool_stats *stats, u64 *data)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	unsigned int i;
 
-	i40e_add_ethtool_stats(&data, adapter, i40evf_gstrings_stats);
+	i40e_add_ethtool_stats(&data, adapter, iavf_gstrings_stats);
 
 	rcu_read_lock();
-	for (i = 0; i < I40EVF_MAX_REQ_QUEUES; i++) {
+	for (i = 0; i < IAVF_MAX_REQ_QUEUES; i++) {
 		struct i40e_ring *ring;
 
 		/* Avoid accessing un-allocated queues */
 		ring = (i < adapter->num_active_queues ?
 			&adapter->tx_rings[i] : NULL);
-		i40evf_add_queue_stats(&data, ring);
+		iavf_add_queue_stats(&data, ring);
 
 		/* Avoid accessing un-allocated queues */
 		ring = (i < adapter->num_active_queues ?
 			&adapter->rx_rings[i] : NULL);
-		i40evf_add_queue_stats(&data, ring);
+		iavf_add_queue_stats(&data, ring);
 	}
 	rcu_read_unlock();
 }
 
 /**
- * i40evf_get_priv_flag_strings - Get private flag strings
+ * iavf_get_priv_flag_strings - Get private flag strings
  * @netdev: network interface device structure
  * @data: buffer for string data
  *
  * Builds the private flags string table
  **/
-static void i40evf_get_priv_flag_strings(struct net_device *netdev, u8 *data)
+static void iavf_get_priv_flag_strings(struct net_device *netdev, u8 *data)
 {
 	unsigned int i;
 
-	for (i = 0; i < I40EVF_PRIV_FLAGS_STR_LEN; i++) {
+	for (i = 0; i < IAVF_PRIV_FLAGS_STR_LEN; i++) {
 		snprintf(data, ETH_GSTRING_LEN, "%s",
-			 i40evf_gstrings_priv_flags[i].flag_string);
+			 iavf_gstrings_priv_flags[i].flag_string);
 		data += ETH_GSTRING_LEN;
 	}
 }
 
 /**
- * i40evf_get_stat_strings - Get stat strings
+ * iavf_get_stat_strings - Get stat strings
  * @netdev: network interface device structure
  * @data: buffer for string data
  *
  * Builds the statistics string table
  **/
-static void i40evf_get_stat_strings(struct net_device *netdev, u8 *data)
+static void iavf_get_stat_strings(struct net_device *netdev, u8 *data)
 {
 	unsigned int i;
 
-	i40e_add_stat_strings(&data, i40evf_gstrings_stats);
+	i40e_add_stat_strings(&data, iavf_gstrings_stats);
 
 	/* Queues are always allocated in pairs, so we just use num_tx_queues
 	 * for both Tx and Rx queues.
@@ -413,21 +411,21 @@ static void i40evf_get_stat_strings(struct net_device *netdev, u8 *data)
 }
 
 /**
- * i40evf_get_strings - Get string set
+ * iavf_get_strings - Get string set
  * @netdev: network interface device structure
  * @sset: id of string set
  * @data: buffer for string data
  *
  * Builds string tables for various string sets
  **/
-static void i40evf_get_strings(struct net_device *netdev, u32 sset, u8 *data)
+static void iavf_get_strings(struct net_device *netdev, u32 sset, u8 *data)
 {
 	switch (sset) {
 	case ETH_SS_STATS:
-		i40evf_get_stat_strings(netdev, data);
+		iavf_get_stat_strings(netdev, data);
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		i40evf_get_priv_flag_strings(netdev, data);
+		iavf_get_priv_flag_strings(netdev, data);
 		break;
 	default:
 		break;
@@ -435,7 +433,7 @@ static void i40evf_get_strings(struct net_device *netdev, u32 sset, u8 *data)
 }
 
 /**
- * i40evf_get_priv_flags - report device private flags
+ * iavf_get_priv_flags - report device private flags
  * @netdev: network interface device structure
  *
  * The get string set count and the string set should be matched for each
@@ -444,15 +442,15 @@ static void i40evf_get_strings(struct net_device *netdev, u32 sset, u8 *data)
  *
  * Returns a u32 bitmap of flags.
  **/
-static u32 i40evf_get_priv_flags(struct net_device *netdev)
+static u32 iavf_get_priv_flags(struct net_device *netdev)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 i, ret_flags = 0;
 
-	for (i = 0; i < I40EVF_PRIV_FLAGS_STR_LEN; i++) {
-		const struct i40evf_priv_flags *priv_flags;
+	for (i = 0; i < IAVF_PRIV_FLAGS_STR_LEN; i++) {
+		const struct iavf_priv_flags *priv_flags;
 
-		priv_flags = &i40evf_gstrings_priv_flags[i];
+		priv_flags = &iavf_gstrings_priv_flags[i];
 
 		if (priv_flags->flag & adapter->flags)
 			ret_flags |= BIT(i);
@@ -462,23 +460,23 @@ static u32 i40evf_get_priv_flags(struct net_device *netdev)
 }
 
 /**
- * i40evf_set_priv_flags - set private flags
+ * iavf_set_priv_flags - set private flags
  * @netdev: network interface device structure
  * @flags: bit flags to be set
  **/
-static int i40evf_set_priv_flags(struct net_device *netdev, u32 flags)
+static int iavf_set_priv_flags(struct net_device *netdev, u32 flags)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 orig_flags, new_flags, changed_flags;
 	u32 i;
 
 	orig_flags = READ_ONCE(adapter->flags);
 	new_flags = orig_flags;
 
-	for (i = 0; i < I40EVF_PRIV_FLAGS_STR_LEN; i++) {
-		const struct i40evf_priv_flags *priv_flags;
+	for (i = 0; i < IAVF_PRIV_FLAGS_STR_LEN; i++) {
+		const struct iavf_priv_flags *priv_flags;
 
-		priv_flags = &i40evf_gstrings_priv_flags[i];
+		priv_flags = &iavf_gstrings_priv_flags[i];
 
 		if (flags & BIT(i))
 			new_flags |= priv_flags->flag;
@@ -515,9 +513,9 @@ static int i40evf_set_priv_flags(struct net_device *netdev, u32 flags)
 	 */
 
 	/* issue a reset to force legacy-rx change to take effect */
-	if (changed_flags & I40EVF_FLAG_LEGACY_RX) {
+	if (changed_flags & IAVF_FLAG_LEGACY_RX) {
 		if (netif_running(netdev)) {
-			adapter->flags |= I40EVF_FLAG_RESET_NEEDED;
+			adapter->flags |= IAVF_FLAG_RESET_NEEDED;
 			schedule_work(&adapter->reset_task);
 		}
 	}
@@ -526,29 +524,29 @@ static int i40evf_set_priv_flags(struct net_device *netdev, u32 flags)
 }
 
 /**
- * i40evf_get_msglevel - Get debug message level
+ * iavf_get_msglevel - Get debug message level
  * @netdev: network interface device structure
  *
  * Returns current debug message level.
  **/
-static u32 i40evf_get_msglevel(struct net_device *netdev)
+static u32 iavf_get_msglevel(struct net_device *netdev)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	return adapter->msg_enable;
 }
 
 /**
- * i40evf_set_msglevel - Set debug message level
+ * iavf_set_msglevel - Set debug message level
  * @netdev: network interface device structure
  * @data: message level
  *
  * Set current debug message level. Higher values cause the driver to
  * be noisier.
  **/
-static void i40evf_set_msglevel(struct net_device *netdev, u32 data)
+static void iavf_set_msglevel(struct net_device *netdev, u32 data)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	if (I40E_DEBUG_USER & data)
 		adapter->hw.debug_mask = data;
@@ -556,69 +554,69 @@ static void i40evf_set_msglevel(struct net_device *netdev, u32 data)
 }
 
 /**
- * i40evf_get_drvinfo - Get driver info
+ * iavf_get_drvinfo - Get driver info
  * @netdev: network interface device structure
  * @drvinfo: ethool driver info structure
  *
  * Returns information about the driver and device for display to the user.
  **/
-static void i40evf_get_drvinfo(struct net_device *netdev,
+static void iavf_get_drvinfo(struct net_device *netdev,
 			       struct ethtool_drvinfo *drvinfo)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
-	strlcpy(drvinfo->driver, i40evf_driver_name, 32);
-	strlcpy(drvinfo->version, i40evf_driver_version, 32);
+	strlcpy(drvinfo->driver, iavf_driver_name, 32);
+	strlcpy(drvinfo->version, iavf_driver_version, 32);
 	strlcpy(drvinfo->fw_version, "N/A", 4);
 	strlcpy(drvinfo->bus_info, pci_name(adapter->pdev), 32);
-	drvinfo->n_priv_flags = I40EVF_PRIV_FLAGS_STR_LEN;
+	drvinfo->n_priv_flags = IAVF_PRIV_FLAGS_STR_LEN;
 }
 
 /**
- * i40evf_get_ringparam - Get ring parameters
+ * iavf_get_ringparam - Get ring parameters
  * @netdev: network interface device structure
  * @ring: ethtool ringparam structure
  *
  * Returns current ring parameters. TX and RX rings are reported separately,
  * but the number of rings is not reported.
  **/
-static void i40evf_get_ringparam(struct net_device *netdev,
+static void iavf_get_ringparam(struct net_device *netdev,
 				 struct ethtool_ringparam *ring)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
-	ring->rx_max_pending = I40EVF_MAX_RXD;
-	ring->tx_max_pending = I40EVF_MAX_TXD;
+	ring->rx_max_pending = IAVF_MAX_RXD;
+	ring->tx_max_pending = IAVF_MAX_TXD;
 	ring->rx_pending = adapter->rx_desc_count;
 	ring->tx_pending = adapter->tx_desc_count;
 }
 
 /**
- * i40evf_set_ringparam - Set ring parameters
+ * iavf_set_ringparam - Set ring parameters
  * @netdev: network interface device structure
  * @ring: ethtool ringparam structure
  *
  * Sets ring parameters. TX and RX rings are controlled separately, but the
  * number of rings is not specified, so all rings get the same settings.
  **/
-static int i40evf_set_ringparam(struct net_device *netdev,
+static int iavf_set_ringparam(struct net_device *netdev,
 				struct ethtool_ringparam *ring)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 new_rx_count, new_tx_count;
 
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
 
 	new_tx_count = clamp_t(u32, ring->tx_pending,
-			       I40EVF_MIN_TXD,
-			       I40EVF_MAX_TXD);
-	new_tx_count = ALIGN(new_tx_count, I40EVF_REQ_DESCRIPTOR_MULTIPLE);
+			       IAVF_MIN_TXD,
+			       IAVF_MAX_TXD);
+	new_tx_count = ALIGN(new_tx_count, IAVF_REQ_DESCRIPTOR_MULTIPLE);
 
 	new_rx_count = clamp_t(u32, ring->rx_pending,
-			       I40EVF_MIN_RXD,
-			       I40EVF_MAX_RXD);
-	new_rx_count = ALIGN(new_rx_count, I40EVF_REQ_DESCRIPTOR_MULTIPLE);
+			       IAVF_MIN_RXD,
+			       IAVF_MAX_RXD);
+	new_rx_count = ALIGN(new_rx_count, IAVF_REQ_DESCRIPTOR_MULTIPLE);
 
 	/* if nothing to do return success */
 	if ((new_tx_count == adapter->tx_desc_count) &&
@@ -629,7 +627,7 @@ static int i40evf_set_ringparam(struct net_device *netdev,
 	adapter->rx_desc_count = new_rx_count;
 
 	if (netif_running(netdev)) {
-		adapter->flags |= I40EVF_FLAG_RESET_NEEDED;
+		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
 		schedule_work(&adapter->reset_task);
 	}
 
@@ -637,7 +635,7 @@ static int i40evf_set_ringparam(struct net_device *netdev,
 }
 
 /**
- * __i40evf_get_coalesce - get per-queue coalesce settings
+ * __iavf_get_coalesce - get per-queue coalesce settings
  * @netdev: the netdev to check
  * @ec: ethtool coalesce data structure
  * @queue: which queue to pick
@@ -646,11 +644,11 @@ static int i40evf_set_ringparam(struct net_device *netdev,
  * are per queue. If queue is <0 then we default to queue 0 as the
  * representative value.
  **/
-static int __i40evf_get_coalesce(struct net_device *netdev,
+static int __iavf_get_coalesce(struct net_device *netdev,
 				 struct ethtool_coalesce *ec,
 				 int queue)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	struct i40e_vsi *vsi = &adapter->vsi;
 	struct i40e_ring *rx_ring, *tx_ring;
 
@@ -681,7 +679,7 @@ static int __i40evf_get_coalesce(struct net_device *netdev,
 }
 
 /**
- * i40evf_get_coalesce - Get interrupt coalescing settings
+ * iavf_get_coalesce - Get interrupt coalescing settings
  * @netdev: network interface device structure
  * @ec: ethtool coalesce structure
  *
@@ -690,36 +688,36 @@ static int __i40evf_get_coalesce(struct net_device *netdev,
  * this functionality. Note that if per-queue settings have been modified this
  * only represents the settings of queue 0.
  **/
-static int i40evf_get_coalesce(struct net_device *netdev,
+static int iavf_get_coalesce(struct net_device *netdev,
 			       struct ethtool_coalesce *ec)
 {
-	return __i40evf_get_coalesce(netdev, ec, -1);
+	return __iavf_get_coalesce(netdev, ec, -1);
 }
 
 /**
- * i40evf_get_per_queue_coalesce - get coalesce values for specific queue
+ * iavf_get_per_queue_coalesce - get coalesce values for specific queue
  * @netdev: netdev to read
  * @ec: coalesce settings from ethtool
  * @queue: the queue to read
  *
  * Read specific queue's coalesce settings.
  **/
-static int i40evf_get_per_queue_coalesce(struct net_device *netdev,
+static int iavf_get_per_queue_coalesce(struct net_device *netdev,
 					 u32 queue,
 					 struct ethtool_coalesce *ec)
 {
-	return __i40evf_get_coalesce(netdev, ec, queue);
+	return __iavf_get_coalesce(netdev, ec, queue);
 }
 
 /**
- * i40evf_set_itr_per_queue - set ITR values for specific queue
+ * iavf_set_itr_per_queue - set ITR values for specific queue
  * @adapter: the VF adapter struct to set values for
  * @ec: coalesce settings from ethtool
  * @queue: the queue to modify
  *
  * Change the ITR settings for a specific queue.
  **/
-static void i40evf_set_itr_per_queue(struct i40evf_adapter *adapter,
+static void iavf_set_itr_per_queue(struct iavf_adapter *adapter,
 				     struct ethtool_coalesce *ec,
 				     int queue)
 {
@@ -751,18 +749,18 @@ static void i40evf_set_itr_per_queue(struct i40evf_adapter *adapter,
 }
 
 /**
- * __i40evf_set_coalesce - set coalesce settings for particular queue
+ * __iavf_set_coalesce - set coalesce settings for particular queue
  * @netdev: the netdev to change
  * @ec: ethtool coalesce settings
  * @queue: the queue to change
  *
  * Sets the coalesce settings for a particular queue.
  **/
-static int __i40evf_set_coalesce(struct net_device *netdev,
+static int __iavf_set_coalesce(struct net_device *netdev,
 				 struct ethtool_coalesce *ec,
 				 int queue)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	struct i40e_vsi *vsi = &adapter->vsi;
 	int i;
 
@@ -793,9 +791,9 @@ static int __i40evf_set_coalesce(struct net_device *netdev,
 	 */
 	if (queue < 0) {
 		for (i = 0; i < adapter->num_active_queues; i++)
-			i40evf_set_itr_per_queue(adapter, ec, i);
+			iavf_set_itr_per_queue(adapter, ec, i);
 	} else if (queue < adapter->num_active_queues) {
-		i40evf_set_itr_per_queue(adapter, ec, queue);
+		iavf_set_itr_per_queue(adapter, ec, queue);
 	} else {
 		netif_info(adapter, drv, netdev, "Invalid queue value, queue range is 0 - %d\n",
 			   adapter->num_active_queues - 1);
@@ -806,46 +804,46 @@ static int __i40evf_set_coalesce(struct net_device *netdev,
 }
 
 /**
- * i40evf_set_coalesce - Set interrupt coalescing settings
+ * iavf_set_coalesce - Set interrupt coalescing settings
  * @netdev: network interface device structure
  * @ec: ethtool coalesce structure
  *
  * Change current coalescing settings for every queue.
  **/
-static int i40evf_set_coalesce(struct net_device *netdev,
+static int iavf_set_coalesce(struct net_device *netdev,
 			       struct ethtool_coalesce *ec)
 {
-	return __i40evf_set_coalesce(netdev, ec, -1);
+	return __iavf_set_coalesce(netdev, ec, -1);
 }
 
 /**
- * i40evf_set_per_queue_coalesce - set specific queue's coalesce settings
+ * iavf_set_per_queue_coalesce - set specific queue's coalesce settings
  * @netdev: the netdev to change
  * @ec: ethtool's coalesce settings
  * @queue: the queue to modify
  *
  * Modifies a specific queue's coalesce settings.
  */
-static int i40evf_set_per_queue_coalesce(struct net_device *netdev,
+static int iavf_set_per_queue_coalesce(struct net_device *netdev,
 					 u32 queue,
 					 struct ethtool_coalesce *ec)
 {
-	return __i40evf_set_coalesce(netdev, ec, queue);
+	return __iavf_set_coalesce(netdev, ec, queue);
 }
 
 /**
- * i40evf_get_rxnfc - command to get RX flow classification rules
+ * iavf_get_rxnfc - command to get RX flow classification rules
  * @netdev: network interface device structure
  * @cmd: ethtool rxnfc command
  * @rule_locs: pointer to store rule locations
  *
  * Returns Success if the command is supported.
  **/
-static int i40evf_get_rxnfc(struct net_device *netdev,
+static int iavf_get_rxnfc(struct net_device *netdev,
 			    struct ethtool_rxnfc *cmd,
 			    u32 *rule_locs)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	int ret = -EOPNOTSUPP;
 
 	switch (cmd->cmd) {
@@ -864,20 +862,20 @@ static int i40evf_get_rxnfc(struct net_device *netdev,
 	return ret;
 }
 /**
- * i40evf_get_channels: get the number of channels supported by the device
+ * iavf_get_channels: get the number of channels supported by the device
  * @netdev: network interface device structure
  * @ch: channel information structure
  *
  * For the purposes of our device, we only use combined channels, i.e. a tx/rx
  * queue pair. Report one extra channel to match our "other" MSI-X vector.
  **/
-static void i40evf_get_channels(struct net_device *netdev,
+static void iavf_get_channels(struct net_device *netdev,
 				struct ethtool_channels *ch)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	/* Report maximum channels */
-	ch->max_combined = I40EVF_MAX_REQ_QUEUES;
+	ch->max_combined = IAVF_MAX_REQ_QUEUES;
 
 	ch->max_other = NONQ_VECS;
 	ch->other_count = NONQ_VECS;
@@ -886,7 +884,7 @@ static void i40evf_get_channels(struct net_device *netdev,
 }
 
 /**
- * i40evf_set_channels: set the new channel count
+ * iavf_set_channels: set the new channel count
  * @netdev: network interface device structure
  * @ch: channel information structure
  *
@@ -894,10 +892,10 @@ static void i40evf_get_channels(struct net_device *netdev,
  * reset we'll realloc queues and fix the RSS table.  Returns 0 on success,
  * negative on failure.
  **/
-static int i40evf_set_channels(struct net_device *netdev,
+static int iavf_set_channels(struct net_device *netdev,
 			       struct ethtool_channels *ch)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	int num_req = ch->combined_count;
 
 	if (num_req != adapter->num_active_queues &&
@@ -916,44 +914,44 @@ static int i40evf_set_channels(struct net_device *netdev,
 	/* All of these should have already been checked by ethtool before this
 	 * even gets to us, but just to be sure.
 	 */
-	if (num_req <= 0 || num_req > I40EVF_MAX_REQ_QUEUES)
+	if (num_req <= 0 || num_req > IAVF_MAX_REQ_QUEUES)
 		return -EINVAL;
 
 	if (ch->rx_count || ch->tx_count || ch->other_count != NONQ_VECS)
 		return -EINVAL;
 
 	adapter->num_req_queues = num_req;
-	return i40evf_request_queues(adapter, num_req);
+	return iavf_request_queues(adapter, num_req);
 }
 
 /**
- * i40evf_get_rxfh_key_size - get the RSS hash key size
+ * iavf_get_rxfh_key_size - get the RSS hash key size
  * @netdev: network interface device structure
  *
  * Returns the table size.
  **/
-static u32 i40evf_get_rxfh_key_size(struct net_device *netdev)
+static u32 iavf_get_rxfh_key_size(struct net_device *netdev)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	return adapter->rss_key_size;
 }
 
 /**
- * i40evf_get_rxfh_indir_size - get the rx flow hash indirection table size
+ * iavf_get_rxfh_indir_size - get the rx flow hash indirection table size
  * @netdev: network interface device structure
  *
  * Returns the table size.
  **/
-static u32 i40evf_get_rxfh_indir_size(struct net_device *netdev)
+static u32 iavf_get_rxfh_indir_size(struct net_device *netdev)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	return adapter->rss_lut_size;
 }
 
 /**
- * i40evf_get_rxfh - get the rx flow hash indirection table
+ * iavf_get_rxfh - get the rx flow hash indirection table
  * @netdev: network interface device structure
  * @indir: indirection table
  * @key: hash key
@@ -961,10 +959,10 @@ static u32 i40evf_get_rxfh_indir_size(struct net_device *netdev)
  *
  * Reads the indirection table directly from the hardware. Always returns 0.
  **/
-static int i40evf_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
+static int iavf_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
 			   u8 *hfunc)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u16 i;
 
 	if (hfunc)
@@ -982,7 +980,7 @@ static int i40evf_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
 }
 
 /**
- * i40evf_set_rxfh - set the rx flow hash indirection table
+ * iavf_set_rxfh - set the rx flow hash indirection table
  * @netdev: network interface device structure
  * @indir: indirection table
  * @key: hash key
@@ -991,10 +989,10 @@ static int i40evf_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
  * Returns -EINVAL if the table specifies an inavlid queue id, otherwise
  * returns 0 after programming the table.
  **/
-static int i40evf_set_rxfh(struct net_device *netdev, const u32 *indir,
+static int iavf_set_rxfh(struct net_device *netdev, const u32 *indir,
 			   const u8 *key, const u8 hfunc)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u16 i;
 
 	/* We do not allow change in unsupported parameters */
@@ -1012,43 +1010,43 @@ static int i40evf_set_rxfh(struct net_device *netdev, const u32 *indir,
 	for (i = 0; i < adapter->rss_lut_size; i++)
 		adapter->rss_lut[i] = (u8)(indir[i]);
 
-	return i40evf_config_rss(adapter);
+	return iavf_config_rss(adapter);
 }
 
-static const struct ethtool_ops i40evf_ethtool_ops = {
-	.get_drvinfo		= i40evf_get_drvinfo,
+static const struct ethtool_ops iavf_ethtool_ops = {
+	.get_drvinfo		= iavf_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
-	.get_ringparam		= i40evf_get_ringparam,
-	.set_ringparam		= i40evf_set_ringparam,
-	.get_strings		= i40evf_get_strings,
-	.get_ethtool_stats	= i40evf_get_ethtool_stats,
-	.get_sset_count		= i40evf_get_sset_count,
-	.get_priv_flags		= i40evf_get_priv_flags,
-	.set_priv_flags		= i40evf_set_priv_flags,
-	.get_msglevel		= i40evf_get_msglevel,
-	.set_msglevel		= i40evf_set_msglevel,
-	.get_coalesce		= i40evf_get_coalesce,
-	.set_coalesce		= i40evf_set_coalesce,
-	.get_per_queue_coalesce = i40evf_get_per_queue_coalesce,
-	.set_per_queue_coalesce = i40evf_set_per_queue_coalesce,
-	.get_rxnfc		= i40evf_get_rxnfc,
-	.get_rxfh_indir_size	= i40evf_get_rxfh_indir_size,
-	.get_rxfh		= i40evf_get_rxfh,
-	.set_rxfh		= i40evf_set_rxfh,
-	.get_channels		= i40evf_get_channels,
-	.set_channels		= i40evf_set_channels,
-	.get_rxfh_key_size	= i40evf_get_rxfh_key_size,
-	.get_link_ksettings	= i40evf_get_link_ksettings,
+	.get_ringparam		= iavf_get_ringparam,
+	.set_ringparam		= iavf_set_ringparam,
+	.get_strings		= iavf_get_strings,
+	.get_ethtool_stats	= iavf_get_ethtool_stats,
+	.get_sset_count		= iavf_get_sset_count,
+	.get_priv_flags		= iavf_get_priv_flags,
+	.set_priv_flags		= iavf_set_priv_flags,
+	.get_msglevel		= iavf_get_msglevel,
+	.set_msglevel		= iavf_set_msglevel,
+	.get_coalesce		= iavf_get_coalesce,
+	.set_coalesce		= iavf_set_coalesce,
+	.get_per_queue_coalesce = iavf_get_per_queue_coalesce,
+	.set_per_queue_coalesce = iavf_set_per_queue_coalesce,
+	.get_rxnfc		= iavf_get_rxnfc,
+	.get_rxfh_indir_size	= iavf_get_rxfh_indir_size,
+	.get_rxfh		= iavf_get_rxfh,
+	.set_rxfh		= iavf_set_rxfh,
+	.get_channels		= iavf_get_channels,
+	.set_channels		= iavf_set_channels,
+	.get_rxfh_key_size	= iavf_get_rxfh_key_size,
+	.get_link_ksettings	= iavf_get_link_ksettings,
 };
 
 /**
- * i40evf_set_ethtool_ops - Initialize ethtool ops struct
+ * iavf_set_ethtool_ops - Initialize ethtool ops struct
  * @netdev: network interface device structure
  *
  * Sets ethtool ops struct in our netdev so that ethtool can call
  * our functions.
  **/
-void i40evf_set_ethtool_ops(struct net_device *netdev)
+void iavf_set_ethtool_ops(struct net_device *netdev)
 {
-	netdev->ethtool_ops = &i40evf_ethtool_ops;
+	netdev->ethtool_ops = &iavf_ethtool_ops;
 }
diff --git a/drivers/net/ethernet/intel/iavf/i40evf_main.c b/drivers/net/ethernet/intel/iavf/i40evf_main.c
index 6f34b54bd90f..f7b4d5aacee3 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/iavf/i40evf_main.c
@@ -4,19 +4,19 @@
 #include "i40evf.h"
 #include "i40e_prototype.h"
 #include "i40evf_client.h"
-/* All i40evf tracepoints are defined by the include below, which must
+/* All iavf tracepoints are defined by the include below, which must
  * be included exactly once across the whole kernel with
  * CREATE_TRACE_POINTS defined
  */
 #define CREATE_TRACE_POINTS
 #include "i40e_trace.h"
 
-static int i40evf_setup_all_tx_resources(struct i40evf_adapter *adapter);
-static int i40evf_setup_all_rx_resources(struct i40evf_adapter *adapter);
-static int i40evf_close(struct net_device *netdev);
+static int iavf_setup_all_tx_resources(struct iavf_adapter *adapter);
+static int iavf_setup_all_rx_resources(struct iavf_adapter *adapter);
+static int iavf_close(struct net_device *netdev);
 
-char i40evf_driver_name[] = "i40evf";
-static const char i40evf_driver_string[] =
+char iavf_driver_name[] = "iavf";
+static const char iavf_driver_string[] =
 	"Intel(R) Ethernet Adaptive Virtual Function Network Driver";
 
 #define DRV_KERN "-k"
@@ -28,11 +28,11 @@ static const char i40evf_driver_string[] =
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD) \
 	     DRV_KERN
-const char i40evf_driver_version[] = DRV_VERSION;
-static const char i40evf_copyright[] =
+const char iavf_driver_version[] = DRV_VERSION;
+static const char iavf_copyright[] =
 	"Copyright (c) 2013 - 2018 Intel Corporation.";
 
-/* i40evf_pci_tbl - PCI Device ID Table
+/* iavf_pci_tbl - PCI Device ID Table
  *
  * Wildcard entries (PCI_ANY_ID) should come last
  * Last entry must be all 0s
@@ -40,7 +40,7 @@ static const char i40evf_copyright[] =
  * { Vendor ID, Device ID, SubVendor ID, SubDevice ID,
  *   Class, Class Mask, private data (not used) }
  */
-static const struct pci_device_id i40evf_pci_tbl[] = {
+static const struct pci_device_id iavf_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_VF), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_VF_HV), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_X722_VF), 0},
@@ -49,7 +49,7 @@ static const struct pci_device_id i40evf_pci_tbl[] = {
 	{0, }
 };
 
-MODULE_DEVICE_TABLE(pci, i40evf_pci_tbl);
+MODULE_DEVICE_TABLE(pci, iavf_pci_tbl);
 
 MODULE_ALIAS("i40evf");
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
@@ -57,20 +57,20 @@ MODULE_DESCRIPTION("Intel(R) XL710 X710 Virtual Function Network Driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
-static struct workqueue_struct *i40evf_wq;
+static struct workqueue_struct *iavf_wq;
 
 /**
- * i40evf_allocate_dma_mem_d - OS specific memory alloc for shared code
+ * iavf_allocate_dma_mem_d - OS specific memory alloc for shared code
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to fill out
  * @size: size of memory requested
  * @alignment: what to align the allocation to
  **/
-i40e_status i40evf_allocate_dma_mem_d(struct i40e_hw *hw,
+i40e_status iavf_allocate_dma_mem_d(struct i40e_hw *hw,
 				      struct i40e_dma_mem *mem,
 				      u64 size, u32 alignment)
 {
-	struct i40evf_adapter *adapter = (struct i40evf_adapter *)hw->back;
+	struct iavf_adapter *adapter = (struct iavf_adapter *)hw->back;
 
 	if (!mem)
 		return I40E_ERR_PARAM;
@@ -85,13 +85,13 @@ i40e_status i40evf_allocate_dma_mem_d(struct i40e_hw *hw,
 }
 
 /**
- * i40evf_free_dma_mem_d - OS specific memory free for shared code
+ * iavf_free_dma_mem_d - OS specific memory free for shared code
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to free
  **/
-i40e_status i40evf_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
+i40e_status iavf_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
 {
-	struct i40evf_adapter *adapter = (struct i40evf_adapter *)hw->back;
+	struct iavf_adapter *adapter = (struct iavf_adapter *)hw->back;
 
 	if (!mem || !mem->va)
 		return I40E_ERR_PARAM;
@@ -101,12 +101,12 @@ i40e_status i40evf_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
 }
 
 /**
- * i40evf_allocate_virt_mem_d - OS specific memory alloc for shared code
+ * iavf_allocate_virt_mem_d - OS specific memory alloc for shared code
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to fill out
  * @size: size of memory requested
  **/
-i40e_status i40evf_allocate_virt_mem_d(struct i40e_hw *hw,
+i40e_status iavf_allocate_virt_mem_d(struct i40e_hw *hw,
 				       struct i40e_virt_mem *mem, u32 size)
 {
 	if (!mem)
@@ -122,11 +122,11 @@ i40e_status i40evf_allocate_virt_mem_d(struct i40e_hw *hw,
 }
 
 /**
- * i40evf_free_virt_mem_d - OS specific memory free for shared code
+ * iavf_free_virt_mem_d - OS specific memory free for shared code
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to free
  **/
-i40e_status i40evf_free_virt_mem_d(struct i40e_hw *hw,
+i40e_status iavf_free_virt_mem_d(struct i40e_hw *hw,
 				   struct i40e_virt_mem *mem)
 {
 	if (!mem)
@@ -139,12 +139,12 @@ i40e_status i40evf_free_virt_mem_d(struct i40e_hw *hw,
 }
 
 /**
- * i40evf_debug_d - OS dependent version of debug printing
+ * iavf_debug_d - OS dependent version of debug printing
  * @hw:  pointer to the HW structure
  * @mask: debug level mask
  * @fmt_str: printf-type format description
  **/
-void i40evf_debug_d(void *hw, u32 mask, char *fmt_str, ...)
+void iavf_debug_d(void *hw, u32 mask, char *fmt_str, ...)
 {
 	char buf[512];
 	va_list argptr;
@@ -161,35 +161,35 @@ void i40evf_debug_d(void *hw, u32 mask, char *fmt_str, ...)
 }
 
 /**
- * i40evf_schedule_reset - Set the flags and schedule a reset event
+ * iavf_schedule_reset - Set the flags and schedule a reset event
  * @adapter: board private structure
  **/
-void i40evf_schedule_reset(struct i40evf_adapter *adapter)
+void iavf_schedule_reset(struct iavf_adapter *adapter)
 {
 	if (!(adapter->flags &
-	      (I40EVF_FLAG_RESET_PENDING | I40EVF_FLAG_RESET_NEEDED))) {
-		adapter->flags |= I40EVF_FLAG_RESET_NEEDED;
+	      (IAVF_FLAG_RESET_PENDING | IAVF_FLAG_RESET_NEEDED))) {
+		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
 		schedule_work(&adapter->reset_task);
 	}
 }
 
 /**
- * i40evf_tx_timeout - Respond to a Tx Hang
+ * iavf_tx_timeout - Respond to a Tx Hang
  * @netdev: network interface device structure
  **/
-static void i40evf_tx_timeout(struct net_device *netdev)
+static void iavf_tx_timeout(struct net_device *netdev)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	adapter->tx_timeout_count++;
-	i40evf_schedule_reset(adapter);
+	iavf_schedule_reset(adapter);
 }
 
 /**
- * i40evf_misc_irq_disable - Mask off interrupt generation on the NIC
+ * iavf_misc_irq_disable - Mask off interrupt generation on the NIC
  * @adapter: board private structure
  **/
-static void i40evf_misc_irq_disable(struct i40evf_adapter *adapter)
+static void iavf_misc_irq_disable(struct iavf_adapter *adapter)
 {
 	struct i40e_hw *hw = &adapter->hw;
 
@@ -205,10 +205,10 @@ static void i40evf_misc_irq_disable(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_misc_irq_enable - Enable default interrupt generation settings
+ * iavf_misc_irq_enable - Enable default interrupt generation settings
  * @adapter: board private structure
  **/
-static void i40evf_misc_irq_enable(struct i40evf_adapter *adapter)
+static void iavf_misc_irq_enable(struct iavf_adapter *adapter)
 {
 	struct i40e_hw *hw = &adapter->hw;
 
@@ -221,10 +221,10 @@ static void i40evf_misc_irq_enable(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_irq_disable - Mask off interrupt generation on the NIC
+ * iavf_irq_disable - Mask off interrupt generation on the NIC
  * @adapter: board private structure
  **/
-static void i40evf_irq_disable(struct i40evf_adapter *adapter)
+static void iavf_irq_disable(struct iavf_adapter *adapter)
 {
 	int i;
 	struct i40e_hw *hw = &adapter->hw;
@@ -241,11 +241,11 @@ static void i40evf_irq_disable(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_irq_enable_queues - Enable interrupt for specified queues
+ * iavf_irq_enable_queues - Enable interrupt for specified queues
  * @adapter: board private structure
  * @mask: bitmap of queues to enable
  **/
-void i40evf_irq_enable_queues(struct i40evf_adapter *adapter, u32 mask)
+void iavf_irq_enable_queues(struct iavf_adapter *adapter, u32 mask)
 {
 	struct i40e_hw *hw = &adapter->hw;
 	int i;
@@ -260,30 +260,30 @@ void i40evf_irq_enable_queues(struct i40evf_adapter *adapter, u32 mask)
 }
 
 /**
- * i40evf_irq_enable - Enable default interrupt generation settings
+ * iavf_irq_enable - Enable default interrupt generation settings
  * @adapter: board private structure
  * @flush: boolean value whether to run rd32()
  **/
-void i40evf_irq_enable(struct i40evf_adapter *adapter, bool flush)
+void iavf_irq_enable(struct iavf_adapter *adapter, bool flush)
 {
 	struct i40e_hw *hw = &adapter->hw;
 
-	i40evf_misc_irq_enable(adapter);
-	i40evf_irq_enable_queues(adapter, ~0);
+	iavf_misc_irq_enable(adapter);
+	iavf_irq_enable_queues(adapter, ~0);
 
 	if (flush)
 		rd32(hw, I40E_VFGEN_RSTAT);
 }
 
 /**
- * i40evf_msix_aq - Interrupt handler for vector 0
+ * iavf_msix_aq - Interrupt handler for vector 0
  * @irq: interrupt number
  * @data: pointer to netdev
  **/
-static irqreturn_t i40evf_msix_aq(int irq, void *data)
+static irqreturn_t iavf_msix_aq(int irq, void *data)
 {
 	struct net_device *netdev = data;
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	struct i40e_hw *hw = &adapter->hw;
 
 	/* handle non-queue interrupts, these reads clear the registers */
@@ -297,11 +297,11 @@ static irqreturn_t i40evf_msix_aq(int irq, void *data)
 }
 
 /**
- * i40evf_msix_clean_rings - MSIX mode Interrupt Handler
+ * iavf_msix_clean_rings - MSIX mode Interrupt Handler
  * @irq: interrupt number
  * @data: pointer to a q_vector
  **/
-static irqreturn_t i40evf_msix_clean_rings(int irq, void *data)
+static irqreturn_t iavf_msix_clean_rings(int irq, void *data)
 {
 	struct i40e_q_vector *q_vector = data;
 
@@ -314,13 +314,13 @@ static irqreturn_t i40evf_msix_clean_rings(int irq, void *data)
 }
 
 /**
- * i40evf_map_vector_to_rxq - associate irqs with rx queues
+ * iavf_map_vector_to_rxq - associate irqs with rx queues
  * @adapter: board private structure
  * @v_idx: interrupt number
  * @r_idx: queue number
  **/
 static void
-i40evf_map_vector_to_rxq(struct i40evf_adapter *adapter, int v_idx, int r_idx)
+iavf_map_vector_to_rxq(struct iavf_adapter *adapter, int v_idx, int r_idx)
 {
 	struct i40e_q_vector *q_vector = &adapter->q_vectors[v_idx];
 	struct i40e_ring *rx_ring = &adapter->rx_rings[r_idx];
@@ -340,13 +340,13 @@ i40evf_map_vector_to_rxq(struct i40evf_adapter *adapter, int v_idx, int r_idx)
 }
 
 /**
- * i40evf_map_vector_to_txq - associate irqs with tx queues
+ * iavf_map_vector_to_txq - associate irqs with tx queues
  * @adapter: board private structure
  * @v_idx: interrupt number
  * @t_idx: queue number
  **/
 static void
-i40evf_map_vector_to_txq(struct i40evf_adapter *adapter, int v_idx, int t_idx)
+iavf_map_vector_to_txq(struct iavf_adapter *adapter, int v_idx, int t_idx)
 {
 	struct i40e_q_vector *q_vector = &adapter->q_vectors[v_idx];
 	struct i40e_ring *tx_ring = &adapter->tx_rings[t_idx];
@@ -366,7 +366,7 @@ i40evf_map_vector_to_txq(struct i40evf_adapter *adapter, int v_idx, int t_idx)
 }
 
 /**
- * i40evf_map_rings_to_vectors - Maps descriptor rings to vectors
+ * iavf_map_rings_to_vectors - Maps descriptor rings to vectors
  * @adapter: board private structure to initialize
  *
  * This function maps descriptor rings to the queue-specific vectors
@@ -375,7 +375,7 @@ i40evf_map_vector_to_txq(struct i40evf_adapter *adapter, int v_idx, int t_idx)
  * group the rings as "efficiently" as possible.  You would add new
  * mapping configurations in here.
  **/
-static void i40evf_map_rings_to_vectors(struct i40evf_adapter *adapter)
+static void iavf_map_rings_to_vectors(struct iavf_adapter *adapter)
 {
 	int rings_remaining = adapter->num_active_queues;
 	int ridx = 0, vidx = 0;
@@ -384,8 +384,8 @@ static void i40evf_map_rings_to_vectors(struct i40evf_adapter *adapter)
 	q_vectors = adapter->num_msix_vectors - NONQ_VECS;
 
 	for (; ridx < rings_remaining; ridx++) {
-		i40evf_map_vector_to_rxq(adapter, vidx, ridx);
-		i40evf_map_vector_to_txq(adapter, vidx, ridx);
+		iavf_map_vector_to_rxq(adapter, vidx, ridx);
+		iavf_map_vector_to_txq(adapter, vidx, ridx);
 
 		/* In the case where we have more queues than vectors, continue
 		 * round-robin on vectors until all queues are mapped.
@@ -394,20 +394,20 @@ static void i40evf_map_rings_to_vectors(struct i40evf_adapter *adapter)
 			vidx = 0;
 	}
 
-	adapter->aq_required |= I40EVF_FLAG_AQ_MAP_VECTORS;
+	adapter->aq_required |= IAVF_FLAG_AQ_MAP_VECTORS;
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
 /**
- * i40evf_netpoll - A Polling 'interrupt' handler
+ * iavf_netpoll - A Polling 'interrupt' handler
  * @netdev: network interface device structure
  *
  * This is used by netconsole to send skbs without having to re-enable
  * interrupts.  It's not called while the normal interrupt routine is executing.
  **/
-static void i40evf_netpoll(struct net_device *netdev)
+static void iavf_netpoll(struct net_device *netdev)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	int q_vectors = adapter->num_msix_vectors - NONQ_VECS;
 	int i;
 
@@ -416,19 +416,19 @@ static void i40evf_netpoll(struct net_device *netdev)
 		return;
 
 	for (i = 0; i < q_vectors; i++)
-		i40evf_msix_clean_rings(0, &adapter->q_vectors[i]);
+		iavf_msix_clean_rings(0, &adapter->q_vectors[i]);
 }
 
 #endif
 /**
- * i40evf_irq_affinity_notify - Callback for affinity changes
+ * iavf_irq_affinity_notify - Callback for affinity changes
  * @notify: context as to what irq was changed
  * @mask: the new affinity mask
  *
  * This is a callback function used by the irq_set_affinity_notifier function
  * so that we may register to receive changes to the irq affinity masks.
  **/
-static void i40evf_irq_affinity_notify(struct irq_affinity_notify *notify,
+static void iavf_irq_affinity_notify(struct irq_affinity_notify *notify,
 				       const cpumask_t *mask)
 {
 	struct i40e_q_vector *q_vector =
@@ -438,17 +438,17 @@ static void i40evf_irq_affinity_notify(struct irq_affinity_notify *notify,
 }
 
 /**
- * i40evf_irq_affinity_release - Callback for affinity notifier release
+ * iavf_irq_affinity_release - Callback for affinity notifier release
  * @ref: internal core kernel usage
  *
  * This is a callback function used by the irq_set_affinity_notifier function
  * to inform the current notification subscriber that they will no longer
  * receive notifications.
  **/
-static void i40evf_irq_affinity_release(struct kref *ref) {}
+static void iavf_irq_affinity_release(struct kref *ref) {}
 
 /**
- * i40evf_request_traffic_irqs - Initialize MSI-X interrupts
+ * iavf_request_traffic_irqs - Initialize MSI-X interrupts
  * @adapter: board private structure
  * @basename: device basename
  *
@@ -456,14 +456,14 @@ static void i40evf_irq_affinity_release(struct kref *ref) {}
  * interrupts from the kernel.
  **/
 static int
-i40evf_request_traffic_irqs(struct i40evf_adapter *adapter, char *basename)
+iavf_request_traffic_irqs(struct iavf_adapter *adapter, char *basename)
 {
 	unsigned int vector, q_vectors;
 	unsigned int rx_int_idx = 0, tx_int_idx = 0;
 	int irq_num, err;
 	int cpu;
 
-	i40evf_irq_disable(adapter);
+	iavf_irq_disable(adapter);
 	/* Decrement for Other and TCP Timer vectors */
 	q_vectors = adapter->num_msix_vectors - NONQ_VECS;
 
@@ -473,20 +473,20 @@ i40evf_request_traffic_irqs(struct i40evf_adapter *adapter, char *basename)
 
 		if (q_vector->tx.ring && q_vector->rx.ring) {
 			snprintf(q_vector->name, sizeof(q_vector->name),
-				 "i40evf-%s-TxRx-%d", basename, rx_int_idx++);
+				 "iavf-%s-TxRx-%d", basename, rx_int_idx++);
 			tx_int_idx++;
 		} else if (q_vector->rx.ring) {
 			snprintf(q_vector->name, sizeof(q_vector->name),
-				 "i40evf-%s-rx-%d", basename, rx_int_idx++);
+				 "iavf-%s-rx-%d", basename, rx_int_idx++);
 		} else if (q_vector->tx.ring) {
 			snprintf(q_vector->name, sizeof(q_vector->name),
-				 "i40evf-%s-tx-%d", basename, tx_int_idx++);
+				 "iavf-%s-tx-%d", basename, tx_int_idx++);
 		} else {
 			/* skip this unused q_vector */
 			continue;
 		}
 		err = request_irq(irq_num,
-				  i40evf_msix_clean_rings,
+				  iavf_msix_clean_rings,
 				  0,
 				  q_vector->name,
 				  q_vector);
@@ -496,9 +496,9 @@ i40evf_request_traffic_irqs(struct i40evf_adapter *adapter, char *basename)
 			goto free_queue_irqs;
 		}
 		/* register for affinity change notifications */
-		q_vector->affinity_notify.notify = i40evf_irq_affinity_notify;
+		q_vector->affinity_notify.notify = iavf_irq_affinity_notify;
 		q_vector->affinity_notify.release =
-						   i40evf_irq_affinity_release;
+						   iavf_irq_affinity_release;
 		irq_set_affinity_notifier(irq_num, &q_vector->affinity_notify);
 		/* Spread the IRQ affinity hints across online CPUs. Note that
 		 * get_cpu_mask returns a mask with a permanent lifetime so
@@ -522,23 +522,23 @@ i40evf_request_traffic_irqs(struct i40evf_adapter *adapter, char *basename)
 }
 
 /**
- * i40evf_request_misc_irq - Initialize MSI-X interrupts
+ * iavf_request_misc_irq - Initialize MSI-X interrupts
  * @adapter: board private structure
  *
  * Allocates MSI-X vector 0 and requests interrupts from the kernel. This
  * vector is only for the admin queue, and stays active even when the netdev
  * is closed.
  **/
-static int i40evf_request_misc_irq(struct i40evf_adapter *adapter)
+static int iavf_request_misc_irq(struct iavf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	int err;
 
 	snprintf(adapter->misc_vector_name,
-		 sizeof(adapter->misc_vector_name) - 1, "i40evf-%s:mbx",
+		 sizeof(adapter->misc_vector_name) - 1, "iavf-%s:mbx",
 		 dev_name(&adapter->pdev->dev));
 	err = request_irq(adapter->msix_entries[0].vector,
-			  &i40evf_msix_aq, 0,
+			  &iavf_msix_aq, 0,
 			  adapter->misc_vector_name, netdev);
 	if (err) {
 		dev_err(&adapter->pdev->dev,
@@ -550,12 +550,12 @@ static int i40evf_request_misc_irq(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_free_traffic_irqs - Free MSI-X interrupts
+ * iavf_free_traffic_irqs - Free MSI-X interrupts
  * @adapter: board private structure
  *
  * Frees all MSI-X vectors other than 0.
  **/
-static void i40evf_free_traffic_irqs(struct i40evf_adapter *adapter)
+static void iavf_free_traffic_irqs(struct iavf_adapter *adapter)
 {
 	int vector, irq_num, q_vectors;
 
@@ -573,12 +573,12 @@ static void i40evf_free_traffic_irqs(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_free_misc_irq - Free MSI-X miscellaneous vector
+ * iavf_free_misc_irq - Free MSI-X miscellaneous vector
  * @adapter: board private structure
  *
  * Frees MSI-X vector 0.
  **/
-static void i40evf_free_misc_irq(struct i40evf_adapter *adapter)
+static void iavf_free_misc_irq(struct iavf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 
@@ -589,12 +589,12 @@ static void i40evf_free_misc_irq(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_configure_tx - Configure Transmit Unit after Reset
+ * iavf_configure_tx - Configure Transmit Unit after Reset
  * @adapter: board private structure
  *
  * Configure the Tx unit of the MAC after a reset.
  **/
-static void i40evf_configure_tx(struct i40evf_adapter *adapter)
+static void iavf_configure_tx(struct iavf_adapter *adapter)
 {
 	struct i40e_hw *hw = &adapter->hw;
 	int i;
@@ -604,12 +604,12 @@ static void i40evf_configure_tx(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_configure_rx - Configure Receive Unit after Reset
+ * iavf_configure_rx - Configure Receive Unit after Reset
  * @adapter: board private structure
  *
  * Configure the Rx unit of the MAC after a reset.
  **/
-static void i40evf_configure_rx(struct i40evf_adapter *adapter)
+static void iavf_configure_rx(struct iavf_adapter *adapter)
 {
 	unsigned int rx_buf_len = I40E_RXBUFFER_2048;
 	struct i40e_hw *hw = &adapter->hw;
@@ -617,7 +617,7 @@ static void i40evf_configure_rx(struct i40evf_adapter *adapter)
 
 	/* Legacy Rx will always default to a 2048 buffer size. */
 #if (PAGE_SIZE < 8192)
-	if (!(adapter->flags & I40EVF_FLAG_LEGACY_RX)) {
+	if (!(adapter->flags & IAVF_FLAG_LEGACY_RX)) {
 		struct net_device *netdev = adapter->netdev;
 
 		/* For jumbo frames on systems with 4K pages we have to use
@@ -640,7 +640,7 @@ static void i40evf_configure_rx(struct i40evf_adapter *adapter)
 		adapter->rx_rings[i].tail = hw->hw_addr + I40E_QRX_TAIL1(i);
 		adapter->rx_rings[i].rx_buf_len = rx_buf_len;
 
-		if (adapter->flags & I40EVF_FLAG_LEGACY_RX)
+		if (adapter->flags & IAVF_FLAG_LEGACY_RX)
 			clear_ring_build_skb_enabled(&adapter->rx_rings[i]);
 		else
 			set_ring_build_skb_enabled(&adapter->rx_rings[i]);
@@ -648,7 +648,7 @@ static void i40evf_configure_rx(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_find_vlan - Search filter list for specific vlan filter
+ * iavf_find_vlan - Search filter list for specific vlan filter
  * @adapter: board private structure
  * @vlan: vlan tag
  *
@@ -656,9 +656,9 @@ static void i40evf_configure_rx(struct i40evf_adapter *adapter)
  * mac_vlan_list_lock.
  **/
 static struct
-i40evf_vlan_filter *i40evf_find_vlan(struct i40evf_adapter *adapter, u16 vlan)
+iavf_vlan_filter *iavf_find_vlan(struct iavf_adapter *adapter, u16 vlan)
 {
-	struct i40evf_vlan_filter *f;
+	struct iavf_vlan_filter *f;
 
 	list_for_each_entry(f, &adapter->vlan_filter_list, list) {
 		if (vlan == f->vlan)
@@ -668,20 +668,20 @@ i40evf_vlan_filter *i40evf_find_vlan(struct i40evf_adapter *adapter, u16 vlan)
 }
 
 /**
- * i40evf_add_vlan - Add a vlan filter to the list
+ * iavf_add_vlan - Add a vlan filter to the list
  * @adapter: board private structure
  * @vlan: VLAN tag
  *
  * Returns ptr to the filter object or NULL when no memory available.
  **/
 static struct
-i40evf_vlan_filter *i40evf_add_vlan(struct i40evf_adapter *adapter, u16 vlan)
+iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter, u16 vlan)
 {
-	struct i40evf_vlan_filter *f = NULL;
+	struct iavf_vlan_filter *f = NULL;
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
-	f = i40evf_find_vlan(adapter, vlan);
+	f = iavf_find_vlan(adapter, vlan);
 	if (!f) {
 		f = kzalloc(sizeof(*f), GFP_KERNEL);
 		if (!f)
@@ -692,7 +692,7 @@ i40evf_vlan_filter *i40evf_add_vlan(struct i40evf_adapter *adapter, u16 vlan)
 		INIT_LIST_HEAD(&f->list);
 		list_add(&f->list, &adapter->vlan_filter_list);
 		f->add = true;
-		adapter->aq_required |= I40EVF_FLAG_AQ_ADD_VLAN_FILTER;
+		adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
 	}
 
 clearout:
@@ -701,63 +701,63 @@ i40evf_vlan_filter *i40evf_add_vlan(struct i40evf_adapter *adapter, u16 vlan)
 }
 
 /**
- * i40evf_del_vlan - Remove a vlan filter from the list
+ * iavf_del_vlan - Remove a vlan filter from the list
  * @adapter: board private structure
  * @vlan: VLAN tag
  **/
-static void i40evf_del_vlan(struct i40evf_adapter *adapter, u16 vlan)
+static void iavf_del_vlan(struct iavf_adapter *adapter, u16 vlan)
 {
-	struct i40evf_vlan_filter *f;
+	struct iavf_vlan_filter *f;
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
-	f = i40evf_find_vlan(adapter, vlan);
+	f = iavf_find_vlan(adapter, vlan);
 	if (f) {
 		f->remove = true;
-		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_VLAN_FILTER;
+		adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;
 	}
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 }
 
 /**
- * i40evf_vlan_rx_add_vid - Add a VLAN filter to a device
+ * iavf_vlan_rx_add_vid - Add a VLAN filter to a device
  * @netdev: network device struct
  * @proto: unused protocol data
  * @vid: VLAN tag
  **/
-static int i40evf_vlan_rx_add_vid(struct net_device *netdev,
+static int iavf_vlan_rx_add_vid(struct net_device *netdev,
 				  __always_unused __be16 proto, u16 vid)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	if (!VLAN_ALLOWED(adapter))
 		return -EIO;
-	if (i40evf_add_vlan(adapter, vid) == NULL)
+	if (iavf_add_vlan(adapter, vid) == NULL)
 		return -ENOMEM;
 	return 0;
 }
 
 /**
- * i40evf_vlan_rx_kill_vid - Remove a VLAN filter from a device
+ * iavf_vlan_rx_kill_vid - Remove a VLAN filter from a device
  * @netdev: network device struct
  * @proto: unused protocol data
  * @vid: VLAN tag
  **/
-static int i40evf_vlan_rx_kill_vid(struct net_device *netdev,
+static int iavf_vlan_rx_kill_vid(struct net_device *netdev,
 				   __always_unused __be16 proto, u16 vid)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	if (VLAN_ALLOWED(adapter)) {
-		i40evf_del_vlan(adapter, vid);
+		iavf_del_vlan(adapter, vid);
 		return 0;
 	}
 	return -EIO;
 }
 
 /**
- * i40evf_find_filter - Search filter list for specific mac filter
+ * iavf_find_filter - Search filter list for specific mac filter
  * @adapter: board private structure
  * @macaddr: the MAC address
  *
@@ -765,10 +765,10 @@ static int i40evf_vlan_rx_kill_vid(struct net_device *netdev,
  * mac_vlan_list_lock.
  **/
 static struct
-i40evf_mac_filter *i40evf_find_filter(struct i40evf_adapter *adapter,
+iavf_mac_filter *iavf_find_filter(struct iavf_adapter *adapter,
 				      const u8 *macaddr)
 {
-	struct i40evf_mac_filter *f;
+	struct iavf_mac_filter *f;
 
 	if (!macaddr)
 		return NULL;
@@ -788,15 +788,15 @@ i40evf_mac_filter *i40evf_find_filter(struct i40evf_adapter *adapter,
  * Returns ptr to the filter object or NULL when no memory available.
  **/
 static struct
-i40evf_mac_filter *i40evf_add_filter(struct i40evf_adapter *adapter,
+iavf_mac_filter *iavf_add_filter(struct iavf_adapter *adapter,
 				     const u8 *macaddr)
 {
-	struct i40evf_mac_filter *f;
+	struct iavf_mac_filter *f;
 
 	if (!macaddr)
 		return NULL;
 
-	f = i40evf_find_filter(adapter, macaddr);
+	f = iavf_find_filter(adapter, macaddr);
 	if (!f) {
 		f = kzalloc(sizeof(*f), GFP_ATOMIC);
 		if (!f)
@@ -806,7 +806,7 @@ i40evf_mac_filter *i40evf_add_filter(struct i40evf_adapter *adapter,
 
 		list_add_tail(&f->list, &adapter->mac_filter_list);
 		f->add = true;
-		adapter->aq_required |= I40EVF_FLAG_AQ_ADD_MAC_FILTER;
+		adapter->aq_required |= IAVF_FLAG_AQ_ADD_MAC_FILTER;
 	} else {
 		f->remove = false;
 	}
@@ -815,17 +815,17 @@ i40evf_mac_filter *i40evf_add_filter(struct i40evf_adapter *adapter,
 }
 
 /**
- * i40evf_set_mac - NDO callback to set port mac address
+ * iavf_set_mac - NDO callback to set port mac address
  * @netdev: network interface device structure
  * @p: pointer to an address structure
  *
  * Returns 0 on success, negative on failure
  **/
-static int i40evf_set_mac(struct net_device *netdev, void *p)
+static int iavf_set_mac(struct net_device *netdev, void *p)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	struct i40e_hw *hw = &adapter->hw;
-	struct i40evf_mac_filter *f;
+	struct iavf_mac_filter *f;
 	struct sockaddr *addr = p;
 
 	if (!is_valid_ether_addr(addr->sa_data))
@@ -834,18 +834,18 @@ static int i40evf_set_mac(struct net_device *netdev, void *p)
 	if (ether_addr_equal(netdev->dev_addr, addr->sa_data))
 		return 0;
 
-	if (adapter->flags & I40EVF_FLAG_ADDR_SET_BY_PF)
+	if (adapter->flags & IAVF_FLAG_ADDR_SET_BY_PF)
 		return -EPERM;
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
-	f = i40evf_find_filter(adapter, hw->mac.addr);
+	f = iavf_find_filter(adapter, hw->mac.addr);
 	if (f) {
 		f->remove = true;
-		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_MAC_FILTER;
+		adapter->aq_required |= IAVF_FLAG_AQ_DEL_MAC_FILTER;
 	}
 
-	f = i40evf_add_filter(adapter, addr->sa_data);
+	f = iavf_add_filter(adapter, addr->sa_data);
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
@@ -858,35 +858,35 @@ static int i40evf_set_mac(struct net_device *netdev, void *p)
 }
 
 /**
- * i40evf_addr_sync - Callback for dev_(mc|uc)_sync to add address
+ * iavf_addr_sync - Callback for dev_(mc|uc)_sync to add address
  * @netdev: the netdevice
  * @addr: address to add
  *
  * Called by __dev_(mc|uc)_sync when an address needs to be added. We call
  * __dev_(uc|mc)_sync from .set_rx_mode and guarantee to hold the hash lock.
  */
-static int i40evf_addr_sync(struct net_device *netdev, const u8 *addr)
+static int iavf_addr_sync(struct net_device *netdev, const u8 *addr)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
-	if (i40evf_add_filter(adapter, addr))
+	if (iavf_add_filter(adapter, addr))
 		return 0;
 	else
 		return -ENOMEM;
 }
 
 /**
- * i40evf_addr_unsync - Callback for dev_(mc|uc)_sync to remove address
+ * iavf_addr_unsync - Callback for dev_(mc|uc)_sync to remove address
  * @netdev: the netdevice
  * @addr: address to add
  *
  * Called by __dev_(mc|uc)_sync when an address needs to be removed. We call
  * __dev_(uc|mc)_sync from .set_rx_mode and guarantee to hold the hash lock.
  */
-static int i40evf_addr_unsync(struct net_device *netdev, const u8 *addr)
+static int iavf_addr_unsync(struct net_device *netdev, const u8 *addr)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
-	struct i40evf_mac_filter *f;
+	struct iavf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_mac_filter *f;
 
 	/* Under some circumstances, we might receive a request to delete
 	 * our own device address from our uc list. Because we store the
@@ -896,47 +896,47 @@ static int i40evf_addr_unsync(struct net_device *netdev, const u8 *addr)
 	if (ether_addr_equal(addr, netdev->dev_addr))
 		return 0;
 
-	f = i40evf_find_filter(adapter, addr);
+	f = iavf_find_filter(adapter, addr);
 	if (f) {
 		f->remove = true;
-		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_MAC_FILTER;
+		adapter->aq_required |= IAVF_FLAG_AQ_DEL_MAC_FILTER;
 	}
 	return 0;
 }
 
 /**
- * i40evf_set_rx_mode - NDO callback to set the netdev filters
+ * iavf_set_rx_mode - NDO callback to set the netdev filters
  * @netdev: network interface device structure
  **/
-static void i40evf_set_rx_mode(struct net_device *netdev)
+static void iavf_set_rx_mode(struct net_device *netdev)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
-	__dev_uc_sync(netdev, i40evf_addr_sync, i40evf_addr_unsync);
-	__dev_mc_sync(netdev, i40evf_addr_sync, i40evf_addr_unsync);
+	__dev_uc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
+	__dev_mc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
 	if (netdev->flags & IFF_PROMISC &&
-	    !(adapter->flags & I40EVF_FLAG_PROMISC_ON))
-		adapter->aq_required |= I40EVF_FLAG_AQ_REQUEST_PROMISC;
+	    !(adapter->flags & IAVF_FLAG_PROMISC_ON))
+		adapter->aq_required |= IAVF_FLAG_AQ_REQUEST_PROMISC;
 	else if (!(netdev->flags & IFF_PROMISC) &&
-		 adapter->flags & I40EVF_FLAG_PROMISC_ON)
-		adapter->aq_required |= I40EVF_FLAG_AQ_RELEASE_PROMISC;
+		 adapter->flags & IAVF_FLAG_PROMISC_ON)
+		adapter->aq_required |= IAVF_FLAG_AQ_RELEASE_PROMISC;
 
 	if (netdev->flags & IFF_ALLMULTI &&
-	    !(adapter->flags & I40EVF_FLAG_ALLMULTI_ON))
-		adapter->aq_required |= I40EVF_FLAG_AQ_REQUEST_ALLMULTI;
+	    !(adapter->flags & IAVF_FLAG_ALLMULTI_ON))
+		adapter->aq_required |= IAVF_FLAG_AQ_REQUEST_ALLMULTI;
 	else if (!(netdev->flags & IFF_ALLMULTI) &&
-		 adapter->flags & I40EVF_FLAG_ALLMULTI_ON)
-		adapter->aq_required |= I40EVF_FLAG_AQ_RELEASE_ALLMULTI;
+		 adapter->flags & IAVF_FLAG_ALLMULTI_ON)
+		adapter->aq_required |= IAVF_FLAG_AQ_RELEASE_ALLMULTI;
 }
 
 /**
- * i40evf_napi_enable_all - enable NAPI on all queue vectors
+ * iavf_napi_enable_all - enable NAPI on all queue vectors
  * @adapter: board private structure
  **/
-static void i40evf_napi_enable_all(struct i40evf_adapter *adapter)
+static void iavf_napi_enable_all(struct iavf_adapter *adapter)
 {
 	int q_idx;
 	struct i40e_q_vector *q_vector;
@@ -952,10 +952,10 @@ static void i40evf_napi_enable_all(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_napi_disable_all - disable NAPI on all queue vectors
+ * iavf_napi_disable_all - disable NAPI on all queue vectors
  * @adapter: board private structure
  **/
-static void i40evf_napi_disable_all(struct i40evf_adapter *adapter)
+static void iavf_napi_disable_all(struct iavf_adapter *adapter)
 {
 	int q_idx;
 	struct i40e_q_vector *q_vector;
@@ -968,43 +968,43 @@ static void i40evf_napi_disable_all(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_configure - set up transmit and receive data structures
+ * iavf_configure - set up transmit and receive data structures
  * @adapter: board private structure
  **/
-static void i40evf_configure(struct i40evf_adapter *adapter)
+static void iavf_configure(struct iavf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	int i;
 
-	i40evf_set_rx_mode(netdev);
+	iavf_set_rx_mode(netdev);
 
-	i40evf_configure_tx(adapter);
-	i40evf_configure_rx(adapter);
-	adapter->aq_required |= I40EVF_FLAG_AQ_CONFIGURE_QUEUES;
+	iavf_configure_tx(adapter);
+	iavf_configure_rx(adapter);
+	adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_QUEUES;
 
 	for (i = 0; i < adapter->num_active_queues; i++) {
 		struct i40e_ring *ring = &adapter->rx_rings[i];
 
-		i40evf_alloc_rx_buffers(ring, I40E_DESC_UNUSED(ring));
+		iavf_alloc_rx_buffers(ring, I40E_DESC_UNUSED(ring));
 	}
 }
 
 /**
- * i40evf_up_complete - Finish the last steps of bringing up a connection
+ * iavf_up_complete - Finish the last steps of bringing up a connection
  * @adapter: board private structure
  *
- * Expects to be called while holding the __I40EVF_IN_CRITICAL_TASK bit lock.
+ * Expects to be called while holding the __IAVF_IN_CRITICAL_TASK bit lock.
  **/
-static void i40evf_up_complete(struct i40evf_adapter *adapter)
+static void iavf_up_complete(struct iavf_adapter *adapter)
 {
-	adapter->state = __I40EVF_RUNNING;
+	adapter->state = __IAVF_RUNNING;
 	clear_bit(__I40E_VSI_DOWN, adapter->vsi.state);
 
-	i40evf_napi_enable_all(adapter);
+	iavf_napi_enable_all(adapter);
 
-	adapter->aq_required |= I40EVF_FLAG_AQ_ENABLE_QUEUES;
+	adapter->aq_required |= IAVF_FLAG_AQ_ENABLE_QUEUES;
 	if (CLIENT_ENABLED(adapter))
-		adapter->flags |= I40EVF_FLAG_CLIENT_NEEDS_OPEN;
+		adapter->flags |= IAVF_FLAG_CLIENT_NEEDS_OPEN;
 	mod_timer_pending(&adapter->watchdog_timer, jiffies + 1);
 }
 
@@ -1012,23 +1012,23 @@ static void i40evf_up_complete(struct i40evf_adapter *adapter)
  * i40e_down - Shutdown the connection processing
  * @adapter: board private structure
  *
- * Expects to be called while holding the __I40EVF_IN_CRITICAL_TASK bit lock.
+ * Expects to be called while holding the __IAVF_IN_CRITICAL_TASK bit lock.
  **/
-void i40evf_down(struct i40evf_adapter *adapter)
+void iavf_down(struct iavf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
-	struct i40evf_vlan_filter *vlf;
-	struct i40evf_mac_filter *f;
-	struct i40evf_cloud_filter *cf;
+	struct iavf_vlan_filter *vlf;
+	struct iavf_mac_filter *f;
+	struct iavf_cloud_filter *cf;
 
-	if (adapter->state <= __I40EVF_DOWN_PENDING)
+	if (adapter->state <= __IAVF_DOWN_PENDING)
 		return;
 
 	netif_carrier_off(netdev);
 	netif_tx_disable(netdev);
 	adapter->link_up = false;
-	i40evf_napi_disable_all(adapter);
-	i40evf_irq_disable(adapter);
+	iavf_napi_disable_all(adapter);
+	iavf_irq_disable(adapter);
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
@@ -1055,25 +1055,25 @@ void i40evf_down(struct i40evf_adapter *adapter)
 	}
 	spin_unlock_bh(&adapter->cloud_filter_list_lock);
 
-	if (!(adapter->flags & I40EVF_FLAG_PF_COMMS_FAILED) &&
-	    adapter->state != __I40EVF_RESETTING) {
+	if (!(adapter->flags & IAVF_FLAG_PF_COMMS_FAILED) &&
+	    adapter->state != __IAVF_RESETTING) {
 		/* cancel any current operation */
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		/* Schedule operations to close down the HW. Don't wait
 		 * here for this to complete. The watchdog is still running
 		 * and it will take care of this.
 		 */
-		adapter->aq_required = I40EVF_FLAG_AQ_DEL_MAC_FILTER;
-		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_VLAN_FILTER;
-		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_CLOUD_FILTER;
-		adapter->aq_required |= I40EVF_FLAG_AQ_DISABLE_QUEUES;
+		adapter->aq_required = IAVF_FLAG_AQ_DEL_MAC_FILTER;
+		adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;
+		adapter->aq_required |= IAVF_FLAG_AQ_DEL_CLOUD_FILTER;
+		adapter->aq_required |= IAVF_FLAG_AQ_DISABLE_QUEUES;
 	}
 
 	mod_timer_pending(&adapter->watchdog_timer, jiffies + 1);
 }
 
 /**
- * i40evf_acquire_msix_vectors - Setup the MSIX capability
+ * iavf_acquire_msix_vectors - Setup the MSIX capability
  * @adapter: board private structure
  * @vectors: number of vectors to request
  *
@@ -1082,7 +1082,7 @@ void i40evf_down(struct i40evf_adapter *adapter)
  * Returns 0 on success, negative on failure
  **/
 static int
-i40evf_acquire_msix_vectors(struct i40evf_adapter *adapter, int vectors)
+iavf_acquire_msix_vectors(struct iavf_adapter *adapter, int vectors)
 {
 	int err, vector_threshold;
 
@@ -1116,12 +1116,12 @@ i40evf_acquire_msix_vectors(struct i40evf_adapter *adapter, int vectors)
 }
 
 /**
- * i40evf_free_queues - Free memory for all rings
+ * iavf_free_queues - Free memory for all rings
  * @adapter: board private structure to initialize
  *
  * Free all of the memory associated with queue pairs.
  **/
-static void i40evf_free_queues(struct i40evf_adapter *adapter)
+static void iavf_free_queues(struct iavf_adapter *adapter)
 {
 	if (!adapter->vsi_res)
 		return;
@@ -1133,14 +1133,14 @@ static void i40evf_free_queues(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_alloc_queues - Allocate memory for all rings
+ * iavf_alloc_queues - Allocate memory for all rings
  * @adapter: board private structure to initialize
  *
  * We allocate one ring per queue at run-time since we don't know the
  * number of queues at compile-time.  The polling_netdev array is
  * intended for Multiqueue, but should work fine with a single queue.
  **/
-static int i40evf_alloc_queues(struct i40evf_adapter *adapter)
+static int iavf_alloc_queues(struct iavf_adapter *adapter)
 {
 	int i, num_active_queues;
 
@@ -1180,7 +1180,7 @@ static int i40evf_alloc_queues(struct i40evf_adapter *adapter)
 		tx_ring->dev = &adapter->pdev->dev;
 		tx_ring->count = adapter->tx_desc_count;
 		tx_ring->itr_setting = I40E_ITR_TX_DEF;
-		if (adapter->flags & I40EVF_FLAG_WB_ON_ITR_CAPABLE)
+		if (adapter->flags & IAVF_FLAG_WB_ON_ITR_CAPABLE)
 			tx_ring->flags |= I40E_TXR_FLAGS_WB_ON_ITR;
 
 		rx_ring = &adapter->rx_rings[i];
@@ -1196,18 +1196,18 @@ static int i40evf_alloc_queues(struct i40evf_adapter *adapter)
 	return 0;
 
 err_out:
-	i40evf_free_queues(adapter);
+	iavf_free_queues(adapter);
 	return -ENOMEM;
 }
 
 /**
- * i40evf_set_interrupt_capability - set MSI-X or FAIL if not supported
+ * iavf_set_interrupt_capability - set MSI-X or FAIL if not supported
  * @adapter: board private structure to initialize
  *
  * Attempt to configure the interrupts using the best available
  * capabilities of the hardware and the kernel.
  **/
-static int i40evf_set_interrupt_capability(struct i40evf_adapter *adapter)
+static int iavf_set_interrupt_capability(struct iavf_adapter *adapter)
 {
 	int vector, v_budget;
 	int pairs = 0;
@@ -1237,7 +1237,7 @@ static int i40evf_set_interrupt_capability(struct i40evf_adapter *adapter)
 	for (vector = 0; vector < v_budget; vector++)
 		adapter->msix_entries[vector].entry = vector;
 
-	err = i40evf_acquire_msix_vectors(adapter, v_budget);
+	err = iavf_acquire_msix_vectors(adapter, v_budget);
 
 out:
 	netif_set_real_num_rx_queues(adapter->netdev, pairs);
@@ -1251,7 +1251,7 @@ static int i40evf_set_interrupt_capability(struct i40evf_adapter *adapter)
  *
  * Return 0 on success, negative on failure
  **/
-static int i40evf_config_rss_aq(struct i40evf_adapter *adapter)
+static int iavf_config_rss_aq(struct iavf_adapter *adapter)
 {
 	struct i40e_aqc_get_set_rss_key_data *rss_key =
 		(struct i40e_aqc_get_set_rss_key_data *)adapter->rss_key;
@@ -1265,21 +1265,21 @@ static int i40evf_config_rss_aq(struct i40evf_adapter *adapter)
 		return -EBUSY;
 	}
 
-	ret = i40evf_aq_set_rss_key(hw, adapter->vsi.id, rss_key);
+	ret = iavf_aq_set_rss_key(hw, adapter->vsi.id, rss_key);
 	if (ret) {
 		dev_err(&adapter->pdev->dev, "Cannot set RSS key, err %s aq_err %s\n",
-			i40evf_stat_str(hw, ret),
-			i40evf_aq_str(hw, hw->aq.asq_last_status));
+			iavf_stat_str(hw, ret),
+			iavf_aq_str(hw, hw->aq.asq_last_status));
 		return ret;
 
 	}
 
-	ret = i40evf_aq_set_rss_lut(hw, adapter->vsi.id, false,
+	ret = iavf_aq_set_rss_lut(hw, adapter->vsi.id, false,
 				    adapter->rss_lut, adapter->rss_lut_size);
 	if (ret) {
 		dev_err(&adapter->pdev->dev, "Cannot set RSS lut, err %s aq_err %s\n",
-			i40evf_stat_str(hw, ret),
-			i40evf_aq_str(hw, hw->aq.asq_last_status));
+			iavf_stat_str(hw, ret),
+			iavf_aq_str(hw, hw->aq.asq_last_status));
 	}
 
 	return ret;
@@ -1287,12 +1287,12 @@ static int i40evf_config_rss_aq(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_config_rss_reg - Configure RSS keys and lut by writing registers
+ * iavf_config_rss_reg - Configure RSS keys and lut by writing registers
  * @adapter: board private structure
  *
  * Returns 0 on success, negative on failure
  **/
-static int i40evf_config_rss_reg(struct i40evf_adapter *adapter)
+static int iavf_config_rss_reg(struct iavf_adapter *adapter)
 {
 	struct i40e_hw *hw = &adapter->hw;
 	u32 *dw;
@@ -1312,30 +1312,30 @@ static int i40evf_config_rss_reg(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_config_rss - Configure RSS keys and lut
+ * iavf_config_rss - Configure RSS keys and lut
  * @adapter: board private structure
  *
  * Returns 0 on success, negative on failure
  **/
-int i40evf_config_rss(struct i40evf_adapter *adapter)
+int iavf_config_rss(struct iavf_adapter *adapter)
 {
 
 	if (RSS_PF(adapter)) {
-		adapter->aq_required |= I40EVF_FLAG_AQ_SET_RSS_LUT |
-					I40EVF_FLAG_AQ_SET_RSS_KEY;
+		adapter->aq_required |= IAVF_FLAG_AQ_SET_RSS_LUT |
+					IAVF_FLAG_AQ_SET_RSS_KEY;
 		return 0;
 	} else if (RSS_AQ(adapter)) {
-		return i40evf_config_rss_aq(adapter);
+		return iavf_config_rss_aq(adapter);
 	} else {
-		return i40evf_config_rss_reg(adapter);
+		return iavf_config_rss_reg(adapter);
 	}
 }
 
 /**
- * i40evf_fill_rss_lut - Fill the lut with default values
+ * iavf_fill_rss_lut - Fill the lut with default values
  * @adapter: board private structure
  **/
-static void i40evf_fill_rss_lut(struct i40evf_adapter *adapter)
+static void iavf_fill_rss_lut(struct iavf_adapter *adapter)
 {
 	u16 i;
 
@@ -1344,12 +1344,12 @@ static void i40evf_fill_rss_lut(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_init_rss - Prepare for RSS
+ * iavf_init_rss - Prepare for RSS
  * @adapter: board private structure
  *
  * Return 0 on success, negative on failure
  **/
-static int i40evf_init_rss(struct i40evf_adapter *adapter)
+static int iavf_init_rss(struct iavf_adapter *adapter)
 {
 	struct i40e_hw *hw = &adapter->hw;
 	int ret;
@@ -1366,22 +1366,22 @@ static int i40evf_init_rss(struct i40evf_adapter *adapter)
 		wr32(hw, I40E_VFQF_HENA(1), (u32)(adapter->hena >> 32));
 	}
 
-	i40evf_fill_rss_lut(adapter);
+	iavf_fill_rss_lut(adapter);
 
 	netdev_rss_key_fill((void *)adapter->rss_key, adapter->rss_key_size);
-	ret = i40evf_config_rss(adapter);
+	ret = iavf_config_rss(adapter);
 
 	return ret;
 }
 
 /**
- * i40evf_alloc_q_vectors - Allocate memory for interrupt vectors
+ * iavf_alloc_q_vectors - Allocate memory for interrupt vectors
  * @adapter: board private structure to initialize
  *
  * We allocate one q_vector per queue interrupt.  If allocation fails we
  * return -ENOMEM.
  **/
-static int i40evf_alloc_q_vectors(struct i40evf_adapter *adapter)
+static int iavf_alloc_q_vectors(struct iavf_adapter *adapter)
 {
 	int q_idx = 0, num_q_vectors;
 	struct i40e_q_vector *q_vector;
@@ -1400,21 +1400,21 @@ static int i40evf_alloc_q_vectors(struct i40evf_adapter *adapter)
 		q_vector->reg_idx = q_idx;
 		cpumask_copy(&q_vector->affinity_mask, cpu_possible_mask);
 		netif_napi_add(adapter->netdev, &q_vector->napi,
-			       i40evf_napi_poll, NAPI_POLL_WEIGHT);
+			       iavf_napi_poll, NAPI_POLL_WEIGHT);
 	}
 
 	return 0;
 }
 
 /**
- * i40evf_free_q_vectors - Free memory allocated for interrupt vectors
+ * iavf_free_q_vectors - Free memory allocated for interrupt vectors
  * @adapter: board private structure to initialize
  *
  * This function frees the memory allocated to the q_vectors.  In addition if
  * NAPI is enabled it will delete any references to the NAPI struct prior
  * to freeing the q_vector.
  **/
-static void i40evf_free_q_vectors(struct i40evf_adapter *adapter)
+static void iavf_free_q_vectors(struct iavf_adapter *adapter)
 {
 	int q_idx, num_q_vectors;
 	int napi_vectors;
@@ -1435,11 +1435,11 @@ static void i40evf_free_q_vectors(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_reset_interrupt_capability - Reset MSIX setup
+ * iavf_reset_interrupt_capability - Reset MSIX setup
  * @adapter: board private structure
  *
  **/
-void i40evf_reset_interrupt_capability(struct i40evf_adapter *adapter)
+void iavf_reset_interrupt_capability(struct iavf_adapter *adapter)
 {
 	if (!adapter->msix_entries)
 		return;
@@ -1450,15 +1450,15 @@ void i40evf_reset_interrupt_capability(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_init_interrupt_scheme - Determine if MSIX is supported and init
+ * iavf_init_interrupt_scheme - Determine if MSIX is supported and init
  * @adapter: board private structure to initialize
  *
  **/
-int i40evf_init_interrupt_scheme(struct i40evf_adapter *adapter)
+int iavf_init_interrupt_scheme(struct iavf_adapter *adapter)
 {
 	int err;
 
-	err = i40evf_alloc_queues(adapter);
+	err = iavf_alloc_queues(adapter);
 	if (err) {
 		dev_err(&adapter->pdev->dev,
 			"Unable to allocate memory for queues\n");
@@ -1466,7 +1466,7 @@ int i40evf_init_interrupt_scheme(struct i40evf_adapter *adapter)
 	}
 
 	rtnl_lock();
-	err = i40evf_set_interrupt_capability(adapter);
+	err = iavf_set_interrupt_capability(adapter);
 	rtnl_unlock();
 	if (err) {
 		dev_err(&adapter->pdev->dev,
@@ -1474,7 +1474,7 @@ int i40evf_init_interrupt_scheme(struct i40evf_adapter *adapter)
 		goto err_set_interrupt;
 	}
 
-	err = i40evf_alloc_q_vectors(adapter);
+	err = iavf_alloc_q_vectors(adapter);
 	if (err) {
 		dev_err(&adapter->pdev->dev,
 			"Unable to allocate memory for queue vectors\n");
@@ -1497,18 +1497,18 @@ int i40evf_init_interrupt_scheme(struct i40evf_adapter *adapter)
 
 	return 0;
 err_alloc_q_vectors:
-	i40evf_reset_interrupt_capability(adapter);
+	iavf_reset_interrupt_capability(adapter);
 err_set_interrupt:
-	i40evf_free_queues(adapter);
+	iavf_free_queues(adapter);
 err_alloc_queues:
 	return err;
 }
 
 /**
- * i40evf_free_rss - Free memory used by RSS structs
+ * iavf_free_rss - Free memory used by RSS structs
  * @adapter: board private structure
  **/
-static void i40evf_free_rss(struct i40evf_adapter *adapter)
+static void iavf_free_rss(struct iavf_adapter *adapter)
 {
 	kfree(adapter->rss_key);
 	adapter->rss_key = NULL;
@@ -1518,52 +1518,52 @@ static void i40evf_free_rss(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_reinit_interrupt_scheme - Reallocate queues and vectors
+ * iavf_reinit_interrupt_scheme - Reallocate queues and vectors
  * @adapter: board private structure
  *
  * Returns 0 on success, negative on failure
  **/
-static int i40evf_reinit_interrupt_scheme(struct i40evf_adapter *adapter)
+static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	int err;
 
 	if (netif_running(netdev))
-		i40evf_free_traffic_irqs(adapter);
-	i40evf_free_misc_irq(adapter);
-	i40evf_reset_interrupt_capability(adapter);
-	i40evf_free_q_vectors(adapter);
-	i40evf_free_queues(adapter);
+		iavf_free_traffic_irqs(adapter);
+	iavf_free_misc_irq(adapter);
+	iavf_reset_interrupt_capability(adapter);
+	iavf_free_q_vectors(adapter);
+	iavf_free_queues(adapter);
 
-	err =  i40evf_init_interrupt_scheme(adapter);
+	err =  iavf_init_interrupt_scheme(adapter);
 	if (err)
 		goto err;
 
 	netif_tx_stop_all_queues(netdev);
 
-	err = i40evf_request_misc_irq(adapter);
+	err = iavf_request_misc_irq(adapter);
 	if (err)
 		goto err;
 
 	set_bit(__I40E_VSI_DOWN, adapter->vsi.state);
 
-	i40evf_map_rings_to_vectors(adapter);
+	iavf_map_rings_to_vectors(adapter);
 
 	if (RSS_AQ(adapter))
-		adapter->aq_required |= I40EVF_FLAG_AQ_CONFIGURE_RSS;
+		adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_RSS;
 	else
-		err = i40evf_init_rss(adapter);
+		err = iavf_init_rss(adapter);
 err:
 	return err;
 }
 
 /**
- * i40evf_watchdog_timer - Periodic call-back timer
+ * iavf_watchdog_timer - Periodic call-back timer
  * @data: pointer to adapter disguised as unsigned long
  **/
-static void i40evf_watchdog_timer(struct timer_list *t)
+static void iavf_watchdog_timer(struct timer_list *t)
 {
-	struct i40evf_adapter *adapter = from_timer(adapter, t,
+	struct iavf_adapter *adapter = from_timer(adapter, t,
 						    watchdog_timer);
 
 	schedule_work(&adapter->watchdog_task);
@@ -1571,31 +1571,31 @@ static void i40evf_watchdog_timer(struct timer_list *t)
 }
 
 /**
- * i40evf_watchdog_task - Periodic call-back task
+ * iavf_watchdog_task - Periodic call-back task
  * @work: pointer to work_struct
  **/
-static void i40evf_watchdog_task(struct work_struct *work)
+static void iavf_watchdog_task(struct work_struct *work)
 {
-	struct i40evf_adapter *adapter = container_of(work,
-						      struct i40evf_adapter,
+	struct iavf_adapter *adapter = container_of(work,
+						      struct iavf_adapter,
 						      watchdog_task);
 	struct i40e_hw *hw = &adapter->hw;
 	u32 reg_val;
 
-	if (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section))
+	if (test_and_set_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section))
 		goto restart_watchdog;
 
-	if (adapter->flags & I40EVF_FLAG_PF_COMMS_FAILED) {
+	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED) {
 		reg_val = rd32(hw, I40E_VFGEN_RSTAT) &
 			  I40E_VFGEN_RSTAT_VFR_STATE_MASK;
 		if ((reg_val == VIRTCHNL_VFR_VFACTIVE) ||
 		    (reg_val == VIRTCHNL_VFR_COMPLETED)) {
 			/* A chance for redemption! */
 			dev_err(&adapter->pdev->dev, "Hardware came out of reset. Attempting reinit.\n");
-			adapter->state = __I40EVF_STARTUP;
-			adapter->flags &= ~I40EVF_FLAG_PF_COMMS_FAILED;
+			adapter->state = __IAVF_STARTUP;
+			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
 			schedule_delayed_work(&adapter->init_task, 10);
-			clear_bit(__I40EVF_IN_CRITICAL_TASK,
+			clear_bit(__IAVF_IN_CRITICAL_TASK,
 				  &adapter->crit_section);
 			/* Don't reschedule the watchdog, since we've restarted
 			 * the init task. When init_task contacts the PF and
@@ -1609,15 +1609,15 @@ static void i40evf_watchdog_task(struct work_struct *work)
 		goto watchdog_done;
 	}
 
-	if ((adapter->state < __I40EVF_DOWN) ||
-	    (adapter->flags & I40EVF_FLAG_RESET_PENDING))
+	if ((adapter->state < __IAVF_DOWN) ||
+	    (adapter->flags & IAVF_FLAG_RESET_PENDING))
 		goto watchdog_done;
 
 	/* check for reset */
 	reg_val = rd32(hw, I40E_VF_ARQLEN1) & I40E_VF_ARQLEN1_ARQENABLE_MASK;
-	if (!(adapter->flags & I40EVF_FLAG_RESET_PENDING) && !reg_val) {
-		adapter->state = __I40EVF_RESETTING;
-		adapter->flags |= I40EVF_FLAG_RESET_PENDING;
+	if (!(adapter->flags & IAVF_FLAG_RESET_PENDING) && !reg_val) {
+		adapter->state = __IAVF_RESETTING;
+		adapter->flags |= IAVF_FLAG_RESET_PENDING;
 		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
 		schedule_work(&adapter->reset_task);
 		adapter->aq_required = 0;
@@ -1629,140 +1629,140 @@ static void i40evf_watchdog_task(struct work_struct *work)
 	 * here so we don't race on the admin queue.
 	 */
 	if (adapter->current_op) {
-		if (!i40evf_asq_done(hw)) {
+		if (!iavf_asq_done(hw)) {
 			dev_dbg(&adapter->pdev->dev, "Admin queue timeout\n");
-			i40evf_send_api_ver(adapter);
+			iavf_send_api_ver(adapter);
 		}
 		goto watchdog_done;
 	}
-	if (adapter->aq_required & I40EVF_FLAG_AQ_GET_CONFIG) {
-		i40evf_send_vf_config_msg(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_GET_CONFIG) {
+		iavf_send_vf_config_msg(adapter);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_DISABLE_QUEUES) {
-		i40evf_disable_queues(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_DISABLE_QUEUES) {
+		iavf_disable_queues(adapter);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_MAP_VECTORS) {
-		i40evf_map_queues(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_MAP_VECTORS) {
+		iavf_map_queues(adapter);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_ADD_MAC_FILTER) {
-		i40evf_add_ether_addrs(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_ADD_MAC_FILTER) {
+		iavf_add_ether_addrs(adapter);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_ADD_VLAN_FILTER) {
-		i40evf_add_vlans(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_ADD_VLAN_FILTER) {
+		iavf_add_vlans(adapter);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_DEL_MAC_FILTER) {
-		i40evf_del_ether_addrs(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_DEL_MAC_FILTER) {
+		iavf_del_ether_addrs(adapter);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_DEL_VLAN_FILTER) {
-		i40evf_del_vlans(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_DEL_VLAN_FILTER) {
+		iavf_del_vlans(adapter);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_ENABLE_VLAN_STRIPPING) {
-		i40evf_enable_vlan_stripping(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_ENABLE_VLAN_STRIPPING) {
+		iavf_enable_vlan_stripping(adapter);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_DISABLE_VLAN_STRIPPING) {
-		i40evf_disable_vlan_stripping(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_DISABLE_VLAN_STRIPPING) {
+		iavf_disable_vlan_stripping(adapter);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_CONFIGURE_QUEUES) {
-		i40evf_configure_queues(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_CONFIGURE_QUEUES) {
+		iavf_configure_queues(adapter);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_ENABLE_QUEUES) {
-		i40evf_enable_queues(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_ENABLE_QUEUES) {
+		iavf_enable_queues(adapter);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_CONFIGURE_RSS) {
+	if (adapter->aq_required & IAVF_FLAG_AQ_CONFIGURE_RSS) {
 		/* This message goes straight to the firmware, not the
 		 * PF, so we don't have to set current_op as we will
 		 * not get a response through the ARQ.
 		 */
-		i40evf_init_rss(adapter);
-		adapter->aq_required &= ~I40EVF_FLAG_AQ_CONFIGURE_RSS;
+		iavf_init_rss(adapter);
+		adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_RSS;
 		goto watchdog_done;
 	}
-	if (adapter->aq_required & I40EVF_FLAG_AQ_GET_HENA) {
-		i40evf_get_hena(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_GET_HENA) {
+		iavf_get_hena(adapter);
 		goto watchdog_done;
 	}
-	if (adapter->aq_required & I40EVF_FLAG_AQ_SET_HENA) {
-		i40evf_set_hena(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_SET_HENA) {
+		iavf_set_hena(adapter);
 		goto watchdog_done;
 	}
-	if (adapter->aq_required & I40EVF_FLAG_AQ_SET_RSS_KEY) {
-		i40evf_set_rss_key(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_SET_RSS_KEY) {
+		iavf_set_rss_key(adapter);
 		goto watchdog_done;
 	}
-	if (adapter->aq_required & I40EVF_FLAG_AQ_SET_RSS_LUT) {
-		i40evf_set_rss_lut(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_SET_RSS_LUT) {
+		iavf_set_rss_lut(adapter);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_REQUEST_PROMISC) {
-		i40evf_set_promiscuous(adapter, FLAG_VF_UNICAST_PROMISC |
+	if (adapter->aq_required & IAVF_FLAG_AQ_REQUEST_PROMISC) {
+		iavf_set_promiscuous(adapter, FLAG_VF_UNICAST_PROMISC |
 				       FLAG_VF_MULTICAST_PROMISC);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_REQUEST_ALLMULTI) {
-		i40evf_set_promiscuous(adapter, FLAG_VF_MULTICAST_PROMISC);
+	if (adapter->aq_required & IAVF_FLAG_AQ_REQUEST_ALLMULTI) {
+		iavf_set_promiscuous(adapter, FLAG_VF_MULTICAST_PROMISC);
 		goto watchdog_done;
 	}
 
-	if ((adapter->aq_required & I40EVF_FLAG_AQ_RELEASE_PROMISC) &&
-	    (adapter->aq_required & I40EVF_FLAG_AQ_RELEASE_ALLMULTI)) {
-		i40evf_set_promiscuous(adapter, 0);
+	if ((adapter->aq_required & IAVF_FLAG_AQ_RELEASE_PROMISC) &&
+	    (adapter->aq_required & IAVF_FLAG_AQ_RELEASE_ALLMULTI)) {
+		iavf_set_promiscuous(adapter, 0);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_ENABLE_CHANNELS) {
-		i40evf_enable_channels(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_ENABLE_CHANNELS) {
+		iavf_enable_channels(adapter);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_DISABLE_CHANNELS) {
-		i40evf_disable_channels(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_DISABLE_CHANNELS) {
+		iavf_disable_channels(adapter);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_ADD_CLOUD_FILTER) {
-		i40evf_add_cloud_filter(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_ADD_CLOUD_FILTER) {
+		iavf_add_cloud_filter(adapter);
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_DEL_CLOUD_FILTER) {
-		i40evf_del_cloud_filter(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_DEL_CLOUD_FILTER) {
+		iavf_del_cloud_filter(adapter);
 		goto watchdog_done;
 	}
 
 	schedule_delayed_work(&adapter->client_task, msecs_to_jiffies(5));
 
-	if (adapter->state == __I40EVF_RUNNING)
-		i40evf_request_stats(adapter);
+	if (adapter->state == __IAVF_RUNNING)
+		iavf_request_stats(adapter);
 watchdog_done:
-	if (adapter->state == __I40EVF_RUNNING)
-		i40evf_detect_recover_hung(&adapter->vsi);
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+	if (adapter->state == __IAVF_RUNNING)
+		iavf_detect_recover_hung(&adapter->vsi);
+	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
 restart_watchdog:
-	if (adapter->state == __I40EVF_REMOVE)
+	if (adapter->state == __IAVF_REMOVE)
 		return;
 	if (adapter->aq_required)
 		mod_timer(&adapter->watchdog_timer,
@@ -1772,28 +1772,28 @@ static void i40evf_watchdog_task(struct work_struct *work)
 	schedule_work(&adapter->adminq_task);
 }
 
-static void i40evf_disable_vf(struct i40evf_adapter *adapter)
+static void iavf_disable_vf(struct iavf_adapter *adapter)
 {
-	struct i40evf_mac_filter *f, *ftmp;
-	struct i40evf_vlan_filter *fv, *fvtmp;
-	struct i40evf_cloud_filter *cf, *cftmp;
+	struct iavf_mac_filter *f, *ftmp;
+	struct iavf_vlan_filter *fv, *fvtmp;
+	struct iavf_cloud_filter *cf, *cftmp;
 
-	adapter->flags |= I40EVF_FLAG_PF_COMMS_FAILED;
+	adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
 
 	/* We don't use netif_running() because it may be true prior to
 	 * ndo_open() returning, so we can't assume it means all our open
 	 * tasks have finished, since we're not holding the rtnl_lock here.
 	 */
-	if (adapter->state == __I40EVF_RUNNING) {
+	if (adapter->state == __IAVF_RUNNING) {
 		set_bit(__I40E_VSI_DOWN, adapter->vsi.state);
 		netif_carrier_off(adapter->netdev);
 		netif_tx_disable(adapter->netdev);
 		adapter->link_up = false;
-		i40evf_napi_disable_all(adapter);
-		i40evf_irq_disable(adapter);
-		i40evf_free_traffic_irqs(adapter);
-		i40evf_free_all_tx_resources(adapter);
-		i40evf_free_all_rx_resources(adapter);
+		iavf_napi_disable_all(adapter);
+		iavf_irq_disable(adapter);
+		iavf_free_traffic_irqs(adapter);
+		iavf_free_all_tx_resources(adapter);
+		iavf_free_all_rx_resources(adapter);
 	}
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
@@ -1819,41 +1819,41 @@ static void i40evf_disable_vf(struct i40evf_adapter *adapter)
 	}
 	spin_unlock_bh(&adapter->cloud_filter_list_lock);
 
-	i40evf_free_misc_irq(adapter);
-	i40evf_reset_interrupt_capability(adapter);
-	i40evf_free_queues(adapter);
-	i40evf_free_q_vectors(adapter);
+	iavf_free_misc_irq(adapter);
+	iavf_reset_interrupt_capability(adapter);
+	iavf_free_queues(adapter);
+	iavf_free_q_vectors(adapter);
 	kfree(adapter->vf_res);
-	i40evf_shutdown_adminq(&adapter->hw);
+	iavf_shutdown_adminq(&adapter->hw);
 	adapter->netdev->flags &= ~IFF_UP;
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
-	adapter->flags &= ~I40EVF_FLAG_RESET_PENDING;
-	adapter->state = __I40EVF_DOWN;
+	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
+	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
+	adapter->state = __IAVF_DOWN;
 	wake_up(&adapter->down_waitqueue);
 	dev_info(&adapter->pdev->dev, "Reset task did not complete, VF disabled\n");
 }
 
-#define I40EVF_RESET_WAIT_MS 10
-#define I40EVF_RESET_WAIT_COUNT 500
+#define IAVF_RESET_WAIT_MS 10
+#define IAVF_RESET_WAIT_COUNT 500
 /**
- * i40evf_reset_task - Call-back task to handle hardware reset
+ * iavf_reset_task - Call-back task to handle hardware reset
  * @work: pointer to work_struct
  *
  * During reset we need to shut down and reinitialize the admin queue
  * before we can use it to communicate with the PF again. We also clear
  * and reinit the rings because that context is lost as well.
  **/
-static void i40evf_reset_task(struct work_struct *work)
+static void iavf_reset_task(struct work_struct *work)
 {
-	struct i40evf_adapter *adapter = container_of(work,
-						      struct i40evf_adapter,
+	struct iavf_adapter *adapter = container_of(work,
+						      struct iavf_adapter,
 						      reset_task);
 	struct virtchnl_vf_resource *vfres = adapter->vf_res;
 	struct net_device *netdev = adapter->netdev;
 	struct i40e_hw *hw = &adapter->hw;
-	struct i40evf_vlan_filter *vlf;
-	struct i40evf_cloud_filter *cf;
-	struct i40evf_mac_filter *f;
+	struct iavf_vlan_filter *vlf;
+	struct iavf_cloud_filter *cf;
+	struct iavf_mac_filter *f;
 	u32 reg_val;
 	int i = 0, err;
 	bool running;
@@ -1861,49 +1861,49 @@ static void i40evf_reset_task(struct work_struct *work)
 	/* When device is being removed it doesn't make sense to run the reset
 	 * task, just return in such a case.
 	 */
-	if (test_bit(__I40EVF_IN_REMOVE_TASK, &adapter->crit_section))
+	if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
 		return;
 
-	while (test_and_set_bit(__I40EVF_IN_CLIENT_TASK,
+	while (test_and_set_bit(__IAVF_IN_CLIENT_TASK,
 				&adapter->crit_section))
 		usleep_range(500, 1000);
 	if (CLIENT_ENABLED(adapter)) {
-		adapter->flags &= ~(I40EVF_FLAG_CLIENT_NEEDS_OPEN |
-				    I40EVF_FLAG_CLIENT_NEEDS_CLOSE |
-				    I40EVF_FLAG_CLIENT_NEEDS_L2_PARAMS |
-				    I40EVF_FLAG_SERVICE_CLIENT_REQUESTED);
+		adapter->flags &= ~(IAVF_FLAG_CLIENT_NEEDS_OPEN |
+				    IAVF_FLAG_CLIENT_NEEDS_CLOSE |
+				    IAVF_FLAG_CLIENT_NEEDS_L2_PARAMS |
+				    IAVF_FLAG_SERVICE_CLIENT_REQUESTED);
 		cancel_delayed_work_sync(&adapter->client_task);
-		i40evf_notify_client_close(&adapter->vsi, true);
+		iavf_notify_client_close(&adapter->vsi, true);
 	}
-	i40evf_misc_irq_disable(adapter);
-	if (adapter->flags & I40EVF_FLAG_RESET_NEEDED) {
-		adapter->flags &= ~I40EVF_FLAG_RESET_NEEDED;
+	iavf_misc_irq_disable(adapter);
+	if (adapter->flags & IAVF_FLAG_RESET_NEEDED) {
+		adapter->flags &= ~IAVF_FLAG_RESET_NEEDED;
 		/* Restart the AQ here. If we have been reset but didn't
 		 * detect it, or if the PF had to reinit, our AQ will be hosed.
 		 */
-		i40evf_shutdown_adminq(hw);
-		i40evf_init_adminq(hw);
-		i40evf_request_reset(adapter);
+		iavf_shutdown_adminq(hw);
+		iavf_init_adminq(hw);
+		iavf_request_reset(adapter);
 	}
-	adapter->flags |= I40EVF_FLAG_RESET_PENDING;
+	adapter->flags |= IAVF_FLAG_RESET_PENDING;
 
 	/* poll until we see the reset actually happen */
-	for (i = 0; i < I40EVF_RESET_WAIT_COUNT; i++) {
+	for (i = 0; i < IAVF_RESET_WAIT_COUNT; i++) {
 		reg_val = rd32(hw, I40E_VF_ARQLEN1) &
 			  I40E_VF_ARQLEN1_ARQENABLE_MASK;
 		if (!reg_val)
 			break;
 		usleep_range(5000, 10000);
 	}
-	if (i == I40EVF_RESET_WAIT_COUNT) {
+	if (i == IAVF_RESET_WAIT_COUNT) {
 		dev_info(&adapter->pdev->dev, "Never saw reset\n");
 		goto continue_reset; /* act like the reset happened */
 	}
 
 	/* wait until the reset is complete and the PF is responding to us */
-	for (i = 0; i < I40EVF_RESET_WAIT_COUNT; i++) {
+	for (i = 0; i < IAVF_RESET_WAIT_COUNT; i++) {
 		/* sleep first to make sure a minimum wait time is met */
-		msleep(I40EVF_RESET_WAIT_MS);
+		msleep(IAVF_RESET_WAIT_MS);
 
 		reg_val = rd32(hw, I40E_VFGEN_RSTAT) &
 			  I40E_VFGEN_RSTAT_VFR_STATE_MASK;
@@ -1913,11 +1913,11 @@ static void i40evf_reset_task(struct work_struct *work)
 
 	pci_set_master(adapter->pdev);
 
-	if (i == I40EVF_RESET_WAIT_COUNT) {
+	if (i == IAVF_RESET_WAIT_COUNT) {
 		dev_err(&adapter->pdev->dev, "Reset never finished (%x)\n",
 			reg_val);
-		i40evf_disable_vf(adapter);
-		clear_bit(__I40EVF_IN_CLIENT_TASK, &adapter->crit_section);
+		iavf_disable_vf(adapter);
+		clear_bit(__IAVF_IN_CLIENT_TASK, &adapter->crit_section);
 		return; /* Do not attempt to reinit. It's dead, Jim. */
 	}
 
@@ -1926,44 +1926,44 @@ static void i40evf_reset_task(struct work_struct *work)
 	 * ndo_open() returning, so we can't assume it means all our open
 	 * tasks have finished, since we're not holding the rtnl_lock here.
 	 */
-	running = ((adapter->state == __I40EVF_RUNNING) ||
-		   (adapter->state == __I40EVF_RESETTING));
+	running = ((adapter->state == __IAVF_RUNNING) ||
+		   (adapter->state == __IAVF_RESETTING));
 
 	if (running) {
 		netif_carrier_off(netdev);
 		netif_tx_stop_all_queues(netdev);
 		adapter->link_up = false;
-		i40evf_napi_disable_all(adapter);
+		iavf_napi_disable_all(adapter);
 	}
-	i40evf_irq_disable(adapter);
+	iavf_irq_disable(adapter);
 
-	adapter->state = __I40EVF_RESETTING;
-	adapter->flags &= ~I40EVF_FLAG_RESET_PENDING;
+	adapter->state = __IAVF_RESETTING;
+	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
 
 	/* free the Tx/Rx rings and descriptors, might be better to just
 	 * re-use them sometime in the future
 	 */
-	i40evf_free_all_rx_resources(adapter);
-	i40evf_free_all_tx_resources(adapter);
+	iavf_free_all_rx_resources(adapter);
+	iavf_free_all_tx_resources(adapter);
 
-	adapter->flags |= I40EVF_FLAG_QUEUES_DISABLED;
+	adapter->flags |= IAVF_FLAG_QUEUES_DISABLED;
 	/* kill and reinit the admin queue */
-	i40evf_shutdown_adminq(hw);
+	iavf_shutdown_adminq(hw);
 	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
-	err = i40evf_init_adminq(hw);
+	err = iavf_init_adminq(hw);
 	if (err)
 		dev_info(&adapter->pdev->dev, "Failed to init adminq: %d\n",
 			 err);
 	adapter->aq_required = 0;
 
-	if (adapter->flags & I40EVF_FLAG_REINIT_ITR_NEEDED) {
-		err = i40evf_reinit_interrupt_scheme(adapter);
+	if (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED) {
+		err = iavf_reinit_interrupt_scheme(adapter);
 		if (err)
 			goto reset_err;
 	}
 
-	adapter->aq_required |= I40EVF_FLAG_AQ_GET_CONFIG;
-	adapter->aq_required |= I40EVF_FLAG_AQ_MAP_VECTORS;
+	adapter->aq_required |= IAVF_FLAG_AQ_GET_CONFIG;
+	adapter->aq_required |= IAVF_FLAG_AQ_MAP_VECTORS;
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
@@ -1988,10 +1988,10 @@ static void i40evf_reset_task(struct work_struct *work)
 	}
 	spin_unlock_bh(&adapter->cloud_filter_list_lock);
 
-	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_MAC_FILTER;
-	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_VLAN_FILTER;
-	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_CLOUD_FILTER;
-	i40evf_misc_irq_enable(adapter);
+	adapter->aq_required |= IAVF_FLAG_AQ_ADD_MAC_FILTER;
+	adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
+	adapter->aq_required |= IAVF_FLAG_AQ_ADD_CLOUD_FILTER;
+	iavf_misc_irq_enable(adapter);
 
 	mod_timer(&adapter->watchdog_timer, jiffies + 2);
 
@@ -2000,52 +2000,52 @@ static void i40evf_reset_task(struct work_struct *work)
 	 */
 	if (running) {
 		/* allocate transmit descriptors */
-		err = i40evf_setup_all_tx_resources(adapter);
+		err = iavf_setup_all_tx_resources(adapter);
 		if (err)
 			goto reset_err;
 
 		/* allocate receive descriptors */
-		err = i40evf_setup_all_rx_resources(adapter);
+		err = iavf_setup_all_rx_resources(adapter);
 		if (err)
 			goto reset_err;
 
-		if (adapter->flags & I40EVF_FLAG_REINIT_ITR_NEEDED) {
-			err = i40evf_request_traffic_irqs(adapter,
+		if (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED) {
+			err = iavf_request_traffic_irqs(adapter,
 							  netdev->name);
 			if (err)
 				goto reset_err;
 
-			adapter->flags &= ~I40EVF_FLAG_REINIT_ITR_NEEDED;
+			adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
 		}
 
-		i40evf_configure(adapter);
+		iavf_configure(adapter);
 
-		i40evf_up_complete(adapter);
+		iavf_up_complete(adapter);
 
-		i40evf_irq_enable(adapter, true);
+		iavf_irq_enable(adapter, true);
 	} else {
-		adapter->state = __I40EVF_DOWN;
+		adapter->state = __IAVF_DOWN;
 		wake_up(&adapter->down_waitqueue);
 	}
-	clear_bit(__I40EVF_IN_CLIENT_TASK, &adapter->crit_section);
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+	clear_bit(__IAVF_IN_CLIENT_TASK, &adapter->crit_section);
+	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
 
 	return;
 reset_err:
-	clear_bit(__I40EVF_IN_CLIENT_TASK, &adapter->crit_section);
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+	clear_bit(__IAVF_IN_CLIENT_TASK, &adapter->crit_section);
+	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
 	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
-	i40evf_close(netdev);
+	iavf_close(netdev);
 }
 
 /**
- * i40evf_adminq_task - worker thread to clean the admin queue
+ * iavf_adminq_task - worker thread to clean the admin queue
  * @work: pointer to work_struct containing our data
  **/
-static void i40evf_adminq_task(struct work_struct *work)
+static void iavf_adminq_task(struct work_struct *work)
 {
-	struct i40evf_adapter *adapter =
-		container_of(work, struct i40evf_adapter, adminq_task);
+	struct iavf_adapter *adapter =
+		container_of(work, struct iavf_adapter, adminq_task);
 	struct i40e_hw *hw = &adapter->hw;
 	struct i40e_arq_event_info event;
 	enum virtchnl_ops v_op;
@@ -2053,31 +2053,31 @@ static void i40evf_adminq_task(struct work_struct *work)
 	u32 val, oldval;
 	u16 pending;
 
-	if (adapter->flags & I40EVF_FLAG_PF_COMMS_FAILED)
+	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
 		goto out;
 
-	event.buf_len = I40EVF_MAX_AQ_BUF_SIZE;
+	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
 	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
 	if (!event.msg_buf)
 		goto out;
 
 	do {
-		ret = i40evf_clean_arq_element(hw, &event, &pending);
+		ret = iavf_clean_arq_element(hw, &event, &pending);
 		v_op = (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);
 		v_ret = (i40e_status)le32_to_cpu(event.desc.cookie_low);
 
 		if (ret || !v_op)
 			break; /* No event to process or error cleaning ARQ */
 
-		i40evf_virtchnl_completion(adapter, v_op, v_ret, event.msg_buf,
+		iavf_virtchnl_completion(adapter, v_op, v_ret, event.msg_buf,
 					   event.msg_len);
 		if (pending != 0)
-			memset(event.msg_buf, 0, I40EVF_MAX_AQ_BUF_SIZE);
+			memset(event.msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
 	} while (pending);
 
 	if ((adapter->flags &
-	     (I40EVF_FLAG_RESET_PENDING | I40EVF_FLAG_RESET_NEEDED)) ||
-	    adapter->state == __I40EVF_RESETTING)
+	     (IAVF_FLAG_RESET_PENDING | IAVF_FLAG_RESET_NEEDED)) ||
+	    adapter->state == __IAVF_RESETTING)
 		goto freedom;
 
 	/* check for error indications */
@@ -2121,58 +2121,58 @@ static void i40evf_adminq_task(struct work_struct *work)
 	kfree(event.msg_buf);
 out:
 	/* re-enable Admin queue interrupt cause */
-	i40evf_misc_irq_enable(adapter);
+	iavf_misc_irq_enable(adapter);
 }
 
 /**
- * i40evf_client_task - worker thread to perform client work
+ * iavf_client_task - worker thread to perform client work
  * @work: pointer to work_struct containing our data
  *
  * This task handles client interactions. Because client calls can be
  * reentrant, we can't handle them in the watchdog.
  **/
-static void i40evf_client_task(struct work_struct *work)
+static void iavf_client_task(struct work_struct *work)
 {
-	struct i40evf_adapter *adapter =
-		container_of(work, struct i40evf_adapter, client_task.work);
+	struct iavf_adapter *adapter =
+		container_of(work, struct iavf_adapter, client_task.work);
 
 	/* If we can't get the client bit, just give up. We'll be rescheduled
 	 * later.
 	 */
 
-	if (test_and_set_bit(__I40EVF_IN_CLIENT_TASK, &adapter->crit_section))
+	if (test_and_set_bit(__IAVF_IN_CLIENT_TASK, &adapter->crit_section))
 		return;
 
-	if (adapter->flags & I40EVF_FLAG_SERVICE_CLIENT_REQUESTED) {
-		i40evf_client_subtask(adapter);
-		adapter->flags &= ~I40EVF_FLAG_SERVICE_CLIENT_REQUESTED;
+	if (adapter->flags & IAVF_FLAG_SERVICE_CLIENT_REQUESTED) {
+		iavf_client_subtask(adapter);
+		adapter->flags &= ~IAVF_FLAG_SERVICE_CLIENT_REQUESTED;
 		goto out;
 	}
-	if (adapter->flags & I40EVF_FLAG_CLIENT_NEEDS_L2_PARAMS) {
-		i40evf_notify_client_l2_params(&adapter->vsi);
-		adapter->flags &= ~I40EVF_FLAG_CLIENT_NEEDS_L2_PARAMS;
+	if (adapter->flags & IAVF_FLAG_CLIENT_NEEDS_L2_PARAMS) {
+		iavf_notify_client_l2_params(&adapter->vsi);
+		adapter->flags &= ~IAVF_FLAG_CLIENT_NEEDS_L2_PARAMS;
 		goto out;
 	}
-	if (adapter->flags & I40EVF_FLAG_CLIENT_NEEDS_CLOSE) {
-		i40evf_notify_client_close(&adapter->vsi, false);
-		adapter->flags &= ~I40EVF_FLAG_CLIENT_NEEDS_CLOSE;
+	if (adapter->flags & IAVF_FLAG_CLIENT_NEEDS_CLOSE) {
+		iavf_notify_client_close(&adapter->vsi, false);
+		adapter->flags &= ~IAVF_FLAG_CLIENT_NEEDS_CLOSE;
 		goto out;
 	}
-	if (adapter->flags & I40EVF_FLAG_CLIENT_NEEDS_OPEN) {
-		i40evf_notify_client_open(&adapter->vsi);
-		adapter->flags &= ~I40EVF_FLAG_CLIENT_NEEDS_OPEN;
+	if (adapter->flags & IAVF_FLAG_CLIENT_NEEDS_OPEN) {
+		iavf_notify_client_open(&adapter->vsi);
+		adapter->flags &= ~IAVF_FLAG_CLIENT_NEEDS_OPEN;
 	}
 out:
-	clear_bit(__I40EVF_IN_CLIENT_TASK, &adapter->crit_section);
+	clear_bit(__IAVF_IN_CLIENT_TASK, &adapter->crit_section);
 }
 
 /**
- * i40evf_free_all_tx_resources - Free Tx Resources for All Queues
+ * iavf_free_all_tx_resources - Free Tx Resources for All Queues
  * @adapter: board private structure
  *
  * Free all transmit software resources
  **/
-void i40evf_free_all_tx_resources(struct i40evf_adapter *adapter)
+void iavf_free_all_tx_resources(struct iavf_adapter *adapter)
 {
 	int i;
 
@@ -2181,11 +2181,11 @@ void i40evf_free_all_tx_resources(struct i40evf_adapter *adapter)
 
 	for (i = 0; i < adapter->num_active_queues; i++)
 		if (adapter->tx_rings[i].desc)
-			i40evf_free_tx_resources(&adapter->tx_rings[i]);
+			iavf_free_tx_resources(&adapter->tx_rings[i]);
 }
 
 /**
- * i40evf_setup_all_tx_resources - allocate all queues Tx resources
+ * iavf_setup_all_tx_resources - allocate all queues Tx resources
  * @adapter: board private structure
  *
  * If this function returns with an error, then it's possible one or
@@ -2194,13 +2194,13 @@ void i40evf_free_all_tx_resources(struct i40evf_adapter *adapter)
  *
  * Return 0 on success, negative on failure
  **/
-static int i40evf_setup_all_tx_resources(struct i40evf_adapter *adapter)
+static int iavf_setup_all_tx_resources(struct iavf_adapter *adapter)
 {
 	int i, err = 0;
 
 	for (i = 0; i < adapter->num_active_queues; i++) {
 		adapter->tx_rings[i].count = adapter->tx_desc_count;
-		err = i40evf_setup_tx_descriptors(&adapter->tx_rings[i]);
+		err = iavf_setup_tx_descriptors(&adapter->tx_rings[i]);
 		if (!err)
 			continue;
 		dev_err(&adapter->pdev->dev,
@@ -2212,7 +2212,7 @@ static int i40evf_setup_all_tx_resources(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_setup_all_rx_resources - allocate all queues Rx resources
+ * iavf_setup_all_rx_resources - allocate all queues Rx resources
  * @adapter: board private structure
  *
  * If this function returns with an error, then it's possible one or
@@ -2221,13 +2221,13 @@ static int i40evf_setup_all_tx_resources(struct i40evf_adapter *adapter)
  *
  * Return 0 on success, negative on failure
  **/
-static int i40evf_setup_all_rx_resources(struct i40evf_adapter *adapter)
+static int iavf_setup_all_rx_resources(struct iavf_adapter *adapter)
 {
 	int i, err = 0;
 
 	for (i = 0; i < adapter->num_active_queues; i++) {
 		adapter->rx_rings[i].count = adapter->rx_desc_count;
-		err = i40evf_setup_rx_descriptors(&adapter->rx_rings[i]);
+		err = iavf_setup_rx_descriptors(&adapter->rx_rings[i]);
 		if (!err)
 			continue;
 		dev_err(&adapter->pdev->dev,
@@ -2238,12 +2238,12 @@ static int i40evf_setup_all_rx_resources(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_free_all_rx_resources - Free Rx Resources for All Queues
+ * iavf_free_all_rx_resources - Free Rx Resources for All Queues
  * @adapter: board private structure
  *
  * Free all receive software resources
  **/
-void i40evf_free_all_rx_resources(struct i40evf_adapter *adapter)
+void iavf_free_all_rx_resources(struct iavf_adapter *adapter)
 {
 	int i;
 
@@ -2252,15 +2252,15 @@ void i40evf_free_all_rx_resources(struct i40evf_adapter *adapter)
 
 	for (i = 0; i < adapter->num_active_queues; i++)
 		if (adapter->rx_rings[i].desc)
-			i40evf_free_rx_resources(&adapter->rx_rings[i]);
+			iavf_free_rx_resources(&adapter->rx_rings[i]);
 }
 
 /**
- * i40evf_validate_tx_bandwidth - validate the max Tx bandwidth
+ * iavf_validate_tx_bandwidth - validate the max Tx bandwidth
  * @adapter: board private structure
  * @max_tx_rate: max Tx bw for a tc
  **/
-static int i40evf_validate_tx_bandwidth(struct i40evf_adapter *adapter,
+static int iavf_validate_tx_bandwidth(struct iavf_adapter *adapter,
 					u64 max_tx_rate)
 {
 	int speed = 0, ret = 0;
@@ -2298,7 +2298,7 @@ static int i40evf_validate_tx_bandwidth(struct i40evf_adapter *adapter,
 }
 
 /**
- * i40evf_validate_channel_config - validate queue mapping info
+ * iavf_validate_channel_config - validate queue mapping info
  * @adapter: board private structure
  * @mqprio_qopt: queue parameters
  *
@@ -2306,7 +2306,7 @@ static int i40evf_validate_tx_bandwidth(struct i40evf_adapter *adapter,
  * configure queue channels is valid or not. Returns 0 on a valid
  * config.
  **/
-static int i40evf_validate_ch_config(struct i40evf_adapter *adapter,
+static int iavf_validate_ch_config(struct iavf_adapter *adapter,
 				     struct tc_mqprio_qopt_offload *mqprio_qopt)
 {
 	u64 total_max_rate = 0;
@@ -2314,7 +2314,7 @@ static int i40evf_validate_ch_config(struct i40evf_adapter *adapter,
 	u64 tx_rate = 0;
 	int ret = 0;
 
-	if (mqprio_qopt->qopt.num_tc > I40EVF_MAX_TRAFFIC_CLASS ||
+	if (mqprio_qopt->qopt.num_tc > IAVF_MAX_TRAFFIC_CLASS ||
 	    mqprio_qopt->qopt.num_tc < 1)
 		return -EINVAL;
 
@@ -2329,24 +2329,24 @@ static int i40evf_validate_ch_config(struct i40evf_adapter *adapter,
 		}
 		/*convert to Mbps */
 		tx_rate = div_u64(mqprio_qopt->max_rate[i],
-				  I40EVF_MBPS_DIVISOR);
+				  IAVF_MBPS_DIVISOR);
 		total_max_rate += tx_rate;
 		num_qps += mqprio_qopt->qopt.count[i];
 	}
-	if (num_qps > I40EVF_MAX_REQ_QUEUES)
+	if (num_qps > IAVF_MAX_REQ_QUEUES)
 		return -EINVAL;
 
-	ret = i40evf_validate_tx_bandwidth(adapter, total_max_rate);
+	ret = iavf_validate_tx_bandwidth(adapter, total_max_rate);
 	return ret;
 }
 
 /**
- * i40evf_del_all_cloud_filters - delete all cloud filters
+ * iavf_del_all_cloud_filters - delete all cloud filters
  * on the traffic classes
  **/
-static void i40evf_del_all_cloud_filters(struct i40evf_adapter *adapter)
+static void iavf_del_all_cloud_filters(struct iavf_adapter *adapter)
 {
-	struct i40evf_cloud_filter *cf, *cftmp;
+	struct iavf_cloud_filter *cf, *cftmp;
 
 	spin_lock_bh(&adapter->cloud_filter_list_lock);
 	list_for_each_entry_safe(cf, cftmp, &adapter->cloud_filter_list,
@@ -2359,7 +2359,7 @@ static void i40evf_del_all_cloud_filters(struct i40evf_adapter *adapter)
 }
 
 /**
- * __i40evf_setup_tc - configure multiple traffic classes
+ * __iavf_setup_tc - configure multiple traffic classes
  * @netdev: network interface device structure
  * @type_date: tc offload data
  *
@@ -2369,10 +2369,10 @@ static void i40evf_del_all_cloud_filters(struct i40evf_adapter *adapter)
  *
  * Returns 0 on success.
  **/
-static int __i40evf_setup_tc(struct net_device *netdev, void *type_data)
+static int __iavf_setup_tc(struct net_device *netdev, void *type_data)
 {
 	struct tc_mqprio_qopt_offload *mqprio_qopt = type_data;
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	struct virtchnl_vf_resource *vfres = adapter->vf_res;
 	u8 num_tc = 0, total_qps = 0;
 	int ret = 0, netdev_tc = 0;
@@ -2385,14 +2385,14 @@ static int __i40evf_setup_tc(struct net_device *netdev, void *type_data)
 
 	/* delete queue_channel */
 	if (!mqprio_qopt->qopt.hw) {
-		if (adapter->ch_config.state == __I40EVF_TC_RUNNING) {
+		if (adapter->ch_config.state == __IAVF_TC_RUNNING) {
 			/* reset the tc configuration */
 			netdev_reset_tc(netdev);
 			adapter->num_tc = 0;
 			netif_tx_stop_all_queues(netdev);
 			netif_tx_disable(netdev);
-			i40evf_del_all_cloud_filters(adapter);
-			adapter->aq_required = I40EVF_FLAG_AQ_DISABLE_CHANNELS;
+			iavf_del_all_cloud_filters(adapter);
+			adapter->aq_required = IAVF_FLAG_AQ_DISABLE_CHANNELS;
 			goto exit;
 		} else {
 			return -EINVAL;
@@ -2405,12 +2405,12 @@ static int __i40evf_setup_tc(struct net_device *netdev, void *type_data)
 			dev_err(&adapter->pdev->dev, "ADq not supported\n");
 			return -EOPNOTSUPP;
 		}
-		if (adapter->ch_config.state != __I40EVF_TC_INVALID) {
+		if (adapter->ch_config.state != __IAVF_TC_INVALID) {
 			dev_err(&adapter->pdev->dev, "TC configuration already exists\n");
 			return -EINVAL;
 		}
 
-		ret = i40evf_validate_ch_config(adapter, mqprio_qopt);
+		ret = iavf_validate_ch_config(adapter, mqprio_qopt);
 		if (ret)
 			return ret;
 		/* Return if same TC config is requested */
@@ -2418,7 +2418,7 @@ static int __i40evf_setup_tc(struct net_device *netdev, void *type_data)
 			return 0;
 		adapter->num_tc = num_tc;
 
-		for (i = 0; i < I40EVF_MAX_TRAFFIC_CLASS; i++) {
+		for (i = 0; i < IAVF_MAX_TRAFFIC_CLASS; i++) {
 			if (i < num_tc) {
 				adapter->ch_config.ch_info[i].count =
 					mqprio_qopt->qopt.count[i];
@@ -2428,7 +2428,7 @@ static int __i40evf_setup_tc(struct net_device *netdev, void *type_data)
 				max_tx_rate = mqprio_qopt->max_rate[i];
 				/* convert to Mbps */
 				max_tx_rate = div_u64(max_tx_rate,
-						      I40EVF_MBPS_DIVISOR);
+						      IAVF_MBPS_DIVISOR);
 				adapter->ch_config.ch_info[i].max_tx_rate =
 					max_tx_rate;
 			} else {
@@ -2439,11 +2439,11 @@ static int __i40evf_setup_tc(struct net_device *netdev, void *type_data)
 		adapter->ch_config.total_qps = total_qps;
 		netif_tx_stop_all_queues(netdev);
 		netif_tx_disable(netdev);
-		adapter->aq_required |= I40EVF_FLAG_AQ_ENABLE_CHANNELS;
+		adapter->aq_required |= IAVF_FLAG_AQ_ENABLE_CHANNELS;
 		netdev_reset_tc(netdev);
 		/* Report the tc mapping up the stack */
 		netdev_set_num_tc(adapter->netdev, num_tc);
-		for (i = 0; i < I40EVF_MAX_TRAFFIC_CLASS; i++) {
+		for (i = 0; i < IAVF_MAX_TRAFFIC_CLASS; i++) {
 			u16 qcount = mqprio_qopt->qopt.count[i];
 			u16 qoffset = mqprio_qopt->qopt.offset[i];
 
@@ -2457,14 +2457,14 @@ static int __i40evf_setup_tc(struct net_device *netdev, void *type_data)
 }
 
 /**
- * i40evf_parse_cls_flower - Parse tc flower filters provided by kernel
+ * iavf_parse_cls_flower - Parse tc flower filters provided by kernel
  * @adapter: board private structure
  * @cls_flower: pointer to struct tc_cls_flower_offload
  * @filter: pointer to cloud filter structure
  */
-static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
+static int iavf_parse_cls_flower(struct iavf_adapter *adapter,
 				   struct tc_cls_flower_offload *f,
-				   struct i40evf_cloud_filter *filter)
+				   struct iavf_cloud_filter *filter)
 {
 	u16 n_proto_mask = 0;
 	u16 n_proto_key = 0;
@@ -2495,7 +2495,7 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 						  f->mask);
 
 		if (mask->keyid != 0)
-			field_flags |= I40EVF_CLOUD_FIELD_TEN_ID;
+			field_flags |= IAVF_CLOUD_FIELD_TEN_ID;
 	}
 
 	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_BASIC)) {
@@ -2542,7 +2542,7 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 		/* use is_broadcast and is_zero to check for all 0xf or 0 */
 		if (!is_zero_ether_addr(mask->dst)) {
 			if (is_broadcast_ether_addr(mask->dst)) {
-				field_flags |= I40EVF_CLOUD_FIELD_OMAC;
+				field_flags |= IAVF_CLOUD_FIELD_OMAC;
 			} else {
 				dev_err(&adapter->pdev->dev, "Bad ether dest mask %pM\n",
 					mask->dst);
@@ -2552,7 +2552,7 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 
 		if (!is_zero_ether_addr(mask->src)) {
 			if (is_broadcast_ether_addr(mask->src)) {
-				field_flags |= I40EVF_CLOUD_FIELD_IMAC;
+				field_flags |= IAVF_CLOUD_FIELD_IMAC;
 			} else {
 				dev_err(&adapter->pdev->dev, "Bad ether src mask %pM\n",
 					mask->src);
@@ -2593,7 +2593,7 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 
 		if (mask->vlan_id) {
 			if (mask->vlan_id == VLAN_VID_MASK) {
-				field_flags |= I40EVF_CLOUD_FIELD_IVLAN;
+				field_flags |= IAVF_CLOUD_FIELD_IVLAN;
 			} else {
 				dev_err(&adapter->pdev->dev, "Bad vlan mask %u\n",
 					mask->vlan_id);
@@ -2625,7 +2625,7 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 
 		if (mask->dst) {
 			if (mask->dst == cpu_to_be32(0xffffffff)) {
-				field_flags |= I40EVF_CLOUD_FIELD_IIP;
+				field_flags |= IAVF_CLOUD_FIELD_IIP;
 			} else {
 				dev_err(&adapter->pdev->dev, "Bad ip dst mask 0x%08x\n",
 					be32_to_cpu(mask->dst));
@@ -2635,7 +2635,7 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 
 		if (mask->src) {
 			if (mask->src == cpu_to_be32(0xffffffff)) {
-				field_flags |= I40EVF_CLOUD_FIELD_IIP;
+				field_flags |= IAVF_CLOUD_FIELD_IIP;
 			} else {
 				dev_err(&adapter->pdev->dev, "Bad ip src mask 0x%08x\n",
 					be32_to_cpu(mask->dst));
@@ -2643,7 +2643,7 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 			}
 		}
 
-		if (field_flags & I40EVF_CLOUD_FIELD_TEN_ID) {
+		if (field_flags & IAVF_CLOUD_FIELD_TEN_ID) {
 			dev_info(&adapter->pdev->dev, "Tenant id not allowed for ip filter\n");
 			return I40E_ERR_CONFIG;
 		}
@@ -2684,7 +2684,7 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 			return I40E_ERR_CONFIG;
 		}
 		if (!ipv6_addr_any(&mask->dst) || !ipv6_addr_any(&mask->src))
-			field_flags |= I40EVF_CLOUD_FIELD_IIP;
+			field_flags |= IAVF_CLOUD_FIELD_IIP;
 
 		for (i = 0; i < 4; i++)
 			vf->mask.tcp_spec.dst_ip[i] |= cpu_to_be32(0xffffffff);
@@ -2707,7 +2707,7 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 
 		if (mask->src) {
 			if (mask->src == cpu_to_be16(0xffff)) {
-				field_flags |= I40EVF_CLOUD_FIELD_IIP;
+				field_flags |= IAVF_CLOUD_FIELD_IIP;
 			} else {
 				dev_err(&adapter->pdev->dev, "Bad src port mask %u\n",
 					be16_to_cpu(mask->src));
@@ -2717,7 +2717,7 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 
 		if (mask->dst) {
 			if (mask->dst == cpu_to_be16(0xffff)) {
-				field_flags |= I40EVF_CLOUD_FIELD_IIP;
+				field_flags |= IAVF_CLOUD_FIELD_IIP;
 			} else {
 				dev_err(&adapter->pdev->dev, "Bad dst port mask %u\n",
 					be16_to_cpu(mask->dst));
@@ -2740,13 +2740,13 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 }
 
 /**
- * i40evf_handle_tclass - Forward to a traffic class on the device
+ * iavf_handle_tclass - Forward to a traffic class on the device
  * @adapter: board private structure
  * @tc: traffic class index on the device
  * @filter: pointer to cloud filter structure
  */
-static int i40evf_handle_tclass(struct i40evf_adapter *adapter, u32 tc,
-				struct i40evf_cloud_filter *filter)
+static int iavf_handle_tclass(struct iavf_adapter *adapter, u32 tc,
+				struct iavf_cloud_filter *filter)
 {
 	if (tc == 0)
 		return 0;
@@ -2764,15 +2764,15 @@ static int i40evf_handle_tclass(struct i40evf_adapter *adapter, u32 tc,
 }
 
 /**
- * i40evf_configure_clsflower - Add tc flower filters
+ * iavf_configure_clsflower - Add tc flower filters
  * @adapter: board private structure
  * @cls_flower: Pointer to struct tc_cls_flower_offload
  */
-static int i40evf_configure_clsflower(struct i40evf_adapter *adapter,
+static int iavf_configure_clsflower(struct iavf_adapter *adapter,
 				      struct tc_cls_flower_offload *cls_flower)
 {
 	int tc = tc_classid_to_hwtc(adapter->netdev, cls_flower->classid);
-	struct i40evf_cloud_filter *filter = NULL;
+	struct iavf_cloud_filter *filter = NULL;
 	int err = -EINVAL, count = 50;
 
 	if (tc < 0) {
@@ -2784,7 +2784,7 @@ static int i40evf_configure_clsflower(struct i40evf_adapter *adapter,
 	if (!filter)
 		return -ENOMEM;
 
-	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
+	while (test_and_set_bit(__IAVF_IN_CRITICAL_TASK,
 				&adapter->crit_section)) {
 		if (--count == 0)
 			goto err;
@@ -2797,11 +2797,11 @@ static int i40evf_configure_clsflower(struct i40evf_adapter *adapter,
 	memset(&filter->f.mask.tcp_spec, 0, sizeof(struct virtchnl_l4_spec));
 	/* start out with flow type and eth type IPv4 to begin with */
 	filter->f.flow_type = VIRTCHNL_TCP_V4_FLOW;
-	err = i40evf_parse_cls_flower(adapter, cls_flower, filter);
+	err = iavf_parse_cls_flower(adapter, cls_flower, filter);
 	if (err < 0)
 		goto err;
 
-	err = i40evf_handle_tclass(adapter, tc, filter);
+	err = iavf_handle_tclass(adapter, tc, filter);
 	if (err < 0)
 		goto err;
 
@@ -2810,27 +2810,27 @@ static int i40evf_configure_clsflower(struct i40evf_adapter *adapter,
 	list_add_tail(&filter->list, &adapter->cloud_filter_list);
 	adapter->num_cloud_filters++;
 	filter->add = true;
-	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_CLOUD_FILTER;
+	adapter->aq_required |= IAVF_FLAG_AQ_ADD_CLOUD_FILTER;
 	spin_unlock_bh(&adapter->cloud_filter_list_lock);
 err:
 	if (err)
 		kfree(filter);
 
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
 	return err;
 }
 
-/* i40evf_find_cf - Find the cloud filter in the list
+/* iavf_find_cf - Find the cloud filter in the list
  * @adapter: Board private structure
  * @cookie: filter specific cookie
  *
  * Returns ptr to the filter object or NULL. Must be called while holding the
  * cloud_filter_list_lock.
  */
-static struct i40evf_cloud_filter *i40evf_find_cf(struct i40evf_adapter *adapter,
+static struct iavf_cloud_filter *iavf_find_cf(struct iavf_adapter *adapter,
 						  unsigned long *cookie)
 {
-	struct i40evf_cloud_filter *filter = NULL;
+	struct iavf_cloud_filter *filter = NULL;
 
 	if (!cookie)
 		return NULL;
@@ -2843,21 +2843,21 @@ static struct i40evf_cloud_filter *i40evf_find_cf(struct i40evf_adapter *adapter
 }
 
 /**
- * i40evf_delete_clsflower - Remove tc flower filters
+ * iavf_delete_clsflower - Remove tc flower filters
  * @adapter: board private structure
  * @cls_flower: Pointer to struct tc_cls_flower_offload
  */
-static int i40evf_delete_clsflower(struct i40evf_adapter *adapter,
+static int iavf_delete_clsflower(struct iavf_adapter *adapter,
 				   struct tc_cls_flower_offload *cls_flower)
 {
-	struct i40evf_cloud_filter *filter = NULL;
+	struct iavf_cloud_filter *filter = NULL;
 	int err = 0;
 
 	spin_lock_bh(&adapter->cloud_filter_list_lock);
-	filter = i40evf_find_cf(adapter, &cls_flower->cookie);
+	filter = iavf_find_cf(adapter, &cls_flower->cookie);
 	if (filter) {
 		filter->del = true;
-		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_CLOUD_FILTER;
+		adapter->aq_required |= IAVF_FLAG_AQ_DEL_CLOUD_FILTER;
 	} else {
 		err = -EINVAL;
 	}
@@ -2867,11 +2867,11 @@ static int i40evf_delete_clsflower(struct i40evf_adapter *adapter,
 }
 
 /**
- * i40evf_setup_tc_cls_flower - flower classifier offloads
+ * iavf_setup_tc_cls_flower - flower classifier offloads
  * @netdev: net device to configure
  * @type_data: offload data
  */
-static int i40evf_setup_tc_cls_flower(struct i40evf_adapter *adapter,
+static int iavf_setup_tc_cls_flower(struct iavf_adapter *adapter,
 				      struct tc_cls_flower_offload *cls_flower)
 {
 	if (cls_flower->common.chain_index)
@@ -2879,9 +2879,9 @@ static int i40evf_setup_tc_cls_flower(struct i40evf_adapter *adapter,
 
 	switch (cls_flower->command) {
 	case TC_CLSFLOWER_REPLACE:
-		return i40evf_configure_clsflower(adapter, cls_flower);
+		return iavf_configure_clsflower(adapter, cls_flower);
 	case TC_CLSFLOWER_DESTROY:
-		return i40evf_delete_clsflower(adapter, cls_flower);
+		return iavf_delete_clsflower(adapter, cls_flower);
 	case TC_CLSFLOWER_STATS:
 		return -EOPNOTSUPP;
 	default:
@@ -2890,46 +2890,46 @@ static int i40evf_setup_tc_cls_flower(struct i40evf_adapter *adapter,
 }
 
 /**
- * i40evf_setup_tc_block_cb - block callback for tc
+ * iavf_setup_tc_block_cb - block callback for tc
  * @type: type of offload
  * @type_data: offload data
  * @cb_priv:
  *
  * This function is the block callback for traffic classes
  **/
-static int i40evf_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
+static int iavf_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 				    void *cb_priv)
 {
 	switch (type) {
 	case TC_SETUP_CLSFLOWER:
-		return i40evf_setup_tc_cls_flower(cb_priv, type_data);
+		return iavf_setup_tc_cls_flower(cb_priv, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
 }
 
 /**
- * i40evf_setup_tc_block - register callbacks for tc
+ * iavf_setup_tc_block - register callbacks for tc
  * @netdev: network interface device structure
  * @f: tc offload data
  *
  * This function registers block callbacks for tc
  * offloads
  **/
-static int i40evf_setup_tc_block(struct net_device *dev,
+static int iavf_setup_tc_block(struct net_device *dev,
 				 struct tc_block_offload *f)
 {
-	struct i40evf_adapter *adapter = netdev_priv(dev);
+	struct iavf_adapter *adapter = netdev_priv(dev);
 
 	if (f->binder_type != TCF_BLOCK_BINDER_TYPE_CLSACT_INGRESS)
 		return -EOPNOTSUPP;
 
 	switch (f->command) {
 	case TC_BLOCK_BIND:
-		return tcf_block_cb_register(f->block, i40evf_setup_tc_block_cb,
+		return tcf_block_cb_register(f->block, iavf_setup_tc_block_cb,
 					     adapter, adapter, f->extack);
 	case TC_BLOCK_UNBIND:
-		tcf_block_cb_unregister(f->block, i40evf_setup_tc_block_cb,
+		tcf_block_cb_unregister(f->block, iavf_setup_tc_block_cb,
 					adapter);
 		return 0;
 	default:
@@ -2938,7 +2938,7 @@ static int i40evf_setup_tc_block(struct net_device *dev,
 }
 
 /**
- * i40evf_setup_tc - configure multiple traffic classes
+ * iavf_setup_tc - configure multiple traffic classes
  * @netdev: network interface device structure
  * @type: type of offload
  * @type_date: tc offload data
@@ -2948,21 +2948,21 @@ static int i40evf_setup_tc_block(struct net_device *dev,
  *
  * Returns 0 on success
  **/
-static int i40evf_setup_tc(struct net_device *netdev, enum tc_setup_type type,
+static int iavf_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			   void *type_data)
 {
 	switch (type) {
 	case TC_SETUP_QDISC_MQPRIO:
-		return __i40evf_setup_tc(netdev, type_data);
+		return __iavf_setup_tc(netdev, type_data);
 	case TC_SETUP_BLOCK:
-		return i40evf_setup_tc_block(netdev, type_data);
+		return iavf_setup_tc_block(netdev, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
 }
 
 /**
- * i40evf_open - Called when a network interface is made active
+ * iavf_open - Called when a network interface is made active
  * @netdev: network interface device structure
  *
  * Returns 0 on success, negative value on failure
@@ -2973,71 +2973,71 @@ static int i40evf_setup_tc(struct net_device *netdev, enum tc_setup_type type,
  * handler is registered with the OS, the watchdog timer is started,
  * and the stack is notified that the interface is ready.
  **/
-static int i40evf_open(struct net_device *netdev)
+static int iavf_open(struct net_device *netdev)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	int err;
 
-	if (adapter->flags & I40EVF_FLAG_PF_COMMS_FAILED) {
+	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED) {
 		dev_err(&adapter->pdev->dev, "Unable to open device due to PF driver failure.\n");
 		return -EIO;
 	}
 
-	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
+	while (test_and_set_bit(__IAVF_IN_CRITICAL_TASK,
 				&adapter->crit_section))
 		usleep_range(500, 1000);
 
-	if (adapter->state != __I40EVF_DOWN) {
+	if (adapter->state != __IAVF_DOWN) {
 		err = -EBUSY;
 		goto err_unlock;
 	}
 
 	/* allocate transmit descriptors */
-	err = i40evf_setup_all_tx_resources(adapter);
+	err = iavf_setup_all_tx_resources(adapter);
 	if (err)
 		goto err_setup_tx;
 
 	/* allocate receive descriptors */
-	err = i40evf_setup_all_rx_resources(adapter);
+	err = iavf_setup_all_rx_resources(adapter);
 	if (err)
 		goto err_setup_rx;
 
 	/* clear any pending interrupts, may auto mask */
-	err = i40evf_request_traffic_irqs(adapter, netdev->name);
+	err = iavf_request_traffic_irqs(adapter, netdev->name);
 	if (err)
 		goto err_req_irq;
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
-	i40evf_add_filter(adapter, adapter->hw.mac.addr);
+	iavf_add_filter(adapter, adapter->hw.mac.addr);
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
-	i40evf_configure(adapter);
+	iavf_configure(adapter);
 
-	i40evf_up_complete(adapter);
+	iavf_up_complete(adapter);
 
-	i40evf_irq_enable(adapter, true);
+	iavf_irq_enable(adapter, true);
 
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
 
 	return 0;
 
 err_req_irq:
-	i40evf_down(adapter);
-	i40evf_free_traffic_irqs(adapter);
+	iavf_down(adapter);
+	iavf_free_traffic_irqs(adapter);
 err_setup_rx:
-	i40evf_free_all_rx_resources(adapter);
+	iavf_free_all_rx_resources(adapter);
 err_setup_tx:
-	i40evf_free_all_tx_resources(adapter);
+	iavf_free_all_tx_resources(adapter);
 err_unlock:
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
 
 	return err;
 }
 
 /**
- * i40evf_close - Disables a network interface
+ * iavf_close - Disables a network interface
  * @netdev: network interface device structure
  *
  * Returns 0, this is not allowed to fail
@@ -3047,41 +3047,41 @@ static int i40evf_open(struct net_device *netdev)
  * needs to be disabled. All IRQs except vector 0 (reserved for admin queue)
  * are freed, along with all transmit and receive resources.
  **/
-static int i40evf_close(struct net_device *netdev)
+static int iavf_close(struct net_device *netdev)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	int status;
 
-	if (adapter->state <= __I40EVF_DOWN_PENDING)
+	if (adapter->state <= __IAVF_DOWN_PENDING)
 		return 0;
 
-	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
+	while (test_and_set_bit(__IAVF_IN_CRITICAL_TASK,
 				&adapter->crit_section))
 		usleep_range(500, 1000);
 
 	set_bit(__I40E_VSI_DOWN, adapter->vsi.state);
 	if (CLIENT_ENABLED(adapter))
-		adapter->flags |= I40EVF_FLAG_CLIENT_NEEDS_CLOSE;
+		adapter->flags |= IAVF_FLAG_CLIENT_NEEDS_CLOSE;
 
-	i40evf_down(adapter);
-	adapter->state = __I40EVF_DOWN_PENDING;
-	i40evf_free_traffic_irqs(adapter);
+	iavf_down(adapter);
+	adapter->state = __IAVF_DOWN_PENDING;
+	iavf_free_traffic_irqs(adapter);
 
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
 
 	/* We explicitly don't free resources here because the hardware is
 	 * still active and can DMA into memory. Resources are cleared in
-	 * i40evf_virtchnl_completion() after we get confirmation from the PF
+	 * iavf_virtchnl_completion() after we get confirmation from the PF
 	 * driver that the rings have been stopped.
 	 *
-	 * Also, we wait for state to transition to __I40EVF_DOWN before
-	 * returning. State change occurs in i40evf_virtchnl_completion() after
+	 * Also, we wait for state to transition to __IAVF_DOWN before
+	 * returning. State change occurs in iavf_virtchnl_completion() after
 	 * VF resources are released (which occurs after PF driver processes and
 	 * responds to admin queue commands).
 	 */
 
 	status = wait_event_timeout(adapter->down_waitqueue,
-				    adapter->state == __I40EVF_DOWN,
+				    adapter->state == __IAVF_DOWN,
 				    msecs_to_jiffies(200));
 	if (!status)
 		netdev_warn(netdev, "Device resources not yet released\n");
@@ -3089,22 +3089,22 @@ static int i40evf_close(struct net_device *netdev)
 }
 
 /**
- * i40evf_change_mtu - Change the Maximum Transfer Unit
+ * iavf_change_mtu - Change the Maximum Transfer Unit
  * @netdev: network interface device structure
  * @new_mtu: new value for maximum frame size
  *
  * Returns 0 on success, negative on failure
  **/
-static int i40evf_change_mtu(struct net_device *netdev, int new_mtu)
+static int iavf_change_mtu(struct net_device *netdev, int new_mtu)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	netdev->mtu = new_mtu;
 	if (CLIENT_ENABLED(adapter)) {
-		i40evf_notify_client_l2_params(&adapter->vsi);
-		adapter->flags |= I40EVF_FLAG_SERVICE_CLIENT_REQUESTED;
+		iavf_notify_client_l2_params(&adapter->vsi);
+		adapter->flags |= IAVF_FLAG_SERVICE_CLIENT_REQUESTED;
 	}
-	adapter->flags |= I40EVF_FLAG_RESET_NEEDED;
+	adapter->flags |= IAVF_FLAG_RESET_NEEDED;
 	schedule_work(&adapter->reset_task);
 
 	return 0;
@@ -3116,10 +3116,10 @@ static int i40evf_change_mtu(struct net_device *netdev, int new_mtu)
  * @features: the feature set that the stack is suggesting
  * Note: expects to be called while under rtnl_lock()
  **/
-static int i40evf_set_features(struct net_device *netdev,
+static int iavf_set_features(struct net_device *netdev,
 			       netdev_features_t features)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	/* Don't allow changing VLAN_RX flag when adapter is not capable
 	 * of VLAN offload
@@ -3130,22 +3130,22 @@ static int i40evf_set_features(struct net_device *netdev,
 	} else if ((netdev->features ^ features) & NETIF_F_HW_VLAN_CTAG_RX) {
 		if (features & NETIF_F_HW_VLAN_CTAG_RX)
 			adapter->aq_required |=
-				I40EVF_FLAG_AQ_ENABLE_VLAN_STRIPPING;
+				IAVF_FLAG_AQ_ENABLE_VLAN_STRIPPING;
 		else
 			adapter->aq_required |=
-				I40EVF_FLAG_AQ_DISABLE_VLAN_STRIPPING;
+				IAVF_FLAG_AQ_DISABLE_VLAN_STRIPPING;
 	}
 
 	return 0;
 }
 
 /**
- * i40evf_features_check - Validate encapsulated packet conforms to limits
+ * iavf_features_check - Validate encapsulated packet conforms to limits
  * @skb: skb buff
  * @dev: This physical port's netdev
  * @features: Offload features that the stack believes apply
  **/
-static netdev_features_t i40evf_features_check(struct sk_buff *skb,
+static netdev_features_t iavf_features_check(struct sk_buff *skb,
 					       struct net_device *dev,
 					       netdev_features_t features)
 {
@@ -3198,16 +3198,16 @@ static netdev_features_t i40evf_features_check(struct sk_buff *skb,
 }
 
 /**
- * i40evf_fix_features - fix up the netdev feature bits
+ * iavf_fix_features - fix up the netdev feature bits
  * @netdev: our net device
  * @features: desired feature bits
  *
  * Returns fixed-up features bits
  **/
-static netdev_features_t i40evf_fix_features(struct net_device *netdev,
+static netdev_features_t iavf_fix_features(struct net_device *netdev,
 					     netdev_features_t features)
 {
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	if (!(adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN))
 		features &= ~(NETIF_F_HW_VLAN_CTAG_TX |
@@ -3217,33 +3217,33 @@ static netdev_features_t i40evf_fix_features(struct net_device *netdev,
 	return features;
 }
 
-static const struct net_device_ops i40evf_netdev_ops = {
-	.ndo_open		= i40evf_open,
-	.ndo_stop		= i40evf_close,
-	.ndo_start_xmit		= i40evf_xmit_frame,
-	.ndo_set_rx_mode	= i40evf_set_rx_mode,
+static const struct net_device_ops iavf_netdev_ops = {
+	.ndo_open		= iavf_open,
+	.ndo_stop		= iavf_close,
+	.ndo_start_xmit		= iavf_xmit_frame,
+	.ndo_set_rx_mode	= iavf_set_rx_mode,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_mac_address	= i40evf_set_mac,
-	.ndo_change_mtu		= i40evf_change_mtu,
-	.ndo_tx_timeout		= i40evf_tx_timeout,
-	.ndo_vlan_rx_add_vid	= i40evf_vlan_rx_add_vid,
-	.ndo_vlan_rx_kill_vid	= i40evf_vlan_rx_kill_vid,
-	.ndo_features_check	= i40evf_features_check,
-	.ndo_fix_features	= i40evf_fix_features,
-	.ndo_set_features	= i40evf_set_features,
+	.ndo_set_mac_address	= iavf_set_mac,
+	.ndo_change_mtu		= iavf_change_mtu,
+	.ndo_tx_timeout		= iavf_tx_timeout,
+	.ndo_vlan_rx_add_vid	= iavf_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= iavf_vlan_rx_kill_vid,
+	.ndo_features_check	= iavf_features_check,
+	.ndo_fix_features	= iavf_fix_features,
+	.ndo_set_features	= iavf_set_features,
 #ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller	= i40evf_netpoll,
+	.ndo_poll_controller	= iavf_netpoll,
 #endif
-	.ndo_setup_tc		= i40evf_setup_tc,
+	.ndo_setup_tc		= iavf_setup_tc,
 };
 
 /**
- * i40evf_check_reset_complete - check that VF reset is complete
+ * iavf_check_reset_complete - check that VF reset is complete
  * @hw: pointer to hw struct
  *
  * Returns 0 if device is ready to use, or -EBUSY if it's in reset.
  **/
-static int i40evf_check_reset_complete(struct i40e_hw *hw)
+static int iavf_check_reset_complete(struct i40e_hw *hw)
 {
 	u32 rstat;
 	int i;
@@ -3260,13 +3260,13 @@ static int i40evf_check_reset_complete(struct i40e_hw *hw)
 }
 
 /**
- * i40evf_process_config - Process the config information we got from the PF
+ * iavf_process_config - Process the config information we got from the PF
  * @adapter: board private structure
  *
  * Verify that we have a valid config struct, and set up our netdev features
  * and our VSI struct.
  **/
-int i40evf_process_config(struct i40evf_adapter *adapter)
+int iavf_process_config(struct iavf_adapter *adapter)
 {
 	struct virtchnl_vf_resource *vfres = adapter->vf_res;
 	int i, num_req_queues = adapter->num_req_queues;
@@ -3295,9 +3295,9 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
 			"Requested %d queues, but PF only gave us %d.\n",
 			num_req_queues,
 			adapter->vsi_res->num_queue_pairs);
-		adapter->flags |= I40EVF_FLAG_REINIT_ITR_NEEDED;
+		adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
 		adapter->num_req_queues = adapter->vsi_res->num_queue_pairs;
-		i40evf_schedule_reset(adapter);
+		iavf_schedule_reset(adapter);
 		return -ENODEV;
 	}
 	adapter->num_req_queues = 0;
@@ -3391,15 +3391,15 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
 		adapter->rss_key_size = vfres->rss_key_size;
 		adapter->rss_lut_size = vfres->rss_lut_size;
 	} else {
-		adapter->rss_key_size = I40EVF_HKEY_ARRAY_SIZE;
-		adapter->rss_lut_size = I40EVF_HLUT_ARRAY_SIZE;
+		adapter->rss_key_size = IAVF_HKEY_ARRAY_SIZE;
+		adapter->rss_lut_size = IAVF_HLUT_ARRAY_SIZE;
 	}
 
 	return 0;
 }
 
 /**
- * i40evf_init_task - worker thread to perform delayed initialization
+ * iavf_init_task - worker thread to perform delayed initialization
  * @work: pointer to work_struct containing our data
  *
  * This task completes the work that was begun in probe. Due to the nature
@@ -3410,10 +3410,10 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
  * communications with the PF driver and set up our netdev, the watchdog
  * takes over.
  **/
-static void i40evf_init_task(struct work_struct *work)
+static void iavf_init_task(struct work_struct *work)
 {
-	struct i40evf_adapter *adapter = container_of(work,
-						      struct i40evf_adapter,
+	struct iavf_adapter *adapter = container_of(work,
+						      struct iavf_adapter,
 						      init_task.work);
 	struct net_device *netdev = adapter->netdev;
 	struct i40e_hw *hw = &adapter->hw;
@@ -3421,54 +3421,54 @@ static void i40evf_init_task(struct work_struct *work)
 	int err, bufsz;
 
 	switch (adapter->state) {
-	case __I40EVF_STARTUP:
+	case __IAVF_STARTUP:
 		/* driver loaded, probe complete */
-		adapter->flags &= ~I40EVF_FLAG_PF_COMMS_FAILED;
-		adapter->flags &= ~I40EVF_FLAG_RESET_PENDING;
+		adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
+		adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
 		err = i40e_set_mac_type(hw);
 		if (err) {
 			dev_err(&pdev->dev, "Failed to set MAC type (%d)\n",
 				err);
 			goto err;
 		}
-		err = i40evf_check_reset_complete(hw);
+		err = iavf_check_reset_complete(hw);
 		if (err) {
 			dev_info(&pdev->dev, "Device is still in reset (%d), retrying\n",
 				 err);
 			goto err;
 		}
-		hw->aq.num_arq_entries = I40EVF_AQ_LEN;
-		hw->aq.num_asq_entries = I40EVF_AQ_LEN;
-		hw->aq.arq_buf_size = I40EVF_MAX_AQ_BUF_SIZE;
-		hw->aq.asq_buf_size = I40EVF_MAX_AQ_BUF_SIZE;
+		hw->aq.num_arq_entries = IAVF_AQ_LEN;
+		hw->aq.num_asq_entries = IAVF_AQ_LEN;
+		hw->aq.arq_buf_size = IAVF_MAX_AQ_BUF_SIZE;
+		hw->aq.asq_buf_size = IAVF_MAX_AQ_BUF_SIZE;
 
-		err = i40evf_init_adminq(hw);
+		err = iavf_init_adminq(hw);
 		if (err) {
 			dev_err(&pdev->dev, "Failed to init Admin Queue (%d)\n",
 				err);
 			goto err;
 		}
-		err = i40evf_send_api_ver(adapter);
+		err = iavf_send_api_ver(adapter);
 		if (err) {
 			dev_err(&pdev->dev, "Unable to send to PF (%d)\n", err);
-			i40evf_shutdown_adminq(hw);
+			iavf_shutdown_adminq(hw);
 			goto err;
 		}
-		adapter->state = __I40EVF_INIT_VERSION_CHECK;
+		adapter->state = __IAVF_INIT_VERSION_CHECK;
 		goto restart;
-	case __I40EVF_INIT_VERSION_CHECK:
-		if (!i40evf_asq_done(hw)) {
+	case __IAVF_INIT_VERSION_CHECK:
+		if (!iavf_asq_done(hw)) {
 			dev_err(&pdev->dev, "Admin queue command never completed\n");
-			i40evf_shutdown_adminq(hw);
-			adapter->state = __I40EVF_STARTUP;
+			iavf_shutdown_adminq(hw);
+			adapter->state = __IAVF_STARTUP;
 			goto err;
 		}
 
 		/* aq msg sent, awaiting reply */
-		err = i40evf_verify_api_ver(adapter);
+		err = iavf_verify_api_ver(adapter);
 		if (err) {
 			if (err == I40E_ERR_ADMIN_QUEUE_NO_WORK)
-				err = i40evf_send_api_ver(adapter);
+				err = iavf_send_api_ver(adapter);
 			else
 				dev_err(&pdev->dev, "Unsupported PF API version %d.%d, expected %d.%d\n",
 					adapter->pf_version.major,
@@ -3477,15 +3477,15 @@ static void i40evf_init_task(struct work_struct *work)
 					VIRTCHNL_VERSION_MINOR);
 			goto err;
 		}
-		err = i40evf_send_vf_config_msg(adapter);
+		err = iavf_send_vf_config_msg(adapter);
 		if (err) {
 			dev_err(&pdev->dev, "Unable to send config request (%d)\n",
 				err);
 			goto err;
 		}
-		adapter->state = __I40EVF_INIT_GET_RESOURCES;
+		adapter->state = __IAVF_INIT_GET_RESOURCES;
 		goto restart;
-	case __I40EVF_INIT_GET_RESOURCES:
+	case __IAVF_INIT_GET_RESOURCES:
 		/* aq msg sent, awaiting reply */
 		if (!adapter->vf_res) {
 			bufsz = sizeof(struct virtchnl_vf_resource) +
@@ -3495,16 +3495,16 @@ static void i40evf_init_task(struct work_struct *work)
 			if (!adapter->vf_res)
 				goto err;
 		}
-		err = i40evf_get_vf_config(adapter);
+		err = iavf_get_vf_config(adapter);
 		if (err == I40E_ERR_ADMIN_QUEUE_NO_WORK) {
-			err = i40evf_send_vf_config_msg(adapter);
+			err = iavf_send_vf_config_msg(adapter);
 			goto err;
 		} else if (err == I40E_ERR_PARAM) {
 			/* We only get ERR_PARAM if the device is in a very bad
 			 * state or if we've been disabled for previous bad
 			 * behavior. Either way, we're done now.
 			 */
-			i40evf_shutdown_adminq(hw);
+			iavf_shutdown_adminq(hw);
 			dev_err(&pdev->dev, "Unable to get VF config due to PF error condition, not retrying\n");
 			return;
 		}
@@ -3513,20 +3513,20 @@ static void i40evf_init_task(struct work_struct *work)
 				err);
 			goto err_alloc;
 		}
-		adapter->state = __I40EVF_INIT_SW;
+		adapter->state = __IAVF_INIT_SW;
 		break;
 	default:
 		goto err_alloc;
 	}
 
-	if (i40evf_process_config(adapter))
+	if (iavf_process_config(adapter))
 		goto err_alloc;
 	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 
-	adapter->flags |= I40EVF_FLAG_RX_CSUM_ENABLED;
+	adapter->flags |= IAVF_FLAG_RX_CSUM_ENABLED;
 
-	netdev->netdev_ops = &i40evf_netdev_ops;
-	i40evf_set_ethtool_ops(netdev);
+	netdev->netdev_ops = &iavf_netdev_ops;
+	iavf_set_ethtool_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
 
 	/* MTU range: 68 - 9710 */
@@ -3539,25 +3539,25 @@ static void i40evf_init_task(struct work_struct *work)
 		eth_hw_addr_random(netdev);
 		ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
 	} else {
-		adapter->flags |= I40EVF_FLAG_ADDR_SET_BY_PF;
+		adapter->flags |= IAVF_FLAG_ADDR_SET_BY_PF;
 		ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
 		ether_addr_copy(netdev->perm_addr, adapter->hw.mac.addr);
 	}
 
-	timer_setup(&adapter->watchdog_timer, i40evf_watchdog_timer, 0);
+	timer_setup(&adapter->watchdog_timer, iavf_watchdog_timer, 0);
 	mod_timer(&adapter->watchdog_timer, jiffies + 1);
 
-	adapter->tx_desc_count = I40EVF_DEFAULT_TXD;
-	adapter->rx_desc_count = I40EVF_DEFAULT_RXD;
-	err = i40evf_init_interrupt_scheme(adapter);
+	adapter->tx_desc_count = IAVF_DEFAULT_TXD;
+	adapter->rx_desc_count = IAVF_DEFAULT_RXD;
+	err = iavf_init_interrupt_scheme(adapter);
 	if (err)
 		goto err_sw_init;
-	i40evf_map_rings_to_vectors(adapter);
+	iavf_map_rings_to_vectors(adapter);
 	if (adapter->vf_res->vf_cap_flags &
 	    VIRTCHNL_VF_OFFLOAD_WB_ON_ITR)
-		adapter->flags |= I40EVF_FLAG_WB_ON_ITR_CAPABLE;
+		adapter->flags |= IAVF_FLAG_WB_ON_ITR_CAPABLE;
 
-	err = i40evf_request_misc_irq(adapter);
+	err = iavf_request_misc_irq(adapter);
 	if (err)
 		goto err_sw_init;
 
@@ -3574,7 +3574,7 @@ static void i40evf_init_task(struct work_struct *work)
 
 	netif_tx_stop_all_queues(netdev);
 	if (CLIENT_ALLOWED(adapter)) {
-		err = i40evf_lan_add_device(adapter);
+		err = iavf_lan_add_device(adapter);
 		if (err)
 			dev_info(&pdev->dev, "Failed to add VF to client API service list: %d\n",
 				 err);
@@ -3584,9 +3584,9 @@ static void i40evf_init_task(struct work_struct *work)
 	if (netdev->features & NETIF_F_GRO)
 		dev_info(&pdev->dev, "GRO is enabled\n");
 
-	adapter->state = __I40EVF_DOWN;
+	adapter->state = __IAVF_DOWN;
 	set_bit(__I40E_VSI_DOWN, adapter->vsi.state);
-	i40evf_misc_irq_enable(adapter);
+	iavf_misc_irq_enable(adapter);
 	wake_up(&adapter->down_waitqueue);
 
 	adapter->rss_key = kzalloc(adapter->rss_key_size, GFP_KERNEL);
@@ -3595,31 +3595,31 @@ static void i40evf_init_task(struct work_struct *work)
 		goto err_mem;
 
 	if (RSS_AQ(adapter)) {
-		adapter->aq_required |= I40EVF_FLAG_AQ_CONFIGURE_RSS;
+		adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_RSS;
 		mod_timer_pending(&adapter->watchdog_timer, jiffies + 1);
 	} else {
-		i40evf_init_rss(adapter);
+		iavf_init_rss(adapter);
 	}
 	return;
 restart:
 	schedule_delayed_work(&adapter->init_task, msecs_to_jiffies(30));
 	return;
 err_mem:
-	i40evf_free_rss(adapter);
+	iavf_free_rss(adapter);
 err_register:
-	i40evf_free_misc_irq(adapter);
+	iavf_free_misc_irq(adapter);
 err_sw_init:
-	i40evf_reset_interrupt_capability(adapter);
+	iavf_reset_interrupt_capability(adapter);
 err_alloc:
 	kfree(adapter->vf_res);
 	adapter->vf_res = NULL;
 err:
 	/* Things went into the weeds, so try again later */
-	if (++adapter->aq_wait_count > I40EVF_AQ_MAX_ERR) {
+	if (++adapter->aq_wait_count > IAVF_AQ_MAX_ERR) {
 		dev_err(&pdev->dev, "Failed to communicate with PF; waiting before retry\n");
-		adapter->flags |= I40EVF_FLAG_PF_COMMS_FAILED;
-		i40evf_shutdown_adminq(hw);
-		adapter->state = __I40EVF_STARTUP;
+		adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
+		iavf_shutdown_adminq(hw);
+		adapter->state = __IAVF_STARTUP;
 		schedule_delayed_work(&adapter->init_task, HZ * 5);
 		return;
 	}
@@ -3627,21 +3627,21 @@ static void i40evf_init_task(struct work_struct *work)
 }
 
 /**
- * i40evf_shutdown - Shutdown the device in preparation for a reboot
+ * iavf_shutdown - Shutdown the device in preparation for a reboot
  * @pdev: pci device structure
  **/
-static void i40evf_shutdown(struct pci_dev *pdev)
+static void iavf_shutdown(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	netif_device_detach(netdev);
 
 	if (netif_running(netdev))
-		i40evf_close(netdev);
+		iavf_close(netdev);
 
 	/* Prevent the watchdog from running. */
-	adapter->state = __I40EVF_REMOVE;
+	adapter->state = __IAVF_REMOVE;
 	adapter->aq_required = 0;
 
 #ifdef CONFIG_PM
@@ -3652,20 +3652,20 @@ static void i40evf_shutdown(struct pci_dev *pdev)
 }
 
 /**
- * i40evf_probe - Device Initialization Routine
+ * iavf_probe - Device Initialization Routine
  * @pdev: PCI device information struct
- * @ent: entry in i40evf_pci_tbl
+ * @ent: entry in iavf_pci_tbl
  *
  * Returns 0 on success, negative on failure
  *
- * i40evf_probe initializes an adapter identified by a pci_dev structure.
+ * iavf_probe initializes an adapter identified by a pci_dev structure.
  * The OS initialization, configuring of the adapter private structure,
  * and a hardware reset occur.
  **/
-static int i40evf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct net_device *netdev;
-	struct i40evf_adapter *adapter = NULL;
+	struct iavf_adapter *adapter = NULL;
 	struct i40e_hw *hw = NULL;
 	int err;
 
@@ -3683,7 +3683,7 @@ static int i40evf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
-	err = pci_request_regions(pdev, i40evf_driver_name);
+	err = pci_request_regions(pdev, iavf_driver_name);
 	if (err) {
 		dev_err(&pdev->dev,
 			"pci_request_regions failed 0x%x\n", err);
@@ -3694,8 +3694,8 @@ static int i40evf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 
-	netdev = alloc_etherdev_mq(sizeof(struct i40evf_adapter),
-				   I40EVF_MAX_REQ_QUEUES);
+	netdev = alloc_etherdev_mq(sizeof(struct iavf_adapter),
+				   IAVF_MAX_REQ_QUEUES);
 	if (!netdev) {
 		err = -ENOMEM;
 		goto err_alloc_etherdev;
@@ -3713,7 +3713,7 @@ static int i40evf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->back = adapter;
 
 	adapter->msg_enable = BIT(DEFAULT_DEBUG_LEVEL_SHIFT) - 1;
-	adapter->state = __I40EVF_STARTUP;
+	adapter->state = __IAVF_STARTUP;
 
 	/* Call save state here because it relies on the adapter struct. */
 	pci_save_state(pdev);
@@ -3746,11 +3746,11 @@ static int i40evf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_LIST_HEAD(&adapter->vlan_filter_list);
 	INIT_LIST_HEAD(&adapter->cloud_filter_list);
 
-	INIT_WORK(&adapter->reset_task, i40evf_reset_task);
-	INIT_WORK(&adapter->adminq_task, i40evf_adminq_task);
-	INIT_WORK(&adapter->watchdog_task, i40evf_watchdog_task);
-	INIT_DELAYED_WORK(&adapter->client_task, i40evf_client_task);
-	INIT_DELAYED_WORK(&adapter->init_task, i40evf_init_task);
+	INIT_WORK(&adapter->reset_task, iavf_reset_task);
+	INIT_WORK(&adapter->adminq_task, iavf_adminq_task);
+	INIT_WORK(&adapter->watchdog_task, iavf_watchdog_task);
+	INIT_DELAYED_WORK(&adapter->client_task, iavf_client_task);
+	INIT_DELAYED_WORK(&adapter->init_task, iavf_init_task);
 	schedule_delayed_work(&adapter->init_task,
 			      msecs_to_jiffies(5 * (pdev->devfn & 0x07)));
 
@@ -3771,33 +3771,33 @@ static int i40evf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 #ifdef CONFIG_PM
 /**
- * i40evf_suspend - Power management suspend routine
+ * iavf_suspend - Power management suspend routine
  * @pdev: PCI device information struct
  * @state: unused
  *
  * Called when the system (VM) is entering sleep/suspend.
  **/
-static int i40evf_suspend(struct pci_dev *pdev, pm_message_t state)
+static int iavf_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	int retval = 0;
 
 	netif_device_detach(netdev);
 
-	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
+	while (test_and_set_bit(__IAVF_IN_CRITICAL_TASK,
 				&adapter->crit_section))
 		usleep_range(500, 1000);
 
 	if (netif_running(netdev)) {
 		rtnl_lock();
-		i40evf_down(adapter);
+		iavf_down(adapter);
 		rtnl_unlock();
 	}
-	i40evf_free_misc_irq(adapter);
-	i40evf_reset_interrupt_capability(adapter);
+	iavf_free_misc_irq(adapter);
+	iavf_reset_interrupt_capability(adapter);
 
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
 
 	retval = pci_save_state(pdev);
 	if (retval)
@@ -3809,14 +3809,14 @@ static int i40evf_suspend(struct pci_dev *pdev, pm_message_t state)
 }
 
 /**
- * i40evf_resume - Power management resume routine
+ * iavf_resume - Power management resume routine
  * @pdev: PCI device information struct
  *
  * Called when the system (VM) is resumed from sleep/suspend.
  **/
-static int i40evf_resume(struct pci_dev *pdev)
+static int iavf_resume(struct pci_dev *pdev)
 {
-	struct i40evf_adapter *adapter = pci_get_drvdata(pdev);
+	struct iavf_adapter *adapter = pci_get_drvdata(pdev);
 	struct net_device *netdev = adapter->netdev;
 	u32 err;
 
@@ -3835,13 +3835,13 @@ static int i40evf_resume(struct pci_dev *pdev)
 	pci_set_master(pdev);
 
 	rtnl_lock();
-	err = i40evf_set_interrupt_capability(adapter);
+	err = iavf_set_interrupt_capability(adapter);
 	if (err) {
 		rtnl_unlock();
 		dev_err(&pdev->dev, "Cannot enable MSI-X interrupts.\n");
 		return err;
 	}
-	err = i40evf_request_misc_irq(adapter);
+	err = iavf_request_misc_irq(adapter);
 	rtnl_unlock();
 	if (err) {
 		dev_err(&pdev->dev, "Cannot get interrupt vector.\n");
@@ -3857,25 +3857,25 @@ static int i40evf_resume(struct pci_dev *pdev)
 
 #endif /* CONFIG_PM */
 /**
- * i40evf_remove - Device Removal Routine
+ * iavf_remove - Device Removal Routine
  * @pdev: PCI device information struct
  *
- * i40evf_remove is called by the PCI subsystem to alert the driver
+ * iavf_remove is called by the PCI subsystem to alert the driver
  * that it should release a PCI device.  The could be caused by a
  * Hot-Plug event, or because the driver is going to be removed from
  * memory.
  **/
-static void i40evf_remove(struct pci_dev *pdev)
+static void iavf_remove(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
-	struct i40evf_adapter *adapter = netdev_priv(netdev);
-	struct i40evf_vlan_filter *vlf, *vlftmp;
-	struct i40evf_mac_filter *f, *ftmp;
-	struct i40evf_cloud_filter *cf, *cftmp;
+	struct iavf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_vlan_filter *vlf, *vlftmp;
+	struct iavf_mac_filter *f, *ftmp;
+	struct iavf_cloud_filter *cf, *cftmp;
 	struct i40e_hw *hw = &adapter->hw;
 	int err;
 	/* Indicate we are in remove and not to run reset_task */
-	set_bit(__I40EVF_IN_REMOVE_TASK, &adapter->crit_section);
+	set_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section);
 	cancel_delayed_work_sync(&adapter->init_task);
 	cancel_work_sync(&adapter->reset_task);
 	cancel_delayed_work_sync(&adapter->client_task);
@@ -3884,39 +3884,39 @@ static void i40evf_remove(struct pci_dev *pdev)
 		adapter->netdev_registered = false;
 	}
 	if (CLIENT_ALLOWED(adapter)) {
-		err = i40evf_lan_del_device(adapter);
+		err = iavf_lan_del_device(adapter);
 		if (err)
 			dev_warn(&pdev->dev, "Failed to delete client device: %d\n",
 				 err);
 	}
 
 	/* Shut down all the garbage mashers on the detention level */
-	adapter->state = __I40EVF_REMOVE;
+	adapter->state = __IAVF_REMOVE;
 	adapter->aq_required = 0;
-	adapter->flags &= ~I40EVF_FLAG_REINIT_ITR_NEEDED;
-	i40evf_request_reset(adapter);
+	adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
+	iavf_request_reset(adapter);
 	msleep(50);
 	/* If the FW isn't responding, kick it once, but only once. */
-	if (!i40evf_asq_done(hw)) {
-		i40evf_request_reset(adapter);
+	if (!iavf_asq_done(hw)) {
+		iavf_request_reset(adapter);
 		msleep(50);
 	}
-	i40evf_free_all_tx_resources(adapter);
-	i40evf_free_all_rx_resources(adapter);
-	i40evf_misc_irq_disable(adapter);
-	i40evf_free_misc_irq(adapter);
-	i40evf_reset_interrupt_capability(adapter);
-	i40evf_free_q_vectors(adapter);
+	iavf_free_all_tx_resources(adapter);
+	iavf_free_all_rx_resources(adapter);
+	iavf_misc_irq_disable(adapter);
+	iavf_free_misc_irq(adapter);
+	iavf_reset_interrupt_capability(adapter);
+	iavf_free_q_vectors(adapter);
 
 	if (adapter->watchdog_timer.function)
 		del_timer_sync(&adapter->watchdog_timer);
 
 	cancel_work_sync(&adapter->adminq_task);
 
-	i40evf_free_rss(adapter);
+	iavf_free_rss(adapter);
 
 	if (hw->aq.asq.count)
-		i40evf_shutdown_adminq(hw);
+		iavf_shutdown_adminq(hw);
 
 	/* destroy the locks only once, here */
 	mutex_destroy(&hw->aq.arq_mutex);
@@ -3924,9 +3924,9 @@ static void i40evf_remove(struct pci_dev *pdev)
 
 	iounmap(hw->hw_addr);
 	pci_release_regions(pdev);
-	i40evf_free_all_tx_resources(adapter);
-	i40evf_free_all_rx_resources(adapter);
-	i40evf_free_queues(adapter);
+	iavf_free_all_tx_resources(adapter);
+	iavf_free_all_rx_resources(adapter);
+	iavf_free_queues(adapter);
 	kfree(adapter->vf_res);
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 	/* If we got removed before an up/down sequence, we've got a filter
@@ -3958,16 +3958,16 @@ static void i40evf_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
-static struct pci_driver i40evf_driver = {
-	.name     = i40evf_driver_name,
-	.id_table = i40evf_pci_tbl,
-	.probe    = i40evf_probe,
-	.remove   = i40evf_remove,
+static struct pci_driver iavf_driver = {
+	.name     = iavf_driver_name,
+	.id_table = iavf_pci_tbl,
+	.probe    = iavf_probe,
+	.remove   = iavf_remove,
 #ifdef CONFIG_PM
-	.suspend  = i40evf_suspend,
-	.resume   = i40evf_resume,
+	.suspend  = iavf_suspend,
+	.resume   = iavf_resume,
 #endif
-	.shutdown = i40evf_shutdown,
+	.shutdown = iavf_shutdown,
 };
 
 /**
@@ -3976,26 +3976,26 @@ static struct pci_driver i40evf_driver = {
  * i40e_init_module is the first routine called when the driver is
  * loaded. All it does is register with the PCI subsystem.
  **/
-static int __init i40evf_init_module(void)
+static int __init iavf_init_module(void)
 {
 	int ret;
 
-	pr_info("i40evf: %s - version %s\n", i40evf_driver_string,
-		i40evf_driver_version);
+	pr_info("iavf: %s - version %s\n", iavf_driver_string,
+		iavf_driver_version);
 
-	pr_info("%s\n", i40evf_copyright);
+	pr_info("%s\n", iavf_copyright);
 
-	i40evf_wq = alloc_workqueue("%s", WQ_UNBOUND | WQ_MEM_RECLAIM, 1,
-				    i40evf_driver_name);
-	if (!i40evf_wq) {
-		pr_err("%s: Failed to create workqueue\n", i40evf_driver_name);
+	iavf_wq = alloc_workqueue("%s", WQ_UNBOUND | WQ_MEM_RECLAIM, 1,
+				    iavf_driver_name);
+	if (!iavf_wq) {
+		pr_err("%s: Failed to create workqueue\n", iavf_driver_name);
 		return -ENOMEM;
 	}
-	ret = pci_register_driver(&i40evf_driver);
+	ret = pci_register_driver(&iavf_driver);
 	return ret;
 }
 
-module_init(i40evf_init_module);
+module_init(iavf_init_module);
 
 /**
  * i40e_exit_module - Driver Exit Cleanup Routine
@@ -4003,12 +4003,12 @@ module_init(i40evf_init_module);
  * i40e_exit_module is called just before the driver is removed
  * from memory.
  **/
-static void __exit i40evf_exit_module(void)
+static void __exit iavf_exit_module(void)
 {
-	pci_unregister_driver(&i40evf_driver);
-	destroy_workqueue(i40evf_wq);
+	pci_unregister_driver(&iavf_driver);
+	destroy_workqueue(iavf_wq);
 }
 
-module_exit(i40evf_exit_module);
+module_exit(iavf_exit_module);
 
-/* i40evf_main.c */
+/* iavf_main.c */
diff --git a/drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c
index 6579dabab78c..4dbba07fd383 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c
@@ -6,11 +6,11 @@
 #include "i40evf_client.h"
 
 /* busy wait delay in msec */
-#define I40EVF_BUSY_WAIT_DELAY 10
-#define I40EVF_BUSY_WAIT_COUNT 50
+#define IAVF_BUSY_WAIT_DELAY 10
+#define IAVF_BUSY_WAIT_COUNT 50
 
 /**
- * i40evf_send_pf_msg
+ * iavf_send_pf_msg
  * @adapter: adapter structure
  * @op: virtual channel opcode
  * @msg: pointer to message buffer
@@ -18,44 +18,44 @@
  *
  * Send message to PF and print status if failure.
  **/
-static int i40evf_send_pf_msg(struct i40evf_adapter *adapter,
+static int iavf_send_pf_msg(struct iavf_adapter *adapter,
 			      enum virtchnl_ops op, u8 *msg, u16 len)
 {
 	struct i40e_hw *hw = &adapter->hw;
 	i40e_status err;
 
-	if (adapter->flags & I40EVF_FLAG_PF_COMMS_FAILED)
+	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
 		return 0; /* nothing to see here, move along */
 
-	err = i40e_aq_send_msg_to_pf(hw, op, 0, msg, len, NULL);
+	err = iavf_aq_send_msg_to_pf(hw, op, 0, msg, len, NULL);
 	if (err)
 		dev_dbg(&adapter->pdev->dev, "Unable to send opcode %d to PF, err %s, aq_err %s\n",
-			op, i40evf_stat_str(hw, err),
-			i40evf_aq_str(hw, hw->aq.asq_last_status));
+			op, iavf_stat_str(hw, err),
+			iavf_aq_str(hw, hw->aq.asq_last_status));
 	return err;
 }
 
 /**
- * i40evf_send_api_ver
+ * iavf_send_api_ver
  * @adapter: adapter structure
  *
  * Send API version admin queue message to the PF. The reply is not checked
  * in this function. Returns 0 if the message was successfully
  * sent, or one of the I40E_ADMIN_QUEUE_ERROR_ statuses if not.
  **/
-int i40evf_send_api_ver(struct i40evf_adapter *adapter)
+int iavf_send_api_ver(struct iavf_adapter *adapter)
 {
 	struct virtchnl_version_info vvi;
 
 	vvi.major = VIRTCHNL_VERSION_MAJOR;
 	vvi.minor = VIRTCHNL_VERSION_MINOR;
 
-	return i40evf_send_pf_msg(adapter, VIRTCHNL_OP_VERSION, (u8 *)&vvi,
+	return iavf_send_pf_msg(adapter, VIRTCHNL_OP_VERSION, (u8 *)&vvi,
 				  sizeof(vvi));
 }
 
 /**
- * i40evf_verify_api_ver
+ * iavf_verify_api_ver
  * @adapter: adapter structure
  *
  * Compare API versions with the PF. Must be called after admin queue is
@@ -63,7 +63,7 @@ int i40evf_send_api_ver(struct i40evf_adapter *adapter)
  * I40E_ERR_ADMIN_QUEUE_NO_WORK if the admin queue is empty, and any errors
  * from the firmware are propagated.
  **/
-int i40evf_verify_api_ver(struct i40evf_adapter *adapter)
+int iavf_verify_api_ver(struct iavf_adapter *adapter)
 {
 	struct virtchnl_version_info *pf_vvi;
 	struct i40e_hw *hw = &adapter->hw;
@@ -71,7 +71,7 @@ int i40evf_verify_api_ver(struct i40evf_adapter *adapter)
 	enum virtchnl_ops op;
 	i40e_status err;
 
-	event.buf_len = I40EVF_MAX_AQ_BUF_SIZE;
+	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
 	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
 	if (!event.msg_buf) {
 		err = -ENOMEM;
@@ -79,8 +79,8 @@ int i40evf_verify_api_ver(struct i40evf_adapter *adapter)
 	}
 
 	while (1) {
-		err = i40evf_clean_arq_element(hw, &event, NULL);
-		/* When the AQ is empty, i40evf_clean_arq_element will return
+		err = iavf_clean_arq_element(hw, &event, NULL);
+		/* When the AQ is empty, iavf_clean_arq_element will return
 		 * nonzero and this loop will terminate.
 		 */
 		if (err)
@@ -118,14 +118,14 @@ int i40evf_verify_api_ver(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_send_vf_config_msg
+ * iavf_send_vf_config_msg
  * @adapter: adapter structure
  *
  * Send VF configuration request admin queue message to the PF. The reply
  * is not checked in this function. Returns 0 if the message was
  * successfully sent, or one of the I40E_ADMIN_QUEUE_ERROR_ statuses if not.
  **/
-int i40evf_send_vf_config_msg(struct i40evf_adapter *adapter)
+int iavf_send_vf_config_msg(struct iavf_adapter *adapter)
 {
 	u32 caps;
 
@@ -142,45 +142,45 @@ int i40evf_send_vf_config_msg(struct i40evf_adapter *adapter)
 	       VIRTCHNL_VF_OFFLOAD_ADQ;
 
 	adapter->current_op = VIRTCHNL_OP_GET_VF_RESOURCES;
-	adapter->aq_required &= ~I40EVF_FLAG_AQ_GET_CONFIG;
+	adapter->aq_required &= ~IAVF_FLAG_AQ_GET_CONFIG;
 	if (PF_IS_V11(adapter))
-		return i40evf_send_pf_msg(adapter,
+		return iavf_send_pf_msg(adapter,
 					  VIRTCHNL_OP_GET_VF_RESOURCES,
 					  (u8 *)&caps, sizeof(caps));
 	else
-		return i40evf_send_pf_msg(adapter,
+		return iavf_send_pf_msg(adapter,
 					  VIRTCHNL_OP_GET_VF_RESOURCES,
 					  NULL, 0);
 }
 
 /**
- * i40evf_validate_num_queues
+ * iavf_validate_num_queues
  * @adapter: adapter structure
  *
  * Validate that the number of queues the PF has sent in
  * VIRTCHNL_OP_GET_VF_RESOURCES is not larger than the VF can handle.
  **/
-static void i40evf_validate_num_queues(struct i40evf_adapter *adapter)
+static void iavf_validate_num_queues(struct iavf_adapter *adapter)
 {
-	if (adapter->vf_res->num_queue_pairs > I40EVF_MAX_REQ_QUEUES) {
+	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
 		struct virtchnl_vsi_resource *vsi_res;
 		int i;
 
 		dev_info(&adapter->pdev->dev, "Received %d queues, but can only have a max of %d\n",
 			 adapter->vf_res->num_queue_pairs,
-			 I40EVF_MAX_REQ_QUEUES);
+			 IAVF_MAX_REQ_QUEUES);
 		dev_info(&adapter->pdev->dev, "Fixing by reducing queues to %d\n",
-			 I40EVF_MAX_REQ_QUEUES);
-		adapter->vf_res->num_queue_pairs = I40EVF_MAX_REQ_QUEUES;
+			 IAVF_MAX_REQ_QUEUES);
+		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
 		for (i = 0; i < adapter->vf_res->num_vsis; i++) {
 			vsi_res = &adapter->vf_res->vsi_res[i];
-			vsi_res->num_queue_pairs = I40EVF_MAX_REQ_QUEUES;
+			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
 		}
 	}
 }
 
 /**
- * i40evf_get_vf_config
+ * iavf_get_vf_config
  * @adapter: private adapter structure
  *
  * Get VF configuration from PF and populate hw structure. Must be called after
@@ -188,7 +188,7 @@ static void i40evf_validate_num_queues(struct i40evf_adapter *adapter)
  * with maximum timeout. Response from PF is returned in the buffer for further
  * processing by the caller.
  **/
-int i40evf_get_vf_config(struct i40evf_adapter *adapter)
+int iavf_get_vf_config(struct iavf_adapter *adapter)
 {
 	struct i40e_hw *hw = &adapter->hw;
 	struct i40e_arq_event_info event;
@@ -206,10 +206,10 @@ int i40evf_get_vf_config(struct i40evf_adapter *adapter)
 	}
 
 	while (1) {
-		/* When the AQ is empty, i40evf_clean_arq_element will return
+		/* When the AQ is empty, iavf_clean_arq_element will return
 		 * nonzero and this loop will terminate.
 		 */
-		err = i40evf_clean_arq_element(hw, &event, NULL);
+		err = iavf_clean_arq_element(hw, &event, NULL);
 		if (err)
 			goto out_alloc;
 		op =
@@ -225,8 +225,8 @@ int i40evf_get_vf_config(struct i40evf_adapter *adapter)
 	 * we aren't getting too many queues
 	 */
 	if (!err)
-		i40evf_validate_num_queues(adapter);
-	i40e_vf_parse_hw_config(hw, adapter->vf_res);
+		iavf_validate_num_queues(adapter);
+	iavf_vf_parse_hw_config(hw, adapter->vf_res);
 out_alloc:
 	kfree(event.msg_buf);
 out:
@@ -234,12 +234,12 @@ int i40evf_get_vf_config(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_configure_queues
+ * iavf_configure_queues
  * @adapter: adapter structure
  *
  * Request that the PF set up our (previously allocated) queues.
  **/
-void i40evf_configure_queues(struct i40evf_adapter *adapter)
+void iavf_configure_queues(struct iavf_adapter *adapter)
 {
 	struct virtchnl_vsi_queue_config_info *vqci;
 	struct virtchnl_queue_pair_info *vqpi;
@@ -260,7 +260,7 @@ void i40evf_configure_queues(struct i40evf_adapter *adapter)
 		return;
 
 	/* Limit maximum frame size when jumbo frames is not enabled */
-	if (!(adapter->flags & I40EVF_FLAG_LEGACY_RX) &&
+	if (!(adapter->flags & IAVF_FLAG_LEGACY_RX) &&
 	    (adapter->netdev->mtu <= ETH_DATA_LEN))
 		max_frame = I40E_RXBUFFER_1536 - NET_IP_ALIGN;
 
@@ -286,19 +286,19 @@ void i40evf_configure_queues(struct i40evf_adapter *adapter)
 		vqpi++;
 	}
 
-	adapter->aq_required &= ~I40EVF_FLAG_AQ_CONFIGURE_QUEUES;
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_VSI_QUEUES,
+	adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_VSI_QUEUES,
 			   (u8 *)vqci, len);
 	kfree(vqci);
 }
 
 /**
- * i40evf_enable_queues
+ * iavf_enable_queues
  * @adapter: adapter structure
  *
  * Request that the PF enable all of our queues.
  **/
-void i40evf_enable_queues(struct i40evf_adapter *adapter)
+void iavf_enable_queues(struct iavf_adapter *adapter)
 {
 	struct virtchnl_queue_select vqs;
 
@@ -312,18 +312,18 @@ void i40evf_enable_queues(struct i40evf_adapter *adapter)
 	vqs.vsi_id = adapter->vsi_res->vsi_id;
 	vqs.tx_queues = BIT(adapter->num_active_queues) - 1;
 	vqs.rx_queues = vqs.tx_queues;
-	adapter->aq_required &= ~I40EVF_FLAG_AQ_ENABLE_QUEUES;
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_ENABLE_QUEUES,
+	adapter->aq_required &= ~IAVF_FLAG_AQ_ENABLE_QUEUES;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ENABLE_QUEUES,
 			   (u8 *)&vqs, sizeof(vqs));
 }
 
 /**
- * i40evf_disable_queues
+ * iavf_disable_queues
  * @adapter: adapter structure
  *
  * Request that the PF disable all of our queues.
  **/
-void i40evf_disable_queues(struct i40evf_adapter *adapter)
+void iavf_disable_queues(struct iavf_adapter *adapter)
 {
 	struct virtchnl_queue_select vqs;
 
@@ -337,19 +337,19 @@ void i40evf_disable_queues(struct i40evf_adapter *adapter)
 	vqs.vsi_id = adapter->vsi_res->vsi_id;
 	vqs.tx_queues = BIT(adapter->num_active_queues) - 1;
 	vqs.rx_queues = vqs.tx_queues;
-	adapter->aq_required &= ~I40EVF_FLAG_AQ_DISABLE_QUEUES;
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_QUEUES,
+	adapter->aq_required &= ~IAVF_FLAG_AQ_DISABLE_QUEUES;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_QUEUES,
 			   (u8 *)&vqs, sizeof(vqs));
 }
 
 /**
- * i40evf_map_queues
+ * iavf_map_queues
  * @adapter: adapter structure
  *
  * Request that the PF map queues to interrupt vectors. Misc causes, including
  * admin queue, are always mapped to vector 0.
  **/
-void i40evf_map_queues(struct i40evf_adapter *adapter)
+void iavf_map_queues(struct iavf_adapter *adapter)
 {
 	struct virtchnl_irq_map_info *vimi;
 	struct virtchnl_vector_map *vecmap;
@@ -393,21 +393,21 @@ void i40evf_map_queues(struct i40evf_adapter *adapter)
 	vecmap->txq_map = 0;
 	vecmap->rxq_map = 0;
 
-	adapter->aq_required &= ~I40EVF_FLAG_AQ_MAP_VECTORS;
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_IRQ_MAP,
+	adapter->aq_required &= ~IAVF_FLAG_AQ_MAP_VECTORS;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_IRQ_MAP,
 			   (u8 *)vimi, len);
 	kfree(vimi);
 }
 
 /**
- * i40evf_request_queues
+ * iavf_request_queues
  * @adapter: adapter structure
  * @num: number of requested queues
  *
  * We get a default number of queues from the PF.  This enables us to request a
  * different number.  Returns 0 on success, negative on failure
  **/
-int i40evf_request_queues(struct i40evf_adapter *adapter, int num)
+int iavf_request_queues(struct iavf_adapter *adapter, int num)
 {
 	struct virtchnl_vf_res_request vfres;
 
@@ -421,22 +421,22 @@ int i40evf_request_queues(struct i40evf_adapter *adapter, int num)
 	vfres.num_queue_pairs = num;
 
 	adapter->current_op = VIRTCHNL_OP_REQUEST_QUEUES;
-	adapter->flags |= I40EVF_FLAG_REINIT_ITR_NEEDED;
-	return i40evf_send_pf_msg(adapter, VIRTCHNL_OP_REQUEST_QUEUES,
+	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
+	return iavf_send_pf_msg(adapter, VIRTCHNL_OP_REQUEST_QUEUES,
 				  (u8 *)&vfres, sizeof(vfres));
 }
 
 /**
- * i40evf_add_ether_addrs
+ * iavf_add_ether_addrs
  * @adapter: adapter structure
  *
  * Request that the PF add one or more addresses to our filters.
  **/
-void i40evf_add_ether_addrs(struct i40evf_adapter *adapter)
+void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 {
 	struct virtchnl_ether_addr_list *veal;
 	int len, i = 0, count = 0;
-	struct i40evf_mac_filter *f;
+	struct iavf_mac_filter *f;
 	bool more = false;
 
 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
@@ -453,7 +453,7 @@ void i40evf_add_ether_addrs(struct i40evf_adapter *adapter)
 			count++;
 	}
 	if (!count) {
-		adapter->aq_required &= ~I40EVF_FLAG_AQ_ADD_MAC_FILTER;
+		adapter->aq_required &= ~IAVF_FLAG_AQ_ADD_MAC_FILTER;
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);
 		return;
 	}
@@ -461,9 +461,9 @@ void i40evf_add_ether_addrs(struct i40evf_adapter *adapter)
 
 	len = sizeof(struct virtchnl_ether_addr_list) +
 	      (count * sizeof(struct virtchnl_ether_addr));
-	if (len > I40EVF_MAX_AQ_BUF_SIZE) {
+	if (len > IAVF_MAX_AQ_BUF_SIZE) {
 		dev_warn(&adapter->pdev->dev, "Too many add MAC changes in one request\n");
-		count = (I40EVF_MAX_AQ_BUF_SIZE -
+		count = (IAVF_MAX_AQ_BUF_SIZE -
 			 sizeof(struct virtchnl_ether_addr_list)) /
 			sizeof(struct virtchnl_ether_addr);
 		len = sizeof(struct virtchnl_ether_addr_list) +
@@ -489,25 +489,25 @@ void i40evf_add_ether_addrs(struct i40evf_adapter *adapter)
 		}
 	}
 	if (!more)
-		adapter->aq_required &= ~I40EVF_FLAG_AQ_ADD_MAC_FILTER;
+		adapter->aq_required &= ~IAVF_FLAG_AQ_ADD_MAC_FILTER;
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR,
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR,
 			   (u8 *)veal, len);
 	kfree(veal);
 }
 
 /**
- * i40evf_del_ether_addrs
+ * iavf_del_ether_addrs
  * @adapter: adapter structure
  *
  * Request that the PF remove one or more addresses from our filters.
  **/
-void i40evf_del_ether_addrs(struct i40evf_adapter *adapter)
+void iavf_del_ether_addrs(struct iavf_adapter *adapter)
 {
 	struct virtchnl_ether_addr_list *veal;
-	struct i40evf_mac_filter *f, *ftmp;
+	struct iavf_mac_filter *f, *ftmp;
 	int len, i = 0, count = 0;
 	bool more = false;
 
@@ -525,7 +525,7 @@ void i40evf_del_ether_addrs(struct i40evf_adapter *adapter)
 			count++;
 	}
 	if (!count) {
-		adapter->aq_required &= ~I40EVF_FLAG_AQ_DEL_MAC_FILTER;
+		adapter->aq_required &= ~IAVF_FLAG_AQ_DEL_MAC_FILTER;
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);
 		return;
 	}
@@ -533,9 +533,9 @@ void i40evf_del_ether_addrs(struct i40evf_adapter *adapter)
 
 	len = sizeof(struct virtchnl_ether_addr_list) +
 	      (count * sizeof(struct virtchnl_ether_addr));
-	if (len > I40EVF_MAX_AQ_BUF_SIZE) {
+	if (len > IAVF_MAX_AQ_BUF_SIZE) {
 		dev_warn(&adapter->pdev->dev, "Too many delete MAC changes in one request\n");
-		count = (I40EVF_MAX_AQ_BUF_SIZE -
+		count = (IAVF_MAX_AQ_BUF_SIZE -
 			 sizeof(struct virtchnl_ether_addr_list)) /
 			sizeof(struct virtchnl_ether_addr);
 		len = sizeof(struct virtchnl_ether_addr_list) +
@@ -561,26 +561,26 @@ void i40evf_del_ether_addrs(struct i40evf_adapter *adapter)
 		}
 	}
 	if (!more)
-		adapter->aq_required &= ~I40EVF_FLAG_AQ_DEL_MAC_FILTER;
+		adapter->aq_required &= ~IAVF_FLAG_AQ_DEL_MAC_FILTER;
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_DEL_ETH_ADDR,
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DEL_ETH_ADDR,
 			   (u8 *)veal, len);
 	kfree(veal);
 }
 
 /**
- * i40evf_add_vlans
+ * iavf_add_vlans
  * @adapter: adapter structure
  *
  * Request that the PF add one or more VLAN filters to our VSI.
  **/
-void i40evf_add_vlans(struct i40evf_adapter *adapter)
+void iavf_add_vlans(struct iavf_adapter *adapter)
 {
 	struct virtchnl_vlan_filter_list *vvfl;
 	int len, i = 0, count = 0;
-	struct i40evf_vlan_filter *f;
+	struct iavf_vlan_filter *f;
 	bool more = false;
 
 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
@@ -597,7 +597,7 @@ void i40evf_add_vlans(struct i40evf_adapter *adapter)
 			count++;
 	}
 	if (!count) {
-		adapter->aq_required &= ~I40EVF_FLAG_AQ_ADD_VLAN_FILTER;
+		adapter->aq_required &= ~IAVF_FLAG_AQ_ADD_VLAN_FILTER;
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);
 		return;
 	}
@@ -605,9 +605,9 @@ void i40evf_add_vlans(struct i40evf_adapter *adapter)
 
 	len = sizeof(struct virtchnl_vlan_filter_list) +
 	      (count * sizeof(u16));
-	if (len > I40EVF_MAX_AQ_BUF_SIZE) {
+	if (len > IAVF_MAX_AQ_BUF_SIZE) {
 		dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
-		count = (I40EVF_MAX_AQ_BUF_SIZE -
+		count = (IAVF_MAX_AQ_BUF_SIZE -
 			 sizeof(struct virtchnl_vlan_filter_list)) /
 			sizeof(u16);
 		len = sizeof(struct virtchnl_vlan_filter_list) +
@@ -632,24 +632,24 @@ void i40evf_add_vlans(struct i40evf_adapter *adapter)
 		}
 	}
 	if (!more)
-		adapter->aq_required &= ~I40EVF_FLAG_AQ_ADD_VLAN_FILTER;
+		adapter->aq_required &= ~IAVF_FLAG_AQ_ADD_VLAN_FILTER;
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_VLAN, (u8 *)vvfl, len);
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_VLAN, (u8 *)vvfl, len);
 	kfree(vvfl);
 }
 
 /**
- * i40evf_del_vlans
+ * iavf_del_vlans
  * @adapter: adapter structure
  *
  * Request that the PF remove one or more VLAN filters from our VSI.
  **/
-void i40evf_del_vlans(struct i40evf_adapter *adapter)
+void iavf_del_vlans(struct iavf_adapter *adapter)
 {
 	struct virtchnl_vlan_filter_list *vvfl;
-	struct i40evf_vlan_filter *f, *ftmp;
+	struct iavf_vlan_filter *f, *ftmp;
 	int len, i = 0, count = 0;
 	bool more = false;
 
@@ -667,7 +667,7 @@ void i40evf_del_vlans(struct i40evf_adapter *adapter)
 			count++;
 	}
 	if (!count) {
-		adapter->aq_required &= ~I40EVF_FLAG_AQ_DEL_VLAN_FILTER;
+		adapter->aq_required &= ~IAVF_FLAG_AQ_DEL_VLAN_FILTER;
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);
 		return;
 	}
@@ -675,9 +675,9 @@ void i40evf_del_vlans(struct i40evf_adapter *adapter)
 
 	len = sizeof(struct virtchnl_vlan_filter_list) +
 	      (count * sizeof(u16));
-	if (len > I40EVF_MAX_AQ_BUF_SIZE) {
+	if (len > IAVF_MAX_AQ_BUF_SIZE) {
 		dev_warn(&adapter->pdev->dev, "Too many delete VLAN changes in one request\n");
-		count = (I40EVF_MAX_AQ_BUF_SIZE -
+		count = (IAVF_MAX_AQ_BUF_SIZE -
 			 sizeof(struct virtchnl_vlan_filter_list)) /
 			sizeof(u16);
 		len = sizeof(struct virtchnl_vlan_filter_list) +
@@ -703,22 +703,22 @@ void i40evf_del_vlans(struct i40evf_adapter *adapter)
 		}
 	}
 	if (!more)
-		adapter->aq_required &= ~I40EVF_FLAG_AQ_DEL_VLAN_FILTER;
+		adapter->aq_required &= ~IAVF_FLAG_AQ_DEL_VLAN_FILTER;
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_DEL_VLAN, (u8 *)vvfl, len);
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DEL_VLAN, (u8 *)vvfl, len);
 	kfree(vvfl);
 }
 
 /**
- * i40evf_set_promiscuous
+ * iavf_set_promiscuous
  * @adapter: adapter structure
  * @flags: bitmask to control unicast/multicast promiscuous.
  *
  * Request that the PF enable promiscuous mode for our VSI.
  **/
-void i40evf_set_promiscuous(struct i40evf_adapter *adapter, int flags)
+void iavf_set_promiscuous(struct iavf_adapter *adapter, int flags)
 {
 	struct virtchnl_promisc_info vpi;
 	int promisc_all;
@@ -733,39 +733,39 @@ void i40evf_set_promiscuous(struct i40evf_adapter *adapter, int flags)
 	promisc_all = FLAG_VF_UNICAST_PROMISC |
 		      FLAG_VF_MULTICAST_PROMISC;
 	if ((flags & promisc_all) == promisc_all) {
-		adapter->flags |= I40EVF_FLAG_PROMISC_ON;
-		adapter->aq_required &= ~I40EVF_FLAG_AQ_REQUEST_PROMISC;
+		adapter->flags |= IAVF_FLAG_PROMISC_ON;
+		adapter->aq_required &= ~IAVF_FLAG_AQ_REQUEST_PROMISC;
 		dev_info(&adapter->pdev->dev, "Entering promiscuous mode\n");
 	}
 
 	if (flags & FLAG_VF_MULTICAST_PROMISC) {
-		adapter->flags |= I40EVF_FLAG_ALLMULTI_ON;
-		adapter->aq_required &= ~I40EVF_FLAG_AQ_REQUEST_ALLMULTI;
+		adapter->flags |= IAVF_FLAG_ALLMULTI_ON;
+		adapter->aq_required &= ~IAVF_FLAG_AQ_REQUEST_ALLMULTI;
 		dev_info(&adapter->pdev->dev, "Entering multicast promiscuous mode\n");
 	}
 
 	if (!flags) {
-		adapter->flags &= ~(I40EVF_FLAG_PROMISC_ON |
-				    I40EVF_FLAG_ALLMULTI_ON);
-		adapter->aq_required &= ~(I40EVF_FLAG_AQ_RELEASE_PROMISC |
-					  I40EVF_FLAG_AQ_RELEASE_ALLMULTI);
+		adapter->flags &= ~(IAVF_FLAG_PROMISC_ON |
+				    IAVF_FLAG_ALLMULTI_ON);
+		adapter->aq_required &= ~(IAVF_FLAG_AQ_RELEASE_PROMISC |
+					  IAVF_FLAG_AQ_RELEASE_ALLMULTI);
 		dev_info(&adapter->pdev->dev, "Leaving promiscuous mode\n");
 	}
 
 	adapter->current_op = VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE;
 	vpi.vsi_id = adapter->vsi_res->vsi_id;
 	vpi.flags = flags;
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE,
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE,
 			   (u8 *)&vpi, sizeof(vpi));
 }
 
 /**
- * i40evf_request_stats
+ * iavf_request_stats
  * @adapter: adapter structure
  *
  * Request VSI statistics from PF.
  **/
-void i40evf_request_stats(struct i40evf_adapter *adapter)
+void iavf_request_stats(struct iavf_adapter *adapter)
 {
 	struct virtchnl_queue_select vqs;
 
@@ -776,19 +776,19 @@ void i40evf_request_stats(struct i40evf_adapter *adapter)
 	adapter->current_op = VIRTCHNL_OP_GET_STATS;
 	vqs.vsi_id = adapter->vsi_res->vsi_id;
 	/* queue maps are ignored for this message - only the vsi is used */
-	if (i40evf_send_pf_msg(adapter, VIRTCHNL_OP_GET_STATS,
+	if (iavf_send_pf_msg(adapter, VIRTCHNL_OP_GET_STATS,
 			       (u8 *)&vqs, sizeof(vqs)))
 		/* if the request failed, don't lock out others */
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 }
 
 /**
- * i40evf_get_hena
+ * iavf_get_hena
  * @adapter: adapter structure
  *
  * Request hash enable capabilities from PF
  **/
-void i40evf_get_hena(struct i40evf_adapter *adapter)
+void iavf_get_hena(struct iavf_adapter *adapter)
 {
 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
@@ -797,18 +797,18 @@ void i40evf_get_hena(struct i40evf_adapter *adapter)
 		return;
 	}
 	adapter->current_op = VIRTCHNL_OP_GET_RSS_HENA_CAPS;
-	adapter->aq_required &= ~I40EVF_FLAG_AQ_GET_HENA;
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_GET_RSS_HENA_CAPS,
+	adapter->aq_required &= ~IAVF_FLAG_AQ_GET_HENA;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_GET_RSS_HENA_CAPS,
 			   NULL, 0);
 }
 
 /**
- * i40evf_set_hena
+ * iavf_set_hena
  * @adapter: adapter structure
  *
  * Request the PF to set our RSS hash capabilities
  **/
-void i40evf_set_hena(struct i40evf_adapter *adapter)
+void iavf_set_hena(struct iavf_adapter *adapter)
 {
 	struct virtchnl_rss_hena vrh;
 
@@ -820,18 +820,18 @@ void i40evf_set_hena(struct i40evf_adapter *adapter)
 	}
 	vrh.hena = adapter->hena;
 	adapter->current_op = VIRTCHNL_OP_SET_RSS_HENA;
-	adapter->aq_required &= ~I40EVF_FLAG_AQ_SET_HENA;
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_SET_RSS_HENA,
+	adapter->aq_required &= ~IAVF_FLAG_AQ_SET_HENA;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_SET_RSS_HENA,
 			   (u8 *)&vrh, sizeof(vrh));
 }
 
 /**
- * i40evf_set_rss_key
+ * iavf_set_rss_key
  * @adapter: adapter structure
  *
  * Request the PF to set our RSS hash key
  **/
-void i40evf_set_rss_key(struct i40evf_adapter *adapter)
+void iavf_set_rss_key(struct iavf_adapter *adapter)
 {
 	struct virtchnl_rss_key *vrk;
 	int len;
@@ -852,19 +852,19 @@ void i40evf_set_rss_key(struct i40evf_adapter *adapter)
 	memcpy(vrk->key, adapter->rss_key, adapter->rss_key_size);
 
 	adapter->current_op = VIRTCHNL_OP_CONFIG_RSS_KEY;
-	adapter->aq_required &= ~I40EVF_FLAG_AQ_SET_RSS_KEY;
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_RSS_KEY,
+	adapter->aq_required &= ~IAVF_FLAG_AQ_SET_RSS_KEY;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_RSS_KEY,
 			   (u8 *)vrk, len);
 	kfree(vrk);
 }
 
 /**
- * i40evf_set_rss_lut
+ * iavf_set_rss_lut
  * @adapter: adapter structure
  *
  * Request the PF to set our RSS lookup table
  **/
-void i40evf_set_rss_lut(struct i40evf_adapter *adapter)
+void iavf_set_rss_lut(struct iavf_adapter *adapter)
 {
 	struct virtchnl_rss_lut *vrl;
 	int len;
@@ -884,19 +884,19 @@ void i40evf_set_rss_lut(struct i40evf_adapter *adapter)
 	vrl->lut_entries = adapter->rss_lut_size;
 	memcpy(vrl->lut, adapter->rss_lut, adapter->rss_lut_size);
 	adapter->current_op = VIRTCHNL_OP_CONFIG_RSS_LUT;
-	adapter->aq_required &= ~I40EVF_FLAG_AQ_SET_RSS_LUT;
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_RSS_LUT,
+	adapter->aq_required &= ~IAVF_FLAG_AQ_SET_RSS_LUT;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_RSS_LUT,
 			   (u8 *)vrl, len);
 	kfree(vrl);
 }
 
 /**
- * i40evf_enable_vlan_stripping
+ * iavf_enable_vlan_stripping
  * @adapter: adapter structure
  *
  * Request VLAN header stripping to be enabled
  **/
-void i40evf_enable_vlan_stripping(struct i40evf_adapter *adapter)
+void iavf_enable_vlan_stripping(struct iavf_adapter *adapter)
 {
 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
@@ -905,18 +905,18 @@ void i40evf_enable_vlan_stripping(struct i40evf_adapter *adapter)
 		return;
 	}
 	adapter->current_op = VIRTCHNL_OP_ENABLE_VLAN_STRIPPING;
-	adapter->aq_required &= ~I40EVF_FLAG_AQ_ENABLE_VLAN_STRIPPING;
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_ENABLE_VLAN_STRIPPING,
+	adapter->aq_required &= ~IAVF_FLAG_AQ_ENABLE_VLAN_STRIPPING;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ENABLE_VLAN_STRIPPING,
 			   NULL, 0);
 }
 
 /**
- * i40evf_disable_vlan_stripping
+ * iavf_disable_vlan_stripping
  * @adapter: adapter structure
  *
  * Request VLAN header stripping to be disabled
  **/
-void i40evf_disable_vlan_stripping(struct i40evf_adapter *adapter)
+void iavf_disable_vlan_stripping(struct iavf_adapter *adapter)
 {
 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
@@ -925,18 +925,18 @@ void i40evf_disable_vlan_stripping(struct i40evf_adapter *adapter)
 		return;
 	}
 	adapter->current_op = VIRTCHNL_OP_DISABLE_VLAN_STRIPPING;
-	adapter->aq_required &= ~I40EVF_FLAG_AQ_DISABLE_VLAN_STRIPPING;
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_VLAN_STRIPPING,
+	adapter->aq_required &= ~IAVF_FLAG_AQ_DISABLE_VLAN_STRIPPING;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_VLAN_STRIPPING,
 			   NULL, 0);
 }
 
 /**
- * i40evf_print_link_message - print link up or down
+ * iavf_print_link_message - print link up or down
  * @adapter: adapter structure
  *
  * Log a message telling the world of our wonderous link status
  */
-static void i40evf_print_link_message(struct i40evf_adapter *adapter)
+static void iavf_print_link_message(struct iavf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	char *speed = "Unknown ";
@@ -973,13 +973,13 @@ static void i40evf_print_link_message(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_enable_channel
+ * iavf_enable_channel
  * @adapter: adapter structure
  *
  * Request that the PF enable channels as specified by
  * the user via tc tool.
  **/
-void i40evf_enable_channels(struct i40evf_adapter *adapter)
+void iavf_enable_channels(struct iavf_adapter *adapter)
 {
 	struct virtchnl_tc_info *vti = NULL;
 	u16 len;
@@ -1007,22 +1007,22 @@ void i40evf_enable_channels(struct i40evf_adapter *adapter)
 				adapter->ch_config.ch_info[i].max_tx_rate;
 	}
 
-	adapter->ch_config.state = __I40EVF_TC_RUNNING;
-	adapter->flags |= I40EVF_FLAG_REINIT_ITR_NEEDED;
+	adapter->ch_config.state = __IAVF_TC_RUNNING;
+	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
 	adapter->current_op = VIRTCHNL_OP_ENABLE_CHANNELS;
-	adapter->aq_required &= ~I40EVF_FLAG_AQ_ENABLE_CHANNELS;
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_ENABLE_CHANNELS,
+	adapter->aq_required &= ~IAVF_FLAG_AQ_ENABLE_CHANNELS;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ENABLE_CHANNELS,
 			   (u8 *)vti, len);
 	kfree(vti);
 }
 
 /**
- * i40evf_disable_channel
+ * iavf_disable_channel
  * @adapter: adapter structure
  *
  * Request that the PF disable channels that are configured
  **/
-void i40evf_disable_channels(struct i40evf_adapter *adapter)
+void iavf_disable_channels(struct iavf_adapter *adapter)
 {
 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
@@ -1031,22 +1031,22 @@ void i40evf_disable_channels(struct i40evf_adapter *adapter)
 		return;
 	}
 
-	adapter->ch_config.state = __I40EVF_TC_INVALID;
-	adapter->flags |= I40EVF_FLAG_REINIT_ITR_NEEDED;
+	adapter->ch_config.state = __IAVF_TC_INVALID;
+	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
 	adapter->current_op = VIRTCHNL_OP_DISABLE_CHANNELS;
-	adapter->aq_required &= ~I40EVF_FLAG_AQ_DISABLE_CHANNELS;
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_CHANNELS,
+	adapter->aq_required &= ~IAVF_FLAG_AQ_DISABLE_CHANNELS;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_CHANNELS,
 			   NULL, 0);
 }
 
 /**
- * i40evf_print_cloud_filter
+ * iavf_print_cloud_filter
  * @adapter: adapter structure
  * @f: cloud filter to print
  *
  * Print the cloud filter
  **/
-static void i40evf_print_cloud_filter(struct i40evf_adapter *adapter,
+static void iavf_print_cloud_filter(struct iavf_adapter *adapter,
 				      struct virtchnl_filter *f)
 {
 	switch (f->flow_type) {
@@ -1074,15 +1074,15 @@ static void i40evf_print_cloud_filter(struct i40evf_adapter *adapter,
 }
 
 /**
- * i40evf_add_cloud_filter
+ * iavf_add_cloud_filter
  * @adapter: adapter structure
  *
  * Request that the PF add cloud filters as specified
  * by the user via tc tool.
  **/
-void i40evf_add_cloud_filter(struct i40evf_adapter *adapter)
+void iavf_add_cloud_filter(struct iavf_adapter *adapter)
 {
-	struct i40evf_cloud_filter *cf;
+	struct iavf_cloud_filter *cf;
 	struct virtchnl_filter *f;
 	int len = 0, count = 0;
 
@@ -1099,7 +1099,7 @@ void i40evf_add_cloud_filter(struct i40evf_adapter *adapter)
 		}
 	}
 	if (!count) {
-		adapter->aq_required &= ~I40EVF_FLAG_AQ_ADD_CLOUD_FILTER;
+		adapter->aq_required &= ~IAVF_FLAG_AQ_ADD_CLOUD_FILTER;
 		return;
 	}
 	adapter->current_op = VIRTCHNL_OP_ADD_CLOUD_FILTER;
@@ -1113,8 +1113,8 @@ void i40evf_add_cloud_filter(struct i40evf_adapter *adapter)
 		if (cf->add) {
 			memcpy(f, &cf->f, sizeof(struct virtchnl_filter));
 			cf->add = false;
-			cf->state = __I40EVF_CF_ADD_PENDING;
-			i40evf_send_pf_msg(adapter,
+			cf->state = __IAVF_CF_ADD_PENDING;
+			iavf_send_pf_msg(adapter,
 					   VIRTCHNL_OP_ADD_CLOUD_FILTER,
 					   (u8 *)f, len);
 		}
@@ -1123,15 +1123,15 @@ void i40evf_add_cloud_filter(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_del_cloud_filter
+ * iavf_del_cloud_filter
  * @adapter: adapter structure
  *
  * Request that the PF delete cloud filters as specified
  * by the user via tc tool.
  **/
-void i40evf_del_cloud_filter(struct i40evf_adapter *adapter)
+void iavf_del_cloud_filter(struct iavf_adapter *adapter)
 {
-	struct i40evf_cloud_filter *cf, *cftmp;
+	struct iavf_cloud_filter *cf, *cftmp;
 	struct virtchnl_filter *f;
 	int len = 0, count = 0;
 
@@ -1148,7 +1148,7 @@ void i40evf_del_cloud_filter(struct i40evf_adapter *adapter)
 		}
 	}
 	if (!count) {
-		adapter->aq_required &= ~I40EVF_FLAG_AQ_DEL_CLOUD_FILTER;
+		adapter->aq_required &= ~IAVF_FLAG_AQ_DEL_CLOUD_FILTER;
 		return;
 	}
 	adapter->current_op = VIRTCHNL_OP_DEL_CLOUD_FILTER;
@@ -1162,8 +1162,8 @@ void i40evf_del_cloud_filter(struct i40evf_adapter *adapter)
 		if (cf->del) {
 			memcpy(f, &cf->f, sizeof(struct virtchnl_filter));
 			cf->del = false;
-			cf->state = __I40EVF_CF_DEL_PENDING;
-			i40evf_send_pf_msg(adapter,
+			cf->state = __IAVF_CF_DEL_PENDING;
+			iavf_send_pf_msg(adapter,
 					   VIRTCHNL_OP_DEL_CLOUD_FILTER,
 					   (u8 *)f, len);
 		}
@@ -1172,20 +1172,20 @@ void i40evf_del_cloud_filter(struct i40evf_adapter *adapter)
 }
 
 /**
- * i40evf_request_reset
+ * iavf_request_reset
  * @adapter: adapter structure
  *
  * Request that the PF reset this VF. No response is expected.
  **/
-void i40evf_request_reset(struct i40evf_adapter *adapter)
+void iavf_request_reset(struct iavf_adapter *adapter)
 {
 	/* Don't check CURRENT_OP - this is always higher priority */
-	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_RESET_VF, NULL, 0);
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_RESET_VF, NULL, 0);
 	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 }
 
 /**
- * i40evf_virtchnl_completion
+ * iavf_virtchnl_completion
  * @adapter: adapter structure
  * @v_opcode: opcode sent by PF
  * @v_retval: retval sent by PF
@@ -1196,7 +1196,7 @@ void i40evf_request_reset(struct i40evf_adapter *adapter)
  * wait, we fire off our requests and assume that no errors will be returned.
  * This function handles the reply messages.
  **/
-void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
+void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 				enum virtchnl_ops v_opcode,
 				i40e_status v_retval,
 				u8 *msg, u16 msglen)
@@ -1224,7 +1224,7 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 				 * after we enable queues and actually prepared
 				 * to send traffic.
 				 */
-				if (adapter->state != __I40EVF_RUNNING)
+				if (adapter->state != __IAVF_RUNNING)
 					break;
 
 				/* For ADq enabled VF, we reconfigure VSIs and
@@ -1232,7 +1232,7 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 				 * queues are enabled.
 				 */
 				if (adapter->flags &
-				    I40EVF_FLAG_QUEUES_DISABLED)
+				    IAVF_FLAG_QUEUES_DISABLED)
 					break;
 			}
 
@@ -1244,12 +1244,12 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 				netif_tx_stop_all_queues(netdev);
 				netif_carrier_off(netdev);
 			}
-			i40evf_print_link_message(adapter);
+			iavf_print_link_message(adapter);
 			break;
 		case VIRTCHNL_EVENT_RESET_IMPENDING:
 			dev_info(&adapter->pdev->dev, "Reset warning received from the PF\n");
-			if (!(adapter->flags & I40EVF_FLAG_RESET_PENDING)) {
-				adapter->flags |= I40EVF_FLAG_RESET_PENDING;
+			if (!(adapter->flags & IAVF_FLAG_RESET_PENDING)) {
+				adapter->flags |= IAVF_FLAG_RESET_PENDING;
 				dev_info(&adapter->pdev->dev, "Scheduling reset task\n");
 				schedule_work(&adapter->reset_task);
 			}
@@ -1265,47 +1265,47 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 		switch (v_opcode) {
 		case VIRTCHNL_OP_ADD_VLAN:
 			dev_err(&adapter->pdev->dev, "Failed to add VLAN filter, error %s\n",
-				i40evf_stat_str(&adapter->hw, v_retval));
+				iavf_stat_str(&adapter->hw, v_retval));
 			break;
 		case VIRTCHNL_OP_ADD_ETH_ADDR:
 			dev_err(&adapter->pdev->dev, "Failed to add MAC filter, error %s\n",
-				i40evf_stat_str(&adapter->hw, v_retval));
+				iavf_stat_str(&adapter->hw, v_retval));
 			break;
 		case VIRTCHNL_OP_DEL_VLAN:
 			dev_err(&adapter->pdev->dev, "Failed to delete VLAN filter, error %s\n",
-				i40evf_stat_str(&adapter->hw, v_retval));
+				iavf_stat_str(&adapter->hw, v_retval));
 			break;
 		case VIRTCHNL_OP_DEL_ETH_ADDR:
 			dev_err(&adapter->pdev->dev, "Failed to delete MAC filter, error %s\n",
-				i40evf_stat_str(&adapter->hw, v_retval));
+				iavf_stat_str(&adapter->hw, v_retval));
 			break;
 		case VIRTCHNL_OP_ENABLE_CHANNELS:
 			dev_err(&adapter->pdev->dev, "Failed to configure queue channels, error %s\n",
-				i40evf_stat_str(&adapter->hw, v_retval));
-			adapter->flags &= ~I40EVF_FLAG_REINIT_ITR_NEEDED;
-			adapter->ch_config.state = __I40EVF_TC_INVALID;
+				iavf_stat_str(&adapter->hw, v_retval));
+			adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
+			adapter->ch_config.state = __IAVF_TC_INVALID;
 			netdev_reset_tc(netdev);
 			netif_tx_start_all_queues(netdev);
 			break;
 		case VIRTCHNL_OP_DISABLE_CHANNELS:
 			dev_err(&adapter->pdev->dev, "Failed to disable queue channels, error %s\n",
-				i40evf_stat_str(&adapter->hw, v_retval));
-			adapter->flags &= ~I40EVF_FLAG_REINIT_ITR_NEEDED;
-			adapter->ch_config.state = __I40EVF_TC_RUNNING;
+				iavf_stat_str(&adapter->hw, v_retval));
+			adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
+			adapter->ch_config.state = __IAVF_TC_RUNNING;
 			netif_tx_start_all_queues(netdev);
 			break;
 		case VIRTCHNL_OP_ADD_CLOUD_FILTER: {
-			struct i40evf_cloud_filter *cf, *cftmp;
+			struct iavf_cloud_filter *cf, *cftmp;
 
 			list_for_each_entry_safe(cf, cftmp,
 						 &adapter->cloud_filter_list,
 						 list) {
-				if (cf->state == __I40EVF_CF_ADD_PENDING) {
-					cf->state = __I40EVF_CF_INVALID;
+				if (cf->state == __IAVF_CF_ADD_PENDING) {
+					cf->state = __IAVF_CF_INVALID;
 					dev_info(&adapter->pdev->dev, "Failed to add cloud filter, error %s\n",
-						 i40evf_stat_str(&adapter->hw,
+						 iavf_stat_str(&adapter->hw,
 								 v_retval));
-					i40evf_print_cloud_filter(adapter,
+					iavf_print_cloud_filter(adapter,
 								  &cf->f);
 					list_del(&cf->list);
 					kfree(cf);
@@ -1315,16 +1315,16 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 			}
 			break;
 		case VIRTCHNL_OP_DEL_CLOUD_FILTER: {
-			struct i40evf_cloud_filter *cf;
+			struct iavf_cloud_filter *cf;
 
 			list_for_each_entry(cf, &adapter->cloud_filter_list,
 					    list) {
-				if (cf->state == __I40EVF_CF_DEL_PENDING) {
-					cf->state = __I40EVF_CF_ACTIVE;
+				if (cf->state == __IAVF_CF_DEL_PENDING) {
+					cf->state = __IAVF_CF_ACTIVE;
 					dev_info(&adapter->pdev->dev, "Failed to del cloud filter, error %s\n",
-						 i40evf_stat_str(&adapter->hw,
+						 iavf_stat_str(&adapter->hw,
 								 v_retval));
-					i40evf_print_cloud_filter(adapter,
+					iavf_print_cloud_filter(adapter,
 								  &cf->f);
 				}
 			}
@@ -1333,7 +1333,7 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 		default:
 			dev_err(&adapter->pdev->dev, "PF returned error %d (%s) to our request %d\n",
 				v_retval,
-				i40evf_stat_str(&adapter->hw, v_retval),
+				iavf_stat_str(&adapter->hw, v_retval),
 				v_opcode);
 		}
 	}
@@ -1360,8 +1360,8 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 			  I40E_MAX_VF_VSI *
 			  sizeof(struct virtchnl_vsi_resource);
 		memcpy(adapter->vf_res, msg, min(msglen, len));
-		i40evf_validate_num_queues(adapter);
-		i40e_vf_parse_hw_config(&adapter->hw, adapter->vf_res);
+		iavf_validate_num_queues(adapter);
+		iavf_vf_parse_hw_config(&adapter->hw, adapter->vf_res);
 		if (is_zero_ether_addr(adapter->hw.mac.addr)) {
 			/* restore current mac address */
 			ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
@@ -1371,19 +1371,19 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 			ether_addr_copy(netdev->perm_addr,
 					adapter->hw.mac.addr);
 		}
-		i40evf_process_config(adapter);
+		iavf_process_config(adapter);
 		}
 		break;
 	case VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
-		i40evf_irq_enable(adapter, true);
-		adapter->flags &= ~I40EVF_FLAG_QUEUES_DISABLED;
+		iavf_irq_enable(adapter, true);
+		adapter->flags &= ~IAVF_FLAG_QUEUES_DISABLED;
 		break;
 	case VIRTCHNL_OP_DISABLE_QUEUES:
-		i40evf_free_all_tx_resources(adapter);
-		i40evf_free_all_rx_resources(adapter);
-		if (adapter->state == __I40EVF_DOWN_PENDING) {
-			adapter->state = __I40EVF_DOWN;
+		iavf_free_all_tx_resources(adapter);
+		iavf_free_all_rx_resources(adapter);
+		if (adapter->state == __IAVF_DOWN_PENDING) {
+			adapter->state = __IAVF_DOWN;
 			wake_up(&adapter->down_waitqueue);
 		}
 		break;
@@ -1402,7 +1402,7 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 		 * care about that.
 		 */
 		if (msglen && CLIENT_ENABLED(adapter))
-			i40evf_notify_client_message(&adapter->vsi,
+			iavf_notify_client_message(&adapter->vsi,
 						     msg, msglen);
 		break;
 
@@ -1428,26 +1428,26 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 				 adapter->num_req_queues,
 				 vfres->num_queue_pairs);
 			adapter->num_req_queues = 0;
-			adapter->flags &= ~I40EVF_FLAG_REINIT_ITR_NEEDED;
+			adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
 		}
 		}
 		break;
 	case VIRTCHNL_OP_ADD_CLOUD_FILTER: {
-		struct i40evf_cloud_filter *cf;
+		struct iavf_cloud_filter *cf;
 
 		list_for_each_entry(cf, &adapter->cloud_filter_list, list) {
-			if (cf->state == __I40EVF_CF_ADD_PENDING)
-				cf->state = __I40EVF_CF_ACTIVE;
+			if (cf->state == __IAVF_CF_ADD_PENDING)
+				cf->state = __IAVF_CF_ACTIVE;
 		}
 		}
 		break;
 	case VIRTCHNL_OP_DEL_CLOUD_FILTER: {
-		struct i40evf_cloud_filter *cf, *cftmp;
+		struct iavf_cloud_filter *cf, *cftmp;
 
 		list_for_each_entry_safe(cf, cftmp, &adapter->cloud_filter_list,
 					 list) {
-			if (cf->state == __I40EVF_CF_DEL_PENDING) {
-				cf->state = __I40EVF_CF_INVALID;
+			if (cf->state == __IAVF_CF_DEL_PENDING) {
+				cf->state = __IAVF_CF_INVALID;
 				list_del(&cf->list);
 				kfree(cf);
 				adapter->num_cloud_filters--;
-- 
2.14.4


