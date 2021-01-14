From: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Date: Thu, 14 Jan 2021 14:33:17 +0000
Subject: [Intel-wired-lan] [PATCH net-next 3/4] i40e: remove the redundant
 buffer info updates
In-Reply-To: <20210114143318.2171-1-cristian.dumitrescu@intel.com>
References: <20210114143318.2171-1-cristian.dumitrescu@intel.com>
Message-ID: <20210114143318.2171-4-cristian.dumitrescu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

For performace reasons, remove the redundant buffer info updates
(*bi = NULL). The buffers ready to be cleaned can easily be tracked
based on the ring next-to-clean variable, which is consistently
updated.

Signed-off-by: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 33 +++++++++-------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 453ef30d9498..1167496a2e08 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -280,7 +280,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 
 	while (likely(total_rx_packets < (unsigned int)budget)) {
 		union i40e_rx_desc *rx_desc;
-		struct xdp_buff **bi;
+		struct xdp_buff *bi;
 		unsigned int size;
 		u64 qword;
 
@@ -297,9 +297,8 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 			i40e_clean_programming_status(rx_ring,
 						      rx_desc->raw.qword[0],
 						      qword);
-			bi = i40e_rx_bi(rx_ring, next_to_clean);
-			xsk_buff_free(*bi);
-			*bi = NULL;
+			bi = *i40e_rx_bi(rx_ring, next_to_clean);
+			xsk_buff_free(bi);
 			next_to_clean = (next_to_clean + 1) & count_mask;
 			continue;
 		}
@@ -309,18 +308,17 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		if (!size)
 			break;
 
-		bi = i40e_rx_bi(rx_ring, next_to_clean);
-		(*bi)->data_end = (*bi)->data + size;
-		xsk_buff_dma_sync_for_cpu(*bi, rx_ring->xsk_pool);
+		bi = *i40e_rx_bi(rx_ring, next_to_clean);
+		bi->data_end = bi->data + size;
+		xsk_buff_dma_sync_for_cpu(bi, rx_ring->xsk_pool);
 
-		xdp_res = i40e_run_xdp_zc(rx_ring, *bi);
+		xdp_res = i40e_run_xdp_zc(rx_ring, bi);
 		if (xdp_res) {
 			if (xdp_res & (I40E_XDP_TX | I40E_XDP_REDIR))
 				xdp_xmit |= xdp_res;
 			else
-				xsk_buff_free(*bi);
+				xsk_buff_free(bi);
 
-			*bi = NULL;
 			total_rx_bytes += size;
 			total_rx_packets++;
 
@@ -335,8 +333,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		 * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
 		 * SBP is *not* set in PRT_SBPVSI (default not set).
 		 */
-		skb = i40e_construct_skb_zc(rx_ring, *bi);
-		*bi = NULL;
+		skb = i40e_construct_skb_zc(rx_ring, bi);
 		if (!skb) {
 			rx_ring->rx_stats.alloc_buff_failed++;
 			break;
@@ -594,16 +591,14 @@ int i40e_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 
 void i40e_xsk_clean_rx_ring(struct i40e_ring *rx_ring)
 {
-	u16 i;
-
-	for (i = 0; i < rx_ring->count; i++) {
-		struct xdp_buff *rx_bi = *i40e_rx_bi(rx_ring, i);
+	u16 count_mask = rx_ring->count - 1;
+	u16 ntc = rx_ring->next_to_clean;
+	u16 ntu = rx_ring->next_to_use;
 
-		if (!rx_bi)
-			continue;
+	for ( ; ntc != ntu; ntc = (ntc + 1)  & count_mask) {
+		struct xdp_buff *rx_bi = *i40e_rx_bi(rx_ring, ntc);
 
 		xsk_buff_free(rx_bi);
-		rx_bi = NULL;
 	}
 }
 
-- 
2.25.1

