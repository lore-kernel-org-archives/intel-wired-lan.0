From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 26 Feb 2018 13:37:43 -0800
Subject: [Intel-wired-lan] [RFC PATCH 3/5] ixgbevf: Delay tail write for XDP
 packets
In-Reply-To: <20180226213745.14508-1-anthony.l.nguyen@intel.com>
References: <20180226213745.14508-1-anthony.l.nguyen@intel.com>
Message-ID: <20180226213745.14508-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Current XDP implementation hits the tail on every XDP_TX; change the
driver to only hit the tail after packet processing is complete.

Based on commit 7379f97a4fce ("ixgbe: delay tail write to every 'n'
packets")

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 30 ++++++++++++++---------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 20d2f415ea0d..ca6c11bae66c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1016,14 +1016,8 @@ static int ixgbevf_xmit_xdp_ring(struct ixgbevf_ring *ring,
 			cpu_to_le32((len << IXGBE_ADVTXD_PAYLEN_SHIFT) |
 				    IXGBE_ADVTXD_CC);
 
-	/* Force memory writes to complete before letting h/w know there
-	 * are new descriptors to fetch.  (Only applicable for weak-ordered
-	 * memory model archs, such as IA-64).
-	 *
-	 * We also need this memory barrier to make certain all of the
-	 * status bits have been updated before next_to_watch is written.
-	 */
-	wmb();
+	/* Avoid any potential race with cleanup */
+	smp_wmb();
 
 	/* set next_to_watch value indicating a packet is present */
 	i++;
@@ -1033,8 +1027,6 @@ static int ixgbevf_xmit_xdp_ring(struct ixgbevf_ring *ring,
 	tx_buffer->next_to_watch = tx_desc;
 	ring->next_to_use = i;
 
-	/* notify HW of packet */
-	ixgbevf_write_tail(ring, i);
 	return IXGBEVF_XDP_TX;
 }
 
@@ -1101,6 +1093,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 	struct ixgbevf_adapter *adapter = q_vector->adapter;
 	u16 cleaned_count = ixgbevf_desc_unused(rx_ring);
 	struct sk_buff *skb = rx_ring->skb;
+	bool xdp_xmit = false;
 	struct xdp_buff xdp;
 
 	xdp.rxq = &rx_ring->xdp_rxq;
@@ -1142,11 +1135,13 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		}
 
 		if (IS_ERR(skb)) {
-			if (PTR_ERR(skb) == -IXGBEVF_XDP_TX)
+			if (PTR_ERR(skb) == -IXGBEVF_XDP_TX) {
+				xdp_xmit = true;
 				ixgbevf_rx_buffer_flip(rx_ring, rx_buffer,
 						       size);
-			else
+			} else {
 				rx_buffer->pagecnt_bias++;
+			}
 			total_rx_packets++;
 			total_rx_bytes += size;
 		} else if (skb) {
@@ -1208,6 +1203,17 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 	/* place incomplete frames back on ring for completion */
 	rx_ring->skb = skb;
 
+	if (xdp_xmit) {
+		struct ixgbevf_ring *xdp_ring =
+			adapter->xdp_ring[rx_ring->queue_index];
+
+		/* Force memory writes to complete before letting h/w
+		 * know there are new descriptors to fetch.
+		 */
+		wmb();
+		ixgbevf_write_tail(xdp_ring, xdp_ring->next_to_use);
+	}
+
 	u64_stats_update_begin(&rx_ring->syncp);
 	rx_ring->stats.packets += total_rx_packets;
 	rx_ring->stats.bytes += total_rx_bytes;
-- 
2.13.6

