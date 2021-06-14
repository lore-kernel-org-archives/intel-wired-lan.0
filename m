From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 14 Jun 2021 14:46:06 -0700
Subject: [Intel-wired-lan] [PATCH net-next 1/2] ice: remove the VSI info
 from previous agg
Message-ID: <20210614214607.41749-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Victor Raj <victor.raj@intel.com>

Remove the VSI info from previous aggregator after moving the VSI to a
new aggregator.

Signed-off-by: Victor Raj <victor.raj@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 24 ++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index a17e24e54cf3..9f07b6641705 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -2745,8 +2745,8 @@ static enum ice_status
 ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
 			   u16 vsi_handle, unsigned long *tc_bitmap)
 {
-	struct ice_sched_agg_vsi_info *agg_vsi_info;
-	struct ice_sched_agg_info *agg_info;
+	struct ice_sched_agg_vsi_info *agg_vsi_info, *old_agg_vsi_info = NULL;
+	struct ice_sched_agg_info *agg_info, *old_agg_info;
 	enum ice_status status = 0;
 	struct ice_hw *hw = pi->hw;
 	u8 tc;
@@ -2756,6 +2756,20 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
 	agg_info = ice_get_agg_info(hw, agg_id);
 	if (!agg_info)
 		return ICE_ERR_PARAM;
+	/* If the VSI is already part of another aggregator then update
+	 * its VSI info list
+	 */
+	old_agg_info = ice_get_vsi_agg_info(hw, vsi_handle);
+	if (old_agg_info && old_agg_info != agg_info) {
+		struct ice_sched_agg_vsi_info *vtmp;
+
+		list_for_each_entry_safe(old_agg_vsi_info, vtmp,
+					 &old_agg_info->agg_vsi_list,
+					 list_entry)
+			if (old_agg_vsi_info->vsi_handle == vsi_handle)
+				break;
+	}
+
 	/* check if entry already exist */
 	agg_vsi_info = ice_get_agg_vsi_info(agg_info, vsi_handle);
 	if (!agg_vsi_info) {
@@ -2780,6 +2794,12 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
 			break;
 
 		set_bit(tc, agg_vsi_info->tc_bitmap);
+		if (old_agg_vsi_info)
+			clear_bit(tc, old_agg_vsi_info->tc_bitmap);
+	}
+	if (old_agg_vsi_info && !old_agg_vsi_info->tc_bitmap[0]) {
+		list_del(&old_agg_vsi_info->list_entry);
+		devm_kfree(ice_hw_to_dev(pi->hw), old_agg_vsi_info);
 	}
 	return status;
 }
-- 
2.20.1

