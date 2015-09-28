From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:16:51 -0400
Subject: [Intel-wired-lan] [next PATCH S17 02/11] i40e/i40evf: refactor irq
	enable function
In-Reply-To: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443464220-148318-3-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

This change moves a multi-line register setting into a function
which simplifies reading the flow of the enable function.

This also fixes a bug where the enable function was enabling
the interrupt twice while trying to update the two interrupt
throttle rate thresholds for rx and tx.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: Ie308f9d0d48540204590cb9d7a5a7b1196f959bb
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 112 +++++++++++++++-----------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 108 ++++++++++++++-----------
 2 files changed, 128 insertions(+), 92 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 8d83af0..c023b12 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -814,6 +814,8 @@ void i40e_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector)
  * i40e_set_new_dynamic_itr - Find new ITR level
  * @rc: structure containing ring performance data
  *
+ * Returns true if itr changed, false if not
+ *
  * Stores a new ITR value based on packets and byte counts during
  * the last interrupt.  The advantage of per interrupt computation
  * is faster updates and more accurate ITR for the current traffic
@@ -822,14 +824,14 @@ void i40e_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector)
  * testing data as well as attempting to minimize response time
  * while increasing bulk throughput.
  **/
-static void i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
+static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 {
 	enum i40e_latency_range new_latency_range = rc->latency_range;
 	u32 new_itr = rc->itr;
 	int bytes_per_int;
 
 	if (rc->total_packets == 0 || !rc->itr)
-		return;
+		return false;
 
 	/* simple throttlerate management
 	 *   0-10MB/s   lowest (100000 ints/s)
@@ -873,11 +875,15 @@ static void i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 		break;
 	}
 
-	if (new_itr != rc->itr)
-		rc->itr = new_itr;
-
 	rc->total_bytes = 0;
 	rc->total_packets = 0;
+
+	if (new_itr != rc->itr) {
+		rc->itr = new_itr;
+		return true;
+	}
+
+	return false;
 }
 
 /**
@@ -1746,6 +1752,21 @@ static int i40e_clean_rx_irq_1buf(struct i40e_ring *rx_ring, int budget)
 	return total_rx_packets;
 }
 
+static u32 i40e_buildreg_itr(const int type, const u16 itr)
+{
+	u32 val;
+
+	val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
+	      I40E_PFINT_DYN_CTLN_CLEARPBA_MASK |
+	      (type << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT) |
+	      (itr << I40E_PFINT_DYN_CTLN_INTERVAL_SHIFT);
+
+	return val;
+}
+
+/* a small macro to shorten up some long lines */
+#define INTREG I40E_PFINT_DYN_CTLN
+
 /**
  * i40e_update_enable_itr - Update itr and re-enable MSIX interrupt
  * @vsi: the VSI we care about
@@ -1756,54 +1777,53 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 					  struct i40e_q_vector *q_vector)
 {
 	struct i40e_hw *hw = &vsi->back->hw;
-	u16 old_itr;
+	bool rx = false, tx = false;
+	u32 rxval, txval;
 	int vector;
-	u32 val;
 
 	vector = (q_vector->v_idx + vsi->base_vector);
+
+	rxval = txval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
+
 	if (ITR_IS_DYNAMIC(vsi->rx_itr_setting)) {
-		old_itr = q_vector->rx.itr;
-		i40e_set_new_dynamic_itr(&q_vector->rx);
-		if (old_itr != q_vector->rx.itr) {
-			val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
-			I40E_PFINT_DYN_CTLN_CLEARPBA_MASK |
-			(I40E_RX_ITR <<
-				I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT) |
-			(q_vector->rx.itr <<
-				I40E_PFINT_DYN_CTLN_INTERVAL_SHIFT);
-		} else {
-			val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
-			I40E_PFINT_DYN_CTLN_CLEARPBA_MASK |
-			(I40E_ITR_NONE <<
-				I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT);
-		}
-		if (!test_bit(__I40E_DOWN, &vsi->state))
-			wr32(hw, I40E_PFINT_DYN_CTLN(vector - 1), val);
-	} else {
-		i40e_irq_dynamic_enable(vsi, q_vector->v_idx);
+		rx = i40e_set_new_dynamic_itr(&q_vector->rx);
+		rxval = i40e_buildreg_itr(I40E_RX_ITR, q_vector->rx.itr);
 	}
+
 	if (ITR_IS_DYNAMIC(vsi->tx_itr_setting)) {
-		old_itr = q_vector->tx.itr;
-		i40e_set_new_dynamic_itr(&q_vector->tx);
-		if (old_itr != q_vector->tx.itr) {
-			val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
-				I40E_PFINT_DYN_CTLN_CLEARPBA_MASK |
-				(I40E_TX_ITR <<
-				   I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT) |
-				(q_vector->tx.itr <<
-				   I40E_PFINT_DYN_CTLN_INTERVAL_SHIFT);
-		} else {
-			val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
-				I40E_PFINT_DYN_CTLN_CLEARPBA_MASK |
-				(I40E_ITR_NONE <<
-				   I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT);
-		}
-		if (!test_bit(__I40E_DOWN, &vsi->state))
-			wr32(hw, I40E_PFINT_DYN_CTLN(q_vector->v_idx +
-			      vsi->base_vector - 1), val);
-	} else {
-		i40e_irq_dynamic_enable(vsi, q_vector->v_idx);
+		tx = i40e_set_new_dynamic_itr(&q_vector->tx);
+		txval = i40e_buildreg_itr(I40E_TX_ITR, q_vector->tx.itr);
 	}
+
+	if (rx || tx) {
+		/* get the higher of the two ITR adjustments and
+		 * use the same value for both ITR registers
+		 * when in adaptive mode (rx and/or tx)
+		 */
+		u16 itr = max(q_vector->tx.itr, q_vector->rx.itr);
+
+		q_vector->tx.itr = q_vector->rx.itr = itr;
+		txval = i40e_buildreg_itr(I40E_TX_ITR, itr);
+		tx = true;
+		rxval = i40e_buildreg_itr(I40E_RX_ITR, itr);
+		rx = true;
+	}
+
+	/* only need to enable the interrupt once, but need
+	 * to possibly update both ITR values
+	 */
+	if (rx) {
+		/* set the INTENA_MSK_MASK so that this first write
+		 * won't actually enable the interrupt, instead just
+		 * updating the ITR (it's bit 31 PF and VF)
+		 */
+		rxval |= BIT(31);
+		/* don't check _DOWN because interrupt isn't being enabled */
+		wr32(hw, INTREG(vector - 1), rxval);
+	}
+
+	if (!test_bit(__I40E_DOWN, &vsi->state))
+		wr32(hw, INTREG(vector - 1), txval);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 97493a4..3d2646b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -318,6 +318,8 @@ static void i40evf_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector
  * i40e_set_new_dynamic_itr - Find new ITR level
  * @rc: structure containing ring performance data
  *
+ * Returns true if itr changed, false if not
+ *
  * Stores a new ITR value based on packets and byte counts during
  * the last interrupt.  The advantage of per interrupt computation
  * is faster updates and more accurate ITR for the current traffic
@@ -326,14 +328,14 @@ static void i40evf_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector
  * testing data as well as attempting to minimize response time
  * while increasing bulk throughput.
  **/
-static void i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
+static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 {
 	enum i40e_latency_range new_latency_range = rc->latency_range;
 	u32 new_itr = rc->itr;
 	int bytes_per_int;
 
 	if (rc->total_packets == 0 || !rc->itr)
-		return;
+		return false;
 
 	/* simple throttlerate management
 	 *   0-10MB/s   lowest (100000 ints/s)
@@ -377,11 +379,15 @@ static void i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 		break;
 	}
 
-	if (new_itr != rc->itr)
-		rc->itr = new_itr;
-
 	rc->total_bytes = 0;
 	rc->total_packets = 0;
+
+	if (new_itr != rc->itr) {
+		rc->itr = new_itr;
+		return true;
+	}
+
+	return false;
 }
 
 /*
@@ -1187,6 +1193,21 @@ static int i40e_clean_rx_irq_1buf(struct i40e_ring *rx_ring, int budget)
 	return total_rx_packets;
 }
 
+static u32 i40e_buildreg_itr(const int type, const u16 itr)
+{
+	u32 val;
+
+	val = I40E_VFINT_DYN_CTLN1_INTENA_MASK |
+	      I40E_VFINT_DYN_CTLN1_CLEARPBA_MASK |
+	      (type << I40E_VFINT_DYN_CTLN1_ITR_INDX_SHIFT) |
+	      (itr << I40E_VFINT_DYN_CTLN1_INTERVAL_SHIFT);
+
+	return val;
+}
+
+/* a small macro to shorten up some long lines */
+#define INTREG I40E_VFINT_DYN_CTLN1
+
 /**
  * i40e_update_enable_itr - Update itr and re-enable MSIX interrupt
  * @vsi: the VSI we care about
@@ -1197,55 +1218,50 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 					  struct i40e_q_vector *q_vector)
 {
 	struct i40e_hw *hw = &vsi->back->hw;
-	u16 old_itr;
+	bool rx = false, tx = false;
+	u32 rxval, txval;
 	int vector;
-	u32 val;
 
 	vector = (q_vector->v_idx + vsi->base_vector);
+	rxval = txval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
+
 	if (ITR_IS_DYNAMIC(vsi->rx_itr_setting)) {
-		old_itr = q_vector->rx.itr;
-		i40e_set_new_dynamic_itr(&q_vector->rx);
-		if (old_itr != q_vector->rx.itr) {
-			val = I40E_VFINT_DYN_CTLN1_INTENA_MASK |
-			I40E_VFINT_DYN_CTLN1_CLEARPBA_MASK |
-			(I40E_RX_ITR <<
-				I40E_VFINT_DYN_CTLN1_ITR_INDX_SHIFT) |
-			(q_vector->rx.itr <<
-				I40E_VFINT_DYN_CTLN1_INTERVAL_SHIFT);
-		} else {
-			val = I40E_VFINT_DYN_CTLN1_INTENA_MASK |
-			I40E_VFINT_DYN_CTLN1_CLEARPBA_MASK |
-			(I40E_ITR_NONE <<
-				I40E_VFINT_DYN_CTLN1_ITR_INDX_SHIFT);
-		}
-		if (!test_bit(__I40E_DOWN, &vsi->state))
-			wr32(hw, I40E_VFINT_DYN_CTLN1(vector - 1), val);
-	} else {
-		i40evf_irq_enable_queues(vsi->back, 1
-			<< q_vector->v_idx);
+		rx = i40e_set_new_dynamic_itr(&q_vector->rx);
+		rxval = i40e_buildreg_itr(I40E_RX_ITR, q_vector->rx.itr);
 	}
 	if (ITR_IS_DYNAMIC(vsi->tx_itr_setting)) {
-		old_itr = q_vector->tx.itr;
-		i40e_set_new_dynamic_itr(&q_vector->tx);
-		if (old_itr != q_vector->tx.itr) {
-			val = I40E_VFINT_DYN_CTLN1_INTENA_MASK |
-				I40E_VFINT_DYN_CTLN1_CLEARPBA_MASK |
-				(I40E_TX_ITR <<
-				   I40E_VFINT_DYN_CTLN1_ITR_INDX_SHIFT) |
-				(q_vector->tx.itr <<
-				   I40E_VFINT_DYN_CTLN1_INTERVAL_SHIFT);
+		tx = i40e_set_new_dynamic_itr(&q_vector->tx);
+		txval = i40e_buildreg_itr(I40E_TX_ITR, q_vector->tx.itr);
+	}
+	if (rx || tx) {
+		/* get the higher of the two ITR adjustments and
+		 * use the same value for both ITR registers
+		 * when in adaptive mode (rx and/or tx)
+		 */
+		u16 itr = max(q_vector->tx.itr, q_vector->rx.itr);
 
-		} else {
-			val = I40E_VFINT_DYN_CTLN1_INTENA_MASK |
-				I40E_VFINT_DYN_CTLN1_CLEARPBA_MASK |
-				(I40E_ITR_NONE <<
-				   I40E_VFINT_DYN_CTLN1_ITR_INDX_SHIFT);
-		}
-		if (!test_bit(__I40E_DOWN, &vsi->state))
-			wr32(hw, I40E_VFINT_DYN_CTLN1(vector - 1), val);
-	} else {
-		i40evf_irq_enable_queues(vsi->back, BIT(q_vector->v_idx));
+		q_vector->tx.itr = q_vector->rx.itr = itr;
+		txval = i40e_buildreg_itr(I40E_TX_ITR, itr);
+		tx = true;
+		rxval = i40e_buildreg_itr(I40E_RX_ITR, itr);
+		rx = true;
 	}
+
+	/* only need to enable the interrupt once, but need
+	 * to possibly update both ITR values
+	 */
+	if (rx) {
+		/* set the INTENA_MSK_MASK so that this first write
+		 * won't actually enable the interrupt, instead just
+		 * updating the ITR (it's bit 31 PF and VF)
+		 */
+		rxval |= BIT(31);
+		/* don't check _DOWN because interrupt isn't being enabled */
+		wr32(hw, INTREG(vector - 1), rxval);
+	}
+
+	if (!test_bit(__I40E_DOWN, &vsi->state))
+		wr32(hw, INTREG(vector - 1), txval);
 }
 
 /**
-- 
1.9.3

