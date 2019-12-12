From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 12 Dec 2019 03:12:57 -0800
Subject: [Intel-wired-lan] [PATCH S35 05/15] ice: Set default value for ITR
 in alloc function
In-Reply-To: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
Message-ID: <20191212111307.33566-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@intel.com>

When the user sets itr_setting to zero from ethtool -C, the driver changes
this value to default in ice_cfg_itr (for example after changing ring
param). Remove code that sets default value in ice_cfg_itr and move it to
place where the driver allocates q_vectors.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 77d6a0291e97..d4559d45288f 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -93,7 +93,8 @@ static int ice_pf_rxq_wait(struct ice_pf *pf, int pf_q, bool ena)
  * @vsi: the VSI being configured
  * @v_idx: index of the vector in the VSI struct
  *
- * We allocate one q_vector. If allocation fails we return -ENOMEM.
+ * We allocate one q_vector and set default value for ITR setting associated
+ * with this q_vector. If allocation fails we return -ENOMEM.
  */
 static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, int v_idx)
 {
@@ -108,6 +109,8 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, int v_idx)
 
 	q_vector->vsi = vsi;
 	q_vector->v_idx = v_idx;
+	q_vector->tx.itr_setting = ICE_DFLT_TX_ITR;
+	q_vector->rx.itr_setting = ICE_DFLT_RX_ITR;
 	if (vsi->type == ICE_VSI_VF)
 		goto out;
 	/* only set affinity_mask if the CPU is online */
@@ -674,10 +677,6 @@ void ice_cfg_itr(struct ice_hw *hw, struct ice_q_vector *q_vector)
 	if (q_vector->num_ring_rx) {
 		struct ice_ring_container *rc = &q_vector->rx;
 
-		/* if this value is set then don't overwrite with default */
-		if (!rc->itr_setting)
-			rc->itr_setting = ICE_DFLT_RX_ITR;
-
 		rc->target_itr = ITR_TO_REG(rc->itr_setting);
 		rc->next_update = jiffies + 1;
 		rc->current_itr = rc->target_itr;
@@ -688,10 +687,6 @@ void ice_cfg_itr(struct ice_hw *hw, struct ice_q_vector *q_vector)
 	if (q_vector->num_ring_tx) {
 		struct ice_ring_container *rc = &q_vector->tx;
 
-		/* if this value is set then don't overwrite with default */
-		if (!rc->itr_setting)
-			rc->itr_setting = ICE_DFLT_TX_ITR;
-
 		rc->target_itr = ITR_TO_REG(rc->itr_setting);
 		rc->next_update = jiffies + 1;
 		rc->current_itr = rc->target_itr;
-- 
2.20.1

