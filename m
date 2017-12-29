From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Dec 2017 08:51:25 -0500
Subject: [Intel-wired-lan] [next PATCH S85-V1 13/14] i40e/i40evf: Split
 container ITR into current_itr and target_itr
Message-ID: <20171229135125.14740-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch is mostly prep-work for replacing the current approach to
programming the dynamic aka adaptive ITR. Specifically here what we are
doing is splitting the Tx and Rx ITR each into two separate values.

The first value current_itr represents the current value of the register.

The second value target_itr represents the desired value of the register.

The general plan by doing this is to allow for deferring the update of the
ITR value under certain circumstances. For now we will work with what we
have, but in the future I hope to change the behavior so that we always
only update one ITR at a time using some simple logic to determine which
ITR requires an update.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 13 +++--
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 22 ++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 68 +++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  5 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 68 +++++++++++++---------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  5 +-
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 14 ++---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 10 ++--
 8 files changed, 117 insertions(+), 88 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 0212f6c..bfaeb77 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2329,14 +2329,15 @@ static void i40e_set_itr_per_queue(struct i40e_vsi *vsi,
 		tx_ring->itr_setting &= ~I40E_ITR_DYNAMIC;
 
 	q_vector = rx_ring->q_vector;
-	q_vector->rx.itr = ITR_TO_REG(rx_ring->itr_setting);
-	wr32(hw, I40E_PFINT_ITRN(I40E_RX_ITR, q_vector->reg_idx),
-	     q_vector->rx.itr);
+	q_vector->rx.target_itr = ITR_TO_REG(rx_ring->itr_setting);
 
 	q_vector = tx_ring->q_vector;
-	q_vector->tx.itr = ITR_TO_REG(tx_ring->itr_setting);
-	wr32(hw, I40E_PFINT_ITRN(I40E_TX_ITR, q_vector->reg_idx),
-	     q_vector->tx.itr);
+	q_vector->tx.target_itr = ITR_TO_REG(tx_ring->itr_setting);
+
+	/* The interrupt handler itself will take care of programming
+	 * the Tx and Rx ITR values based on the values we have entered
+	 * into the q_vector, no need to write the values now.
+	 */
 
 	wr32(hw, I40E_PFINT_RATEN(q_vector->reg_idx), intrl);
 	i40e_flush(hw);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c810e9d..6380d03 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3434,14 +3434,18 @@ static void i40e_vsi_configure_msix(struct i40e_vsi *vsi)
 		struct i40e_q_vector *q_vector = vsi->q_vectors[i];
 
 		q_vector->itr_countdown = ITR_COUNTDOWN_START;
-		q_vector->rx.itr = ITR_TO_REG(vsi->rx_rings[i]->itr_setting);
+		q_vector->rx.target_itr =
+			ITR_TO_REG(vsi->rx_rings[i]->itr_setting);
 		q_vector->rx.latency_range = I40E_LOW_LATENCY;
 		wr32(hw, I40E_PFINT_ITRN(I40E_RX_ITR, vector - 1),
-		     q_vector->rx.itr);
-		q_vector->tx.itr = ITR_TO_REG(vsi->tx_rings[i]->itr_setting);
+		     q_vector->rx.target_itr);
+		q_vector->rx.current_itr = q_vector->rx.target_itr;
+		q_vector->tx.target_itr =
+			ITR_TO_REG(vsi->tx_rings[i]->itr_setting);
 		q_vector->tx.latency_range = I40E_LOW_LATENCY;
 		wr32(hw, I40E_PFINT_ITRN(I40E_TX_ITR, vector - 1),
-		     q_vector->tx.itr);
+		     q_vector->tx.target_itr);
+		q_vector->tx.current_itr = q_vector->tx.target_itr;
 		wr32(hw, I40E_PFINT_RATEN(vector - 1),
 		     i40e_intrl_usec_to_reg(vsi->int_rate_limit));
 
@@ -3543,12 +3547,14 @@ static void i40e_configure_msi_and_legacy(struct i40e_vsi *vsi)
 
 	/* set the ITR configuration */
 	q_vector->itr_countdown = ITR_COUNTDOWN_START;
-	q_vector->rx.itr = ITR_TO_REG(vsi->rx_rings[0]->itr_setting);
+	q_vector->rx.target_itr = ITR_TO_REG(vsi->rx_rings[0]->itr_setting);
 	q_vector->rx.latency_range = I40E_LOW_LATENCY;
-	wr32(hw, I40E_PFINT_ITR0(I40E_RX_ITR), q_vector->rx.itr);
-	q_vector->tx.itr = ITR_TO_REG(vsi->tx_rings[0]->itr_setting);
+	wr32(hw, I40E_PFINT_ITR0(I40E_RX_ITR), q_vector->rx.target_itr);
+	q_vector->rx.current_itr = q_vector->rx.target_itr;
+	q_vector->tx.target_itr = ITR_TO_REG(vsi->tx_rings[0]->itr_setting);
 	q_vector->tx.latency_range = I40E_LOW_LATENCY;
-	wr32(hw, I40E_PFINT_ITR0(I40E_TX_ITR), q_vector->tx.itr);
+	wr32(hw, I40E_PFINT_ITR0(I40E_TX_ITR), q_vector->tx.target_itr);
+	q_vector->tx.current_itr = q_vector->tx.target_itr;
 
 	i40e_enable_misc_int_causes(pf);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 170256e..d810e0e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1011,17 +1011,16 @@ void i40e_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector)
 static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 {
 	enum i40e_latency_range new_latency_range = rc->latency_range;
-	u32 new_itr = rc->itr;
 	int bytes_per_usec;
 	unsigned int usecs, estimated_usecs;
 
 	if (!rc->ring || !ITR_IS_DYNAMIC(rc->ring->itr_setting))
 		return false;
 
-	if (rc->total_packets == 0 || !rc->itr)
+	if (!rc->total_packets || !rc->current_itr)
 		return false;
 
-	usecs = (rc->itr << 1) * ITR_COUNTDOWN_START;
+	usecs = (rc->current_itr << 1) * ITR_COUNTDOWN_START;
 	bytes_per_usec = rc->total_bytes / usecs;
 
 	/* The calculations in this algorithm depend on interrupts actually
@@ -1069,13 +1068,13 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 
 	switch (new_latency_range) {
 	case I40E_LOWEST_LATENCY:
-		new_itr = I40E_ITR_50K;
+		rc->target_itr = I40E_ITR_50K;
 		break;
 	case I40E_LOW_LATENCY:
-		new_itr = I40E_ITR_20K;
+		rc->target_itr = I40E_ITR_20K;
 		break;
 	case I40E_BULK_LATENCY:
-		new_itr = I40E_ITR_18K;
+		rc->target_itr = I40E_ITR_18K;
 		break;
 	default:
 		break;
@@ -1085,11 +1084,7 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 	rc->total_packets = 0;
 	rc->last_itr_update = jiffies;
 
-	if (new_itr != rc->itr) {
-		rc->itr = new_itr;
-		return true;
-	}
-	return false;
+	return rc->target_itr != rc->current_itr;
 }
 
 /**
@@ -2305,7 +2300,7 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 {
 	struct i40e_hw *hw = &vsi->back->hw;
 	bool rx = false, tx = false;
-	u32 txval;
+	u32 intval;
 
 	/* If we don't have MSIX, then we only need to re-enable icr0 */
 	if (!(vsi->back->flags & I40E_FLAG_MSIX_ENABLED)) {
@@ -2313,8 +2308,6 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 		return;
 	}
 
-	txval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
-
 	/* avoid dynamic calculation if in countdown mode */
 	if (q_vector->itr_countdown > 0)
 		goto enable_int;
@@ -2328,26 +2321,43 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 		 * use the same value for both ITR registers
 		 * when in adaptive mode (Rx and/or Tx)
 		 */
-		u16 itr = max(q_vector->tx.itr, q_vector->rx.itr);
-		u32 rxval;
-
-		q_vector->tx.itr = q_vector->rx.itr = itr;
-
-		/* set the INTENA_MSK_MASK so that this first write
-		 * won't actually enable the interrupt, instead just
-		 * updating the ITR (it's bit 31 PF and VF)
-		 */
-		rxval = i40e_buildreg_itr(I40E_RX_ITR, itr) | BIT(31);
+		u16 itr = max(q_vector->tx.target_itr,
+			      q_vector->rx.target_itr);
 
-		/* don't check _DOWN because interrupt isn't being enabled */
-		wr32(hw, INTREG(q_vector->reg_idx), rxval);
-
-		txval = i40e_buildreg_itr(I40E_TX_ITR, itr);
+		q_vector->tx.target_itr = itr;
+		q_vector->rx.target_itr = itr;
 	}
 
 enable_int:
+	if (q_vector->rx.target_itr != q_vector->rx.current_itr) {
+		intval = i40e_buildreg_itr(I40E_RX_ITR,
+					   q_vector->rx.target_itr);
+		q_vector->rx.current_itr = q_vector->rx.target_itr;
+
+		if (q_vector->tx.target_itr != q_vector->tx.current_itr) {
+			/* set the INTENA_MSK_MASK so that this first write
+			 * won't actually enable the interrupt, instead just
+			 * updating the ITR (it's bit 31 PF and VF)
+			 *
+			 * don't check _DOWN because interrupt isn't being
+			 * enabled
+			 */
+			wr32(hw, INTREG(q_vector->reg_idx),
+			     intval | BIT(31));
+			/* now that Rx is done process Tx update */
+			goto update_tx;
+		}
+	} else if (q_vector->tx.target_itr != q_vector->tx.current_itr) {
+update_tx:
+		intval = i40e_buildreg_itr(I40E_TX_ITR,
+					   q_vector->tx.target_itr);
+		q_vector->tx.current_itr = q_vector->tx.target_itr;
+	} else {
+		intval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
+	}
+
 	if (!test_bit(__I40E_VSI_DOWN, vsi->state))
-		wr32(hw, INTREG(q_vector->reg_idx), txval);
+		wr32(hw, INTREG(q_vector->reg_idx), intval);
 
 	if (q_vector->itr_countdown)
 		q_vector->itr_countdown--;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index d226c7c..59acc25 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -32,7 +32,7 @@
 
 /* The datasheet for the X710 and XL710 indicate that the maximum value for
  * the ITR is 8160usec which is then called out as 0xFF0 with a 2usec
- * resoltion. 8160 is 0x1FE0 when written out in hex. So instead of storing
+ * resolution. 8160 is 0x1FE0 when written out in hex. So instead of storing
  * the register value which is divided by 2 lets use the actual values and
  * avoid an excessive amount of translation.
  */
@@ -474,7 +474,8 @@ struct i40e_ring_container {
 	unsigned long last_itr_update;	/* jiffies of last ITR update */
 	u16 count;
 	enum i40e_latency_range latency_range;
-	u16 itr;
+	u16 target_itr;			/* target ITR setting for ring(s) */
+	u16 current_itr;		/* current ITR setting for ring(s) */
 };
 
 /* iterator for handling rings in ring container */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index c5f8e94..1f130e9 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -409,17 +409,16 @@ void i40evf_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector)
 static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 {
 	enum i40e_latency_range new_latency_range = rc->latency_range;
-	u32 new_itr = rc->itr;
 	int bytes_per_usec;
 	unsigned int usecs, estimated_usecs;
 
 	if (!rc->ring || !ITR_IS_DYNAMIC(rc->ring->itr_setting))
 		return false;
 
-	if (rc->total_packets == 0 || !rc->itr)
+	if (!rc->total_packets || !rc->current_itr)
 		return false;
 
-	usecs = (rc->itr << 1) * ITR_COUNTDOWN_START;
+	usecs = (rc->current_itr << 1) * ITR_COUNTDOWN_START;
 	bytes_per_usec = rc->total_bytes / usecs;
 
 	/* The calculations in this algorithm depend on interrupts actually
@@ -467,13 +466,13 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 
 	switch (new_latency_range) {
 	case I40E_LOWEST_LATENCY:
-		new_itr = I40E_ITR_50K;
+		rc->target_itr = I40E_ITR_50K;
 		break;
 	case I40E_LOW_LATENCY:
-		new_itr = I40E_ITR_20K;
+		rc->target_itr = I40E_ITR_20K;
 		break;
 	case I40E_BULK_LATENCY:
-		new_itr = I40E_ITR_18K;
+		rc->target_itr = I40E_ITR_18K;
 		break;
 	default:
 		break;
@@ -483,11 +482,7 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 	rc->total_packets = 0;
 	rc->last_itr_update = jiffies;
 
-	if (new_itr != rc->itr) {
-		rc->itr = new_itr;
-		return true;
-	}
-	return false;
+	return rc->target_itr != rc->current_itr;
 }
 
 /**
@@ -1502,9 +1497,7 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 {
 	struct i40e_hw *hw = &vsi->back->hw;
 	bool rx = false, tx = false;
-	u32 txval;
-
-	txval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
+	u32 intval;
 
 	/* avoid dynamic calculation if in countdown mode */
 	if (q_vector->itr_countdown > 0)
@@ -1519,26 +1512,43 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 		 * use the same value for both ITR registers
 		 * when in adaptive mode (Rx and/or Tx)
 		 */
-		u16 itr = max(q_vector->tx.itr, q_vector->rx.itr);
-		u32 rxval;
-
-		q_vector->tx.itr = q_vector->rx.itr = itr;
-
-		/* set the INTENA_MSK_MASK so that this first write
-		 * won't actually enable the interrupt, instead just
-		 * updating the ITR (it's bit 31 PF and VF)
-		 */
-		rxval = i40e_buildreg_itr(I40E_RX_ITR, itr) | BIT(31);
+		u16 itr = max(q_vector->tx.target_itr,
+			      q_vector->rx.target_itr);
 
-		/* don't check _DOWN because interrupt isn't being enabled */
-		wr32(hw, INTREG(q_vector->reg_idx), rxval);
-
-		txval = i40e_buildreg_itr(I40E_TX_ITR, itr);
+		q_vector->tx.target_itr = itr;
+		q_vector->rx.target_itr = itr;
 	}
 
 enable_int:
+	if (q_vector->rx.target_itr != q_vector->rx.current_itr) {
+		intval = i40e_buildreg_itr(I40E_RX_ITR,
+					   q_vector->rx.target_itr);
+		q_vector->rx.current_itr = q_vector->rx.target_itr;
+
+		if (q_vector->tx.target_itr != q_vector->tx.current_itr) {
+			/* set the INTENA_MSK_MASK so that this first write
+			 * won't actually enable the interrupt, instead just
+			 * updating the ITR (it's bit 31 PF and VF)
+			 *
+			 * don't check _DOWN because interrupt isn't being
+			 * enabled
+			 */
+			wr32(hw, INTREG(q_vector->reg_idx),
+			     intval | BIT(31));
+			/* now that Rx is done process Tx update */
+			goto update_tx;
+		}
+	} else if (q_vector->tx.target_itr != q_vector->tx.current_itr) {
+update_tx:
+		intval = i40e_buildreg_itr(I40E_TX_ITR,
+					   q_vector->tx.target_itr);
+		q_vector->tx.current_itr = q_vector->tx.target_itr;
+	} else {
+		intval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
+	}
+
 	if (!test_bit(__I40E_VSI_DOWN, vsi->state))
-		wr32(hw, INTREG(q_vector->reg_idx), txval);
+		wr32(hw, INTREG(q_vector->reg_idx), intval);
 
 	if (q_vector->itr_countdown)
 		q_vector->itr_countdown--;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index f1c5ef7..5a6012b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -32,7 +32,7 @@
 
 /* The datasheet for the X710 and XL710 indicate that the maximum value for
  * the ITR is 8160usec which is then called out as 0xFF0 with a 2usec
- * resoltion. 8160 is 0x1FE0 when written out in hex. So instead of storing
+ * resolution. 8160 is 0x1FE0 when written out in hex. So instead of storing
  * the register value which is divided by 2 lets use the actual values and
  * avoid an excessive amount of translation.
  */
@@ -442,7 +442,8 @@ struct i40e_ring_container {
 	unsigned long last_itr_update;	/* jiffies of last ITR update */
 	u16 count;
 	enum i40e_latency_range latency_range;
-	u16 itr;
+	u16 target_itr;			/* target ITR setting for ring(s) */
+	u16 current_itr;		/* current ITR setting for ring(s) */
 };
 
 /* iterator for handling rings in ring container */
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
index f5d3725..aded3ad 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
@@ -514,7 +514,6 @@ static void i40evf_set_itr_per_queue(struct i40evf_adapter *adapter,
 {
 	struct i40e_ring *rx_ring = &adapter->rx_rings[queue];
 	struct i40e_ring *tx_ring = &adapter->tx_rings[queue];
-	struct i40e_hw *hw = &adapter->hw;
 	struct i40e_q_vector *q_vector;
 
 	rx_ring->itr_setting = ITR_REG_ALIGN(ec->rx_coalesce_usecs);
@@ -529,16 +528,15 @@ static void i40evf_set_itr_per_queue(struct i40evf_adapter *adapter,
 		tx_ring->itr_setting ^= I40E_ITR_DYNAMIC;
 
 	q_vector = rx_ring->q_vector;
-	q_vector->rx.itr = ITR_TO_REG(rx_ring->itr_setting);
-	wr32(hw, I40E_VFINT_ITRN1(I40E_RX_ITR, q_vector->reg_idx),
-	     q_vector->rx.itr);
+	q_vector->rx.target_itr = ITR_TO_REG(rx_ring->itr_setting);
 
 	q_vector = tx_ring->q_vector;
-	q_vector->tx.itr = ITR_TO_REG(tx_ring->itr_setting);
-	wr32(hw, I40E_VFINT_ITRN1(I40E_TX_ITR, q_vector->reg_idx),
-	     q_vector->tx.itr);
+	q_vector->tx.target_itr = ITR_TO_REG(tx_ring->itr_setting);
 
-	i40e_flush(hw);
+	/* The interrupt handler itself will take care of programming
+	 * the Tx and Rx ITR values based on the values we have entered
+	 * into the q_vector, no need to write the values now.
+	 */
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index f648e5e..3bf6a12 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -354,11 +354,12 @@ i40evf_map_vector_to_rxq(struct i40evf_adapter *adapter, int v_idx, int r_idx)
 	q_vector->rx.ring = rx_ring;
 	q_vector->rx.count++;
 	q_vector->rx.latency_range = I40E_LOW_LATENCY;
-	q_vector->rx.itr = ITR_TO_REG(rx_ring->itr_setting);
+	q_vector->rx.target_itr = ITR_TO_REG(rx_ring->itr_setting);
 	q_vector->ring_mask |= BIT(r_idx);
 	q_vector->itr_countdown = ITR_COUNTDOWN_START;
 	wr32(hw, I40E_VFINT_ITRN1(I40E_RX_ITR, q_vector->reg_idx),
-	     q_vector->rx.itr);
+	     q_vector->rx.current_itr);
+	q_vector->rx.current_itr = q_vector->rx.target_itr;
 }
 
 /**
@@ -380,11 +381,12 @@ i40evf_map_vector_to_txq(struct i40evf_adapter *adapter, int v_idx, int t_idx)
 	q_vector->tx.ring = tx_ring;
 	q_vector->tx.count++;
 	q_vector->tx.latency_range = I40E_LOW_LATENCY;
-	q_vector->tx.itr = ITR_TO_REG(tx_ring->itr_setting);
+	q_vector->tx.target_itr = ITR_TO_REG(tx_ring->itr_setting);
 	q_vector->itr_countdown = ITR_COUNTDOWN_START;
 	q_vector->num_ringpairs++;
 	wr32(hw, I40E_VFINT_ITRN1(I40E_TX_ITR, q_vector->reg_idx),
-	     q_vector->tx.itr);
+	     q_vector->tx.target_itr);
+	q_vector->tx.current_itr = q_vector->tx.target_itr;
 }
 
 /**
-- 
2.9.5

