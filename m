From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue,  4 Sep 2018 20:11:02 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 1/4] i40e: clean zero-copy XDP Tx
 ring on shutdown/reset
In-Reply-To: <20180904181105.10983-1-bjorn.topel@gmail.com>
References: <20180904181105.10983-1-bjorn.topel@gmail.com>
Message-ID: <20180904181105.10983-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

When the zero-copy enabled XDP Tx ring is torn down, due to
configuration changes, outstandning frames on the hardware descriptor
ring are queued on the completion ring.

The completion ring has a back-pressure mechanism that will guarantee
that there is sufficient space on the ring.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 17 +++++++----
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 30 +++++++++++++++++++
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 37bd4e50ccde..7f85d4ba8b54 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -636,13 +636,18 @@ void i40e_clean_tx_ring(struct i40e_ring *tx_ring)
 	unsigned long bi_size;
 	u16 i;
 
-	/* ring already cleared, nothing to do */
-	if (!tx_ring->tx_bi)
-		return;
+	if (ring_is_xdp(tx_ring) && tx_ring->xsk_umem) {
+		i40e_xsk_clean_tx_ring(tx_ring);
+	} else {
+		/* ring already cleared, nothing to do */
+		if (!tx_ring->tx_bi)
+			return;
 
-	/* Free all the Tx ring sk_buffs */
-	for (i = 0; i < tx_ring->count; i++)
-		i40e_unmap_and_free_tx_resource(tx_ring, &tx_ring->tx_bi[i]);
+		/* Free all the Tx ring sk_buffs */
+		for (i = 0; i < tx_ring->count; i++)
+			i40e_unmap_and_free_tx_resource(tx_ring,
+							&tx_ring->tx_bi[i]);
+	}
 
 	bi_size = sizeof(struct i40e_tx_buffer) * tx_ring->count;
 	memset(tx_ring->tx_bi, 0, bi_size);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
index b5afd479a9c5..29c68b29d36f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
@@ -87,4 +87,6 @@ static inline void i40e_arm_wb(struct i40e_ring *tx_ring,
 	}
 }
 
+void i40e_xsk_clean_tx_ring(struct i40e_ring *tx_ring);
+
 #endif /* I40E_TXRX_COMMON_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 2ebfc78bbd09..99116277c4d2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -830,3 +830,33 @@ int i40e_xsk_async_xmit(struct net_device *dev, u32 queue_id)
 
 	return 0;
 }
+
+/**
+ * i40e_xsk_clean_xdp_ring - Clean the XDP Tx ring on shutdown
+ * @xdp_ring: XDP Tx ring
+ **/
+void i40e_xsk_clean_tx_ring(struct i40e_ring *tx_ring)
+{
+	u16 ntc = tx_ring->next_to_clean, ntu = tx_ring->next_to_use;
+	struct xdp_umem *umem = tx_ring->xsk_umem;
+	struct i40e_tx_buffer *tx_bi;
+	u32 xsk_frames = 0;
+
+	while (ntc != ntu) {
+		tx_bi = &tx_ring->tx_bi[ntc];
+
+		if (tx_bi->xdpf)
+			i40e_clean_xdp_tx_buffer(tx_ring, tx_bi);
+		else
+			xsk_frames++;
+
+		tx_bi->xdpf = NULL;
+
+		ntc++;
+		if (ntc > tx_ring->count)
+			ntc = 0;
+	}
+
+	if (xsk_frames)
+		xsk_umem_complete_tx(umem, xsk_frames);
+}
-- 
2.17.1

