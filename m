From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 19 Oct 2018 22:57:47 +0300
Subject: [Intel-wired-lan] [PATCH] igc: Tidy up some white space
Message-ID: <20181019195747.e4h2oihuyroi5vwn@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I just cleaned up a couple small white space issues.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 9d85707e8a81..3233141c594b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1108,7 +1108,7 @@ static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
 
 	/* update pointers within the skb to store the data */
 	skb_reserve(skb, IGC_SKB_PAD);
-	 __skb_put(skb, size);
+	__skb_put(skb, size);
 
 	/* update buffer offset */
 #if (PAGE_SIZE < 8192)
@@ -1160,9 +1160,9 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
 				(va + headlen) - page_address(rx_buffer->page),
 				size, truesize);
 #if (PAGE_SIZE < 8192)
-	rx_buffer->page_offset ^= truesize;
+		rx_buffer->page_offset ^= truesize;
 #else
-	rx_buffer->page_offset += truesize;
+		rx_buffer->page_offset += truesize;
 #endif
 	} else {
 		rx_buffer->pagecnt_bias++;
@@ -1668,8 +1668,8 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
 				tx_buffer->next_to_watch,
 				jiffies,
 				tx_buffer->next_to_watch->wb.status);
-				netif_stop_subqueue(tx_ring->netdev,
-						    tx_ring->queue_index);
+			netif_stop_subqueue(tx_ring->netdev,
+					    tx_ring->queue_index);
 
 			/* we are about to reset, no point in enabling stuff */
 			return true;
-- 
2.11.0

