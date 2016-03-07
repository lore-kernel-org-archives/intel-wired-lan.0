From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 07 Mar 2016 09:30:03 -0800
Subject: [Intel-wired-lan] [PATCH 2/5] i40e/i40evf: Add support for bulk
	free in Tx cleanup
In-Reply-To: <20160307172722.5682.38580.stgit@localhost.localdomain>
References: <20160307172722.5682.38580.stgit@localhost.localdomain>
Message-ID: <20160307173003.5682.90872.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch enables bulk Tx clean for skbs.  In order to enable it we need
to pass the napi_budget value as that is used to determine if we are truly
running in NAPI mode or if we are simply calling the routine from netpoll
with a budget of 0.  In order to avoid adding too many more variables I
thought it best to pass the VSI directly in a fashion similar to what we do
on igb and ixgbe with the q_vector.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   20 +++++++++++---------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   20 +++++++++++---------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 8fb2a966d70e..01cff073f8db 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -636,19 +636,21 @@ u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw)
 
 /**
  * i40e_clean_tx_irq - Reclaim resources after transmit completes
- * @tx_ring:  tx ring to clean
- * @budget:   how many cleans we're allowed
+ * @vsi: the VSI we care about
+ * @tx_ring: Tx ring to clean
+ * @napi_budget: Used to determine if we are in netpoll
  *
  * Returns true if there's any budget left (e.g. the clean is finished)
  **/
-static bool i40e_clean_tx_irq(struct i40e_ring *tx_ring, int budget)
+static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
+			      struct i40e_ring *tx_ring, int napi_budget)
 {
 	u16 i = tx_ring->next_to_clean;
 	struct i40e_tx_buffer *tx_buf;
 	struct i40e_tx_desc *tx_head;
 	struct i40e_tx_desc *tx_desc;
-	unsigned int total_packets = 0;
-	unsigned int total_bytes = 0;
+	unsigned int total_bytes = 0, total_packets = 0;
+	unsigned int budget = vsi->work_limit;
 
 	tx_buf = &tx_ring->tx_bi[i];
 	tx_desc = I40E_TX_DESC(tx_ring, i);
@@ -678,7 +680,7 @@ static bool i40e_clean_tx_irq(struct i40e_ring *tx_ring, int budget)
 		total_packets += tx_buf->gso_segs;
 
 		/* free the skb */
-		dev_consume_skb_any(tx_buf->skb);
+		napi_consume_skb(tx_buf->skb, napi_budget);
 
 		/* unmap skb header data */
 		dma_unmap_single(tx_ring->dev,
@@ -749,7 +751,7 @@ static bool i40e_clean_tx_irq(struct i40e_ring *tx_ring, int budget)
 
 		if (budget &&
 		    ((j / (WB_STRIDE + 1)) == 0) && (j != 0) &&
-		    !test_bit(__I40E_DOWN, &tx_ring->vsi->state) &&
+		    !test_bit(__I40E_DOWN, &vsi->state) &&
 		    (I40E_DESC_UNUSED(tx_ring) != tx_ring->count))
 			tx_ring->arm_wb = true;
 	}
@@ -767,7 +769,7 @@ static bool i40e_clean_tx_irq(struct i40e_ring *tx_ring, int budget)
 		smp_mb();
 		if (__netif_subqueue_stopped(tx_ring->netdev,
 					     tx_ring->queue_index) &&
-		   !test_bit(__I40E_DOWN, &tx_ring->vsi->state)) {
+		   !test_bit(__I40E_DOWN, &vsi->state)) {
 			netif_wake_subqueue(tx_ring->netdev,
 					    tx_ring->queue_index);
 			++tx_ring->tx_stats.restart_queue;
@@ -1975,7 +1977,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 	 * budget and be more aggressive about cleaning up the Tx descriptors.
 	 */
 	i40e_for_each_ring(ring, q_vector->tx) {
-		if (!i40e_clean_tx_irq(ring, vsi->work_limit)) {
+		if (!i40e_clean_tx_irq(vsi, ring, budget)) {
 			clean_complete = false;
 			continue;
 		}
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 839a6df62f72..9e911363c11b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -155,19 +155,21 @@ u32 i40evf_get_tx_pending(struct i40e_ring *ring, bool in_sw)
 
 /**
  * i40e_clean_tx_irq - Reclaim resources after transmit completes
- * @tx_ring:  tx ring to clean
- * @budget:   how many cleans we're allowed
+ * @vsi: the VSI we care about
+ * @tx_ring: Tx ring to clean
+ * @napi_budget: Used to determine if we are in netpoll
  *
  * Returns true if there's any budget left (e.g. the clean is finished)
  **/
-static bool i40e_clean_tx_irq(struct i40e_ring *tx_ring, int budget)
+static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
+			      struct i40e_ring *tx_ring, int napi_budget)
 {
 	u16 i = tx_ring->next_to_clean;
 	struct i40e_tx_buffer *tx_buf;
 	struct i40e_tx_desc *tx_head;
 	struct i40e_tx_desc *tx_desc;
-	unsigned int total_packets = 0;
-	unsigned int total_bytes = 0;
+	unsigned int total_bytes = 0, total_packets = 0;
+	unsigned int budget = vsi->work_limit;
 
 	tx_buf = &tx_ring->tx_bi[i];
 	tx_desc = I40E_TX_DESC(tx_ring, i);
@@ -197,7 +199,7 @@ static bool i40e_clean_tx_irq(struct i40e_ring *tx_ring, int budget)
 		total_packets += tx_buf->gso_segs;
 
 		/* free the skb */
-		dev_kfree_skb_any(tx_buf->skb);
+		napi_consume_skb(tx_buf->skb, napi_budget);
 
 		/* unmap skb header data */
 		dma_unmap_single(tx_ring->dev,
@@ -267,7 +269,7 @@ static bool i40e_clean_tx_irq(struct i40e_ring *tx_ring, int budget)
 
 		if (budget &&
 		    ((j / (WB_STRIDE + 1)) == 0) && (j > 0) &&
-		    !test_bit(__I40E_DOWN, &tx_ring->vsi->state) &&
+		    !test_bit(__I40E_DOWN, &vsi->state) &&
 		    (I40E_DESC_UNUSED(tx_ring) != tx_ring->count))
 			tx_ring->arm_wb = true;
 	}
@@ -285,7 +287,7 @@ static bool i40e_clean_tx_irq(struct i40e_ring *tx_ring, int budget)
 		smp_mb();
 		if (__netif_subqueue_stopped(tx_ring->netdev,
 					     tx_ring->queue_index) &&
-		   !test_bit(__I40E_DOWN, &tx_ring->vsi->state)) {
+		   !test_bit(__I40E_DOWN, &vsi->state)) {
 			netif_wake_subqueue(tx_ring->netdev,
 					    tx_ring->queue_index);
 			++tx_ring->tx_stats.restart_queue;
@@ -1411,7 +1413,7 @@ int i40evf_napi_poll(struct napi_struct *napi, int budget)
 	 * budget and be more aggressive about cleaning up the Tx descriptors.
 	 */
 	i40e_for_each_ring(ring, q_vector->tx) {
-		if (!i40e_clean_tx_irq(ring, vsi->work_limit)) {
+		if (!i40e_clean_tx_irq(vsi, ring, budget)) {
 			clean_complete = false;
 			continue;
 		}

