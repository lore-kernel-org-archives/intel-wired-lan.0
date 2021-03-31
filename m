From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 31 Mar 2021 14:17:02 -0700
Subject: [Intel-wired-lan] [PATCH S58 07/13] ice: use local for consistency
In-Reply-To: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
Message-ID: <20210331211708.55205-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Do a minor refactor on ice_vsi_rebuild to use a local
variable to store vsi->type.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 4c3a8bdfd71b..4e93005686a4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3037,6 +3037,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 	struct ice_coalesce_stored *coalesce;
 	int prev_num_q_vectors = 0;
 	struct ice_vf *vf = NULL;
+	enum ice_vsi_type vtype;
 	enum ice_status status;
 	struct ice_pf *pf;
 	int ret, i;
@@ -3045,7 +3046,8 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 		return -EINVAL;
 
 	pf = vsi->back;
-	if (vsi->type == ICE_VSI_VF)
+	vtype = vsi->type;
+	if (vtype == ICE_VSI_VF)
 		vf = &pf->vf[vsi->vf_id];
 
 	coalesce = kcalloc(vsi->num_q_vectors,
@@ -3063,7 +3065,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 	 * many interrupts each VF needs. SR-IOV MSIX resources are also
 	 * cleared in the same manner.
 	 */
-	if (vsi->type != ICE_VSI_VF) {
+	if (vtype != ICE_VSI_VF) {
 		/* reclaim SW interrupts back to the common pool */
 		ice_free_res(pf->irq_tracker, vsi->base_vector, vsi->idx);
 		pf->num_avail_sw_msix += vsi->num_q_vectors;
@@ -3078,7 +3080,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 	ice_vsi_put_qs(vsi);
 	ice_vsi_clear_rings(vsi);
 	ice_vsi_free_arrays(vsi);
-	if (vsi->type == ICE_VSI_VF)
+	if (vtype == ICE_VSI_VF)
 		ice_vsi_set_num_qs(vsi, vf->vf_id);
 	else
 		ice_vsi_set_num_qs(vsi, ICE_INVAL_VFID);
@@ -3097,7 +3099,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 	if (ret < 0)
 		goto err_vsi;
 
-	switch (vsi->type) {
+	switch (vtype) {
 	case ICE_VSI_CTRL:
 	case ICE_VSI_PF:
 		ret = ice_vsi_alloc_q_vectors(vsi);
@@ -3124,7 +3126,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 				goto err_vectors;
 		}
 		/* ICE_VSI_CTRL does not need RSS so skip RSS processing */
-		if (vsi->type != ICE_VSI_CTRL)
+		if (vtype != ICE_VSI_CTRL)
 			/* Do not exit if configuring RSS had an issue, at
 			 * least receive traffic on first queue. Hence no
 			 * need to capture return value
-- 
2.20.1

