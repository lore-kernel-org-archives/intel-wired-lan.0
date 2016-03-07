From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 07 Mar 2016 09:30:15 -0800
Subject: [Intel-wired-lan] [PATCH 4/5] fm10k: Add support for bulk Tx
 cleanup & cleanup boolean logic
In-Reply-To: <20160307172722.5682.38580.stgit@localhost.localdomain>
References: <20160307172722.5682.38580.stgit@localhost.localdomain>
Message-ID: <20160307173015.5682.15247.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch enables bulk free in Tx cleanup for fm10k and cleans up the
boolean logic in the polling routines for fm10k in the hopes of avoiding
any mix-ups similar to what occurred with i40e and i40evf.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 43f3674501cc..de406dca8f06 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1198,9 +1198,10 @@ void fm10k_tx_timeout_reset(struct fm10k_intfc *interface)
  * fm10k_clean_tx_irq - Reclaim resources after transmit completes
  * @q_vector: structure containing interrupt and ring information
  * @tx_ring: tx ring to clean
+ * @napi_budget: Used to determine if we are in netpoll
  **/
 static bool fm10k_clean_tx_irq(struct fm10k_q_vector *q_vector,
-			       struct fm10k_ring *tx_ring)
+			       struct fm10k_ring *tx_ring, int napi_budget)
 {
 	struct fm10k_intfc *interface = q_vector->interface;
 	struct fm10k_tx_buffer *tx_buffer;
@@ -1238,7 +1239,7 @@ static bool fm10k_clean_tx_irq(struct fm10k_q_vector *q_vector,
 		total_packets += tx_buffer->gso_segs;
 
 		/* free the skb */
-		dev_consume_skb_any(tx_buffer->skb);
+		napi_consume_skb(tx_buffer->skb, napi_budget);
 
 		/* unmap skb header data */
 		dma_unmap_single(tx_ring->dev,
@@ -1449,8 +1450,10 @@ static int fm10k_poll(struct napi_struct *napi, int budget)
 	int per_ring_budget, work_done = 0;
 	bool clean_complete = true;
 
-	fm10k_for_each_ring(ring, q_vector->tx)
-		clean_complete &= fm10k_clean_tx_irq(q_vector, ring);
+	fm10k_for_each_ring(ring, q_vector->tx) {
+		if (!fm10k_clean_tx_irq(q_vector, ring, budget))
+			clean_complete = false;
+	}
 
 	/* Handle case where we are called by netpoll with a budget of 0 */
 	if (budget <= 0)
@@ -1468,7 +1471,8 @@ static int fm10k_poll(struct napi_struct *napi, int budget)
 		int work = fm10k_clean_rx_irq(q_vector, ring, per_ring_budget);
 
 		work_done += work;
-		clean_complete &= !!(work < per_ring_budget);
+		if (work >= per_ring_budget)
+			clean_complete = false;
 	}
 
 	/* If all work not completed, return budget and keep polling */

