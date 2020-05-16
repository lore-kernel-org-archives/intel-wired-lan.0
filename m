From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:42:18 -0700
Subject: [Intel-wired-lan] [PATCH S44 06/14] ice: avoid undefined behavior
In-Reply-To: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516004226.4795-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

When writing the driver's struct ice_tlan_ctx structure, do not write the
8-bit element int_q_state with the associated internal-to-hardware field
which is 122-bits, otherwise the helper function ice_write_byte() will use
undefined behavior when setting the mask used for that write.  This should
not cause any functional change and will avoid use of undefined behavior.
Also, update a comment to highlight this structure element is not written.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c      |  5 +++--
 drivers/net/ethernet/intel/ice/ice_common.c    | 12 ++++++++++--
 drivers/net/ethernet/intel/ice/ice_common.h    |  3 ++-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h |  2 +-
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index ff6a5cf8e06f..a964f5055f37 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -638,6 +638,7 @@ ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_ring *ring,
 	struct ice_aqc_add_txqs_perq *txq;
 	struct ice_pf *pf = vsi->back;
 	u8 buf_len = sizeof(*qg_buf);
+	struct ice_hw *hw = &pf->hw;
 	enum ice_status status;
 	u16 pf_q;
 	u8 tc;
@@ -646,13 +647,13 @@ ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_ring *ring,
 	ice_setup_tx_ctx(ring, &tlan_ctx, pf_q);
 	/* copy context contents into the qg_buf */
 	qg_buf->txqs[0].txq_id = cpu_to_le16(pf_q);
-	ice_set_ctx((u8 *)&tlan_ctx, qg_buf->txqs[0].txq_ctx,
+	ice_set_ctx(hw, (u8 *)&tlan_ctx, qg_buf->txqs[0].txq_ctx,
 		    ice_tlan_ctx_info);
 
 	/* init queue specific tail reg. It is referred as
 	 * transmit comm scheduler queue doorbell.
 	 */
-	ring->tail = pf->hw.hw_addr + QTX_COMM_DBELL(pf_q);
+	ring->tail = hw->hw_addr + QTX_COMM_DBELL(pf_q);
 
 	if (IS_ENABLED(CONFIG_DCB))
 		tc = ring->dcb_tc;
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index b0bbba8e6f6c..8eccec1fa9e7 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1099,7 +1099,7 @@ ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 
 	rlan_ctx->prefena = 1;
 
-	ice_set_ctx((u8 *)rlan_ctx, ctx_buf, ice_rlan_ctx_info);
+	ice_set_ctx(hw, (u8 *)rlan_ctx, ctx_buf, ice_rlan_ctx_info);
 	return ice_copy_rxq_ctx_to_hw(hw, ctx_buf, rxq_index);
 }
 
@@ -3268,12 +3268,14 @@ ice_write_qword(u8 *src_ctx, u8 *dest_ctx, const struct ice_ctx_ele *ce_info)
 
 /**
  * ice_set_ctx - set context bits in packed structure
+ * @hw: pointer to the hardware structure
  * @src_ctx:  pointer to a generic non-packed context structure
  * @dest_ctx: pointer to memory for the packed structure
  * @ce_info:  a description of the structure to be transformed
  */
 enum ice_status
-ice_set_ctx(u8 *src_ctx, u8 *dest_ctx, const struct ice_ctx_ele *ce_info)
+ice_set_ctx(struct ice_hw *hw, u8 *src_ctx, u8 *dest_ctx,
+	    const struct ice_ctx_ele *ce_info)
 {
 	int f;
 
@@ -3282,6 +3284,12 @@ ice_set_ctx(u8 *src_ctx, u8 *dest_ctx, const struct ice_ctx_ele *ce_info)
 		 * using the correct size so that we are correct regardless
 		 * of the endianness of the machine.
 		 */
+		if (ce_info[f].width > (ce_info[f].size_of * BITS_PER_BYTE)) {
+			ice_debug(hw, ICE_DBG_QCTX,
+				  "Field %d width of %d bits larger than size of %d byte(s) ... skipping write\n",
+				  f, ce_info[f].width, ce_info[f].size_of);
+			continue;
+		}
 		switch (ce_info[f].size_of) {
 		case sizeof(u8):
 			ice_write_byte(src_ctx, dest_ctx, &ce_info[f]);
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 9bac3e46da33..2cfd684061e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -70,7 +70,8 @@ enum ice_status ice_aq_q_shutdown(struct ice_hw *hw, bool unloading);
 void ice_fill_dflt_direct_cmd_desc(struct ice_aq_desc *desc, u16 opcode);
 extern const struct ice_ctx_ele ice_tlan_ctx_info[];
 enum ice_status
-ice_set_ctx(u8 *src_ctx, u8 *dest_ctx, const struct ice_ctx_ele *ce_info);
+ice_set_ctx(struct ice_hw *hw, u8 *src_ctx, u8 *dest_ctx,
+	    const struct ice_ctx_ele *ce_info);
 
 extern struct mutex ice_global_cfg_lock_sw;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index bd2cd3435768..14dfbbc1b2cf 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -581,7 +581,7 @@ struct ice_tlan_ctx {
 	u8 drop_ena;
 	u8 cache_prof_idx;
 	u8 pkt_shaper_prof_idx;
-	u8 int_q_state;	/* width not needed - internal do not write */
+	u8 int_q_state;	/* width not needed - internal - DO NOT WRITE!!! */
 };
 
 /* macro to make the table lines short */
-- 
2.20.1

