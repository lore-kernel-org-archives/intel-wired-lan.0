From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 24 Mar 2022 12:49:07 +0100
Subject: [Intel-wired-lan] [PATCH intel-next] ice: introduce common helper
 for retrieving VSI by vsi_num
Message-ID: <20220324114907.73459-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Both ice_idc.c and ice_virtchnl.c carry their own implementation of a
helper function that is looking for a given VSI based on provided
vsi_num. Their functionality is the same, so let's introduce the common
function in ice.h that both of the mentioned sites will use.

This is a strictly cleanup thing, no functionality is changed.

Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          | 15 +++++++++++++
 drivers/net/ethernet/intel/ice/ice_idc.c      | 15 -------------
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 22 ++-----------------
 3 files changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index e9aa1fb43c3a..a541446b96e8 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -756,6 +756,21 @@ static inline struct ice_vsi *ice_get_ctrl_vsi(struct ice_pf *pf)
 	return pf->vsi[pf->ctrl_vsi_idx];
 }
 
+/**
+ * ice_find_vsi - Find the VSI from VSI ID
+ * @pf: The PF pointer to search in
+ * @vsi_num: The VSI ID to search for
+ */
+static inline struct ice_vsi *ice_find_vsi(struct ice_pf *pf, u16 vsi_num)
+{
+	int i;
+
+	ice_for_each_vsi(pf, i)
+		if (pf->vsi[i] && pf->vsi[i]->vsi_num == vsi_num)
+			return  pf->vsi[i];
+	return NULL;
+}
+
 /**
  * ice_is_switchdev_running - check if switchdev is configured
  * @pf: pointer to PF structure
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 73aa520317d4..56e03d0e319f 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -44,21 +44,6 @@ void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_event *event)
 	device_unlock(&pf->adev->dev);
 }
 
-/**
- * ice_find_vsi - Find the VSI from VSI ID
- * @pf: The PF pointer to search in
- * @vsi_num: The VSI ID to search for
- */
-static struct ice_vsi *ice_find_vsi(struct ice_pf *pf, u16 vsi_num)
-{
-	int i;
-
-	ice_for_each_vsi(pf, i)
-		if (pf->vsi[i] && pf->vsi[i]->vsi_num == vsi_num)
-			return  pf->vsi[i];
-	return NULL;
-}
-
 /**
  * ice_add_rdma_qset - Add Leaf Node for RDMA Qset
  * @pf: PF struct
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 3f1a63815bac..8ddb462e1af2 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -514,24 +514,6 @@ static void ice_vc_reset_vf_msg(struct ice_vf *vf)
 		ice_reset_vf(vf, 0);
 }
 
-/**
- * ice_find_vsi_from_id
- * @pf: the PF structure to search for the VSI
- * @id: ID of the VSI it is searching for
- *
- * searches for the VSI with the given ID
- */
-static struct ice_vsi *ice_find_vsi_from_id(struct ice_pf *pf, u16 id)
-{
-	int i;
-
-	ice_for_each_vsi(pf, i)
-		if (pf->vsi[i] && pf->vsi[i]->vsi_num == id)
-			return pf->vsi[i];
-
-	return NULL;
-}
-
 /**
  * ice_vc_isvalid_vsi_id
  * @vf: pointer to the VF info
@@ -544,7 +526,7 @@ bool ice_vc_isvalid_vsi_id(struct ice_vf *vf, u16 vsi_id)
 	struct ice_pf *pf = vf->pf;
 	struct ice_vsi *vsi;
 
-	vsi = ice_find_vsi_from_id(pf, vsi_id);
+	vsi = ice_find_vsi(pf, vsi_id);
 
 	return (vsi && (vsi->vf == vf));
 }
@@ -559,7 +541,7 @@ bool ice_vc_isvalid_vsi_id(struct ice_vf *vf, u16 vsi_id)
  */
 static bool ice_vc_isvalid_q_id(struct ice_vf *vf, u16 vsi_id, u8 qid)
 {
-	struct ice_vsi *vsi = ice_find_vsi_from_id(vf->pf, vsi_id);
+	struct ice_vsi *vsi = ice_find_vsi(vf->pf, vsi_id);
 	/* allocated Tx and Rx queues should be always equal for VF VSI */
 	return (vsi && (qid < vsi->alloc_txq));
 }
-- 
2.27.0

