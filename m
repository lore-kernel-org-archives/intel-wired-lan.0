From: Alice Michael <alice.michael@intel.com>
Date: Wed,  5 Apr 2017 07:50:56 -0400
Subject: [Intel-wired-lan] [next S66 v2 04/11] i40e: Simplify
	i40e_detect_recover_hung_queue logic
In-Reply-To: <20170405115103.67374-1-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
Message-ID: <20170405115103.67374-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

This patch greatly reduces the unneeded complexity in the
i40e_detect_recover_hung_queue code path.  The previous implementation
set a 'hung bit' which would then get cleared while polling.  If the
detection routine was called a second time with the bit already set, we
would issue a software interrupt.  This patch makes it such that if
interrupts are disabled and we have pending TX descriptors, we trigger a
software interrupt since in, the worst case, queues are already clean
and we have an extra interrupt.

Additionally this patch removes the workaround for lost interrupts as
calling napi_reschedule in this context can cause software interrupts to
fire on the wrong CPU.

Signed-off-by: Alan Brady <alan.brady@intel.com>
Change-ID: Iae108582a3ceb6229ed1d22e4ed6e69cf97aad8d
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  4 --
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 59 +++++---------------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 12 ++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    |  3 +-
 5 files changed, 15 insertions(+), 64 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 2c12900..e987503 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -613,7 +613,6 @@ struct i40e_vsi {
 	u32 tx_busy;
 	u64 tx_linearize;
 	u64 tx_force_wb;
-	u64 tx_lost_interrupt;
 	u32 rx_buf_failed;
 	u32 rx_page_failed;
 
@@ -699,9 +698,6 @@ struct i40e_q_vector {
 
 	u8 num_ringpairs;	/* total number of ring pairs in vector */
 
-#define I40E_Q_VECTOR_HUNG_DETECT 0 /* Bit Index for hung detection logic */
-	unsigned long hung_detected; /* Set/Reset for hung_detection logic */
-
 	cpumask_t affinity_mask;
 	struct irq_affinity_notify affinity_notify;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 68c0f20..10325b5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -89,7 +89,6 @@ static const struct i40e_stats i40e_gstrings_misc_stats[] = {
 	I40E_VSI_STAT("rx_unknown_protocol", eth_stats.rx_unknown_protocol),
 	I40E_VSI_STAT("tx_linearize", tx_linearize),
 	I40E_VSI_STAT("tx_force_wb", tx_force_wb),
-	I40E_VSI_STAT("tx_lost_interrupt", tx_lost_interrupt),
 	I40E_VSI_STAT("rx_alloc_fail", rx_buf_failed),
 	I40E_VSI_STAT("rx_pg_alloc_fail", rx_page_failed),
 };
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 33725a5..fcfab36 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -737,7 +737,6 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	struct i40e_eth_stats *oes;
 	struct i40e_eth_stats *es;     /* device's eth stats */
 	u32 tx_restart, tx_busy;
-	u64 tx_lost_interrupt;
 	struct i40e_ring *p;
 	u32 rx_page, rx_buf;
 	u64 bytes, packets;
@@ -763,7 +762,6 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	rx_b = rx_p = 0;
 	tx_b = tx_p = 0;
 	tx_restart = tx_busy = tx_linearize = tx_force_wb = 0;
-	tx_lost_interrupt = 0;
 	rx_page = 0;
 	rx_buf = 0;
 	rcu_read_lock();
@@ -782,7 +780,6 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 		tx_busy += p->tx_stats.tx_busy;
 		tx_linearize += p->tx_stats.tx_linearize;
 		tx_force_wb += p->tx_stats.tx_force_wb;
-		tx_lost_interrupt += p->tx_stats.tx_lost_interrupt;
 
 		/* Rx queue is part of the same block as Tx queue */
 		p = &p[1];
@@ -801,7 +798,6 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	vsi->tx_busy = tx_busy;
 	vsi->tx_linearize = tx_linearize;
 	vsi->tx_force_wb = tx_force_wb;
-	vsi->tx_lost_interrupt = tx_lost_interrupt;
 	vsi->rx_page_failed = rx_page;
 	vsi->rx_buf_failed = rx_buf;
 
@@ -4499,16 +4495,15 @@ static int i40e_pf_wait_queues_disabled(struct i40e_pf *pf)
  * @vsi: Pointer to VSI struct
  *
  * This function checks specified queue for given VSI. Detects hung condition.
- * Sets hung bit since it is two step process. Before next run of service task
- * if napi_poll runs, it reset 'hung' bit for respective q_vector. If not,
- * hung condition remain unchanged and during subsequent run, this function
- * issues SW interrupt to recover from hung condition.
+ * We proactively detect hung TX queues by checking if interrupts are disabled
+ * but there are pending descriptors.  If it appears hung, attempt to recover
+ * by triggering a SW interrupt.
  **/
 static void i40e_detect_recover_hung_queue(int q_idx, struct i40e_vsi *vsi)
 {
 	struct i40e_ring *tx_ring = NULL;
 	struct i40e_pf	*pf;
-	u32 head, val, tx_pending_hw;
+	u32 val, tx_pending;
 	int i;
 
 	pf = vsi->back;
@@ -4534,47 +4529,15 @@ static void i40e_detect_recover_hung_queue(int q_idx, struct i40e_vsi *vsi)
 	else
 		val = rd32(&pf->hw, I40E_PFINT_DYN_CTL0);
 
-	head = i40e_get_head(tx_ring);
+	tx_pending = i40e_get_tx_pending(tx_ring);
 
-	tx_pending_hw = i40e_get_tx_pending(tx_ring, false);
-
-	/* HW is done executing descriptors, updated HEAD write back,
-	 * but SW hasn't processed those descriptors. If interrupt is
-	 * not generated from this point ON, it could result into
-	 * dev_watchdog detecting timeout on those netdev_queue,
-	 * hence proactively trigger SW interrupt.
+	/* Interrupts are disabled and TX pending is non-zero,
+	 * trigger the SW interrupt (don't wait). Worst case
+	 * there will be one extra interrupt which may result
+	 * into not cleaning any queues because queues are cleaned.
 	 */
-	if (tx_pending_hw && (!(val & I40E_PFINT_DYN_CTLN_INTENA_MASK))) {
-		/* NAPI Poll didn't run and clear since it was set */
-		if (test_and_clear_bit(I40E_Q_VECTOR_HUNG_DETECT,
-				       &tx_ring->q_vector->hung_detected)) {
-			netdev_info(vsi->netdev, "VSI_seid %d, Hung TX queue %d, tx_pending_hw: %d, NTC:0x%x, HWB: 0x%x, NTU: 0x%x, TAIL: 0x%x\n",
-				    vsi->seid, q_idx, tx_pending_hw,
-				    tx_ring->next_to_clean, head,
-				    tx_ring->next_to_use,
-				    readl(tx_ring->tail));
-			netdev_info(vsi->netdev, "VSI_seid %d, Issuing force_wb for TX queue %d, Interrupt Reg: 0x%x\n",
-				    vsi->seid, q_idx, val);
-			i40e_force_wb(vsi, tx_ring->q_vector);
-		} else {
-			/* First Chance - detected possible hung */
-			set_bit(I40E_Q_VECTOR_HUNG_DETECT,
-				&tx_ring->q_vector->hung_detected);
-		}
-	}
-
-	/* This is the case where we have interrupts missing,
-	 * so the tx_pending in HW will most likely be 0, but we
-	 * will have tx_pending in SW since the WB happened but the
-	 * interrupt got lost.
-	 */
-	if ((!tx_pending_hw) && i40e_get_tx_pending(tx_ring, true) &&
-	    (!(val & I40E_PFINT_DYN_CTLN_INTENA_MASK))) {
-		local_bh_disable();
-		if (napi_reschedule(&tx_ring->q_vector->napi))
-			tx_ring->tx_stats.tx_lost_interrupt++;
-		local_bh_enable();
-	}
+	if (tx_pending && (!(val & I40E_PFINT_DYN_CTLN_INTENA_MASK)))
+		i40e_force_wb(vsi, tx_ring->q_vector);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 9b92d00..b4a7bfc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -711,19 +711,15 @@ void i40e_free_tx_resources(struct i40e_ring *tx_ring)
 /**
  * i40e_get_tx_pending - how many tx descriptors not processed
  * @tx_ring: the ring of descriptors
- * @in_sw: is tx_pending being checked in SW or HW
  *
  * Since there is no access to the ring head register
  * in XL710, we need to use our local copies
  **/
-u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw)
+u32 i40e_get_tx_pending(struct i40e_ring *ring)
 {
 	u32 head, tail;
 
-	if (!in_sw)
-		head = i40e_get_head(ring);
-	else
-		head = ring->next_to_clean;
+	head = i40e_get_head(ring);
 	tail = readl(ring->tail);
 
 	if (head != tail)
@@ -846,7 +842,7 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 		 * them to be written back in case we stay in NAPI.
 		 * In this mode on X722 we do not enable Interrupt.
 		 */
-		unsigned int j = i40e_get_tx_pending(tx_ring, false);
+		unsigned int j = i40e_get_tx_pending(tx_ring);
 
 		if (budget &&
 		    ((j / WB_STRIDE) == 0) && (j > 0) &&
@@ -2185,8 +2181,6 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 		return 0;
 	}
 
-	/* Clear hung_detected bit */
-	clear_bit(I40E_Q_VECTOR_HUNG_DETECT, &q_vector->hung_detected);
 	/* Since the actual Tx work is minimal, we can give the Tx a larger
 	 * budget and be more aggressive about cleaning up the Tx descriptors.
 	 */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 2e876ad..f5de511 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -328,7 +328,6 @@ struct i40e_tx_queue_stats {
 	u64 tx_done_old;
 	u64 tx_linearize;
 	u64 tx_force_wb;
-	u64 tx_lost_interrupt;
 };
 
 struct i40e_rx_queue_stats {
@@ -480,7 +479,7 @@ void i40e_free_tx_resources(struct i40e_ring *tx_ring);
 void i40e_free_rx_resources(struct i40e_ring *rx_ring);
 int i40e_napi_poll(struct napi_struct *napi, int budget);
 void i40e_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector);
-u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw);
+u32 i40e_get_tx_pending(struct i40e_ring *ring);
 int __i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size);
 bool __i40e_chk_linearize(struct sk_buff *skb);
 
-- 
2.9.3

