From: jeff.evanson@gmail.com <jeff.evanson@gmail.com>
Date: Tue, 19 Apr 2022 19:26:35 -0600
Subject: [Intel-wired-lan] [PATCH v2 2/2] igc: Trigger proper interrupts in
 igc_xsk_wakeup
In-Reply-To: <20220420012635.13733-1-jeff.evanson@qsc.com>
References: <20220420012635.13733-1-jeff.evanson@qsc.com>
Message-ID: <20220420012635.13733-3-jeff.evanson@qsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeff Evanson <jeff.evanson@qsc.com>

In igc_xsk_wakeup, trigger the proper interrupt based on whether flags
contains XDP_WAKEUP_RX and/or XDP_WAKEUP_TX.

Consider a scenario where the transmit queue interrupt is mapped to a
different irq from the receive queue. If XDP_WAKEUP_TX is set in the
flags argument, the interrupt for transmit queue must be triggered,
otherwise the transmit queue's napi_struct will never be scheduled.

In the case where both XDP_WAKEUP_TX and XDP_WAKEUP_RX are both set,
the receive interrupt should always be triggered, but the transmit
interrupt should only be triggered if its q_vector differs from the
receive queue's interrupt.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
---
 drivers/net/ethernet/intel/igc/igc_main.c | 40 ++++++++++++++++++-----
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index a36a18c84aeb..41b5d1ac8bc1 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6072,8 +6072,8 @@ static void igc_trigger_rxtxq_interrupt(struct igc_adapter *adapter,
 
 int igc_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 {
+	struct igc_q_vector *txq_vector = NULL, *rxq_vector = NULL;
 	struct igc_adapter *adapter = netdev_priv(dev);
-	struct igc_q_vector *q_vector;
 	struct igc_ring *ring;
 
 	if (test_bit(__IGC_DOWN, &adapter->state))
@@ -6082,17 +6082,39 @@ int igc_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 	if (!igc_xdp_is_enabled(adapter))
 		return -ENXIO;
 
-	if (queue_id >= adapter->num_rx_queues)
-		return -EINVAL;
+	if (flags & XDP_WAKEUP_RX) {
+		if (queue_id >= adapter->num_rx_queues)
+			return -EINVAL;
 
-	ring = adapter->rx_ring[queue_id];
+		ring = adapter->rx_ring[queue_id];
+		if (!ring->xsk_pool)
+			return -ENXIO;
 
-	if (!ring->xsk_pool)
-		return -ENXIO;
+		rxq_vector = ring->q_vector;
+	}
+
+	if (flags & XDP_WAKEUP_TX) {
+		if (queue_id >= adapter->num_tx_queues)
+			return -EINVAL;
+
+		ring = adapter->tx_ring[queue_id];
+		if (!ring->xsk_pool)
+			return -ENXIO;
+
+		txq_vector = ring->q_vector;
+	}
+
+	if (rxq_vector != NULL &&
+	    !napi_if_scheduled_mark_missed(&rxq_vector->napi))
+		igc_trigger_rxtxq_interrupt(adapter, rxq_vector);
 
-	q_vector = adapter->q_vector[queue_id];
-	if (!napi_if_scheduled_mark_missed(&q_vector->napi))
-		igc_trigger_rxtxq_interrupt(adapter, q_vector);
+	/* only trigger tx interrupt if the receive interrupt was not
+	 * triggered or if its irq differs from the receive queue's irq
+	 */
+	if (txq_vector != NULL &&
+            txq_vector != rxq_vector &&
+	    !napi_if_scheduled_mark_missed(&txq_vector->napi))
+		igc_trigger_rxtxq_interrupt(adapter, txq_vector);
 
 	return 0;
 }
-- 
2.17.1

