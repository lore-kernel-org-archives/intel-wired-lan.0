From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Dec 2017 08:48:53 -0500
Subject: [Intel-wired-lan] [next PATCH S85-V1 02/14] i40e/i40evf: Record ITR
 register location in the q_vector
Message-ID: <20171229134853.14186-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

The drivers for i40e and i40evf had a reg_idx value stored in the q_vector
that was going completely unused. I can only assume this was copied over
from ixgbe and nobody knew how to use it.

I'm going to make use of the value to avoid having to compute the vector
and thus the register index for multiple paths throughout the drivers.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     |  1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c     | 12 ++++--------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c   | 12 ++++--------
 drivers/net/ethernet/intel/i40evf/i40evf.h      |  4 ++--
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |  1 +
 5 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4a3b13d..14e4a2b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4107,6 +4107,7 @@ static void i40e_vsi_map_rings_to_vectors(struct i40e_vsi *vsi)
 		num_ringpairs = DIV_ROUND_UP(qp_remaining, q_vectors - v_start);
 
 		q_vector->num_ringpairs = num_ringpairs;
+		q_vector->reg_idx = q_vector->v_idx + vsi->base_vector - 1;
 
 		q_vector->rx.count = 0;
 		q_vector->tx.count = 0;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 95c2aaf..97c2482 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -955,7 +955,7 @@ static void i40e_enable_wb_on_itr(struct i40e_vsi *vsi,
 		      I40E_PFINT_DYN_CTLN_ITR_INDX_MASK; /* set noitr */
 
 		wr32(&vsi->back->hw,
-		     I40E_PFINT_DYN_CTLN(q_vector->v_idx + vsi->base_vector - 1),
+		     I40E_PFINT_DYN_CTLN(q_vector->reg_idx),
 		     val);
 	} else {
 		val = I40E_PFINT_DYN_CTL0_WB_ON_ITR_MASK |
@@ -982,8 +982,7 @@ void i40e_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector)
 			  /* allow 00 to be written to the index */
 
 		wr32(&vsi->back->hw,
-		     I40E_PFINT_DYN_CTLN(q_vector->v_idx +
-					 vsi->base_vector - 1), val);
+		     I40E_PFINT_DYN_CTLN(q_vector->reg_idx), val);
 	} else {
 		u32 val = I40E_PFINT_DYN_CTL0_INTENA_MASK |
 			  I40E_PFINT_DYN_CTL0_ITR_INDX_MASK | /* set noitr */
@@ -2297,7 +2296,6 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 	struct i40e_hw *hw = &vsi->back->hw;
 	bool rx = false, tx = false;
 	u32 rxval, txval;
-	int vector;
 	int idx = q_vector->v_idx;
 	int rx_itr_setting, tx_itr_setting;
 
@@ -2307,8 +2305,6 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 		return;
 	}
 
-	vector = (q_vector->v_idx + vsi->base_vector);
-
 	/* avoid dynamic calculation if in countdown mode OR if
 	 * all dynamic is disabled
 	 */
@@ -2357,12 +2353,12 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 		 */
 		rxval |= BIT(31);
 		/* don't check _DOWN because interrupt isn't being enabled */
-		wr32(hw, INTREG(vector - 1), rxval);
+		wr32(hw, INTREG(q_vector->reg_idx), rxval);
 	}
 
 enable_int:
 	if (!test_bit(__I40E_VSI_DOWN, vsi->state))
-		wr32(hw, INTREG(vector - 1), txval);
+		wr32(hw, INTREG(q_vector->reg_idx), txval);
 
 	if (q_vector->itr_countdown)
 		q_vector->itr_countdown--;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index ae6dd90..464200f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -369,8 +369,7 @@ static void i40e_enable_wb_on_itr(struct i40e_vsi *vsi,
 	      I40E_VFINT_DYN_CTLN1_ITR_INDX_MASK; /* set noitr */
 
 	wr32(&vsi->back->hw,
-	     I40E_VFINT_DYN_CTLN1(q_vector->v_idx +
-				  vsi->base_vector - 1), val);
+	     I40E_VFINT_DYN_CTLN1(q_vector->reg_idx), val);
 	q_vector->arm_wb_state = true;
 }
 
@@ -389,7 +388,7 @@ void i40evf_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector)
 		  /* allow 00 to be written to the index */;
 
 	wr32(&vsi->back->hw,
-	     I40E_VFINT_DYN_CTLN1(q_vector->v_idx + vsi->base_vector - 1),
+	     I40E_VFINT_DYN_CTLN1(q_vector->reg_idx),
 	     val);
 }
 
@@ -1498,12 +1497,9 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 	struct i40e_hw *hw = &vsi->back->hw;
 	bool rx = false, tx = false;
 	u32 rxval, txval;
-	int vector;
 	int idx = q_vector->v_idx;
 	int rx_itr_setting, tx_itr_setting;
 
-	vector = (q_vector->v_idx + vsi->base_vector);
-
 	/* avoid dynamic calculation if in countdown mode OR if
 	 * all dynamic is disabled
 	 */
@@ -1552,12 +1548,12 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 		 */
 		rxval |= BIT(31);
 		/* don't check _DOWN because interrupt isn't being enabled */
-		wr32(hw, INTREG(vector - 1), rxval);
+		wr32(hw, INTREG(q_vector->reg_idx), rxval);
 	}
 
 enable_int:
 	if (!test_bit(__I40E_VSI_DOWN, vsi->state))
-		wr32(hw, INTREG(vector - 1), txval);
+		wr32(hw, INTREG(q_vector->reg_idx), txval);
 
 	if (q_vector->itr_countdown)
 		q_vector->itr_countdown--;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index 33c0ffc..9690c1e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -114,14 +114,14 @@ struct i40e_q_vector {
 	struct i40evf_adapter *adapter;
 	struct i40e_vsi *vsi;
 	struct napi_struct napi;
-	unsigned long reg_idx;
 	struct i40e_ring_container rx;
 	struct i40e_ring_container tx;
 	u32 ring_mask;
 	u8 num_ringpairs;	/* total number of ring pairs in vector */
 #define ITR_COUNTDOWN_START 100
 	u8 itr_countdown;	/* when 0 or 1 update ITR */
-	int v_idx;	/* vector index in list */
+	u16 v_idx;		/* index in the vsi->q_vector array. */
+	u16 reg_idx;		/* register index of the interrupt */
 	char name[IFNAMSIZ + 15];
 	bool arm_wb_state;
 	cpumask_t affinity_mask;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index d59bf06..16989ad 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1387,6 +1387,7 @@ static int i40evf_alloc_q_vectors(struct i40evf_adapter *adapter)
 		q_vector->adapter = adapter;
 		q_vector->vsi = &adapter->vsi;
 		q_vector->v_idx = q_idx;
+		q_vector->reg_idx = q_idx;
 		cpumask_copy(&q_vector->affinity_mask, cpu_possible_mask);
 		netif_napi_add(adapter->netdev, &q_vector->napi,
 			       i40evf_napi_poll, NAPI_POLL_WEIGHT);
-- 
2.9.5

