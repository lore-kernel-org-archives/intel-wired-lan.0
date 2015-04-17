From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 16 Apr 2015 20:06:09 -0400
Subject: [Intel-wired-lan] [net-next S4 12/15] i40evf: skb->xmit_more support
In-Reply-To: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1429229172-143692-13-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Eric added support for skb->xmit_more in i40e, this ports that into i40evf as well.

Support skb->xmit_more in i40evf is straightforward; we need to move
around i40e_maybe_stop_tx() call to correctly test netif_xmit_stopped()
before taking the decision to not kick the NIC.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Daniel Borkmann <dborkman@redhat.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: Idddda6a2e4a7ab335631c91ced51f55b25eb8468
---
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 88 ++++++++++++++-------------
 1 file changed, 47 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index e1a44dd..4f77d38 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1672,6 +1672,47 @@ linearize_chk_done:
 }
 
 /**
+ * __i40evf_maybe_stop_tx - 2nd level check for tx stop conditions
+ * @tx_ring: the ring to be checked
+ * @size:    the size buffer we want to assure is available
+ *
+ * Returns -EBUSY if a stop is needed, else 0
+ **/
+static inline int __i40evf_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
+{
+	netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
+	/* Memory barrier before checking head and tail */
+	smp_mb();
+
+	/* Check again in a case another CPU has just made room available. */
+	if (likely(I40E_DESC_UNUSED(tx_ring) < size))
+		return -EBUSY;
+
+	/* A reprieve! - use start_queue because it doesn't call schedule */
+	netif_start_subqueue(tx_ring->netdev, tx_ring->queue_index);
+	++tx_ring->tx_stats.restart_queue;
+	return 0;
+}
+
+/**
+ * i40evf_maybe_stop_tx - 1st level check for tx stop conditions
+ * @tx_ring: the ring to be checked
+ * @size:    the size buffer we want to assure is available
+ *
+ * Returns 0 if stop is not needed
+ **/
+#ifdef I40E_FCOE
+int i40evf_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
+#else
+static int i40evf_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
+#endif
+{
+	if (likely(I40E_DESC_UNUSED(tx_ring) >= size))
+		return 0;
+	return __i40evf_maybe_stop_tx(tx_ring, size);
+}
+
+/**
  * i40e_tx_map - Build the Tx descriptor
  * @tx_ring:  ring to send buffer on
  * @skb:      send buffer
@@ -1808,8 +1849,12 @@ static void i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 	tx_ring->next_to_use = i;
 
+	i40evf_maybe_stop_tx(tx_ring, DESC_NEEDED);
 	/* notify HW of packet */
-	writel(i, tx_ring->tail);
+	if (!skb->xmit_more ||
+	    netif_xmit_stopped(netdev_get_tx_queue(tx_ring->netdev,
+						   tx_ring->queue_index)))
+		writel(i, tx_ring->tail);
 
 	return;
 
@@ -1831,43 +1876,6 @@ dma_error:
 }
 
 /**
- * __i40e_maybe_stop_tx - 2nd level check for tx stop conditions
- * @tx_ring: the ring to be checked
- * @size:    the size buffer we want to assure is available
- *
- * Returns -EBUSY if a stop is needed, else 0
- **/
-static inline int __i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
-{
-	netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
-	/* Memory barrier before checking head and tail */
-	smp_mb();
-
-	/* Check again in a case another CPU has just made room available. */
-	if (likely(I40E_DESC_UNUSED(tx_ring) < size))
-		return -EBUSY;
-
-	/* A reprieve! - use start_queue because it doesn't call schedule */
-	netif_start_subqueue(tx_ring->netdev, tx_ring->queue_index);
-	++tx_ring->tx_stats.restart_queue;
-	return 0;
-}
-
-/**
- * i40e_maybe_stop_tx - 1st level check for tx stop conditions
- * @tx_ring: the ring to be checked
- * @size:    the size buffer we want to assure is available
- *
- * Returns 0 if stop is not needed
- **/
-static int i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
-{
-	if (likely(I40E_DESC_UNUSED(tx_ring) >= size))
-		return 0;
-	return __i40e_maybe_stop_tx(tx_ring, size);
-}
-
-/**
  * i40e_xmit_descriptor_count - calculate number of tx descriptors needed
  * @skb:     send buffer
  * @tx_ring: ring to send buffer on
@@ -1892,7 +1900,7 @@ static int i40e_xmit_descriptor_count(struct sk_buff *skb,
 		count += TXD_USE_COUNT(skb_shinfo(skb)->frags[f].size);
 
 	count += TXD_USE_COUNT(skb_headlen(skb));
-	if (i40e_maybe_stop_tx(tx_ring, count + 4 + 1)) {
+	if (i40evf_maybe_stop_tx(tx_ring, count + 4 + 1)) {
 		tx_ring->tx_stats.tx_busy++;
 		return 0;
 	}
@@ -1968,8 +1976,6 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	i40e_tx_map(tx_ring, skb, first, tx_flags, hdr_len,
 		    td_cmd, td_offset);
 
-	i40e_maybe_stop_tx(tx_ring, DESC_NEEDED);
-
 	return NETDEV_TX_OK;
 
 out_drop:
-- 
1.9.3

