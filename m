From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Wed, 13 Oct 2021 08:27:07 +0200
Subject: [Intel-wired-lan] [PATCH net-next] ice: send correct vc status in
 switchdev
Message-ID: <20211013062707.353095-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Part of virtchannel messages are treated in different way in switchdev
mode to block configuring VFs from iavf driver side. This blocking was
done by doing nothing and returning succes, event without sending
response.

Not sending response for opcodes that aren't supported in switchdev mode
leads to block iavf driver message handling. This happens for example
when vlan is configured at VF config time (VLAN module is already
loaded).

To get rid of it ice driver should answer for each VF message. In
switchdev mode:
- for adding/deleting VLAN driver should answer success without doing
  anything to allow creating vlan device on VFs
- for enabling/disabling VLAN stripping  and promiscuous mode driver
  should answer not supported, this feature in switchdev can be only
  set from host side

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 63 ++++++++++++++-----
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 3e7fdd7f2e1d..e6748a83466d 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -4463,13 +4463,6 @@ void ice_vc_set_dflt_vf_ops(struct ice_vc_vf_ops *ops)
 	*ops = ice_vc_vf_dflt_ops;
 }
 
-static int
-ice_vc_repr_no_action_msg(struct ice_vf __always_unused *vf,
-			  u8 __always_unused *msg)
-{
-	return 0;
-}
-
 /**
  * ice_vc_repr_add_mac
  * @vf: pointer to VF
@@ -4545,20 +4538,62 @@ ice_vc_repr_del_mac(struct ice_vf __always_unused *vf, u8 __always_unused *msg)
 				     VIRTCHNL_STATUS_SUCCESS, NULL, 0);
 }
 
-static int ice_vc_repr_no_action(struct ice_vf __always_unused *vf)
+static int ice_vc_repr_add_vlan(struct ice_vf *vf, u8 __always_unused *msg)
 {
-	return 0;
+	dev_dbg(ice_pf_to_dev(vf->pf),
+		"Can't add VLAN in switchdev mode for VF %d\n", vf->vf_id);
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_ADD_VLAN,
+				     VIRTCHNL_STATUS_SUCCESS, NULL, 0);
+}
+
+static int ice_vc_repr_del_vlan(struct ice_vf *vf, u8 __always_unused *msg)
+{
+	dev_dbg(ice_pf_to_dev(vf->pf),
+		"Can't delete VLAN in switchdev mode for VF %d\n", vf->vf_id);
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_DEL_VLAN,
+				     VIRTCHNL_STATUS_SUCCESS, NULL, 0);
+}
+
+static int ice_vc_repr_ena_vlan_stripping(struct ice_vf *vf)
+{
+	dev_dbg(ice_pf_to_dev(vf->pf),
+		"Can't enable VLAN stripping in switchdev mode for VF %d\n",
+		vf->vf_id);
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_ENABLE_VLAN_STRIPPING,
+				     VIRTCHNL_STATUS_ERR_NOT_SUPPORTED,
+				     NULL, 0);
+}
+
+static int ice_vc_repr_dis_vlan_stripping(struct ice_vf *vf)
+{
+	dev_dbg(ice_pf_to_dev(vf->pf),
+		"Can't disable VLAN stripping in switchdev mode for VF %d\n",
+		vf->vf_id);
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_DISABLE_VLAN_STRIPPING,
+				     VIRTCHNL_STATUS_ERR_NOT_SUPPORTED,
+				     NULL, 0);
+}
+
+static int
+ice_vc_repr_cfg_promiscuous_mode(struct ice_vf *vf, u8 __always_unused *msg)
+{
+	dev_dbg(ice_pf_to_dev(vf->pf),
+		"Can't config promiscuous mode in switchdev mode for VF %d\n",
+		vf->vf_id);
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE,
+				     VIRTCHNL_STATUS_ERR_NOT_SUPPORTED,
+				     NULL, 0);
 }
 
 void ice_vc_change_ops_to_repr(struct ice_vc_vf_ops *ops)
 {
 	ops->add_mac_addr_msg = ice_vc_repr_add_mac;
 	ops->del_mac_addr_msg = ice_vc_repr_del_mac;
-	ops->add_vlan_msg = ice_vc_repr_no_action_msg;
-	ops->remove_vlan_msg = ice_vc_repr_no_action_msg;
-	ops->ena_vlan_stripping = ice_vc_repr_no_action;
-	ops->dis_vlan_stripping = ice_vc_repr_no_action;
-	ops->cfg_promiscuous_mode_msg = ice_vc_repr_no_action_msg;
+	ops->add_vlan_msg = ice_vc_repr_add_vlan;
+	ops->remove_vlan_msg = ice_vc_repr_del_vlan;
+	ops->ena_vlan_stripping = ice_vc_repr_ena_vlan_stripping;
+	ops->dis_vlan_stripping = ice_vc_repr_dis_vlan_stripping;
+	ops->cfg_promiscuous_mode_msg = ice_vc_repr_cfg_promiscuous_mode;
 }
 
 /**
-- 
2.31.1

