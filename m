From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 29 Jul 2020 17:19:12 -0700
Subject: [Intel-wired-lan] [PATCH S51 03/13] ice: Fix RSS profile locks
In-Reply-To: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
Message-ID: <20200730001922.52568-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vignesh Sridhar <vignesh.sridhar@intel.com>

Replacing flow profile locks with RSS profile locks in the function to
remove all RSS rules for a given VSI. This is to align the locks used
for RSS rule addition to VSI and removal during VSI teardown to avoid
a race condition owing to several iterations of the above operations.
In function to get RSS rules for given VSI and protocol header replacing
the pointer reference of the RSS entry with a copy of hash value to
ensure thread safety.

Signed-off-by: Vignesh Sridhar <vignesh.sridhar@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flow.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index d74e5290677f..fe677621dd51 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -1187,7 +1187,7 @@ enum ice_status ice_rem_vsi_rss_cfg(struct ice_hw *hw, u16 vsi_handle)
 	if (list_empty(&hw->fl_profs[blk]))
 		return 0;
 
-	mutex_lock(&hw->fl_profs_locks[blk]);
+	mutex_lock(&hw->rss_locks);
 	list_for_each_entry_safe(p, t, &hw->fl_profs[blk], l_entry)
 		if (test_bit(vsi_handle, p->vsis)) {
 			status = ice_flow_disassoc_prof(hw, blk, p, vsi_handle);
@@ -1195,12 +1195,12 @@ enum ice_status ice_rem_vsi_rss_cfg(struct ice_hw *hw, u16 vsi_handle)
 				break;
 
 			if (bitmap_empty(p->vsis, ICE_MAX_VSI)) {
-				status = ice_flow_rem_prof_sync(hw, blk, p);
+				status = ice_flow_rem_prof(hw, blk, p->id);
 				if (status)
 					break;
 			}
 		}
-	mutex_unlock(&hw->fl_profs_locks[blk]);
+	mutex_unlock(&hw->rss_locks);
 
 	return status;
 }
@@ -1597,7 +1597,8 @@ enum ice_status ice_replay_rss_cfg(struct ice_hw *hw, u16 vsi_handle)
  */
 u64 ice_get_rss_cfg(struct ice_hw *hw, u16 vsi_handle, u32 hdrs)
 {
-	struct ice_rss_cfg *r, *rss_cfg = NULL;
+	u64 rss_hash = ICE_HASH_INVALID;
+	struct ice_rss_cfg *r;
 
 	/* verify if the protocol header is non zero and VSI is valid */
 	if (hdrs == ICE_FLOW_SEG_HDR_NONE || !ice_is_vsi_valid(hw, vsi_handle))
@@ -1607,10 +1608,10 @@ u64 ice_get_rss_cfg(struct ice_hw *hw, u16 vsi_handle, u32 hdrs)
 	list_for_each_entry(r, &hw->rss_list_head, l_entry)
 		if (test_bit(vsi_handle, r->vsis) &&
 		    r->packet_hdr == hdrs) {
-			rss_cfg = r;
+			rss_hash = r->hashed_flds;
 			break;
 		}
 	mutex_unlock(&hw->rss_locks);
 
-	return rss_cfg ? rss_cfg->hashed_flds : ICE_HASH_INVALID;
+	return rss_hash;
 }
-- 
2.20.1

