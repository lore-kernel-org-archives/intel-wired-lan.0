From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 20 Nov 2020 16:39:29 -0800
Subject: [Intel-wired-lan] [PATCH S54 05/14] ice: Fix AF_XDP multi queue TX
 scaling issue
In-Reply-To: <20201121003938.48514-1-anthony.l.nguyen@intel.com>
References: <20201121003938.48514-1-anthony.l.nguyen@intel.com>
Message-ID: <20201121003938.48514-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sridhar Samudrala <sridhar.samudrala@intel.com>

Set Report Status(RS) bit less frequently allowing the hardware to
reduce descriptor writebacks which in turn reduces contention between
CPU and PCIe.

In ice_xmit_zc routine, RS bit is set only in the last descriptor, just
before bumping the tail. A new field 'next_rs_idx' is introduced in
struct ice_ring to store the index of the last descriptor where RS bit is
set.

In the TX cleanup routine, DD bit is checked only in the descriptor
corresponding to the next_rs_idx and used to figure out the frames that
are ready to be cleaned.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h |  5 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 90 +++++++++++------------
 drivers/net/ethernet/intel/ice/ice_xsk.h  |  5 +-
 4 files changed, 49 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index d2493fa71336..884581a9c4c7 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1623,7 +1623,7 @@ int ice_napi_poll(struct napi_struct *napi, int budget)
 	 */
 	ice_for_each_ring(ring, q_vector->tx) {
 		bool wd = ring->xsk_pool ?
-			  ice_clean_tx_irq_zc(ring, budget) :
+			  ice_clean_tx_irq_zc(ring) :
 			  ice_clean_tx_irq(ring, budget);
 
 		if (!wd)
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index ff1a1cbd078e..d7ca82871b7c 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -283,7 +283,10 @@ struct ice_ring {
 	/* used in interrupt processing */
 	u16 next_to_use;
 	u16 next_to_clean;
-	u16 next_to_alloc;
+	union {
+		u16 next_to_alloc;
+		u16 next_rs_idx;
+	};
 
 	/* stats structs */
 	struct ice_q_stats	stats;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 4d44431c71a0..d32a8c338366 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -617,20 +617,14 @@ int ice_clean_rx_irq_zc(struct ice_ring *rx_ring, int budget)
 static bool ice_xmit_zc(struct ice_ring *xdp_ring, int budget)
 {
 	struct ice_tx_desc *tx_desc = NULL;
-	bool work_done = true;
+	u16 ntu = xdp_ring->next_to_use;
 	struct xdp_desc desc;
 	dma_addr_t dma;
 
 	while (likely(budget-- > 0)) {
 		struct ice_tx_buf *tx_buf;
 
-		if (unlikely(!ICE_DESC_UNUSED(xdp_ring))) {
-			xdp_ring->tx_stats.tx_busy++;
-			work_done = false;
-			break;
-		}
-
-		tx_buf = &xdp_ring->tx_buf[xdp_ring->next_to_use];
+		tx_buf = &xdp_ring->tx_buf[ntu];
 
 		if (!xsk_tx_peek_desc(xdp_ring->xsk_pool, &desc))
 			break;
@@ -641,22 +635,27 @@ static bool ice_xmit_zc(struct ice_ring *xdp_ring, int budget)
 
 		tx_buf->bytecount = desc.len;
 
-		tx_desc = ICE_TX_DESC(xdp_ring, xdp_ring->next_to_use);
+		tx_desc = ICE_TX_DESC(xdp_ring, ntu);
 		tx_desc->buf_addr = cpu_to_le64(dma);
 		tx_desc->cmd_type_offset_bsz =
-			ice_build_ctob(ICE_TXD_LAST_DESC_CMD, 0, desc.len, 0);
+			ice_build_ctob(ICE_TX_DESC_CMD_EOP, 0, desc.len, 0);
 
-		xdp_ring->next_to_use++;
-		if (xdp_ring->next_to_use == xdp_ring->count)
-			xdp_ring->next_to_use = 0;
+		xdp_ring->next_rs_idx = ntu;
+		ntu++;
+		if (ntu == xdp_ring->count)
+			ntu = 0;
 	}
 
 	if (tx_desc) {
+		xdp_ring->next_to_use = ntu;
+		/* Set RS bit for the last frame and bump tail ptr */
+		tx_desc->cmd_type_offset_bsz |=
+			cpu_to_le64(ICE_TX_DESC_CMD_RS << ICE_TXD_QW1_CMD_S);
 		ice_xdp_ring_update_tail(xdp_ring);
 		xsk_tx_release(xdp_ring->xsk_pool);
 	}
 
-	return budget > 0 && work_done;
+	return budget > 0;
 }
 
 /**
@@ -676,30 +675,34 @@ ice_clean_xdp_tx_buf(struct ice_ring *xdp_ring, struct ice_tx_buf *tx_buf)
 /**
  * ice_clean_tx_irq_zc - Completes AF_XDP entries, and cleans XDP entries
  * @xdp_ring: XDP Tx ring
- * @budget: NAPI budget
  *
- * Returns true if cleanup/tranmission is done.
+ * Returns true if cleanup/transmission is done.
  */
-bool ice_clean_tx_irq_zc(struct ice_ring *xdp_ring, int budget)
+bool ice_clean_tx_irq_zc(struct ice_ring *xdp_ring)
 {
-	int total_packets = 0, total_bytes = 0;
-	s16 ntc = xdp_ring->next_to_clean;
-	struct ice_tx_desc *tx_desc;
+	u16 next_rs_idx = xdp_ring->next_rs_idx;
+	u16 ntc = xdp_ring->next_to_clean;
+	struct ice_tx_desc *next_rs_desc;
 	struct ice_tx_buf *tx_buf;
+	u16 frames_ready = 0;
+	u32 total_bytes = 0;
 	u32 xsk_frames = 0;
-	bool xmit_done;
+	u16 i;
 
-	tx_desc = ICE_TX_DESC(xdp_ring, ntc);
-	tx_buf = &xdp_ring->tx_buf[ntc];
-	ntc -= xdp_ring->count;
+	next_rs_desc = ICE_TX_DESC(xdp_ring, next_rs_idx);
+	if (next_rs_desc->cmd_type_offset_bsz &
+		cpu_to_le64(ICE_TX_DESC_DTYPE_DESC_DONE)) {
+		if (next_rs_idx >= ntc)
+			frames_ready = next_rs_idx - ntc;
+		else
+			frames_ready = next_rs_idx + xdp_ring->count - ntc;
+	}
 
-	do {
-		if (!(tx_desc->cmd_type_offset_bsz &
-		      cpu_to_le64(ICE_TX_DESC_DTYPE_DESC_DONE)))
-			break;
+	if (!frames_ready)
+		goto out_xmit;
 
-		total_bytes += tx_buf->bytecount;
-		total_packets++;
+	for (i = 0; i < frames_ready; i++) {
+		tx_buf = &xdp_ring->tx_buf[ntc];
 
 		if (tx_buf->raw_buf) {
 			ice_clean_xdp_tx_buf(xdp_ring, tx_buf);
@@ -708,34 +711,25 @@ bool ice_clean_tx_irq_zc(struct ice_ring *xdp_ring, int budget)
 			xsk_frames++;
 		}
 
-		tx_desc->cmd_type_offset_bsz = 0;
-		tx_buf++;
-		tx_desc++;
-		ntc++;
-
-		if (unlikely(!ntc)) {
-			ntc -= xdp_ring->count;
-			tx_buf = xdp_ring->tx_buf;
-			tx_desc = ICE_TX_DESC(xdp_ring, 0);
-		}
-
-		prefetch(tx_desc);
+		total_bytes += tx_buf->bytecount;
 
-	} while (likely(--budget));
+		++ntc;
+		if (ntc >= xdp_ring->count)
+			ntc = 0;
+	}
 
-	ntc += xdp_ring->count;
 	xdp_ring->next_to_clean = ntc;
 
 	if (xsk_frames)
 		xsk_tx_completed(xdp_ring->xsk_pool, xsk_frames);
 
+	ice_update_tx_ring_stats(xdp_ring, frames_ready, total_bytes);
+
+out_xmit:
 	if (xsk_uses_need_wakeup(xdp_ring->xsk_pool))
 		xsk_set_tx_need_wakeup(xdp_ring->xsk_pool);
 
-	ice_update_tx_ring_stats(xdp_ring, total_packets, total_bytes);
-	xmit_done = ice_xmit_zc(xdp_ring, ICE_DFLT_IRQ_WORK);
-
-	return budget > 0 && xmit_done;
+	return ice_xmit_zc(xdp_ring, ICE_DESC_UNUSED(xdp_ring));
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.h b/drivers/net/ethernet/intel/ice/ice_xsk.h
index fad783690134..4aa84b9c2f90 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.h
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.h
@@ -12,7 +12,7 @@ struct ice_vsi;
 int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool,
 		       u16 qid);
 int ice_clean_rx_irq_zc(struct ice_ring *rx_ring, int budget);
-bool ice_clean_tx_irq_zc(struct ice_ring *xdp_ring, int budget);
+bool ice_clean_tx_irq_zc(struct ice_ring *xdp_ring);
 int ice_xsk_wakeup(struct net_device *netdev, u32 queue_id, u32 flags);
 bool ice_alloc_rx_bufs_zc(struct ice_ring *rx_ring, u16 count);
 bool ice_xsk_any_rx_ring_ena(struct ice_vsi *vsi);
@@ -35,8 +35,7 @@ ice_clean_rx_irq_zc(struct ice_ring __always_unused *rx_ring,
 }
 
 static inline bool
-ice_clean_tx_irq_zc(struct ice_ring __always_unused *xdp_ring,
-		    int __always_unused budget)
+ice_clean_tx_irq_zc(struct ice_ring __always_unused *xdp_ring)
 {
 	return false;
 }
-- 
2.20.1

