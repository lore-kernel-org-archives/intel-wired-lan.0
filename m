From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Dec 2017 08:49:28 -0500
Subject: [Intel-wired-lan] [next PATCH S85-V1 04/14] i40e/i40evf: Only track
 one itr setting per ring instead of Tx/Rx
Message-ID: <20171229134928.14308-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

The rings are already split out into Tx and Rx rings so it does't make
sense to have any single ring store both a Tx and Rx itr_setting value.
Since that is the case drop the pair in favor of storing just a single ITR
value.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     | 12 ++++----
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 32 +++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 14 +++++-----
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  6 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  3 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  6 ++--
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  3 +-
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 24 ++++++++--------
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  8 +++---
 9 files changed, 53 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 4c3b424..e9fc51b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -315,9 +315,9 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 i, rx_ring->vsi,
 			 rx_ring->q_vector);
 		dev_info(&pf->pdev->dev,
-			 "    rx_rings[%i]: rx_itr_setting = %d (%s)\n",
-			 i, rx_ring->rx_itr_setting,
-			 ITR_IS_DYNAMIC(rx_ring->rx_itr_setting) ? "dynamic" : "fixed");
+			 "    rx_rings[%i]: itr_setting = %d (%s)\n",
+			 i, rx_ring->itr_setting,
+			 ITR_IS_DYNAMIC(rx_ring->itr_setting) ? "dynamic" : "fixed");
 	}
 	for (i = 0; i < vsi->num_queue_pairs; i++) {
 		struct i40e_ring *tx_ring = READ_ONCE(vsi->tx_rings[i]);
@@ -366,9 +366,9 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 "    tx_rings[%i]: DCB tc = %d\n",
 			 i, tx_ring->dcb_tc);
 		dev_info(&pf->pdev->dev,
-			 "    tx_rings[%i]: tx_itr_setting = %d (%s)\n",
-			 i, tx_ring->tx_itr_setting,
-			 ITR_IS_DYNAMIC(tx_ring->tx_itr_setting) ? "dynamic" : "fixed");
+			 "    tx_rings[%i]: itr_setting = %d (%s)\n",
+			 i, tx_ring->itr_setting,
+			 ITR_IS_DYNAMIC(tx_ring->itr_setting) ? "dynamic" : "fixed");
 	}
 	rcu_read_unlock();
 	dev_info(&pf->pdev->dev,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 8236689..f829a7a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2244,14 +2244,14 @@ static int __i40e_get_coalesce(struct net_device *netdev,
 	rx_ring = vsi->rx_rings[queue];
 	tx_ring = vsi->tx_rings[queue];
 
-	if (ITR_IS_DYNAMIC(rx_ring->rx_itr_setting))
+	if (ITR_IS_DYNAMIC(rx_ring->itr_setting))
 		ec->use_adaptive_rx_coalesce = 1;
 
-	if (ITR_IS_DYNAMIC(tx_ring->tx_itr_setting))
+	if (ITR_IS_DYNAMIC(tx_ring->itr_setting))
 		ec->use_adaptive_tx_coalesce = 1;
 
-	ec->rx_coalesce_usecs = rx_ring->rx_itr_setting & ~I40E_ITR_DYNAMIC;
-	ec->tx_coalesce_usecs = tx_ring->tx_itr_setting & ~I40E_ITR_DYNAMIC;
+	ec->rx_coalesce_usecs = rx_ring->itr_setting & ~I40E_ITR_DYNAMIC;
+	ec->tx_coalesce_usecs = tx_ring->itr_setting & ~I40E_ITR_DYNAMIC;
 
 	/* we use the _usecs_high to store/set the interrupt rate limit
 	 * that the hardware supports, that almost but not quite
@@ -2315,26 +2315,26 @@ static void i40e_set_itr_per_queue(struct i40e_vsi *vsi,
 
 	intrl = i40e_intrl_usec_to_reg(vsi->int_rate_limit);
 
-	rx_ring->rx_itr_setting = ec->rx_coalesce_usecs;
-	tx_ring->tx_itr_setting = ec->tx_coalesce_usecs;
+	rx_ring->itr_setting = ec->rx_coalesce_usecs;
+	tx_ring->itr_setting = ec->tx_coalesce_usecs;
 
 	if (ec->use_adaptive_rx_coalesce)
-		rx_ring->rx_itr_setting |= I40E_ITR_DYNAMIC;
+		rx_ring->itr_setting |= I40E_ITR_DYNAMIC;
 	else
-		rx_ring->rx_itr_setting &= ~I40E_ITR_DYNAMIC;
+		rx_ring->itr_setting &= ~I40E_ITR_DYNAMIC;
 
 	if (ec->use_adaptive_tx_coalesce)
-		tx_ring->tx_itr_setting |= I40E_ITR_DYNAMIC;
+		tx_ring->itr_setting |= I40E_ITR_DYNAMIC;
 	else
-		tx_ring->tx_itr_setting &= ~I40E_ITR_DYNAMIC;
+		tx_ring->itr_setting &= ~I40E_ITR_DYNAMIC;
 
 	q_vector = rx_ring->q_vector;
-	q_vector->rx.itr = ITR_TO_REG(rx_ring->rx_itr_setting);
+	q_vector->rx.itr = ITR_TO_REG(rx_ring->itr_setting);
 	vector = vsi->base_vector + q_vector->v_idx;
 	wr32(hw, I40E_PFINT_ITRN(I40E_RX_ITR, vector - 1), q_vector->rx.itr);
 
 	q_vector = tx_ring->q_vector;
-	q_vector->tx.itr = ITR_TO_REG(tx_ring->tx_itr_setting);
+	q_vector->tx.itr = ITR_TO_REG(tx_ring->itr_setting);
 	vector = vsi->base_vector + q_vector->v_idx;
 	wr32(hw, I40E_PFINT_ITRN(I40E_TX_ITR, vector - 1), q_vector->tx.itr);
 
@@ -2364,11 +2364,11 @@ static int __i40e_set_coalesce(struct net_device *netdev,
 		vsi->work_limit = ec->tx_max_coalesced_frames_irq;
 
 	if (queue < 0) {
-		cur_rx_itr = vsi->rx_rings[0]->rx_itr_setting;
-		cur_tx_itr = vsi->tx_rings[0]->tx_itr_setting;
+		cur_rx_itr = vsi->rx_rings[0]->itr_setting;
+		cur_tx_itr = vsi->tx_rings[0]->itr_setting;
 	} else if (queue < vsi->num_queue_pairs) {
-		cur_rx_itr = vsi->rx_rings[queue]->rx_itr_setting;
-		cur_tx_itr = vsi->tx_rings[queue]->tx_itr_setting;
+		cur_rx_itr = vsi->rx_rings[queue]->itr_setting;
+		cur_tx_itr = vsi->tx_rings[queue]->itr_setting;
 	} else {
 		netif_info(pf, drv, netdev, "Invalid queue value, queue range is 0 - %d\n",
 			   vsi->num_queue_pairs - 1);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ea8be7c..fdf0bfb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3434,11 +3434,11 @@ static void i40e_vsi_configure_msix(struct i40e_vsi *vsi)
 		struct i40e_q_vector *q_vector = vsi->q_vectors[i];
 
 		q_vector->itr_countdown = ITR_COUNTDOWN_START;
-		q_vector->rx.itr = ITR_TO_REG(vsi->rx_rings[i]->rx_itr_setting);
+		q_vector->rx.itr = ITR_TO_REG(vsi->rx_rings[i]->itr_setting);
 		q_vector->rx.latency_range = I40E_LOW_LATENCY;
 		wr32(hw, I40E_PFINT_ITRN(I40E_RX_ITR, vector - 1),
 		     q_vector->rx.itr);
-		q_vector->tx.itr = ITR_TO_REG(vsi->tx_rings[i]->tx_itr_setting);
+		q_vector->tx.itr = ITR_TO_REG(vsi->tx_rings[i]->itr_setting);
 		q_vector->tx.latency_range = I40E_LOW_LATENCY;
 		wr32(hw, I40E_PFINT_ITRN(I40E_TX_ITR, vector - 1),
 		     q_vector->tx.itr);
@@ -3543,10 +3543,10 @@ static void i40e_configure_msi_and_legacy(struct i40e_vsi *vsi)
 
 	/* set the ITR configuration */
 	q_vector->itr_countdown = ITR_COUNTDOWN_START;
-	q_vector->rx.itr = ITR_TO_REG(vsi->rx_rings[0]->rx_itr_setting);
+	q_vector->rx.itr = ITR_TO_REG(vsi->rx_rings[0]->itr_setting);
 	q_vector->rx.latency_range = I40E_LOW_LATENCY;
 	wr32(hw, I40E_PFINT_ITR0(I40E_RX_ITR), q_vector->rx.itr);
-	q_vector->tx.itr = ITR_TO_REG(vsi->tx_rings[0]->tx_itr_setting);
+	q_vector->tx.itr = ITR_TO_REG(vsi->tx_rings[0]->itr_setting);
 	q_vector->tx.latency_range = I40E_LOW_LATENCY;
 	wr32(hw, I40E_PFINT_ITR0(I40E_TX_ITR), q_vector->tx.itr);
 
@@ -10062,7 +10062,7 @@ static int i40e_alloc_rings(struct i40e_vsi *vsi)
 		ring->dcb_tc = 0;
 		if (vsi->back->hw_features & I40E_HW_WB_ON_ITR_CAPABLE)
 			ring->flags = I40E_TXR_FLAGS_WB_ON_ITR;
-		ring->tx_itr_setting = pf->tx_itr_default;
+		ring->itr_setting = pf->tx_itr_default;
 		vsi->tx_rings[i] = ring++;
 
 		if (!i40e_enabled_xdp_vsi(vsi))
@@ -10080,7 +10080,7 @@ static int i40e_alloc_rings(struct i40e_vsi *vsi)
 		if (vsi->back->hw_features & I40E_HW_WB_ON_ITR_CAPABLE)
 			ring->flags = I40E_TXR_FLAGS_WB_ON_ITR;
 		set_ring_xdp(ring);
-		ring->tx_itr_setting = pf->tx_itr_default;
+		ring->itr_setting = pf->tx_itr_default;
 		vsi->xdp_rings[i] = ring++;
 
 setup_rx:
@@ -10093,7 +10093,7 @@ static int i40e_alloc_rings(struct i40e_vsi *vsi)
 		ring->count = vsi->num_desc;
 		ring->size = 0;
 		ring->dcb_tc = 0;
-		ring->rx_itr_setting = pf->rx_itr_default;
+		ring->itr_setting = pf->rx_itr_default;
 		vsi->rx_rings[i] = ring;
 	}
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 97c2482..44d360e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2276,12 +2276,12 @@ static u32 i40e_buildreg_itr(const int type, const u16 itr)
 #define INTREG I40E_PFINT_DYN_CTLN
 static inline int get_rx_itr(struct i40e_vsi *vsi, int idx)
 {
-	return vsi->rx_rings[idx]->rx_itr_setting;
+	return vsi->rx_rings[idx]->itr_setting;
 }
 
 static inline int get_tx_itr(struct i40e_vsi *vsi, int idx)
 {
-	return vsi->tx_rings[idx]->tx_itr_setting;
+	return vsi->tx_rings[idx]->itr_setting;
 }
 
 /**
@@ -2308,7 +2308,7 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 	/* avoid dynamic calculation if in countdown mode OR if
 	 * all dynamic is disabled
 	 */
-	rxval = txval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
+	txval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
 
 	rx_itr_setting = get_rx_itr(vsi, idx);
 	tx_itr_setting = get_tx_itr(vsi, idx);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index f1c13be..61eee3d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -380,8 +380,7 @@ struct i40e_ring {
 	 * these values always store the USER setting, and must be converted
 	 * before programming to a register.
 	 */
-	u16 rx_itr_setting;
-	u16 tx_itr_setting;
+	u16 itr_setting;
 
 	u16 count;			/* Number of descriptors */
 	u16 reg_idx;			/* HW register index of the ring */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 464200f..291130a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1475,14 +1475,14 @@ static inline int get_rx_itr(struct i40e_vsi *vsi, int idx)
 {
 	struct i40evf_adapter *adapter = vsi->back;
 
-	return adapter->rx_rings[idx].rx_itr_setting;
+	return adapter->rx_rings[idx].itr_setting;
 }
 
 static inline int get_tx_itr(struct i40e_vsi *vsi, int idx)
 {
 	struct i40evf_adapter *adapter = vsi->back;
 
-	return adapter->tx_rings[idx].tx_itr_setting;
+	return adapter->tx_rings[idx].itr_setting;
 }
 
 /**
@@ -1503,7 +1503,7 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 	/* avoid dynamic calculation if in countdown mode OR if
 	 * all dynamic is disabled
 	 */
-	rxval = txval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
+	txval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
 
 	rx_itr_setting = get_rx_itr(vsi, idx);
 	tx_itr_setting = get_tx_itr(vsi, idx);
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index e72f16b..81210c3 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -362,8 +362,7 @@ struct i40e_ring {
 	 * these values always store the USER setting, and must be converted
 	 * before programming to a register.
 	 */
-	u16 rx_itr_setting;
-	u16 tx_itr_setting;
+	u16 itr_setting;
 
 	u16 count;			/* Number of descriptors */
 	u16 reg_idx;			/* HW register index of the ring */
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
index e2d8aa1..11dfdc8 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
@@ -457,14 +457,14 @@ static int __i40evf_get_coalesce(struct net_device *netdev,
 	rx_ring = &adapter->rx_rings[queue];
 	tx_ring = &adapter->tx_rings[queue];
 
-	if (ITR_IS_DYNAMIC(rx_ring->rx_itr_setting))
+	if (ITR_IS_DYNAMIC(rx_ring->itr_setting))
 		ec->use_adaptive_rx_coalesce = 1;
 
-	if (ITR_IS_DYNAMIC(tx_ring->tx_itr_setting))
+	if (ITR_IS_DYNAMIC(tx_ring->itr_setting))
 		ec->use_adaptive_tx_coalesce = 1;
 
-	ec->rx_coalesce_usecs = rx_ring->rx_itr_setting & ~I40E_ITR_DYNAMIC;
-	ec->tx_coalesce_usecs = tx_ring->tx_itr_setting & ~I40E_ITR_DYNAMIC;
+	ec->rx_coalesce_usecs = rx_ring->itr_setting & ~I40E_ITR_DYNAMIC;
+	ec->tx_coalesce_usecs = tx_ring->itr_setting & ~I40E_ITR_DYNAMIC;
 
 	return 0;
 }
@@ -519,24 +519,24 @@ static void i40evf_set_itr_per_queue(struct i40evf_adapter *adapter,
 	struct i40e_q_vector *q_vector;
 	u16 vector;
 
-	rx_ring->rx_itr_setting = ec->rx_coalesce_usecs;
-	tx_ring->tx_itr_setting = ec->tx_coalesce_usecs;
+	rx_ring->itr_setting = ec->rx_coalesce_usecs;
+	tx_ring->itr_setting = ec->tx_coalesce_usecs;
 
-	rx_ring->rx_itr_setting |= I40E_ITR_DYNAMIC;
+	rx_ring->itr_setting |= I40E_ITR_DYNAMIC;
 	if (!ec->use_adaptive_rx_coalesce)
-		rx_ring->rx_itr_setting ^= I40E_ITR_DYNAMIC;
+		rx_ring->itr_setting ^= I40E_ITR_DYNAMIC;
 
-	tx_ring->tx_itr_setting |= I40E_ITR_DYNAMIC;
+	tx_ring->itr_setting |= I40E_ITR_DYNAMIC;
 	if (!ec->use_adaptive_tx_coalesce)
-		tx_ring->tx_itr_setting ^= I40E_ITR_DYNAMIC;
+		tx_ring->itr_setting ^= I40E_ITR_DYNAMIC;
 
 	q_vector = rx_ring->q_vector;
-	q_vector->rx.itr = ITR_TO_REG(rx_ring->rx_itr_setting);
+	q_vector->rx.itr = ITR_TO_REG(rx_ring->itr_setting);
 	vector = vsi->base_vector + q_vector->v_idx;
 	wr32(hw, I40E_VFINT_ITRN1(I40E_RX_ITR, vector - 1), q_vector->rx.itr);
 
 	q_vector = tx_ring->q_vector;
-	q_vector->tx.itr = ITR_TO_REG(tx_ring->tx_itr_setting);
+	q_vector->tx.itr = ITR_TO_REG(tx_ring->itr_setting);
 	vector = vsi->base_vector + q_vector->v_idx;
 	wr32(hw, I40E_VFINT_ITRN1(I40E_TX_ITR, vector - 1), q_vector->tx.itr);
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 16989ad..a5fb540 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -354,7 +354,7 @@ i40evf_map_vector_to_rxq(struct i40evf_adapter *adapter, int v_idx, int r_idx)
 	q_vector->rx.ring = rx_ring;
 	q_vector->rx.count++;
 	q_vector->rx.latency_range = I40E_LOW_LATENCY;
-	q_vector->rx.itr = ITR_TO_REG(rx_ring->rx_itr_setting);
+	q_vector->rx.itr = ITR_TO_REG(rx_ring->itr_setting);
 	q_vector->ring_mask |= BIT(r_idx);
 	q_vector->itr_countdown = ITR_COUNTDOWN_START;
 	wr32(hw, I40E_VFINT_ITRN1(I40E_RX_ITR, v_idx - 1), q_vector->rx.itr);
@@ -379,7 +379,7 @@ i40evf_map_vector_to_txq(struct i40evf_adapter *adapter, int v_idx, int t_idx)
 	q_vector->tx.ring = tx_ring;
 	q_vector->tx.count++;
 	q_vector->tx.latency_range = I40E_LOW_LATENCY;
-	q_vector->tx.itr = ITR_TO_REG(tx_ring->tx_itr_setting);
+	q_vector->tx.itr = ITR_TO_REG(tx_ring->itr_setting);
 	q_vector->itr_countdown = ITR_COUNTDOWN_START;
 	q_vector->num_ringpairs++;
 	wr32(hw, I40E_VFINT_ITRN1(I40E_TX_ITR, v_idx - 1), q_vector->tx.itr);
@@ -1169,7 +1169,7 @@ static int i40evf_alloc_queues(struct i40evf_adapter *adapter)
 		tx_ring->netdev = adapter->netdev;
 		tx_ring->dev = &adapter->pdev->dev;
 		tx_ring->count = adapter->tx_desc_count;
-		tx_ring->tx_itr_setting = I40E_ITR_TX_DEF;
+		tx_ring->itr_setting = I40E_ITR_TX_DEF;
 		if (adapter->flags & I40EVF_FLAG_WB_ON_ITR_CAPABLE)
 			tx_ring->flags |= I40E_TXR_FLAGS_WB_ON_ITR;
 
@@ -1178,7 +1178,7 @@ static int i40evf_alloc_queues(struct i40evf_adapter *adapter)
 		rx_ring->netdev = adapter->netdev;
 		rx_ring->dev = &adapter->pdev->dev;
 		rx_ring->count = adapter->rx_desc_count;
-		rx_ring->rx_itr_setting = I40E_ITR_RX_DEF;
+		rx_ring->itr_setting = I40E_ITR_RX_DEF;
 	}
 
 	adapter->num_active_queues = num_active_queues;
-- 
2.9.5

