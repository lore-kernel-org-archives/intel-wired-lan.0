From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Sep 2016 14:18:40 -0700
Subject: [Intel-wired-lan] [next PATCH S46 4/8] i40e/i40evf: Add txring_txq
	function to match fm10k and ixgbe
In-Reply-To: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
References: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473715124-31296-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch adds a txring_txq function which allows us to convert a
i40e_ring/i40evf_ring to a netdev_tx_queue structure.  This way we
can avoid having to make a multi-line function call for all the spots
that need access to this.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: Ic063b71d8b92ea406d2c32e798c8e2b02809d65b
---
Testing Hints:
        This functionality is most heavily used to stop/start the Tx queues
        so a good way to exercise this is to push the device with multiple
        large flows to the point that you start seeing the Tx restart stat
        incrementing.  As long as no data corruption is reported it is
        passing.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 17 ++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  9 +++++++++
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 17 ++++++-----------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  9 +++++++++
 4 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index a2077be..6e0a7ac 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -584,8 +584,7 @@ void i40e_clean_tx_ring(struct i40e_ring *tx_ring)
 		return;
 
 	/* cleanup Tx queue statistics */
-	netdev_tx_reset_queue(netdev_get_tx_queue(tx_ring->netdev,
-						  tx_ring->queue_index));
+	netdev_tx_reset_queue(txring_txq(tx_ring));
 }
 
 /**
@@ -754,8 +753,8 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 			tx_ring->arm_wb = true;
 	}
 
-	netdev_tx_completed_queue(netdev_get_tx_queue(tx_ring->netdev,
-						      tx_ring->queue_index),
+	/* notify netdev of completed buffers */
+	netdev_tx_completed_queue(txring_txq(tx_ring),
 				  total_packets, total_bytes);
 
 #define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
@@ -2784,9 +2783,7 @@ static inline void i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 	tx_ring->next_to_use = i;
 
-	netdev_tx_sent_queue(netdev_get_tx_queue(tx_ring->netdev,
-						 tx_ring->queue_index),
-						 first->bytecount);
+	netdev_tx_sent_queue(txring_txq(tx_ring), first->bytecount);
 	i40e_maybe_stop_tx(tx_ring, DESC_NEEDED);
 
 	/* Algorithm to optimize tail and RS bit setting:
@@ -2811,13 +2808,11 @@ static inline void i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	 * trigger a force WB.
 	 */
 	if (skb->xmit_more  &&
-	    !netif_xmit_stopped(netdev_get_tx_queue(tx_ring->netdev,
-						    tx_ring->queue_index))) {
+	    !netif_xmit_stopped(txring_txq(tx_ring))) {
 		tx_ring->flags |= I40E_TXR_FLAGS_LAST_XMIT_MORE_SET;
 		tail_bump = false;
 	} else if (!skb->xmit_more &&
-		   !netif_xmit_stopped(netdev_get_tx_queue(tx_ring->netdev,
-						       tx_ring->queue_index)) &&
+		   !netif_xmit_stopped(txring_txq(tx_ring)) &&
 		   (!(tx_ring->flags & I40E_TXR_FLAGS_LAST_XMIT_MORE_SET)) &&
 		   (tx_ring->packet_stride < WB_STRIDE) &&
 		   (desc_count < WB_STRIDE)) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index b78c810..ff63d77 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -463,4 +463,13 @@ static inline bool i40e_rx_is_fcoe(u16 ptype)
 	return (ptype >= I40E_RX_PTYPE_L2_FCOE_PAY3) &&
 	       (ptype <= I40E_RX_PTYPE_L2_FCOE_VFT_FCOTHER);
 }
+
+/**
+ * txring_txq - Find the netdev Tx ring based on the i40e Tx ring
+ * @ring: Tx ring to find the netdev equivilent of
+ **/
+static inline struct netdev_queue *txring_txq(const struct i40e_ring *ring)
+{
+	return netdev_get_tx_queue(ring->netdev, ring->queue_index);
+}
 #endif /* _I40E_TXRX_H_ */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index cb6b130..d4c6a76 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -103,8 +103,7 @@ void i40evf_clean_tx_ring(struct i40e_ring *tx_ring)
 		return;
 
 	/* cleanup Tx queue statistics */
-	netdev_tx_reset_queue(netdev_get_tx_queue(tx_ring->netdev,
-						  tx_ring->queue_index));
+	netdev_tx_reset_queue(txring_txq(tx_ring));
 }
 
 /**
@@ -273,8 +272,8 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 			tx_ring->arm_wb = true;
 	}
 
-	netdev_tx_completed_queue(netdev_get_tx_queue(tx_ring->netdev,
-						      tx_ring->queue_index),
+	/* notify netdev of completed buffers */
+	netdev_tx_completed_queue(txring_txq(tx_ring),
 				  total_packets, total_bytes);
 
 #define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
@@ -2012,9 +2011,7 @@ static inline void i40evf_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 	tx_ring->next_to_use = i;
 
-	netdev_tx_sent_queue(netdev_get_tx_queue(tx_ring->netdev,
-						 tx_ring->queue_index),
-						 first->bytecount);
+	netdev_tx_sent_queue(txring_txq(tx_ring), first->bytecount);
 	i40e_maybe_stop_tx(tx_ring, DESC_NEEDED);
 
 	/* Algorithm to optimize tail and RS bit setting:
@@ -2039,13 +2036,11 @@ static inline void i40evf_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	 * trigger a force WB.
 	 */
 	if (skb->xmit_more  &&
-	    !netif_xmit_stopped(netdev_get_tx_queue(tx_ring->netdev,
-						    tx_ring->queue_index))) {
+	    !netif_xmit_stopped(txring_txq(tx_ring))) {
 		tx_ring->flags |= I40E_TXR_FLAGS_LAST_XMIT_MORE_SET;
 		tail_bump = false;
 	} else if (!skb->xmit_more &&
-		   !netif_xmit_stopped(netdev_get_tx_queue(tx_ring->netdev,
-						       tx_ring->queue_index)) &&
+		   !netif_xmit_stopped(txring_txq(tx_ring)) &&
 		   (!(tx_ring->flags & I40E_TXR_FLAGS_LAST_XMIT_MORE_SET)) &&
 		   (tx_ring->packet_stride < WB_STRIDE) &&
 		   (desc_count < WB_STRIDE)) {
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 0112277..7f72ee7 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -445,4 +445,13 @@ static inline bool i40e_rx_is_fcoe(u16 ptype)
 	return (ptype >= I40E_RX_PTYPE_L2_FCOE_PAY3) &&
 	       (ptype <= I40E_RX_PTYPE_L2_FCOE_VFT_FCOTHER);
 }
+
+/**
+ * txring_txq - Find the netdev Tx ring based on the i40e Tx ring
+ * @ring: Tx ring to find the netdev equivilent of
+ **/
+static inline struct netdev_queue *txring_txq(const struct i40e_ring *ring)
+{
+	return netdev_get_tx_queue(ring->netdev, ring->queue_index);
+}
 #endif /* _I40E_TXRX_H_ */
-- 
2.4.11

