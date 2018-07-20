From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 20 Jul 2018 13:53:41 -0700
Subject: [Intel-wired-lan] [RFC 01/13] ice: Minor updates to Tx scheduler
 code
In-Reply-To: <20180720205353.13296-1-anirudh.venkataramanan@intel.com>
References: <20180720205353.13296-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180720205353.13296-2-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

1) The maximum device nodes is a global value and shared by the whole
   device. Add element AQ command would fail if there is no space to
   add new nodes so the check for max nodes isn't required. So remove
   ice_sched_get_num_nodes_per_layer and ice_sched_val_max_nodes.

2) In ice_sched_add_elems, set default node's CIR/EIR bandwidth weight.

3) Fix default scheduler topology buffer size as the firmware expects
   a 4KB buffer at all times, and will error out if one of any other
   size is provided.

4) Fix some newline/whitespace issues for consistency.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 117 ++++++-----------------------
 drivers/net/ethernet/intel/ice/ice_type.h  |   1 +
 2 files changed, 25 insertions(+), 93 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 2e6c1d92cc88..c7ad6a8ab362 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -192,14 +192,17 @@ ice_sched_remove_elems(struct ice_hw *hw, struct ice_sched_node *parent,
 	buf = devm_kzalloc(ice_hw_to_dev(hw), buf_size, GFP_KERNEL);
 	if (!buf)
 		return ICE_ERR_NO_MEMORY;
+
 	buf->hdr.parent_teid = parent->info.node_teid;
 	buf->hdr.num_elems = cpu_to_le16(num_nodes);
 	for (i = 0; i < num_nodes; i++)
 		buf->teid[i] = cpu_to_le32(node_teids[i]);
+
 	status = ice_aq_delete_sched_elems(hw, 1, buf, buf_size,
 					   &num_groups_removed, NULL);
 	if (status || num_groups_removed != 1)
 		ice_debug(hw, ICE_DBG_SCHED, "remove elements failed\n");
+
 	devm_kfree(ice_hw_to_dev(hw), buf);
 	return status;
 }
@@ -592,13 +595,16 @@ static void ice_sched_clear_port(struct ice_port_info *pi)
  */
 void ice_sched_cleanup_all(struct ice_hw *hw)
 {
-	if (!hw || !hw->port_info)
+	if (!hw)
 		return;
 
-	if (hw->layer_info)
+	if (hw->layer_info) {
 		devm_kfree(ice_hw_to_dev(hw), hw->layer_info);
+		hw->layer_info = NULL;
+	}
 
-	ice_sched_clear_port(hw->port_info);
+	if (hw->port_info)
+		ice_sched_clear_port(hw->port_info);
 
 	hw->num_tx_sched_layers = 0;
 	hw->num_tx_sched_phys_layers = 0;
@@ -671,9 +677,13 @@ ice_sched_add_elems(struct ice_port_info *pi, struct ice_sched_node *tc_node,
 			ICE_AQC_ELEM_VALID_EIR;
 		buf->generic[i].data.generic = 0;
 		buf->generic[i].data.cir_bw.bw_profile_idx =
-			ICE_SCHED_DFLT_RL_PROF_ID;
+			cpu_to_le16(ICE_SCHED_DFLT_RL_PROF_ID);
+		buf->generic[i].data.cir_bw.bw_alloc =
+			cpu_to_le16(ICE_SCHED_DFLT_BW_WT);
 		buf->generic[i].data.eir_bw.bw_profile_idx =
-			ICE_SCHED_DFLT_RL_PROF_ID;
+			cpu_to_le16(ICE_SCHED_DFLT_RL_PROF_ID);
+		buf->generic[i].data.eir_bw.bw_alloc =
+			cpu_to_le16(ICE_SCHED_DFLT_BW_WT);
 	}
 
 	status = ice_aq_add_sched_elems(hw, 1, buf, buf_size,
@@ -697,7 +707,6 @@ ice_sched_add_elems(struct ice_port_info *pi, struct ice_sched_node *tc_node,
 
 		teid = le32_to_cpu(buf->generic[i].node_teid);
 		new_node = ice_sched_find_node_by_teid(parent, teid);
-
 		if (!new_node) {
 			ice_debug(hw, ICE_DBG_SCHED,
 				  "Node is missing for teid =%d\n", teid);
@@ -710,7 +719,6 @@ ice_sched_add_elems(struct ice_port_info *pi, struct ice_sched_node *tc_node,
 		/* add it to previous node sibling pointer */
 		/* Note: siblings are not linked across branches */
 		prev = ice_sched_get_first_node(hw, tc_node, layer);
-
 		if (prev && prev != new_node) {
 			while (prev->sibling)
 				prev = prev->sibling;
@@ -850,78 +858,6 @@ static u8 ice_sched_get_vsi_layer(struct ice_hw *hw)
 	return hw->sw_entry_point_layer;
 }
 
-/**
- * ice_sched_get_num_nodes_per_layer - Get the total number of nodes per layer
- * @pi: pointer to the port info struct
- * @layer: layer number
- *
- * This function calculates the number of nodes present in the scheduler tree
- * including all the branches for a given layer
- */
-static u16
-ice_sched_get_num_nodes_per_layer(struct ice_port_info *pi, u8 layer)
-{
-	struct ice_hw *hw;
-	u16 num_nodes = 0;
-	u8 i;
-
-	if (!pi)
-		return num_nodes;
-
-	hw = pi->hw;
-
-	/* Calculate the number of nodes for all TCs */
-	for (i = 0; i < pi->root->num_children; i++) {
-		struct ice_sched_node *tc_node, *node;
-
-		tc_node = pi->root->children[i];
-
-		/* Get the first node */
-		node = ice_sched_get_first_node(hw, tc_node, layer);
-		if (!node)
-			continue;
-
-		/* count the siblings */
-		while (node) {
-			num_nodes++;
-			node = node->sibling;
-		}
-	}
-
-	return num_nodes;
-}
-
-/**
- * ice_sched_val_max_nodes - check max number of nodes reached or not
- * @pi: port information structure
- * @new_num_nodes_per_layer: pointer to the new number of nodes array
- *
- * This function checks whether the scheduler tree layers have enough space to
- * add new nodes
- */
-static enum ice_status
-ice_sched_validate_for_max_nodes(struct ice_port_info *pi,
-				 u16 *new_num_nodes_per_layer)
-{
-	struct ice_hw *hw = pi->hw;
-	u8 i, qg_layer;
-	u16 num_nodes;
-
-	qg_layer = ice_sched_get_qgrp_layer(hw);
-
-	/* walk through all the layers from SW entry point to qgroup layer */
-	for (i = hw->sw_entry_point_layer; i <= qg_layer; i++) {
-		num_nodes = ice_sched_get_num_nodes_per_layer(pi, i);
-		if (num_nodes + new_num_nodes_per_layer[i] >
-		    le16_to_cpu(hw->layer_info[i].max_pf_nodes)) {
-			ice_debug(hw, ICE_DBG_SCHED,
-				  "max nodes reached for layer = %d\n", i);
-			return ICE_ERR_CFG;
-		}
-	}
-	return 0;
-}
-
 /**
  * ice_rm_dflt_leaf_node - remove the default leaf node in the tree
  * @pi: port information structure
@@ -1003,14 +939,12 @@ enum ice_status ice_sched_init_port(struct ice_port_info *pi)
 	hw = pi->hw;
 
 	/* Query the Default Topology from FW */
-	buf = devm_kcalloc(ice_hw_to_dev(hw), ICE_TXSCHED_MAX_BRANCHES,
-			   sizeof(*buf), GFP_KERNEL);
+	buf = devm_kzalloc(ice_hw_to_dev(hw), ICE_AQ_MAX_BUF_LEN, GFP_KERNEL);
 	if (!buf)
 		return ICE_ERR_NO_MEMORY;
 
 	/* Query default scheduling tree topology */
-	status = ice_aq_get_dflt_topo(hw, pi->lport, buf,
-				      sizeof(*buf) * ICE_TXSCHED_MAX_BRANCHES,
+	status = ice_aq_get_dflt_topo(hw, pi->lport, buf, ICE_AQ_MAX_BUF_LEN,
 				      &num_branches, NULL);
 	if (status)
 		goto err_init_port;
@@ -1311,16 +1245,13 @@ ice_sched_add_vsi_child_nodes(struct ice_port_info *pi, u16 vsi_id,
 	u16 num_added = 0;
 	u8 i, qgl, vsil;
 
-	status = ice_sched_validate_for_max_nodes(pi, num_nodes);
-	if (status)
-		return status;
-
 	qgl = ice_sched_get_qgrp_layer(hw);
 	vsil = ice_sched_get_vsi_layer(hw);
 	parent = ice_sched_get_vsi_node(hw, tc_node, vsi_id);
 	for (i = vsil + 1; i <= qgl; i++) {
 		if (!parent)
 			return ICE_ERR_CFG;
+
 		status = ice_sched_add_nodes_to_layer(pi, tc_node, parent, i,
 						      num_nodes[i],
 						      &first_node_teid,
@@ -1399,7 +1330,8 @@ ice_sched_calc_vsi_support_nodes(struct ice_hw *hw,
 {
 	struct ice_sched_node *node;
 	u16 max_child;
-	u8 i, vsil;
+	u8 vsil;
+	int i;
 
 	vsil = ice_sched_get_vsi_layer(hw);
 	for (i = vsil; i >= hw->sw_entry_point_layer; i--)
@@ -1412,7 +1344,7 @@ ice_sched_calc_vsi_support_nodes(struct ice_hw *hw,
 			/* If intermediate nodes are reached max children
 			 * then add a new one.
 			 */
-			node = ice_sched_get_first_node(hw, tc_node, i);
+			node = ice_sched_get_first_node(hw, tc_node, (u8)i);
 			max_child = le16_to_cpu(hw->layer_info[i].max_children);
 
 			/* scan all the siblings */
@@ -1451,10 +1383,6 @@ ice_sched_add_vsi_support_nodes(struct ice_port_info *pi, u16 vsi_id,
 	if (!pi)
 		return ICE_ERR_PARAM;
 
-	status = ice_sched_validate_for_max_nodes(pi, num_nodes);
-	if (status)
-		return status;
-
 	vsil = ice_sched_get_vsi_layer(pi->hw);
 	for (i = pi->hw->sw_entry_point_layer; i <= vsil; i++) {
 		status = ice_sched_add_nodes_to_layer(pi, tc_node, parent,
@@ -1479,6 +1407,7 @@ ice_sched_add_vsi_support_nodes(struct ice_port_info *pi, u16 vsi_id,
 		if (i == vsil)
 			parent->vsi_id = vsi_id;
 	}
+
 	return 0;
 }
 
@@ -1634,9 +1563,11 @@ ice_sched_cfg_vsi(struct ice_port_info *pi, u16 vsi_id, u8 tc, u16 maxqs,
 		status = ice_sched_add_vsi_to_topo(pi, vsi_id, tc);
 		if (status)
 			return status;
+
 		vsi_node = ice_sched_get_vsi_node(hw, tc_node, vsi_id);
 		if (!vsi_node)
 			return ICE_ERR_CFG;
+
 		vsi->vsi_node[tc] = vsi_node;
 		vsi_node->in_use = true;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 97c366e0ca59..f5aff99bbb61 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -204,6 +204,7 @@ enum ice_agg_type {
 };
 
 #define ICE_SCHED_DFLT_RL_PROF_ID	0
+#define ICE_SCHED_DFLT_BW_WT		1
 
 /* vsi type list entry to locate corresponding vsi/ag nodes */
 struct ice_sched_vsi_info {
-- 
2.14.3

