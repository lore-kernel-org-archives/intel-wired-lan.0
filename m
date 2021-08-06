From: Wojciech Drewek <wojciech.drewek@intel.com>
Date: Fri,  6 Aug 2021 10:49:06 +0200
Subject: [Intel-wired-lan] [PATCH net-next v6 9/9] ice: ndo_setup_tc
 implementation for PR
In-Reply-To: <1628239746-17380-1-git-send-email-wojciech.drewek@intel.com>
References: <1628239746-17380-1-git-send-email-wojciech.drewek@intel.com>
Message-ID: <1628239746-17380-10-git-send-email-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@intel.com>

Add tc-flower support for VF port representor devices.

Implement ndo_setup_tc callback for TC HW offload on VF port representors
devices. Implemented both methods: add and delete tc-flower flows.

Mark NETIF_F_HW_TC bit in net device's feature set to enable offload TC
infrastructure for port representor.

Implement TC filters replay function required to restore filters settings
while switchdev configuration is rebuilt.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c |  3 ++
 drivers/net/ethernet/intel/ice/ice_repr.c    | 53 ++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_tc_lib.c  | 17 +++++++++
 drivers/net/ethernet/intel/ice/ice_tc_lib.h  |  1 +
 4 files changed, 74 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index ec2aa789e214..ef6ca61c9859 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -7,6 +7,7 @@
 #include "ice_fltr.h"
 #include "ice_repr.h"
 #include "ice_devlink.h"
+#include "ice_tc_lib.h"
 
 /**
  * ice_eswitch_setup_env - configure switchdev HW filters
@@ -644,6 +645,8 @@ int ice_eswitch_rebuild(struct ice_pf *pf)
 
 	ice_eswitch_remap_rings_to_vectors(pf);
 
+	ice_replay_tc_fltrs(pf);
+
 	status = ice_vsi_open(ctrl_vsi);
 	if (status)
 		return status;
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 23e27bec4a16..8fd90ac661b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -5,6 +5,7 @@
 #include "ice_eswitch.h"
 #include "ice_devlink.h"
 #include "ice_virtchnl_pf.h"
+#include "ice_tc_lib.h"
 
 /**
  * ice_repr_get_sw_port_id - get port ID associated with representor
@@ -141,6 +142,55 @@ static int ice_repr_stop(struct net_device *netdev)
 	return &repr->vf->devlink_port;
 }
 
+static int
+ice_repr_setup_tc_cls_flower(struct ice_repr *repr,
+			     struct flow_cls_offload *flower)
+{
+	switch (flower->command) {
+	case FLOW_CLS_REPLACE:
+		return ice_add_cls_flower(repr->netdev, repr->src_vsi, flower);
+	case FLOW_CLS_DESTROY:
+		return ice_del_cls_flower(repr->src_vsi, flower);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int
+ice_repr_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
+			   void *cb_priv)
+{
+	struct flow_cls_offload *flower = (struct flow_cls_offload *)type_data;
+	struct ice_netdev_priv *np = (struct ice_netdev_priv *)cb_priv;
+
+	switch (type) {
+	case TC_SETUP_CLSFLOWER:
+		return ice_repr_setup_tc_cls_flower(np->repr, flower);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static LIST_HEAD(ice_repr_block_cb_list);
+
+static int
+ice_repr_setup_tc(struct net_device *netdev, enum tc_setup_type type,
+		  void *type_data)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+
+	switch (type) {
+	case TC_SETUP_BLOCK:
+		return flow_block_cb_setup_simple((struct flow_block_offload *)
+						  type_data,
+						  &ice_repr_block_cb_list,
+						  ice_repr_setup_tc_block_cb,
+						  np, np, true);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct net_device_ops ice_repr_netdev_ops = {
 	.ndo_get_phys_port_name = ice_repr_get_phys_port_name,
 	.ndo_get_stats64 = ice_repr_get_stats64,
@@ -148,6 +198,7 @@ static int ice_repr_stop(struct net_device *netdev)
 	.ndo_stop = ice_repr_stop,
 	.ndo_start_xmit = ice_eswitch_port_start_xmit,
 	.ndo_get_devlink_port = ice_repr_get_devlink_port,
+	.ndo_setup_tc = ice_repr_setup_tc,
 };
 
 /**
@@ -170,6 +221,8 @@ bool ice_is_port_repr_netdev(struct net_device *netdev)
 	netdev->netdev_ops = &ice_repr_netdev_ops;
 	ice_set_ethtool_repr_ops(netdev);
 
+	netdev->hw_features |= NETIF_F_HW_TC;
+
 	netif_carrier_off(netdev);
 	netif_tx_stop_all_queues(netdev);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 6a61888f80aa..34fe725b4a53 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -836,3 +836,20 @@ static int ice_del_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 
 	return 0;
 }
+
+/**
+ * ice_replay_tc_fltrs - replay TC filters
+ * @pf: pointer to PF struct
+ */
+void ice_replay_tc_fltrs(struct ice_pf *pf)
+{
+	struct ice_tc_flower_fltr *fltr;
+	struct hlist_node *node;
+
+	hlist_for_each_entry_safe(fltr, node,
+				  &pf->tc_flower_fltr_list,
+				  tc_flower_node) {
+		fltr->extack = NULL;
+		ice_add_switch_fltr(fltr->src_vsi, fltr);
+	}
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
index 883d2891f92c..d90e9e37ae25 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
@@ -125,5 +125,6 @@ struct ice_tc_flower_fltr {
 		   struct flow_cls_offload *cls_flower);
 int
 ice_del_cls_flower(struct ice_vsi *vsi, struct flow_cls_offload *cls_flower);
+void ice_replay_tc_fltrs(struct ice_pf *pf);
 
 #endif /* _ICE_TC_LIB_H_ */
-- 
1.8.3.1

