From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 14 Sep 2020 08:37:14 -0700
Subject: [Intel-wired-lan] [PATCH S52 1/7] ice: cleanup stack hog
Message-ID: <20200914153720.48498-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

In ice_flow_add_prof_sync(), struct ice_flow_prof_params has recently
grown in size hogging stack space when allocated there.  Hogging stack
space should be avoided.  Change allocation to be on the heap when needed.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flow.c | 44 +++++++++++++----------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index eadc85aee389..2a92071bd7d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -708,37 +708,42 @@ ice_flow_add_prof_sync(struct ice_hw *hw, enum ice_block blk,
 		       struct ice_flow_seg_info *segs, u8 segs_cnt,
 		       struct ice_flow_prof **prof)
 {
-	struct ice_flow_prof_params params;
+	struct ice_flow_prof_params *params;
 	enum ice_status status;
 	u8 i;
 
 	if (!prof)
 		return ICE_ERR_BAD_PTR;
 
-	memset(&params, 0, sizeof(params));
-	params.prof = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*params.prof),
-				   GFP_KERNEL);
-	if (!params.prof)
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
 		return ICE_ERR_NO_MEMORY;
 
+	params->prof = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*params->prof),
+				    GFP_KERNEL);
+	if (!params->prof) {
+		status = ICE_ERR_NO_MEMORY;
+		goto free_params;
+	}
+
 	/* initialize extraction sequence to all invalid (0xff) */
 	for (i = 0; i < ICE_MAX_FV_WORDS; i++) {
-		params.es[i].prot_id = ICE_PROT_INVALID;
-		params.es[i].off = ICE_FV_OFFSET_INVAL;
+		params->es[i].prot_id = ICE_PROT_INVALID;
+		params->es[i].off = ICE_FV_OFFSET_INVAL;
 	}
 
-	params.blk = blk;
-	params.prof->id = prof_id;
-	params.prof->dir = dir;
-	params.prof->segs_cnt = segs_cnt;
+	params->blk = blk;
+	params->prof->id = prof_id;
+	params->prof->dir = dir;
+	params->prof->segs_cnt = segs_cnt;
 
 	/* Make a copy of the segments that need to be persistent in the flow
 	 * profile instance
 	 */
 	for (i = 0; i < segs_cnt; i++)
-		memcpy(&params.prof->segs[i], &segs[i], sizeof(*segs));
+		memcpy(&params->prof->segs[i], &segs[i], sizeof(*segs));
 
-	status = ice_flow_proc_segs(hw, &params);
+	status = ice_flow_proc_segs(hw, params);
 	if (status) {
 		ice_debug(hw, ICE_DBG_FLOW,
 			  "Error processing a flow's packet segments\n");
@@ -746,19 +751,22 @@ ice_flow_add_prof_sync(struct ice_hw *hw, enum ice_block blk,
 	}
 
 	/* Add a HW profile for this flow profile */
-	status = ice_add_prof(hw, blk, prof_id, (u8 *)params.ptypes, params.es);
+	status = ice_add_prof(hw, blk, prof_id, (u8 *)params->ptypes,
+			      params->es);
 	if (status) {
 		ice_debug(hw, ICE_DBG_FLOW, "Error adding a HW flow profile\n");
 		goto out;
 	}
 
-	INIT_LIST_HEAD(&params.prof->entries);
-	mutex_init(&params.prof->entries_lock);
-	*prof = params.prof;
+	INIT_LIST_HEAD(&params->prof->entries);
+	mutex_init(&params->prof->entries_lock);
+	*prof = params->prof;
 
 out:
 	if (status)
-		devm_kfree(ice_hw_to_dev(hw), params.prof);
+		devm_kfree(ice_hw_to_dev(hw), params->prof);
+free_params:
+	kfree(params);
 
 	return status;
 }
-- 
2.20.1

