From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:55:05 -0700
Subject: [Intel-wired-lan] [PATCH S46 8/9] ice: fix aRFS after flow director
 delete
In-Reply-To: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
References: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516005506.5113-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Henry Tieman <henry.w.tieman@intel.com>

The logic was missing for adding back perfect flows after flow director
filter delete. The code now adds perfect flows into the HW tables after
filter delete.

Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
---
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index 22cc4167b974..b92017b8ae4a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -1363,6 +1363,31 @@ void ice_vsi_manage_fdir(struct ice_vsi *vsi, bool ena)
 	mutex_unlock(&hw->fdir_fltr_lock);
 }
 
+/**
+ * ice_fdir_do_rem_flow - delete flow and possibly add perfect flow
+ * @pf: PF structure
+ * @flow_type: FDir flow type to release
+ */
+static void
+ice_fdir_do_rem_flow(struct ice_pf *pf, enum ice_fltr_ptype flow_type)
+{
+	struct ice_hw *hw = &pf->hw;
+	bool need_perfect = false;
+
+	if (flow_type == ICE_FLTR_PTYPE_NONF_IPV4_TCP ||
+	    flow_type == ICE_FLTR_PTYPE_NONF_IPV4_UDP ||
+	    flow_type == ICE_FLTR_PTYPE_NONF_IPV6_TCP ||
+	    flow_type == ICE_FLTR_PTYPE_NONF_IPV6_UDP)
+		need_perfect = true;
+
+	if (need_perfect && test_bit(flow_type, hw->fdir_perfect_fltr))
+		return;
+
+	ice_fdir_rem_flow(hw, ICE_BLK_FD, flow_type);
+	if (need_perfect)
+		ice_create_init_fdir_rule(pf, flow_type);
+}
+
 /**
  * ice_fdir_update_list_entry - add or delete a filter from the filter list
  * @pf: PF structure
@@ -1393,7 +1418,7 @@ ice_fdir_update_list_entry(struct ice_pf *pf, struct ice_fdir_fltr *input,
 			/* we just deleted the last filter of flow_type so we
 			 * should also delete the HW filter info.
 			 */
-			ice_fdir_rem_flow(hw, ICE_BLK_FD, old_fltr->flow_type);
+			ice_fdir_do_rem_flow(pf, old_fltr->flow_type);
 		list_del(&old_fltr->fltr_node);
 		devm_kfree(ice_hw_to_dev(hw), old_fltr);
 	}
-- 
2.20.1

