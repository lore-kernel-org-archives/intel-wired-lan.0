From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Dec 2018 10:03:28 -0800
Subject: [Intel-wired-lan] [PATCH S10 09/15] ice: Move aggregator list into
 ice_hw instance
In-Reply-To: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181219180334.1104-10-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The aggregator list needs to be preserved for use after a reset. This
patch moves it out of the port_info instance and into the ice_hw instance.

Signed-off-by: Tarun Singh <tarun.k.singh@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  2 ++
 drivers/net/ethernet/intel/ice/ice_sched.c  | 34 ++++++++++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_sched.h  |  2 ++
 drivers/net/ethernet/intel/ice/ice_type.h   |  2 +-
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2bcd8230d35e..19695749f903 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -750,6 +750,7 @@ enum ice_status ice_init_hw(struct ice_hw *hw)
 		status = ICE_ERR_CFG;
 		goto err_unroll_sched;
 	}
+	INIT_LIST_HEAD(&hw->agg_list);
 
 	status = ice_init_fltr_mgmt_struct(hw);
 	if (status)
@@ -800,6 +801,7 @@ void ice_deinit_hw(struct ice_hw *hw)
 	ice_cleanup_fltr_mgmt_struct(hw);
 
 	ice_sched_cleanup_all(hw);
+	ice_sched_clear_agg(hw);
 
 	if (hw->port_info) {
 		devm_kfree(ice_hw_to_dev(hw), hw->port_info);
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 99d51990bd54..8091179362d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -561,23 +561,18 @@ ice_sched_suspend_resume_elems(struct ice_hw *hw, u8 num_nodes, u32 *node_teids,
 }
 
 /**
- * ice_sched_clear_tx_topo - clears the schduler tree nodes
- * @pi: port information structure
+ * ice_sched_clear_agg - clears the agg related information
+ * @hw: pointer to the hardware structure
  *
- * This function removes all the nodes from HW as well as from SW DB.
+ * This function removes agg list and free up agg related memory
+ * previously allocated.
  */
-static void ice_sched_clear_tx_topo(struct ice_port_info *pi)
+void ice_sched_clear_agg(struct ice_hw *hw)
 {
 	struct ice_sched_agg_info *agg_info;
 	struct ice_sched_agg_info *atmp;
-	struct ice_hw *hw;
 
-	if (!pi)
-		return;
-
-	hw = pi->hw;
-
-	list_for_each_entry_safe(agg_info, atmp, &pi->agg_list, list_entry) {
+	list_for_each_entry_safe(agg_info, atmp, &hw->agg_list, list_entry) {
 		struct ice_sched_agg_vsi_info *agg_vsi_info;
 		struct ice_sched_agg_vsi_info *vtmp;
 
@@ -586,8 +581,21 @@ static void ice_sched_clear_tx_topo(struct ice_port_info *pi)
 			list_del(&agg_vsi_info->list_entry);
 			devm_kfree(ice_hw_to_dev(hw), agg_vsi_info);
 		}
+		list_del(&agg_info->list_entry);
+		devm_kfree(ice_hw_to_dev(hw), agg_info);
 	}
+}
 
+/**
+ * ice_sched_clear_tx_topo - clears the schduler tree nodes
+ * @pi: port information structure
+ *
+ * This function removes all the nodes from HW as well as from SW DB.
+ */
+static void ice_sched_clear_tx_topo(struct ice_port_info *pi)
+{
+	if (!pi)
+		return;
 	if (pi->root) {
 		ice_free_sched_node(pi, pi->root);
 		pi->root = NULL;
@@ -1005,7 +1013,6 @@ enum ice_status ice_sched_init_port(struct ice_port_info *pi)
 	/* initialize the port for handling the scheduler tree */
 	pi->port_state = ICE_SCHED_PORT_STATE_READY;
 	mutex_init(&pi->sched_lock);
-	INIT_LIST_HEAD(&pi->agg_list);
 
 err_init_port:
 	if (status && pi->root) {
@@ -1588,7 +1595,8 @@ ice_sched_rm_agg_vsi_info(struct ice_port_info *pi, u16 vsi_handle)
 	struct ice_sched_agg_info *agg_info;
 	struct ice_sched_agg_info *atmp;
 
-	list_for_each_entry_safe(agg_info, atmp, &pi->agg_list, list_entry) {
+	list_for_each_entry_safe(agg_info, atmp, &pi->hw->agg_list,
+				 list_entry) {
 		struct ice_sched_agg_vsi_info *agg_vsi_info;
 		struct ice_sched_agg_vsi_info *vtmp;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.h b/drivers/net/ethernet/intel/ice/ice_sched.h
index da5b4c166da8..bee8221ad146 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.h
+++ b/drivers/net/ethernet/intel/ice/ice_sched.h
@@ -28,6 +28,8 @@ enum ice_status ice_sched_init_port(struct ice_port_info *pi);
 enum ice_status ice_sched_query_res_alloc(struct ice_hw *hw);
 void ice_sched_clear_port(struct ice_port_info *pi);
 void ice_sched_cleanup_all(struct ice_hw *hw);
+void ice_sched_clear_agg(struct ice_hw *hw);
+
 struct ice_sched_node *
 ice_sched_find_node_by_teid(struct ice_sched_node *start_node, u32 teid);
 enum ice_status
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 0ea428104215..a078e2c98871 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -272,7 +272,6 @@ struct ice_port_info {
 	struct ice_mac_info mac;
 	struct ice_phy_info phy;
 	struct mutex sched_lock;	/* protect access to TXSched tree */
-	struct list_head agg_list;	/* lists all aggregator */
 	u8 lport;
 #define ICE_LPORT_MASK		0xff
 	u8 is_vf;
@@ -326,6 +325,7 @@ struct ice_hw {
 	u8 max_cgds;
 	u8 sw_entry_point_layer;
 	u16 max_children[ICE_AQC_TOPO_MAX_LEVEL_NUM];
+	struct list_head agg_list;	/* lists all aggregator */
 
 	struct ice_vsi_ctx *vsi_ctx[ICE_MAX_VSI];
 	u8 evb_veb;		/* true for VEB, false for VEPA */
-- 
2.14.5

