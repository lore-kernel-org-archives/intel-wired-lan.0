From: Ilya Maximets <i.maximets@samsung.com>
Date: Thu, 22 Aug 2019 15:30:37 +0300
Subject: [Intel-wired-lan] [PATCH net v2] ixgbe: fix double clean of tx
 descriptors with xdp
References: <CGME20190822123045eucas1p125b6e106f0310bdb50e759ef41993a91@eucas1p1.samsung.com>
Message-ID: <20190822123037.28068-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Tx code doesn't clear the descriptors' status after cleaning.
So, if the budget is larger than number of used elems in a ring, some
descriptors will be accounted twice and xsk_umem_complete_tx will move
prod_tail far beyond the prod_head breaking the comletion queue ring.

Fix that by limiting the number of descriptors to clean by the number
of used descriptors in the tx ring.

'ixgbe_clean_xdp_tx_irq()' function refactored to look more like
'ixgbe_xsk_clean_tx_ring()' since we don't need most of the
complications implemented in the regular 'ixgbe_clean_tx_irq()'
and we're allowed to directly use 'next_to_clean' and 'next_to_use'
indexes.

Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
---

Version 2:
  * 'ixgbe_clean_xdp_tx_irq()' refactored to look more like
    'ixgbe_xsk_clean_tx_ring()'.

 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 34 ++++++++------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 6b609553329f..d1297660e14a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -633,22 +633,23 @@ static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
 bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
 			    struct ixgbe_ring *tx_ring, int napi_budget)
 {
+	u16 ntc = tx_ring->next_to_clean, ntu = tx_ring->next_to_use;
 	unsigned int total_packets = 0, total_bytes = 0;
-	u32 i = tx_ring->next_to_clean, xsk_frames = 0;
 	unsigned int budget = q_vector->tx.work_limit;
 	struct xdp_umem *umem = tx_ring->xsk_umem;
-	union ixgbe_adv_tx_desc *tx_desc;
-	struct ixgbe_tx_buffer *tx_bi;
+	u32 xsk_frames = 0;
 	bool xmit_done;
 
-	tx_bi = &tx_ring->tx_buffer_info[i];
-	tx_desc = IXGBE_TX_DESC(tx_ring, i);
-	i -= tx_ring->count;
+	while (likely(ntc != ntu && budget)) {
+		union ixgbe_adv_tx_desc *tx_desc;
+		struct ixgbe_tx_buffer *tx_bi;
+
+		tx_desc = IXGBE_TX_DESC(tx_ring, ntc);
 
-	do {
 		if (!(tx_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
 			break;
 
+		tx_bi = &tx_ring->tx_buffer_info[ntc];
 		total_bytes += tx_bi->bytecount;
 		total_packets += tx_bi->gso_segs;
 
@@ -659,24 +660,15 @@ bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
 
 		tx_bi->xdpf = NULL;
 
-		tx_bi++;
-		tx_desc++;
-		i++;
-		if (unlikely(!i)) {
-			i -= tx_ring->count;
-			tx_bi = tx_ring->tx_buffer_info;
-			tx_desc = IXGBE_TX_DESC(tx_ring, 0);
-		}
-
-		/* issue prefetch for next Tx descriptor */
-		prefetch(tx_desc);
+		ntc++;
+		if (unlikely(ntc == tx_ring->count))
+			ntc = 0;
 
 		/* update budget accounting */
 		budget--;
-	} while (likely(budget));
+	}
 
-	i += tx_ring->count;
-	tx_ring->next_to_clean = i;
+	tx_ring->next_to_clean = ntc;
 
 	u64_stats_update_begin(&tx_ring->syncp);
 	tx_ring->stats.bytes += total_bytes;
-- 
2.17.1

