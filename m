From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Dec 2017 08:51:20 -0500
Subject: [Intel-wired-lan] [next PATCH S85-V1 12/14] i40evf: Correctly
 populate rxitr_idx and txitr_idx
Message-ID: <20171229135120.14693-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

While testing code for the recent ITR changes I found that updating the Tx
ITR appeared to have no effect with everything defaulting to the Rx ITR. A
bit of digging narrowed it down the fact that we were asking the PF to
associate all causes with ITR 0 as we weren't populating the itr_idx values
for either Rx or Tx.

To correct it I have added the configuration for these values to this
patch. In addition I did some minor clean-up to just add a local pointer
for the vector map instead of dereferencing it based off of the index
repeatedly. In my opinion this makes the resultant code a bit more readable
and saves us a few characters.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 24 ++++++++++++++--------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index feb95b6..09b198e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -344,6 +344,7 @@ void i40evf_disable_queues(struct i40evf_adapter *adapter)
 void i40evf_map_queues(struct i40evf_adapter *adapter)
 {
 	struct virtchnl_irq_map_info *vimi;
+	struct virtchnl_vector_map *vecmap;
 	int v_idx, q_vectors, len;
 	struct i40e_q_vector *q_vector;
 
@@ -367,17 +368,22 @@ void i40evf_map_queues(struct i40evf_adapter *adapter)
 	vimi->num_vectors = adapter->num_msix_vectors;
 	/* Queue vectors first */
 	for (v_idx = 0; v_idx < q_vectors; v_idx++) {
-		q_vector = adapter->q_vectors + v_idx;
-		vimi->vecmap[v_idx].vsi_id = adapter->vsi_res->vsi_id;
-		vimi->vecmap[v_idx].vector_id = v_idx + NONQ_VECS;
-		vimi->vecmap[v_idx].txq_map = q_vector->ring_mask;
-		vimi->vecmap[v_idx].rxq_map = q_vector->ring_mask;
+		q_vector = &adapter->q_vectors[v_idx];
+		vecmap = &vimi->vecmap[v_idx];
+
+		vecmap->vsi_id = adapter->vsi_res->vsi_id;
+		vecmap->vector_id = v_idx + NONQ_VECS;
+		vecmap->txq_map = q_vector->ring_mask;
+		vecmap->rxq_map = q_vector->ring_mask;
+		vecmap->rxitr_idx = I40E_RX_ITR;
+		vecmap->txitr_idx = I40E_TX_ITR;
 	}
 	/* Misc vector last - this is only for AdminQ messages */
-	vimi->vecmap[v_idx].vsi_id = adapter->vsi_res->vsi_id;
-	vimi->vecmap[v_idx].vector_id = 0;
-	vimi->vecmap[v_idx].txq_map = 0;
-	vimi->vecmap[v_idx].rxq_map = 0;
+	vecmap = &vimi->vecmap[v_idx];
+	vecmap->vsi_id = adapter->vsi_res->vsi_id;
+	vecmap->vector_id = 0;
+	vecmap->txq_map = 0;
+	vecmap->rxq_map = 0;
 
 	adapter->aq_required &= ~I40EVF_FLAG_AQ_MAP_VECTORS;
 	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_IRQ_MAP,
-- 
2.9.5

