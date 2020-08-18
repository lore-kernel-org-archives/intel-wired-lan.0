From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 17 Aug 2020 17:25:03 -0700
Subject: [Intel-wired-lan] [PATCH] ice: remove repeated words
Message-ID: <20200818002503.44781-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

A new test in checkpatch detects repeated words; cleanup all pre-existing
occurrences of those now.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c   | 2 +-
 drivers/net/ethernet/intel/ice/ice_flow.c        | 4 ++--
 drivers/net/ethernet/intel/ice/ice_main.c        | 2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index ac448d223e9a..9095b4d274ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -4876,7 +4876,7 @@ ice_rem_prof_id_flow(struct ice_hw *hw, enum ice_block blk, u16 vsi, u64 hdl)
 
 			if (last_profile) {
 				/* If there are no profiles left for this VSIG,
-				 * then simply remove the the VSIG.
+				 * then simply remove the VSIG.
 				 */
 				status = ice_rem_vsig(hw, blk, vsig, &chg);
 				if (status)
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index fe677621dd51..45fa3d9e3af2 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -385,7 +385,7 @@ ice_flow_xtract_fld(struct ice_hw *hw, struct ice_flow_prof_params *params,
  * ice_flow_xtract_raws - Create extract sequence entries for raw bytes
  * @hw: pointer to the HW struct
  * @params: information about the flow to be processed
- * @seg: index of packet segment whose raw fields are to be be extracted
+ * @seg: index of packet segment whose raw fields are to be extracted
  */
 static enum ice_status
 ice_flow_xtract_raws(struct ice_hw *hw, struct ice_flow_prof_params *params,
@@ -999,7 +999,7 @@ enum ice_status ice_flow_rem_entry(struct ice_hw *hw, enum ice_block blk,
  *
  * This helper function stores information of a field being matched, including
  * the type of the field and the locations of the value to match, the mask, and
- * and the upper-bound value in the start of the input buffer for a flow entry.
+ * the upper-bound value in the start of the input buffer for a flow entry.
  * This function should only be used for fixed-size data structures.
  *
  * This function also opportunistically determines the protocol headers to be
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4d79e5c1d6e6..6b6e982e2658 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2417,7 +2417,7 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi)
 	int i, v_idx;
 
 	/* q_vectors are freed in reset path so there's no point in detaching
-	 * rings; in case of rebuild being triggered not from reset reset bits
+	 * rings; in case of rebuild being triggered not from reset bits
 	 * in pf->state won't be set, so additionally check first q_vector
 	 * against NULL
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index bce35ba997a8..c8b2705a8aed 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -872,7 +872,7 @@ static int ice_get_max_valid_res_idx(struct ice_res_tracker *res)
  * always be caught by ice_set_per_vf_res().
  *
  * Return 0 on success, and -EINVAL when there are not enough MSIX vectors in
- * in the PF's space available for SR-IOV.
+ * the PF's space available for SR-IOV.
  */
 static int ice_sriov_set_msix_res(struct ice_pf *pf, u16 num_msix_needed)
 {
-- 
2.20.1

