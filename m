From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:40 -0800
Subject: [Intel-wired-lan] [PATCH S11 13/16] ice: check for a leaf node
 presence
In-Reply-To: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205043.11975-14-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Victor Raj <victor.raj@intel.com>

check for a leaf node presence for a given VSI. This check is required
before removing a VSI since VSIs can't be removed with enabled queues
(with leaf nodes) from the FW scheduler tree unless its a reset.

Signed-off-by: Victor Raj <victor.raj@intel.com>
Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c  | 23 +++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_status.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index f355f59d8b64..56049739a250 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -1615,6 +1615,23 @@ ice_sched_rm_agg_vsi_info(struct ice_port_info *pi, u16 vsi_handle)
 	}
 }
 
+/**
+ * ice_sched_is_leaf_node_present - check for a leaf node in the sub-tree
+ * @node: pointer to the sub-tree node
+ *
+ * This function checks for a leaf node presence in a given sub-tree node.
+ */
+static bool ice_sched_is_leaf_node_present(struct ice_sched_node *node)
+{
+	u8 i;
+
+	for (i = 0; i < node->num_children; i++)
+		if (ice_sched_is_leaf_node_present(node->children[i]))
+			return true;
+	/* check for a leaf node */
+	return (node->info.data.elem_type == ICE_AQC_ELEM_TYPE_LEAF);
+}
+
 /**
  * ice_sched_rm_vsi_cfg - remove the VSI and its children nodes
  * @pi: port information structure
@@ -1649,6 +1666,12 @@ ice_sched_rm_vsi_cfg(struct ice_port_info *pi, u16 vsi_handle, u8 owner)
 		if (!vsi_node)
 			continue;
 
+		if (ice_sched_is_leaf_node_present(vsi_node)) {
+			ice_debug(pi->hw, ICE_DBG_SCHED,
+				  "VSI has leaf nodes in TC %d\n", i);
+			status = ICE_ERR_IN_USE;
+			goto exit_sched_rm_vsi_cfg;
+		}
 		while (j < vsi_node->num_children) {
 			if (vsi_node->children[j]->owner == owner) {
 				ice_free_sched_node(pi, vsi_node->children[j]);
diff --git a/drivers/net/ethernet/intel/ice/ice_status.h b/drivers/net/ethernet/intel/ice/ice_status.h
index f49f299ddf2c..683f48824a29 100644
--- a/drivers/net/ethernet/intel/ice/ice_status.h
+++ b/drivers/net/ethernet/intel/ice/ice_status.h
@@ -22,6 +22,7 @@ enum ice_status {
 	ICE_ERR_OUT_OF_RANGE			= -13,
 	ICE_ERR_ALREADY_EXISTS			= -14,
 	ICE_ERR_DOES_NOT_EXIST			= -15,
+	ICE_ERR_IN_USE				= -16,
 	ICE_ERR_MAX_LIMIT			= -17,
 	ICE_ERR_RESET_ONGOING			= -18,
 	ICE_ERR_BUF_TOO_SHORT			= -52,
-- 
2.14.5

