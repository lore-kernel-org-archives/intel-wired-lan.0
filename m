From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Fri, 25 Sep 2015 12:00:09 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] i40e: Disable Check for Hang
In-Reply-To: <1443207609-171288-1-git-send-email-anjali.singhai@intel.com>
References: <1443207609-171288-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <1443207609-171288-2-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver doesn't need its own check for hang logic as there are no
known issues that cause HW Tx Hangs. This logic was actually
(mis)firing frequently, causing us to reset when we didn't need to.
If a true tx hang happens, just wait for the stack logic to catch the
issue and send us a tx_timeout.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 99 +----------------------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 70 --------------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  8 ---
 3 files changed, 1 insertion(+), 176 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f048002..7b92d1d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -758,7 +758,6 @@ static void i40e_update_link_xoff_rx(struct i40e_pf *pf)
 	struct i40e_hw_port_stats *nsd = &pf->stats;
 	struct i40e_hw *hw = &pf->hw;
 	u64 xoff = 0;
-	u16 i, v;
 
 	if ((hw->fc.current_mode != I40E_FC_FULL) &&
 	    (hw->fc.current_mode != I40E_FC_RX_PAUSE))
@@ -772,20 +771,6 @@ static void i40e_update_link_xoff_rx(struct i40e_pf *pf)
 	/* No new LFC xoff rx */
 	if (!(nsd->link_xoff_rx - xoff))
 		return;
-
-	/* Clear the __I40E_HANG_CHECK_ARMED bit for all Tx rings */
-	for (v = 0; v < pf->num_alloc_vsi; v++) {
-		struct i40e_vsi *vsi = pf->vsi[v];
-
-		if (!vsi || !vsi->tx_rings[0])
-			continue;
-
-		for (i = 0; i < vsi->num_queue_pairs; i++) {
-			struct i40e_ring *ring = vsi->tx_rings[i];
-
-			clear_bit(__I40E_HANG_CHECK_ARMED, &ring->state);
-		}
-	}
 }
 
 /**
@@ -801,7 +786,7 @@ static void i40e_update_prio_xoff_rx(struct i40e_pf *pf)
 	bool xoff[I40E_MAX_TRAFFIC_CLASS] = {false};
 	struct i40e_dcbx_config *dcb_cfg;
 	struct i40e_hw *hw = &pf->hw;
-	u16 i, v;
+	u16 i;
 	u8 tc;
 
 	dcb_cfg = &hw->local_dcbx_config;
@@ -827,23 +812,6 @@ static void i40e_update_prio_xoff_rx(struct i40e_pf *pf)
 		tc = dcb_cfg->etscfg.prioritytable[i];
 		xoff[tc] = true;
 	}
-
-	/* Clear the __I40E_HANG_CHECK_ARMED bit for Tx rings */
-	for (v = 0; v < pf->num_alloc_vsi; v++) {
-		struct i40e_vsi *vsi = pf->vsi[v];
-
-		if (!vsi || !vsi->tx_rings[0])
-			continue;
-
-		for (i = 0; i < vsi->num_queue_pairs; i++) {
-			struct i40e_ring *ring = vsi->tx_rings[i];
-
-			tc = ring->dcb_tc;
-			if (xoff[tc])
-				clear_bit(__I40E_HANG_CHECK_ARMED,
-					  &ring->state);
-		}
-	}
 }
 
 /**
@@ -2803,8 +2771,6 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
 	wr32(hw, I40E_QTX_CTL(pf_q), qtx_ctl);
 	i40e_flush(hw);
 
-	clear_bit(__I40E_HANG_CHECK_ARMED, &ring->state);
-
 	/* cache tail off for easier writes later */
 	ring->tail = hw->hw_addr + I40E_QTX_TAIL(pf_q);
 
@@ -5949,68 +5915,6 @@ static void i40e_link_event(struct i40e_pf *pf)
 }
 
 /**
- * i40e_check_hang_subtask - Check for hung queues and dropped interrupts
- * @pf: board private structure
- *
- * Set the per-queue flags to request a check for stuck queues in the irq
- * clean functions, then force interrupts to be sure the irq clean is called.
- **/
-static void i40e_check_hang_subtask(struct i40e_pf *pf)
-{
-	int i, v;
-
-	/* If we're down or resetting, just bail */
-	if (test_bit(__I40E_DOWN, &pf->state) ||
-	    test_bit(__I40E_CONFIG_BUSY, &pf->state))
-		return;
-
-	/* for each VSI/netdev
-	 *     for each Tx queue
-	 *         set the check flag
-	 *     for each q_vector
-	 *         force an interrupt
-	 */
-	for (v = 0; v < pf->num_alloc_vsi; v++) {
-		struct i40e_vsi *vsi = pf->vsi[v];
-		int armed = 0;
-
-		if (!pf->vsi[v] ||
-		    test_bit(__I40E_DOWN, &vsi->state) ||
-		    (vsi->netdev && !netif_carrier_ok(vsi->netdev)))
-			continue;
-
-		for (i = 0; i < vsi->num_queue_pairs; i++) {
-			set_check_for_tx_hang(vsi->tx_rings[i]);
-			if (test_bit(__I40E_HANG_CHECK_ARMED,
-				     &vsi->tx_rings[i]->state))
-				armed++;
-		}
-
-		if (armed) {
-			if (!(pf->flags & I40E_FLAG_MSIX_ENABLED)) {
-				wr32(&vsi->back->hw, I40E_PFINT_DYN_CTL0,
-				     (I40E_PFINT_DYN_CTL0_INTENA_MASK |
-				      I40E_PFINT_DYN_CTL0_SWINT_TRIG_MASK |
-				      I40E_PFINT_DYN_CTL0_ITR_INDX_MASK |
-				      I40E_PFINT_DYN_CTL0_SW_ITR_INDX_ENA_MASK |
-				      I40E_PFINT_DYN_CTL0_SW_ITR_INDX_MASK));
-			} else {
-				u16 vec = vsi->base_vector - 1;
-				u32 val = (I40E_PFINT_DYN_CTLN_INTENA_MASK |
-				      I40E_PFINT_DYN_CTLN_SWINT_TRIG_MASK |
-				      I40E_PFINT_DYN_CTLN_ITR_INDX_MASK |
-				      I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_MASK |
-				      I40E_PFINT_DYN_CTLN_SW_ITR_INDX_MASK);
-				for (i = 0; i < vsi->num_q_vectors; i++, vec++)
-					wr32(&vsi->back->hw,
-					     I40E_PFINT_DYN_CTLN(vec), val);
-			}
-			i40e_flush(&vsi->back->hw);
-		}
-	}
-}
-
-/**
  * i40e_watchdog_subtask - periodic checks not using event driven response
  * @pf: board private structure
  **/
@@ -6029,7 +5933,6 @@ static void i40e_watchdog_subtask(struct i40e_pf *pf)
 		return;
 	pf->service_timer_previous = jiffies;
 
-	i40e_check_hang_subtask(pf);
 	if (pf->flags & I40E_FLAG_LINK_POLLING_ENABLED)
 		i40e_link_event(pf);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index f75db56..a30e3a1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -636,50 +636,6 @@ static u32 i40e_get_tx_pending(struct i40e_ring *ring)
 	return 0;
 }
 
-/**
- * i40e_check_tx_hang - Is there a hang in the Tx queue
- * @tx_ring: the ring of descriptors
- **/
-static bool i40e_check_tx_hang(struct i40e_ring *tx_ring)
-{
-	u32 tx_done = tx_ring->stats.packets;
-	u32 tx_done_old = tx_ring->tx_stats.tx_done_old;
-	u32 tx_pending = i40e_get_tx_pending(tx_ring);
-	struct i40e_pf *pf = tx_ring->vsi->back;
-	bool ret = false;
-
-	clear_check_for_tx_hang(tx_ring);
-
-	/* Check for a hung queue, but be thorough. This verifies
-	 * that a transmit has been completed since the previous
-	 * check AND there is at least one packet pending. The
-	 * ARMED bit is set to indicate a potential hang. The
-	 * bit is cleared if a pause frame is received to remove
-	 * false hang detection due to PFC or 802.3x frames. By
-	 * requiring this to fail twice we avoid races with
-	 * PFC clearing the ARMED bit and conditions where we
-	 * run the check_tx_hang logic with a transmit completion
-	 * pending but without time to complete it yet.
-	 */
-	if ((tx_done_old == tx_done) && tx_pending) {
-		/* make sure it is true for two checks in a row */
-		ret = test_and_set_bit(__I40E_HANG_CHECK_ARMED,
-				       &tx_ring->state);
-	} else if (tx_done_old == tx_done &&
-		   (tx_pending < I40E_MIN_DESC_PENDING) && (tx_pending > 0)) {
-		if (I40E_DEBUG_FLOW & pf->hw.debug_mask)
-			dev_info(tx_ring->dev, "HW needs some more descs to do a cacheline flush. tx_pending %d, queue %d",
-				 tx_pending, tx_ring->queue_index);
-		pf->tx_sluggish_count++;
-	} else {
-		/* update completed stats and disarm the hang check */
-		tx_ring->tx_stats.tx_done_old = tx_done;
-		clear_bit(__I40E_HANG_CHECK_ARMED, &tx_ring->state);
-	}
-
-	return ret;
-}
-
 #define WB_STRIDE 0x3
 
 /**
@@ -801,32 +757,6 @@ static bool i40e_clean_tx_irq(struct i40e_ring *tx_ring, int budget)
 			tx_ring->arm_wb = true;
 	}
 
-	if (check_for_tx_hang(tx_ring) && i40e_check_tx_hang(tx_ring)) {
-		/* schedule immediate reset if we believe we hung */
-		dev_info(tx_ring->dev, "Detected Tx Unit Hang\n"
-			 "  VSI                  <%d>\n"
-			 "  Tx Queue             <%d>\n"
-			 "  next_to_use          <%x>\n"
-			 "  next_to_clean        <%x>\n",
-			 tx_ring->vsi->seid,
-			 tx_ring->queue_index,
-			 tx_ring->next_to_use, i);
-
-		netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
-
-		dev_info(tx_ring->dev,
-			 "tx hang detected on queue %d, reset requested\n",
-			 tx_ring->queue_index);
-
-		/* do not fire the reset immediately, wait for the stack to
-		 * decide we are truly stuck, also prevents every queue from
-		 * simultaneously requesting a reset
-		 */
-
-		/* the adapter is about to reset, no point in enabling polling */
-		budget = 1;
-	}
-
 	netdev_tx_completed_queue(netdev_get_tx_queue(tx_ring->netdev,
 						      tx_ring->queue_index),
 				  total_packets, total_bytes);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 4871809..809e170 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -201,8 +201,6 @@ struct i40e_rx_queue_stats {
 enum i40e_ring_state_t {
 	__I40E_TX_FDIR_INIT_DONE,
 	__I40E_TX_XPS_INIT_DONE,
-	__I40E_TX_DETECT_HANG,
-	__I40E_HANG_CHECK_ARMED,
 	__I40E_RX_PS_ENABLED,
 	__I40E_RX_16BYTE_DESC_ENABLED,
 };
@@ -213,12 +211,6 @@ enum i40e_ring_state_t {
 	set_bit(__I40E_RX_PS_ENABLED, &(ring)->state)
 #define clear_ring_ps_enabled(ring) \
 	clear_bit(__I40E_RX_PS_ENABLED, &(ring)->state)
-#define check_for_tx_hang(ring) \
-	test_bit(__I40E_TX_DETECT_HANG, &(ring)->state)
-#define set_check_for_tx_hang(ring) \
-	set_bit(__I40E_TX_DETECT_HANG, &(ring)->state)
-#define clear_check_for_tx_hang(ring) \
-	clear_bit(__I40E_TX_DETECT_HANG, &(ring)->state)
 #define ring_is_16byte_desc_enabled(ring) \
 	test_bit(__I40E_RX_16BYTE_DESC_ENABLED, &(ring)->state)
 #define set_ring_16byte_desc_enabled(ring) \
-- 
1.8.1.4

