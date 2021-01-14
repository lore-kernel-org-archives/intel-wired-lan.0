From: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Date: Thu, 14 Jan 2021 14:33:15 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/4] i40e: remove unnecessary
 memory writes of the next to clean pointer
In-Reply-To: <20210114143318.2171-1-cristian.dumitrescu@intel.com>
References: <20210114143318.2171-1-cristian.dumitrescu@intel.com>
Message-ID: <20210114143318.2171-2-cristian.dumitrescu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

For performance reasons, avoid writing the ring next-to-clean pointer
value back to memory on every update, as it is not really necessary.
Instead, simply read it at initialization into a local copy, update
the local copy as necessary and write the local copy back to memory
after the last update.

Signed-off-by: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 30 ++++++++--------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 47eb9c584a12..dc11ecd1a55c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -261,18 +261,6 @@ static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
 	return skb;
 }
 
-/**
- * i40e_inc_ntc: Advance the next_to_clean index
- * @rx_ring: Rx ring
- **/
-static void i40e_inc_ntc(struct i40e_ring *rx_ring)
-{
-	u32 ntc = rx_ring->next_to_clean + 1;
-
-	ntc = (ntc < rx_ring->count) ? ntc : 0;
-	rx_ring->next_to_clean = ntc;
-}
-
 /**
  * i40e_clean_rx_irq_zc - Consumes Rx packets from the hardware ring
  * @rx_ring: Rx ring
@@ -284,6 +272,8 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 {
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	u16 cleaned_count = I40E_DESC_UNUSED(rx_ring);
+	u16 next_to_clean = rx_ring->next_to_clean;
+	u16 count_mask = rx_ring->count - 1;
 	unsigned int xdp_res, xdp_xmit = 0;
 	bool failure = false;
 	struct sk_buff *skb;
@@ -294,7 +284,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		unsigned int size;
 		u64 qword;
 
-		rx_desc = I40E_RX_DESC(rx_ring, rx_ring->next_to_clean);
+		rx_desc = I40E_RX_DESC(rx_ring, next_to_clean);
 		qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
 
 		/* This memory barrier is needed to keep us from reading
@@ -307,11 +297,11 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 			i40e_clean_programming_status(rx_ring,
 						      rx_desc->raw.qword[0],
 						      qword);
-			bi = i40e_rx_bi(rx_ring, rx_ring->next_to_clean);
+			bi = i40e_rx_bi(rx_ring, next_to_clean);
 			xsk_buff_free(*bi);
 			*bi = NULL;
 			cleaned_count++;
-			i40e_inc_ntc(rx_ring);
+			next_to_clean = (next_to_clean + 1) & count_mask;
 			continue;
 		}
 
@@ -320,7 +310,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		if (!size)
 			break;
 
-		bi = i40e_rx_bi(rx_ring, rx_ring->next_to_clean);
+		bi = i40e_rx_bi(rx_ring, next_to_clean);
 		(*bi)->data_end = (*bi)->data + size;
 		xsk_buff_dma_sync_for_cpu(*bi, rx_ring->xsk_pool);
 
@@ -336,7 +326,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 			total_rx_packets++;
 
 			cleaned_count++;
-			i40e_inc_ntc(rx_ring);
+			next_to_clean = (next_to_clean + 1) & count_mask;
 			continue;
 		}
 
@@ -355,7 +345,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		}
 
 		cleaned_count++;
-		i40e_inc_ntc(rx_ring);
+		next_to_clean = (next_to_clean + 1) & count_mask;
 
 		if (eth_skb_pad(skb))
 			continue;
@@ -367,6 +357,8 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		napi_gro_receive(&rx_ring->q_vector->napi, skb);
 	}
 
+	rx_ring->next_to_clean = next_to_clean;
+
 	if (cleaned_count >= I40E_RX_BUFFER_WRITE)
 		failure = !i40e_alloc_rx_buffers_zc(rx_ring, cleaned_count);
 
@@ -374,7 +366,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 	i40e_update_rx_stats(rx_ring, total_rx_bytes, total_rx_packets);
 
 	if (xsk_uses_need_wakeup(rx_ring->xsk_pool)) {
-		if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
+		if (failure || next_to_clean == rx_ring->next_to_use)
 			xsk_set_rx_need_wakeup(rx_ring->xsk_pool);
 		else
 			xsk_clear_rx_need_wakeup(rx_ring->xsk_pool);
-- 
2.25.1

