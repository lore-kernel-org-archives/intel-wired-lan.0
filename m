From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Dec 2017 08:50:44 -0500
Subject: [Intel-wired-lan] [next PATCH S85-V1 09/14] i40e/i40evf: Clean-up
 of bits related to using q_vector->reg_idx
Message-ID: <20171229135044.14551-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch is a further clean-up related to the change over to using
q_vector->reg_idx when accessing the ITR registers. Specifically the code
appears to have several other spots where we were computing the register
offset manually and this resulted in errors in a few spots.

Specifically in the i40evf functions for mapping queues to vectors it
appears we may have had an off by 1 error since (v_idx - 1) for the first
q_vector with an index of 0 would result in us returning -1 if I am not
mistaken.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 12 ++++++------
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 12 +++++-------
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  6 ++++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 5b18e20..1607e5a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2311,7 +2311,7 @@ static void i40e_set_itr_per_queue(struct i40e_vsi *vsi,
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_hw *hw = &pf->hw;
 	struct i40e_q_vector *q_vector;
-	u16 vector, intrl;
+	u16 intrl;
 
 	intrl = i40e_intrl_usec_to_reg(vsi->int_rate_limit);
 
@@ -2330,15 +2330,15 @@ static void i40e_set_itr_per_queue(struct i40e_vsi *vsi,
 
 	q_vector = rx_ring->q_vector;
 	q_vector->rx.itr = ITR_TO_REG(rx_ring->itr_setting);
-	vector = vsi->base_vector + q_vector->v_idx;
-	wr32(hw, I40E_PFINT_ITRN(I40E_RX_ITR, vector - 1), q_vector->rx.itr);
+	wr32(hw, I40E_PFINT_ITRN(I40E_RX_ITR, q_vector->reg_idx),
+	     q_vector->rx.itr);
 
 	q_vector = tx_ring->q_vector;
 	q_vector->tx.itr = ITR_TO_REG(tx_ring->itr_setting);
-	vector = vsi->base_vector + q_vector->v_idx;
-	wr32(hw, I40E_PFINT_ITRN(I40E_TX_ITR, vector - 1), q_vector->tx.itr);
+	wr32(hw, I40E_PFINT_ITRN(I40E_TX_ITR, q_vector->reg_idx),
+	     q_vector->tx.itr);
 
-	wr32(hw, I40E_PFINT_RATEN(vector - 1), intrl);
+	wr32(hw, I40E_PFINT_RATEN(q_vector->reg_idx), intrl);
 	i40e_flush(hw);
 }
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
index 11dfdc8..ed5b8ec 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
@@ -502,7 +502,7 @@ static int i40evf_get_per_queue_coalesce(struct net_device *netdev,
 
 /**
  * i40evf_set_itr_per_queue - set ITR values for specific queue
- * @vsi: the VSI to set values for
+ * @adapter: the VF adapter struct to set values for
  * @ec: coalesce settings from ethtool
  * @queue: the queue to modify
  *
@@ -514,10 +514,8 @@ static void i40evf_set_itr_per_queue(struct i40evf_adapter *adapter,
 {
 	struct i40e_ring *rx_ring = &adapter->rx_rings[queue];
 	struct i40e_ring *tx_ring = &adapter->tx_rings[queue];
-	struct i40e_vsi *vsi = &adapter->vsi;
 	struct i40e_hw *hw = &adapter->hw;
 	struct i40e_q_vector *q_vector;
-	u16 vector;
 
 	rx_ring->itr_setting = ec->rx_coalesce_usecs;
 	tx_ring->itr_setting = ec->tx_coalesce_usecs;
@@ -532,13 +530,13 @@ static void i40evf_set_itr_per_queue(struct i40evf_adapter *adapter,
 
 	q_vector = rx_ring->q_vector;
 	q_vector->rx.itr = ITR_TO_REG(rx_ring->itr_setting);
-	vector = vsi->base_vector + q_vector->v_idx;
-	wr32(hw, I40E_VFINT_ITRN1(I40E_RX_ITR, vector - 1), q_vector->rx.itr);
+	wr32(hw, I40E_VFINT_ITRN1(I40E_RX_ITR, q_vector->reg_idx),
+	     q_vector->rx.itr);
 
 	q_vector = tx_ring->q_vector;
 	q_vector->tx.itr = ITR_TO_REG(tx_ring->itr_setting);
-	vector = vsi->base_vector + q_vector->v_idx;
-	wr32(hw, I40E_VFINT_ITRN1(I40E_TX_ITR, vector - 1), q_vector->tx.itr);
+	wr32(hw, I40E_VFINT_ITRN1(I40E_TX_ITR, q_vector->reg_idx),
+	     q_vector->tx.itr);
 
 	i40e_flush(hw);
 }
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index a5fb540..f648e5e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -357,7 +357,8 @@ i40evf_map_vector_to_rxq(struct i40evf_adapter *adapter, int v_idx, int r_idx)
 	q_vector->rx.itr = ITR_TO_REG(rx_ring->itr_setting);
 	q_vector->ring_mask |= BIT(r_idx);
 	q_vector->itr_countdown = ITR_COUNTDOWN_START;
-	wr32(hw, I40E_VFINT_ITRN1(I40E_RX_ITR, v_idx - 1), q_vector->rx.itr);
+	wr32(hw, I40E_VFINT_ITRN1(I40E_RX_ITR, q_vector->reg_idx),
+	     q_vector->rx.itr);
 }
 
 /**
@@ -382,7 +383,8 @@ i40evf_map_vector_to_txq(struct i40evf_adapter *adapter, int v_idx, int t_idx)
 	q_vector->tx.itr = ITR_TO_REG(tx_ring->itr_setting);
 	q_vector->itr_countdown = ITR_COUNTDOWN_START;
 	q_vector->num_ringpairs++;
-	wr32(hw, I40E_VFINT_ITRN1(I40E_TX_ITR, v_idx - 1), q_vector->tx.itr);
+	wr32(hw, I40E_VFINT_ITRN1(I40E_TX_ITR, q_vector->reg_idx),
+	     q_vector->tx.itr);
 }
 
 /**
-- 
2.9.5

