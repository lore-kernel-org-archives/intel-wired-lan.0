From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  2 Dec 2021 08:38:51 -0800
Subject: [Intel-wired-lan] [PATCH net-next v3 13/14] ice: Add support for
 802.1ad port VLANs VF
In-Reply-To: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
Message-ID: <20211202163852.36436-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently there is only support for 802.1Q port VLANs on SR-IOV VFs. Add
support to also allow 802.1ad port VLANs when double VLAN mode is
enabled.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 51 ++++++++++++++++---
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index de74a2b4f846..f1802de98b82 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -768,6 +768,11 @@ bool ice_vf_is_port_vlan_ena(struct ice_vf *vf)
 	return (ice_vf_get_port_vlan_id(vf) || ice_vf_get_port_vlan_prio(vf));
 }
 
+static u16 ice_vf_get_port_vlan_tpid(struct ice_vf *vf)
+{
+	return vf->port_vlan_info.tpid;
+}
+
 /**
  * ice_vf_rebuild_host_vlan_cfg - add VLAN 0 filter or rebuild the Port VLAN
  * @vf: VF to add MAC filters for
@@ -4129,6 +4134,33 @@ static int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 				     v_ret, (u8 *)vfres, sizeof(*vfres));
 }
 
+/**
+ * ice_is_supported_port_vlan_proto - make sure the vlan_proto is supported
+ * @hw: hardware structure used to check the VLAN mode
+ * @vlan_proto: VLAN TPID being checked
+ *
+ * If the device is configured in Double VLAN Mode (DVM), then both ETH_P_8021Q
+ * and ETH_P_8021AD are supported. If the device is configured in Single VLAN
+ * Mode (SVM), then only ETH_P_8021Q is supported.
+ */
+static bool
+ice_is_supported_port_vlan_proto(struct ice_hw *hw, u16 vlan_proto)
+{
+	bool is_supported = false;
+
+	switch (vlan_proto) {
+	case ETH_P_8021Q:
+		is_supported = true;
+		break;
+	case ETH_P_8021AD:
+		if (ice_is_dvm_ena(hw))
+			is_supported = true;
+		break;
+	}
+
+	return is_supported;
+}
+
 /**
  * ice_set_vf_port_vlan
  * @netdev: network interface device structure
@@ -4144,6 +4176,7 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 		     __be16 vlan_proto)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+	u16 local_vlan_proto = ntohs(vlan_proto);
 	struct device *dev;
 	struct ice_vf *vf;
 	int ret;
@@ -4158,8 +4191,9 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 		return -EINVAL;
 	}
 
-	if (vlan_proto != htons(ETH_P_8021Q)) {
-		dev_err(dev, "VF VLAN protocol is not supported\n");
+	if (!ice_is_supported_port_vlan_proto(&pf->hw, local_vlan_proto)) {
+		dev_err(dev, "VF VLAN protocol 0x%04x is not supported\n",
+			local_vlan_proto);
 		return -EPROTONOSUPPORT;
 	}
 
@@ -4169,19 +4203,20 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 		return ret;
 
 	if (ice_vf_get_port_vlan_prio(vf) == qos &&
+	    ice_vf_get_port_vlan_tpid(vf) == local_vlan_proto &&
 	    ice_vf_get_port_vlan_id(vf) == vlan_id) {
 		/* duplicate request, so just return success */
-		dev_dbg(dev, "Duplicate port VLAN %u, QoS %u request\n",
-			vlan_id, qos);
+		dev_dbg(dev, "Duplicate port VLAN %u, QoS %u, TPID 0x%04x request\n",
+			vlan_id, qos, local_vlan_proto);
 		return 0;
 	}
 
 	mutex_lock(&vf->cfg_lock);
 
-	vf->port_vlan_info = ICE_VLAN(ETH_P_8021Q, vlan_id, qos);
+	vf->port_vlan_info = ICE_VLAN(local_vlan_proto, vlan_id, qos);
 	if (ice_vf_is_port_vlan_ena(vf))
-		dev_info(dev, "Setting VLAN %u, QoS %u on VF %d\n",
-			 vlan_id, qos, vf_id);
+		dev_info(dev, "Setting VLAN %u, QoS %u, TPID 0x%04x on VF %d\n",
+			 vlan_id, qos, local_vlan_proto, vf_id);
 	else
 		dev_info(dev, "Clearing port VLAN on VF %d\n", vf_id);
 
@@ -5904,6 +5939,8 @@ ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi)
 	/* VF configuration for VLAN and applicable QoS */
 	ivi->vlan = ice_vf_get_port_vlan_id(vf);
 	ivi->qos = ice_vf_get_port_vlan_prio(vf);
+	if (ice_vf_is_port_vlan_ena(vf))
+		ivi->vlan_proto = cpu_to_be16(ice_vf_get_port_vlan_tpid(vf));
 
 	ivi->trusted = vf->trusted;
 	ivi->spoofchk = vf->spoofchk;
-- 
2.20.1

