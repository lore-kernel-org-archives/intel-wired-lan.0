From: Alice Michael <alice.michael@intel.com>
Date: Mon, 12 Feb 2018 09:16:59 -0500
Subject: [Intel-wired-lan] [PATCH] i40e/i40evf: use SW variables for hang
 detection
Message-ID: <20180212141659.38064-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

The i40e_detect_recover_hung function uses the i40e_get_tx_pending
function to determine if there are packets stalled on the ring.
i40e_get_tx_pending calculates the pending packets using the head
writeback value and HW tail.  If the queue is stopped and we lose the
interrupt to update our next_to_clean then we a) won't get another
interrupt to clean because queue is stopped b) we won't catch the
problem with i40e_detect_recover_hung because the HW values look like
there's no packets waiting to be transmitted.  Using the SW values we
can catch the issue because next_to_clean will be out of sync with head
writeback.

This has the added benefit being less CPU intensive because we don't
need to reach into the hardware to get the values.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 16 +++++++++++-----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  2 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 121011e..7ccd05b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -709,16 +709,22 @@ void i40e_free_tx_resources(struct i40e_ring *tx_ring)
 /**
  * i40e_get_tx_pending - how many tx descriptors not processed
  * @tx_ring: the ring of descriptors
+ * @in_sw: use SW variables
  *
  * Since there is no access to the ring head register
  * in XL710, we need to use our local copies
  **/
-u32 i40e_get_tx_pending(struct i40e_ring *ring)
+u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw)
 {
 	u32 head, tail;
 
-	head = i40e_get_head(ring);
-	tail = readl(ring->tail);
+	if (!in_sw) {
+		head = i40e_get_head(ring);
+		tail = readl(ring->tail);
+	} else {
+		head = ring->next_to_clean;
+		tail = ring->next_to_use;
+	}
 
 	if (head != tail)
 		return (head < tail) ?
@@ -775,7 +781,7 @@ void i40e_detect_recover_hung(struct i40e_vsi *vsi)
 			 */
 			smp_rmb();
 			tx_ring->tx_stats.prev_pkt_ctr =
-			    i40e_get_tx_pending(tx_ring) ? packets : -1;
+			    i40e_get_tx_pending(tx_ring, true) ? packets : -1;
 		}
 	}
 }
@@ -899,7 +905,7 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 		 * them to be written back in case we stay in NAPI.
 		 * In this mode on X722 we do not enable Interrupt.
 		 */
-		unsigned int j = i40e_get_tx_pending(tx_ring);
+		unsigned int j = i40e_get_tx_pending(tx_ring, false);
 
 		if (budget &&
 		    ((j / WB_STRIDE) == 0) && (j > 0) &&
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index ea114dc..000646b5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -506,7 +506,7 @@ void i40e_free_tx_resources(struct i40e_ring *tx_ring);
 void i40e_free_rx_resources(struct i40e_ring *rx_ring);
 int i40e_napi_poll(struct napi_struct *napi, int budget);
 void i40e_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector);
-u32 i40e_get_tx_pending(struct i40e_ring *ring);
+u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw);
 void i40e_detect_recover_hung(struct i40e_vsi *vsi);
 int __i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size);
 bool __i40e_chk_linearize(struct sk_buff *skb);
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index d3c5263..12bd937 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -197,7 +197,7 @@ void i40evf_detect_recover_hung(struct i40e_vsi *vsi)
 			 */
 			smp_rmb();
 			tx_ring->tx_stats.prev_pkt_ctr =
-			  i40evf_get_tx_pending(tx_ring, false) ? packets : -1;
+			  i40evf_get_tx_pending(tx_ring, true) ? packets : -1;
 		}
 	}
 }
-- 
2.9.5

