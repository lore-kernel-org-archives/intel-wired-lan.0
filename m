From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri,  7 Sep 2018 10:18:47 +0200
Subject: [Intel-wired-lan] [PATCH v2 3/4] i40e: clean zero-copy XDP Rx ring
 on shutdown/reset
In-Reply-To: <20180907081848.5438-1-bjorn.topel@gmail.com>
References: <20180907081848.5438-1-bjorn.topel@gmail.com>
Message-ID: <20180907081848.5438-4-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Outstanding Rx descriptors are temporarily stored on a stash/reuse
queue. When/if the HW rings comes up again, entries from the stash are
used to re-populate the ring.

The latter required some restructuring of the allocation scheme for
the AF_XDP zero-copy implementation. There is now a fast, and a slow
allocation. The "fast allocation" is used from the fast-path and
obtains free buffers from the fill ring and the internal recycle
mechanism. The "slow allocation" is only used in ring setup, and
obtains buffers from the fill ring and the stash (if any).

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   4 +-
 .../ethernet/intel/i40e/i40e_txrx_common.h    |   1 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 100 ++++++++++++++++--
 3 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 7f85d4ba8b54..740ea58ba938 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1355,8 +1355,10 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
 		rx_ring->skb = NULL;
 	}
 
-	if (rx_ring->xsk_umem)
+	if (rx_ring->xsk_umem) {
+		i40e_xsk_clean_rx_ring(rx_ring);
 		goto skip_free;
+	}
 
 	/* Free all the Rx ring sk_buffs */
 	for (i = 0; i < rx_ring->count; i++) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
index 29c68b29d36f..8d46acff6f2e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
@@ -87,6 +87,7 @@ static inline void i40e_arm_wb(struct i40e_ring *tx_ring,
 	}
 }
 
+void i40e_xsk_clean_rx_ring(struct i40e_ring *rx_ring);
 void i40e_xsk_clean_tx_ring(struct i40e_ring *tx_ring);
 
 #endif /* I40E_TXRX_COMMON_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 99116277c4d2..e4b62e871afc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -140,6 +140,7 @@ static void i40e_xsk_umem_dma_unmap(struct i40e_vsi *vsi, struct xdp_umem *umem)
 static int i40e_xsk_umem_enable(struct i40e_vsi *vsi, struct xdp_umem *umem,
 				u16 qid)
 {
+	struct xdp_umem_fq_reuse *reuseq;
 	bool if_running;
 	int err;
 
@@ -156,6 +157,12 @@ static int i40e_xsk_umem_enable(struct i40e_vsi *vsi, struct xdp_umem *umem,
 			return -EBUSY;
 	}
 
+	reuseq = xsk_reuseq_prepare(vsi->rx_rings[0]->count);
+	if (!reuseq)
+		return -ENOMEM;
+
+	xsk_reuseq_free(xsk_reuseq_swap(umem, reuseq));
+
 	err = i40e_xsk_umem_dma_map(vsi, umem);
 	if (err)
 		return err;
@@ -353,16 +360,46 @@ static bool i40e_alloc_buffer_zc(struct i40e_ring *rx_ring,
 }
 
 /**
- * i40e_alloc_rx_buffers_zc - Allocates a number of Rx buffers
+ * i40e_alloc_buffer_slow_zc - Allocates an i40e_rx_buffer
  * @rx_ring: Rx ring
- * @count: The number of buffers to allocate
+ * @bi: Rx buffer to populate
  *
- * This function allocates a number of Rx buffers and places them on
- * the Rx ring.
+ * This function allocates an Rx buffer. The buffer can come from fill
+ * queue, or via the reuse queue.
  *
  * Returns true for a successful allocation, false otherwise
  **/
-bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
+static bool i40e_alloc_buffer_slow_zc(struct i40e_ring *rx_ring,
+				      struct i40e_rx_buffer *bi)
+{
+	struct xdp_umem *umem = rx_ring->xsk_umem;
+	u64 handle, hr;
+
+	if (!xsk_umem_peek_addr_rq(umem, &handle)) {
+		rx_ring->rx_stats.alloc_page_failed++;
+		return false;
+	}
+
+	handle &= rx_ring->xsk_umem->chunk_mask;
+
+	hr = umem->headroom + XDP_PACKET_HEADROOM;
+
+	bi->dma = xdp_umem_get_dma(umem, handle);
+	bi->dma += hr;
+
+	bi->addr = xdp_umem_get_data(umem, handle);
+	bi->addr += hr;
+
+	bi->handle = handle + umem->headroom;
+
+	xsk_umem_discard_addr_rq(umem);
+	return true;
+}
+
+static __always_inline bool __i40e_alloc_rx_buffers_zc(
+	struct i40e_ring *rx_ring, u16 count,
+	bool alloc(struct i40e_ring *rx_ring,
+		   struct i40e_rx_buffer *bi))
 {
 	u16 ntu = rx_ring->next_to_use;
 	union i40e_rx_desc *rx_desc;
@@ -372,7 +409,7 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
 	rx_desc = I40E_RX_DESC(rx_ring, ntu);
 	bi = &rx_ring->rx_bi[ntu];
 	do {
-		if (!i40e_alloc_buffer_zc(rx_ring, bi)) {
+		if (!alloc(rx_ring, bi)) {
 			ok = false;
 			goto no_buffers;
 		}
@@ -404,6 +441,38 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
 	return ok;
 }
 
+/**
+ * i40e_alloc_rx_buffers_zc - Allocates a number of Rx buffers
+ * @rx_ring: Rx ring
+ * @count: The number of buffers to allocate
+ *
+ * This function allocates a number of Rx buffers from the reuse queue
+ * or fill ring and places them on the Rx ring.
+ *
+ * Returns true for a successful allocation, false otherwise
+ **/
+bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
+{
+	return __i40e_alloc_rx_buffers_zc(rx_ring, count,
+					  i40e_alloc_buffer_slow_zc);
+}
+
+/**
+ * i40e_alloc_rx_buffers_fast_zc - Allocates a number of Rx buffers
+ * @rx_ring: Rx ring
+ * @count: The number of buffers to allocate
+ *
+ * This function allocates a number of Rx buffers from the fill ring
+ * or the internal recycle mechanism and places them on the Rx ring.
+ *
+ * Returns true for a successful allocation, false otherwise
+ **/
+static bool i40e_alloc_rx_buffers_fast_zc(struct i40e_ring *rx_ring, u16 count)
+{
+	return __i40e_alloc_rx_buffers_zc(rx_ring, count,
+					  i40e_alloc_buffer_zc);
+}
+
 /**
  * i40e_get_rx_buffer_zc - Return the current Rx buffer
  * @rx_ring: Rx ring
@@ -571,8 +640,8 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 
 		if (cleaned_count >= I40E_RX_BUFFER_WRITE) {
 			failure = failure ||
-				  !i40e_alloc_rx_buffers_zc(rx_ring,
-							    cleaned_count);
+				  !i40e_alloc_rx_buffers_fast_zc(rx_ring,
+								 cleaned_count);
 			cleaned_count = 0;
 		}
 
@@ -831,6 +900,21 @@ int i40e_xsk_async_xmit(struct net_device *dev, u32 queue_id)
 	return 0;
 }
 
+void i40e_xsk_clean_rx_ring(struct i40e_ring *rx_ring)
+{
+	u16 i;
+
+	for (i = 0; i < rx_ring->count; i++) {
+		struct i40e_rx_buffer *rx_bi = &rx_ring->rx_bi[i];
+
+		if (!rx_bi->addr)
+			continue;
+
+		xsk_umem_fq_reuse(rx_ring->xsk_umem, rx_bi->handle);
+		rx_bi->addr = NULL;
+	}
+}
+
 /**
  * i40e_xsk_clean_xdp_ring - Clean the XDP Tx ring on shutdown
  * @xdp_ring: XDP Tx ring
-- 
2.17.1

