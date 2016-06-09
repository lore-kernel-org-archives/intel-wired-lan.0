From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  9 Jun 2016 14:56:05 -0700
Subject: [Intel-wired-lan] [PATCH v2] fm10k: use software values when
	checking for Tx hangs in hot path
Message-ID: <20160609215605.19957-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A previous patch added support to check for hardware tx pending in the
fm10k_down routine. This support was intended to ensure that we
accurately check what the hardware state is. However, checking for Tx
hangs in this manor during the hotpath results in a large performance
hit. Avoid this by making the hotpath check use the SW counters instead.

Fixes: a0f53cf49cb0 ("fm10k: use actual hardware registers when checking for pending Tx", 2016-06-08)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h      |  2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 19 +++++++++++++++----
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  2 +-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index c4cf08dcf5af..75429f2bbc97 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -458,7 +458,7 @@ __be16 fm10k_tx_encap_offload(struct sk_buff *skb);
 netdev_tx_t fm10k_xmit_frame_ring(struct sk_buff *skb,
 				  struct fm10k_ring *tx_ring);
 void fm10k_tx_timeout_reset(struct fm10k_intfc *interface);
-u64 fm10k_get_tx_pending(struct fm10k_ring *ring);
+u64 fm10k_get_tx_pending(struct fm10k_ring *ring, bool in_sw);
 bool fm10k_check_tx_hang(struct fm10k_ring *tx_ring);
 void fm10k_alloc_rx_buffers(struct fm10k_ring *rx_ring, u16 cleaned_count);
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index e9767b6366a8..a4ea84273ea1 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1128,13 +1128,24 @@ static u64 fm10k_get_tx_completed(struct fm10k_ring *ring)
 	return ring->stats.packets;
 }
 
-u64 fm10k_get_tx_pending(struct fm10k_ring *ring)
+/**
+ * fm10k_get_tx_pending - how many tx descriptors not processed
+ * @ring: the ring structure
+ * @in_sw: is tx_pending being checked in SW or in HW?
+ */
+u64 fm10k_get_tx_pending(struct fm10k_ring *ring, bool in_sw)
 {
 	struct fm10k_intfc *interface = ring->q_vector->interface;
 	struct fm10k_hw *hw = &interface->hw;
+	u32 head, tail;
 
-	u32 head = fm10k_read_reg(hw, FM10K_TDH(ring->reg_idx));
-	u32 tail = fm10k_read_reg(hw, FM10K_TDT(ring->reg_idx));
+	if (likely(in_sw)) {
+		head = ring->next_to_clean;
+		tail = ring->next_to_use;
+	} else {
+		head = fm10k_read_reg(hw, FM10K_TDH(ring->reg_idx));
+		tail = fm10k_read_reg(hw, FM10K_TDT(ring->reg_idx));
+	}
 
 	return ((head <= tail) ? tail : tail + ring->count) - head;
 }
@@ -1143,7 +1154,7 @@ bool fm10k_check_tx_hang(struct fm10k_ring *tx_ring)
 {
 	u32 tx_done = fm10k_get_tx_completed(tx_ring);
 	u32 tx_done_old = tx_ring->tx_stats.tx_done_old;
-	u32 tx_pending = fm10k_get_tx_pending(tx_ring);
+	u32 tx_pending = fm10k_get_tx_pending(tx_ring, true);
 
 	clear_check_for_tx_hang(tx_ring);
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 559cda999f49..b0c3d7b3a34c 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1699,7 +1699,7 @@ void fm10k_down(struct fm10k_intfc *interface)
 
 		/* start checking at the last ring to have pending Tx */
 		for (; i < interface->num_tx_queues; i++)
-			if (fm10k_get_tx_pending(interface->tx_ring[i]))
+			if (fm10k_get_tx_pending(interface->tx_ring[i], false))
 				break;
 
 		/* if all the queues are drained, we can break now */
-- 
2.9.0.rc1.405.g81f467e

