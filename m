From: Alice Michael <alice.michael@intel.com>
Date: Wed, 27 Dec 2017 07:32:33 -0500
Subject: [Intel-wired-lan] [next PATCH S84-V2 04/13] i40e/i40evf: Use ring
 pointers to clean up _set_itr_per_queue
In-Reply-To: <20171227123242.22356-1-alice.michael@intel.com>
References: <20171227123242.22356-1-alice.michael@intel.com>
Message-ID: <20171227123242.22356-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This change cleans up the i40e/i40evf_set_itr_per_queue function by
dropping all the unneeded pointer chases. Instead we can just pull out the
pointers for the Tx and Rx rings and use them throughout the function.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 22 +++++++++--------
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 28 +++++++++++-----------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 099b170..79c752a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2305,6 +2305,8 @@ static void i40e_set_itr_per_queue(struct i40e_vsi *vsi,
 				   struct ethtool_coalesce *ec,
 				   int queue)
 {
+	struct i40e_ring *rx_ring = vsi->rx_rings[queue];
+	struct i40e_ring *tx_ring = vsi->tx_rings[queue];
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_hw *hw = &pf->hw;
 	struct i40e_q_vector *q_vector;
@@ -2312,26 +2314,26 @@ static void i40e_set_itr_per_queue(struct i40e_vsi *vsi,
 
 	intrl = i40e_intrl_usec_to_reg(vsi->int_rate_limit);
 
-	vsi->rx_rings[queue]->rx_itr_setting = ec->rx_coalesce_usecs;
-	vsi->tx_rings[queue]->tx_itr_setting = ec->tx_coalesce_usecs;
+	rx_ring->rx_itr_setting = ec->rx_coalesce_usecs;
+	tx_ring->tx_itr_setting = ec->tx_coalesce_usecs;
 
 	if (ec->use_adaptive_rx_coalesce)
-		vsi->rx_rings[queue]->rx_itr_setting |= I40E_ITR_DYNAMIC;
+		rx_ring->rx_itr_setting |= I40E_ITR_DYNAMIC;
 	else
-		vsi->rx_rings[queue]->rx_itr_setting &= ~I40E_ITR_DYNAMIC;
+		rx_ring->rx_itr_setting &= ~I40E_ITR_DYNAMIC;
 
 	if (ec->use_adaptive_tx_coalesce)
-		vsi->tx_rings[queue]->tx_itr_setting |= I40E_ITR_DYNAMIC;
+		tx_ring->tx_itr_setting |= I40E_ITR_DYNAMIC;
 	else
-		vsi->tx_rings[queue]->tx_itr_setting &= ~I40E_ITR_DYNAMIC;
+		tx_ring->tx_itr_setting &= ~I40E_ITR_DYNAMIC;
 
-	q_vector = vsi->rx_rings[queue]->q_vector;
-	q_vector->rx.itr = ITR_TO_REG(vsi->rx_rings[queue]->rx_itr_setting);
+	q_vector = rx_ring->q_vector;
+	q_vector->rx.itr = ITR_TO_REG(rx_ring->rx_itr_setting);
 	vector = vsi->base_vector + q_vector->v_idx;
 	wr32(hw, I40E_PFINT_ITRN(I40E_RX_ITR, vector - 1), q_vector->rx.itr);
 
-	q_vector = vsi->tx_rings[queue]->q_vector;
-	q_vector->tx.itr = ITR_TO_REG(vsi->tx_rings[queue]->tx_itr_setting);
+	q_vector = tx_ring->q_vector;
+	q_vector->tx.itr = ITR_TO_REG(tx_ring->tx_itr_setting);
 	vector = vsi->base_vector + q_vector->v_idx;
 	wr32(hw, I40E_PFINT_ITRN(I40E_TX_ITR, vector - 1), q_vector->tx.itr);
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
index da006fa..e2d8aa1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
@@ -512,31 +512,31 @@ static void i40evf_set_itr_per_queue(struct i40evf_adapter *adapter,
 				     struct ethtool_coalesce *ec,
 				     int queue)
 {
+	struct i40e_ring *rx_ring = &adapter->rx_rings[queue];
+	struct i40e_ring *tx_ring = &adapter->tx_rings[queue];
 	struct i40e_vsi *vsi = &adapter->vsi;
 	struct i40e_hw *hw = &adapter->hw;
 	struct i40e_q_vector *q_vector;
 	u16 vector;
 
-	adapter->rx_rings[queue].rx_itr_setting = ec->rx_coalesce_usecs;
-	adapter->tx_rings[queue].tx_itr_setting = ec->tx_coalesce_usecs;
+	rx_ring->rx_itr_setting = ec->rx_coalesce_usecs;
+	tx_ring->tx_itr_setting = ec->tx_coalesce_usecs;
 
-	if (ec->use_adaptive_rx_coalesce)
-		adapter->rx_rings[queue].rx_itr_setting |= I40E_ITR_DYNAMIC;
-	else
-		adapter->rx_rings[queue].rx_itr_setting &= ~I40E_ITR_DYNAMIC;
+	rx_ring->rx_itr_setting |= I40E_ITR_DYNAMIC;
+	if (!ec->use_adaptive_rx_coalesce)
+		rx_ring->rx_itr_setting ^= I40E_ITR_DYNAMIC;
 
-	if (ec->use_adaptive_tx_coalesce)
-		adapter->tx_rings[queue].tx_itr_setting |= I40E_ITR_DYNAMIC;
-	else
-		adapter->tx_rings[queue].tx_itr_setting &= ~I40E_ITR_DYNAMIC;
+	tx_ring->tx_itr_setting |= I40E_ITR_DYNAMIC;
+	if (!ec->use_adaptive_tx_coalesce)
+		tx_ring->tx_itr_setting ^= I40E_ITR_DYNAMIC;
 
-	q_vector = adapter->rx_rings[queue].q_vector;
-	q_vector->rx.itr = ITR_TO_REG(adapter->rx_rings[queue].rx_itr_setting);
+	q_vector = rx_ring->q_vector;
+	q_vector->rx.itr = ITR_TO_REG(rx_ring->rx_itr_setting);
 	vector = vsi->base_vector + q_vector->v_idx;
 	wr32(hw, I40E_VFINT_ITRN1(I40E_RX_ITR, vector - 1), q_vector->rx.itr);
 
-	q_vector = adapter->tx_rings[queue].q_vector;
-	q_vector->tx.itr = ITR_TO_REG(adapter->tx_rings[queue].tx_itr_setting);
+	q_vector = tx_ring->q_vector;
+	q_vector->tx.itr = ITR_TO_REG(tx_ring->tx_itr_setting);
 	vector = vsi->base_vector + q_vector->v_idx;
 	wr32(hw, I40E_VFINT_ITRN1(I40E_TX_ITR, vector - 1), q_vector->tx.itr);
 
-- 
2.9.5

