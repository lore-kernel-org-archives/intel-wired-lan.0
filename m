From: Ilya Maximets <i.maximets@samsung.com>
Date: Tue, 20 Aug 2019 18:16:11 +0300
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix double clean of tx
 descriptors with xdp
References: <CGME20190820151644eucas1p179d6d1da42bb6be0aad8f58ac46624ce@eucas1p1.samsung.com>
Message-ID: <20190820151611.10727-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Tx code doesn't clear the descriptor status after cleaning.
So, if the budget is larger than number of used elems in a ring, some
descriptors will be accounted twice and xsk_umem_complete_tx will move
prod_tail far beyond the prod_head breaking the comletion queue ring.

Fix that by limiting the number of descriptors to clean by the number
of used descriptors in the tx ring.

Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
---

Not tested yet because of lack of available hardware.
So, testing is very welcome.

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 10 ++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 12 +-----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  6 ++++--
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 39e73ad60352..0befcef46e80 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -512,6 +512,16 @@ static inline u16 ixgbe_desc_unused(struct ixgbe_ring *ring)
 	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 1;
 }
 
+static inline u64 ixgbe_desc_used(struct ixgbe_ring *ring)
+{
+	unsigned int head, tail;
+
+	head = ring->next_to_clean;
+	tail = ring->next_to_use;
+
+	return ((head <= tail) ? tail : tail + ring->count) - head;
+}
+
 #define IXGBE_RX_DESC(R, i)	    \
 	(&(((union ixgbe_adv_rx_desc *)((R)->desc))[i]))
 #define IXGBE_TX_DESC(R, i)	    \
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7882148abb43..d417237857d8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1012,21 +1012,11 @@ static u64 ixgbe_get_tx_completed(struct ixgbe_ring *ring)
 	return ring->stats.packets;
 }
 
-static u64 ixgbe_get_tx_pending(struct ixgbe_ring *ring)
-{
-	unsigned int head, tail;
-
-	head = ring->next_to_clean;
-	tail = ring->next_to_use;
-
-	return ((head <= tail) ? tail : tail + ring->count) - head;
-}
-
 static inline bool ixgbe_check_tx_hang(struct ixgbe_ring *tx_ring)
 {
 	u32 tx_done = ixgbe_get_tx_completed(tx_ring);
 	u32 tx_done_old = tx_ring->tx_stats.tx_done_old;
-	u32 tx_pending = ixgbe_get_tx_pending(tx_ring);
+	u32 tx_pending = ixgbe_desc_used(tx_ring);
 
 	clear_check_for_tx_hang(tx_ring);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 6b609553329f..7702efed356a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -637,6 +637,7 @@ bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
 	u32 i = tx_ring->next_to_clean, xsk_frames = 0;
 	unsigned int budget = q_vector->tx.work_limit;
 	struct xdp_umem *umem = tx_ring->xsk_umem;
+	u32 used_descs = ixgbe_desc_used(tx_ring);
 	union ixgbe_adv_tx_desc *tx_desc;
 	struct ixgbe_tx_buffer *tx_bi;
 	bool xmit_done;
@@ -645,7 +646,7 @@ bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
 	tx_desc = IXGBE_TX_DESC(tx_ring, i);
 	i -= tx_ring->count;
 
-	do {
+	while (likely(budget && used_descs)) {
 		if (!(tx_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
 			break;
 
@@ -673,7 +674,8 @@ bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
 
 		/* update budget accounting */
 		budget--;
-	} while (likely(budget));
+		used_descs--;
+	}
 
 	i += tx_ring->count;
 	tx_ring->next_to_clean = i;
-- 
2.17.1

