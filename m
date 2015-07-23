From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 23 Jul 2015 16:54:41 -0400
Subject: [Intel-wired-lan] [next PATCH S9 12/15] i40e: refactor interrupt
	enable
In-Reply-To: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1437684884-222825-13-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The interrupt enable function was always making the caller add
the base_vector from the vsi struct which is already passed to
the function. Just collapse the math into the helper function.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I54ef33aa7ceebc3231c3cc48f7b39fd0c3ff5806
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  6 ++----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 464fba3..1681e7f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2960,7 +2960,7 @@ void i40e_irq_dynamic_enable_icr0(struct i40e_pf *pf)
 /**
  * i40e_irq_dynamic_enable - Enable default interrupt generation settings
  * @vsi: pointer to a vsi
- * @vector: enable a particular Hw Interrupt vector
+ * @vector: enable a particular Hw Interrupt vector, without base_vector
  **/
 void i40e_irq_dynamic_enable(struct i40e_vsi *vsi, int vector)
 {
@@ -2971,7 +2971,7 @@ void i40e_irq_dynamic_enable(struct i40e_vsi *vsi, int vector)
 	val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
 	      I40E_PFINT_DYN_CTLN_CLEARPBA_MASK |
 	      (I40E_ITR_NONE << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT);
-	wr32(hw, I40E_PFINT_DYN_CTLN(vector - 1), val);
+	wr32(hw, I40E_PFINT_DYN_CTLN(vector + vsi->base_vector - 1), val);
 	/* skip the flush */
 }
 
@@ -3114,8 +3114,7 @@ static int i40e_vsi_enable_irq(struct i40e_vsi *vsi)
 	int i;
 
 	if (pf->flags & I40E_FLAG_MSIX_ENABLED) {
-		for (i = vsi->base_vector;
-		     i < (vsi->num_q_vectors + vsi->base_vector); i++)
+		for (i = 0; i < vsi->num_q_vectors; i++)
 			i40e_irq_dynamic_enable(vsi, i);
 	} else {
 		i40e_irq_dynamic_enable_icr0(pf);
@@ -3347,8 +3346,7 @@ static bool i40e_clean_fdir_tx_irq(struct i40e_ring *tx_ring, int budget)
 	tx_ring->next_to_clean = i;
 
 	if (vsi->back->flags & I40E_FLAG_MSIX_ENABLED) {
-		i40e_irq_dynamic_enable(vsi,
-				tx_ring->q_vector->v_idx + vsi->base_vector);
+		i40e_irq_dynamic_enable(vsi, tx_ring->q_vector->v_idx);
 	}
 	return budget > 0;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 8a3d596..ce3f7cc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1860,8 +1860,7 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 		if (!test_bit(__I40E_DOWN, &vsi->state))
 			wr32(hw, I40E_PFINT_DYN_CTLN(vector - 1), val);
 	} else {
-		i40e_irq_dynamic_enable(vsi,
-					q_vector->v_idx + vsi->base_vector);
+		i40e_irq_dynamic_enable(vsi, q_vector->v_idx);
 	}
 	if (ITR_IS_DYNAMIC(vsi->tx_itr_setting)) {
 		old_itr = q_vector->tx.itr;
@@ -1883,8 +1882,7 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 			wr32(hw, I40E_PFINT_DYN_CTLN(q_vector->v_idx +
 			      vsi->base_vector - 1), val);
 	} else {
-		i40e_irq_dynamic_enable(vsi,
-					q_vector->v_idx + vsi->base_vector);
+		i40e_irq_dynamic_enable(vsi, q_vector->v_idx);
 	}
 }
 
-- 
1.9.3

