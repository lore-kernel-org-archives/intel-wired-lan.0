From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:51:01 -0800
Subject: [Intel-wired-lan] [PATCH S12 14/14] ice: Fix issue reclaiming
 resources back to the pool after reset
In-Reply-To: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205101.12078-15-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

This patch fixes issue reclaiming VF resources back to the pool after
reset - Since we only allocate HW vector for all VFs and track together
with resources allocation for PF with ice_search_res, we need to free VFs
resources separately, using first VF vector index to traverse the list.
Otherwise tracker starts from the last assigned vectors list and causes
maximum supported number of HW vectors, 1024 to be exhausted, depending on
the number of VFs enabled, which causes a lot of unwanted issues, and
failed to reassign vectors for VFs.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d528640fc5b1..af72bb4f8f6f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2681,6 +2681,7 @@ int ice_vsi_release(struct ice_vsi *vsi)
 int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 {
 	u16 max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
+	struct ice_vf *vf = NULL;
 	struct ice_pf *pf;
 	int ret, i;
 
@@ -2688,12 +2689,31 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 		return -EINVAL;
 
 	pf = vsi->back;
+	if (vsi->type == ICE_VSI_VF)
+		vf = &pf->vf[vsi->vf_id];
+
 	ice_rm_vsi_lan_cfg(vsi->port_info, vsi->idx);
 	ice_vsi_free_q_vectors(vsi);
-	ice_free_res(vsi->back->sw_irq_tracker, vsi->sw_base_vector, vsi->idx);
-	ice_free_res(vsi->back->hw_irq_tracker, vsi->hw_base_vector, vsi->idx);
-	vsi->sw_base_vector = 0;
+
+	if (vsi->type != ICE_VSI_VF) {
+		/* reclaim SW interrupts back to the common pool */
+		ice_free_res(pf->sw_irq_tracker, vsi->sw_base_vector, vsi->idx);
+		pf->num_avail_sw_msix += vsi->num_q_vectors;
+		vsi->sw_base_vector = 0;
+		/* reclaim HW interrupts back to the common pool */
+		ice_free_res(pf->hw_irq_tracker, vsi->hw_base_vector,
+			     vsi->idx);
+		pf->num_avail_hw_msix += vsi->num_q_vectors;
+	} else {
+		/* Reclaim VF resources back to the common pool for reset and
+		 * and rebuild, with vector reassignment
+		 */
+		ice_free_res(pf->hw_irq_tracker, vf->first_vector_idx,
+			     vsi->idx);
+		pf->num_avail_hw_msix += pf->num_vf_msix;
+	}
 	vsi->hw_base_vector = 0;
+
 	ice_vsi_clear_rings(vsi);
 	ice_vsi_free_arrays(vsi, false);
 	ice_dev_onetime_setup(&vsi->back->hw);
-- 
2.14.5

