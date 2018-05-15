From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 15 May 2018 21:06:15 +0200
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 12/12] i40e: implement Tx
 zero-copy
In-Reply-To: <20180515190615.23099-1-bjorn.topel@gmail.com>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
Message-ID: <20180515190615.23099-13-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Here, the zero-copy ndo is implemented. As a shortcut, the existing
XDP Tx rings are used for zero-copy. This means that and XDP program
cannot redirect to an AF_XDP enabled XDP Tx ring.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |   7 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 235 +++++++++++++++++++++++-----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |   6 +
 3 files changed, 212 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index dc3d668a741e..91f8e892179a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3055,8 +3055,12 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
 	i40e_status err = 0;
 	u32 qtx_ctl = 0;
 
-	if (ring_is_xdp(ring))
+	ring->clean_tx_irq = i40e_clean_tx_irq;
+	if (ring_is_xdp(ring)) {
 		ring->xsk_umem = i40e_xsk_umem(ring);
+		if (ring->xsk_umem)
+			ring->clean_tx_irq = i40e_clean_tx_irq_zc;
+	}
 
 	/* some ATR related tx ring init */
 	if (vsi->back->flags & I40E_FLAG_FD_ATR_ENABLED) {
@@ -12309,6 +12313,7 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_bpf		= i40e_xdp,
 	.ndo_xdp_xmit		= i40e_xdp_xmit,
 	.ndo_xdp_flush		= i40e_xdp_flush,
+	.ndo_xsk_async_xmit	= i40e_xsk_async_xmit,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index f89ac524652c..17c067556aba 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -649,9 +649,13 @@ void i40e_clean_tx_ring(struct i40e_ring *tx_ring)
 	if (!tx_ring->tx_bi)
 		return;
 
-	/* Free all the Tx ring sk_buffs */
-	for (i = 0; i < tx_ring->count; i++)
-		i40e_unmap_and_free_tx_resource(tx_ring, &tx_ring->tx_bi[i]);
+	/* Cleanup only needed for non XSK TX ZC rings */
+	if (!tx_ring->xsk_umem) {
+		/* Free all the Tx ring sk_buffs */
+		for (i = 0; i < tx_ring->count; i++)
+			i40e_unmap_and_free_tx_resource(tx_ring,
+							&tx_ring->tx_bi[i]);
+	}
 
 	bi_size = sizeof(struct i40e_tx_buffer) * tx_ring->count;
 	memset(tx_ring->tx_bi, 0, bi_size);
@@ -768,8 +772,139 @@ void i40e_detect_recover_hung(struct i40e_vsi *vsi)
 	}
 }
 
+static inline void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring)
+{
+	/* Force memory writes to complete before letting h/w
+	 * know there are new descriptors to fetch.
+	 */
+	wmb();
+	writel_relaxed(xdp_ring->next_to_use, xdp_ring->tail);
+}
+
 #define WB_STRIDE 4
 
+static void i40e_update_stats_and_arm_wb(struct i40e_ring *tx_ring,
+					 struct i40e_vsi *vsi,
+					 unsigned int total_packets,
+					 unsigned int total_bytes,
+					 int budget)
+{
+	u64_stats_update_begin(&tx_ring->syncp);
+	tx_ring->stats.bytes += total_bytes;
+	tx_ring->stats.packets += total_packets;
+	u64_stats_update_end(&tx_ring->syncp);
+	tx_ring->q_vector->tx.total_bytes += total_bytes;
+	tx_ring->q_vector->tx.total_packets += total_packets;
+
+	if (tx_ring->flags & I40E_TXR_FLAGS_WB_ON_ITR) {
+		/* check to see if there are < 4 descriptors
+		 * waiting to be written back, then kick the hardware to force
+		 * them to be written back in case we stay in NAPI.
+		 * In this mode on X722 we do not enable Interrupt.
+		 */
+		unsigned int j = i40e_get_tx_pending(tx_ring, false);
+
+		if (budget &&
+		    ((j / WB_STRIDE) == 0) && (j > 0) &&
+		    !test_bit(__I40E_VSI_DOWN, vsi->state) &&
+		    (I40E_DESC_UNUSED(tx_ring) != tx_ring->count))
+			tx_ring->arm_wb = true;
+	}
+}
+
+/* Returns true if the work is finished */
+static bool i40e_xmit_zc(struct i40e_ring *xdp_ring, unsigned int budget)
+{
+	bool work_done = true, xdp_xmit = false;
+	struct i40e_tx_buffer *tx_bi;
+	struct i40e_tx_desc *tx_desc;
+	dma_addr_t dma;
+	u16 offset;
+	u32 len;
+
+	while (budget-- > 0) {
+		if (!unlikely(I40E_DESC_UNUSED(xdp_ring))) {
+			xdp_ring->tx_stats.tx_busy++;
+			work_done = false;
+			break;
+		}
+
+		if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len,
+					 &offset))
+			break;
+
+		xdp_xmit = true;
+		dma_sync_single_for_device(xdp_ring->dev, dma, len,
+					   DMA_BIDIRECTIONAL);
+
+		tx_bi = &xdp_ring->tx_bi[xdp_ring->next_to_use];
+		tx_bi->bytecount = len;
+		tx_bi->gso_segs = 1;
+
+		tx_desc = I40E_TX_DESC(xdp_ring, xdp_ring->next_to_use);
+		tx_desc->buffer_addr = cpu_to_le64(dma);
+		tx_desc->cmd_type_offset_bsz = build_ctob(I40E_TX_DESC_CMD_ICRC
+							| I40E_TX_DESC_CMD_EOP,
+							  0, len, 0);
+
+		xdp_ring->next_to_use++;
+		if (xdp_ring->next_to_use == xdp_ring->count)
+			xdp_ring->next_to_use = 0;
+	}
+
+	/* Request an interrupt for the last frame and bump tail ptr. */
+	if (xdp_xmit) {
+		tx_desc->cmd_type_offset_bsz |= (I40E_TX_DESC_CMD_RS <<
+						 I40E_TXD_QW1_CMD_SHIFT);
+		i40e_xdp_ring_update_tail(xdp_ring);
+	}
+
+	return !!budget && work_done;
+}
+
+bool i40e_clean_tx_irq_zc(struct i40e_vsi *vsi,
+			  struct i40e_ring *tx_ring, int napi_budget)
+{
+	unsigned int total_bytes = 0, total_packets = 0;
+	struct xdp_umem *umem = tx_ring->xsk_umem;
+	u32 head_idx = i40e_get_head(tx_ring);
+	unsigned int budget = vsi->work_limit;
+	bool work_done = true, xmit_done;
+	u32 completed_frames;
+	u32 frames_ready;
+
+	if (head_idx < tx_ring->next_to_clean)
+		head_idx += tx_ring->count;
+	frames_ready = head_idx - tx_ring->next_to_clean;
+
+	if (frames_ready == 0) {
+		goto out_xmit;
+	} else if (frames_ready > budget) {
+		completed_frames = budget;
+		work_done = false;
+	} else {
+		completed_frames = frames_ready;
+	}
+
+	/* XXX Need to be calculated. */
+	/*total_bytes += tx_buf->bytecount;*/
+	total_packets += completed_frames;
+
+	tx_ring->next_to_clean += completed_frames;
+	if (unlikely(tx_ring->next_to_clean >= tx_ring->count))
+		tx_ring->next_to_clean -= tx_ring->count;
+
+	xsk_umem_complete_tx(umem, completed_frames);
+
+	i40e_update_stats_and_arm_wb(tx_ring, vsi, total_packets,
+				     total_bytes, budget);
+
+out_xmit:
+	xmit_done = i40e_xmit_zc(tx_ring, budget);
+
+	return work_done && xmit_done;
+}
+
 /**
  * i40e_clean_tx_irq - Reclaim resources after transmit completes
  * @vsi: the VSI we care about
@@ -778,8 +913,8 @@ void i40e_detect_recover_hung(struct i40e_vsi *vsi)
  *
  * Returns true if there's any budget left (e.g. the clean is finished)
  **/
-static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
-			      struct i40e_ring *tx_ring, int napi_budget)
+bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
+		       struct i40e_ring *tx_ring, int napi_budget)
 {
 	u16 i = tx_ring->next_to_clean;
 	struct i40e_tx_buffer *tx_buf;
@@ -874,27 +1009,9 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 
 	i += tx_ring->count;
 	tx_ring->next_to_clean = i;
-	u64_stats_update_begin(&tx_ring->syncp);
-	tx_ring->stats.bytes += total_bytes;
-	tx_ring->stats.packets += total_packets;
-	u64_stats_update_end(&tx_ring->syncp);
-	tx_ring->q_vector->tx.total_bytes += total_bytes;
-	tx_ring->q_vector->tx.total_packets += total_packets;
 
-	if (tx_ring->flags & I40E_TXR_FLAGS_WB_ON_ITR) {
-		/* check to see if there are < 4 descriptors
-		 * waiting to be written back, then kick the hardware to force
-		 * them to be written back in case we stay in NAPI.
-		 * In this mode on X722 we do not enable Interrupt.
-		 */
-		unsigned int j = i40e_get_tx_pending(tx_ring, false);
-
-		if (budget &&
-		    ((j / WB_STRIDE) == 0) && (j > 0) &&
-		    !test_bit(__I40E_VSI_DOWN, vsi->state) &&
-		    (I40E_DESC_UNUSED(tx_ring) != tx_ring->count))
-			tx_ring->arm_wb = true;
-	}
+	i40e_update_stats_and_arm_wb(tx_ring, vsi, total_packets,
+				     total_bytes, budget);
 
 	if (ring_is_xdp(tx_ring))
 		return !!budget;
@@ -2266,15 +2383,6 @@ static void i40e_rx_buffer_flip(struct i40e_ring *rx_ring,
 #endif
 }
 
-static inline void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring)
-{
-	/* Force memory writes to complete before letting h/w
-	 * know there are new descriptors to fetch.
-	 */
-	wmb();
-	writel_relaxed(xdp_ring->next_to_use, xdp_ring->tail);
-}
-
 /**
  * i40e_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
  * @rx_ring: rx descriptor ring to transact packets on
@@ -2904,10 +3012,11 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 	 * budget and be more aggressive about cleaning up the Tx descriptors.
 	 */
 	i40e_for_each_ring(ring, q_vector->tx) {
-		if (!i40e_clean_tx_irq(vsi, ring, budget)) {
+		if (!ring->clean_tx_irq(vsi, ring, budget)) {
 			clean_complete = false;
 			continue;
 		}
+
 		arm_wb |= ring->arm_wb;
 		ring->arm_wb = false;
 	}
@@ -3810,6 +3919,30 @@ static inline int i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	return -1;
 }
 
+/**
+ * i40e_napi_is_scheduled - If napi is running, set the NAPIF_STATE_MISSED
+ * @n: napi context
+ *
+ * Returns true if NAPI is scheduled.
+ **/
+static bool i40e_napi_is_scheduled(struct napi_struct *n)
+{
+	unsigned long val, new;
+
+	do {
+		val = READ_ONCE(n->state);
+		if (val & NAPIF_STATE_DISABLE)
+			return true;
+
+		if (!(val & NAPIF_STATE_SCHED))
+			return false;
+
+		new = val | NAPIF_STATE_MISSED;
+	} while (cmpxchg(&n->state, val, new) != val);
+
+	return true;
+}
+
 /**
  * i40e_xmit_xdp_ring - transmits an XDP buffer to an XDP Tx ring
  * @xdp: data to transmit
@@ -4025,6 +4158,9 @@ int i40e_xdp_xmit(struct net_device *dev, struct xdp_frame *xdpf)
 	if (!i40e_enabled_xdp_vsi(vsi) || queue_index >= vsi->num_queue_pairs)
 		return -ENXIO;
 
+	if (vsi->xdp_rings[queue_index]->xsk_umem)
+		return -ENXIO;
+
 	err = i40e_xmit_xdp_ring(xdpf, vsi->xdp_rings[queue_index]);
 	if (err != I40E_XDP_TX)
 		return -ENOSPC;
@@ -4048,5 +4184,34 @@ void i40e_xdp_flush(struct net_device *dev)
 	if (!i40e_enabled_xdp_vsi(vsi) || queue_index >= vsi->num_queue_pairs)
 		return;
 
+	if (vsi->xdp_rings[queue_index]->xsk_umem)
+		return;
+
 	i40e_xdp_ring_update_tail(vsi->xdp_rings[queue_index]);
 }
+
+int i40e_xsk_async_xmit(struct net_device *dev, u32 queue_id)
+{
+	struct i40e_netdev_priv *np = netdev_priv(dev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_ring *ring;
+
+	if (test_bit(__I40E_VSI_DOWN, vsi->state))
+		return -ENETDOWN;
+
+	if (!i40e_enabled_xdp_vsi(vsi))
+		return -ENXIO;
+
+	if (queue_id >= vsi->num_queue_pairs)
+		return -ENXIO;
+
+	if (!vsi->xdp_rings[queue_id]->xsk_umem)
+		return -ENXIO;
+
+	ring = vsi->xdp_rings[queue_id];
+
+	if (!i40e_napi_is_scheduled(&ring->q_vector->napi))
+		i40e_force_wb(vsi, ring->q_vector);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 9d5d9862e9f1..ea1cac00cad4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -428,6 +428,7 @@ struct i40e_ring {
 
 	int (*clean_rx_irq)(struct i40e_ring *, int);
 	bool (*alloc_rx_buffers)(struct i40e_ring *, u16);
+	bool (*clean_tx_irq)(struct i40e_vsi *, struct i40e_ring *, int);
 	struct xdp_umem *xsk_umem;
 
 	struct zero_copy_allocator zca; /* ZC allocator anchor */
@@ -510,6 +511,11 @@ void i40e_xdp_flush(struct net_device *dev);
 int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget);
 int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget);
 void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle);
+bool i40e_clean_tx_irq_zc(struct i40e_vsi *vsi,
+			  struct i40e_ring *tx_ring, int napi_budget);
+bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
+		       struct i40e_ring *tx_ring, int napi_budget);
+int i40e_xsk_async_xmit(struct net_device *dev, u32 queue_id);
 
 /**
  * i40e_get_head - Retrieve head from head writeback
-- 
2.14.1

