From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Feb 2022 16:26:55 -0800
Subject: [Intel-wired-lan] [net-next PATCH 08/25] ice: move
 ice_set_vf_port_vlan near other .ndo ops
In-Reply-To: <20220223002712.2771809-1-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
Message-ID: <20220223002712.2771809-9-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ice_set_vf_port_vlan function is located in ice_sriov.c very far
away from the other .ndo operations that it is similar to. Move this so
that its located near the other .ndo operation definitions.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 192 ++++++++++-----------
 1 file changed, 96 insertions(+), 96 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 8d22b5d94706..eebff1824be2 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -4249,102 +4249,6 @@ static int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 				     v_ret, (u8 *)vfres, sizeof(*vfres));
 }
 
-/**
- * ice_is_supported_port_vlan_proto - make sure the vlan_proto is supported
- * @hw: hardware structure used to check the VLAN mode
- * @vlan_proto: VLAN TPID being checked
- *
- * If the device is configured in Double VLAN Mode (DVM), then both ETH_P_8021Q
- * and ETH_P_8021AD are supported. If the device is configured in Single VLAN
- * Mode (SVM), then only ETH_P_8021Q is supported.
- */
-static bool
-ice_is_supported_port_vlan_proto(struct ice_hw *hw, u16 vlan_proto)
-{
-	bool is_supported = false;
-
-	switch (vlan_proto) {
-	case ETH_P_8021Q:
-		is_supported = true;
-		break;
-	case ETH_P_8021AD:
-		if (ice_is_dvm_ena(hw))
-			is_supported = true;
-		break;
-	}
-
-	return is_supported;
-}
-
-/**
- * ice_set_vf_port_vlan
- * @netdev: network interface device structure
- * @vf_id: VF identifier
- * @vlan_id: VLAN ID being set
- * @qos: priority setting
- * @vlan_proto: VLAN protocol
- *
- * program VF Port VLAN ID and/or QoS
- */
-int
-ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
-		     __be16 vlan_proto)
-{
-	struct ice_pf *pf = ice_netdev_to_pf(netdev);
-	u16 local_vlan_proto = ntohs(vlan_proto);
-	struct device *dev;
-	struct ice_vf *vf;
-	int ret;
-
-	dev = ice_pf_to_dev(pf);
-
-	if (vlan_id >= VLAN_N_VID || qos > 7) {
-		dev_err(dev, "Invalid Port VLAN parameters for VF %d, ID %d, QoS %d\n",
-			vf_id, vlan_id, qos);
-		return -EINVAL;
-	}
-
-	if (!ice_is_supported_port_vlan_proto(&pf->hw, local_vlan_proto)) {
-		dev_err(dev, "VF VLAN protocol 0x%04x is not supported\n",
-			local_vlan_proto);
-		return -EPROTONOSUPPORT;
-	}
-
-	vf = ice_get_vf_by_id(pf, vf_id);
-	if (!vf)
-		return -EINVAL;
-
-	ret = ice_check_vf_ready_for_cfg(vf);
-	if (ret)
-		goto out_put_vf;
-
-	if (ice_vf_get_port_vlan_prio(vf) == qos &&
-	    ice_vf_get_port_vlan_tpid(vf) == local_vlan_proto &&
-	    ice_vf_get_port_vlan_id(vf) == vlan_id) {
-		/* duplicate request, so just return success */
-		dev_dbg(dev, "Duplicate port VLAN %u, QoS %u, TPID 0x%04x request\n",
-			vlan_id, qos, local_vlan_proto);
-		ret = 0;
-		goto out_put_vf;
-	}
-
-	mutex_lock(&vf->cfg_lock);
-
-	vf->port_vlan_info = ICE_VLAN(local_vlan_proto, vlan_id, qos);
-	if (ice_vf_is_port_vlan_ena(vf))
-		dev_info(dev, "Setting VLAN %u, QoS %u, TPID 0x%04x on VF %d\n",
-			 vlan_id, qos, local_vlan_proto, vf_id);
-	else
-		dev_info(dev, "Clearing port VLAN on VF %d\n", vf_id);
-
-	ice_vc_reset_vf(vf);
-	mutex_unlock(&vf->cfg_lock);
-
-out_put_vf:
-	ice_put_vf(vf);
-	return ret;
-}
-
 /**
  * ice_vf_vlan_offload_ena - determine if capabilities support VLAN offloads
  * @caps: VF driver negotiated capabilities
@@ -6483,6 +6387,102 @@ int ice_get_vf_stats(struct net_device *netdev, int vf_id,
 	return ret;
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
+/**
+ * ice_set_vf_port_vlan
+ * @netdev: network interface device structure
+ * @vf_id: VF identifier
+ * @vlan_id: VLAN ID being set
+ * @qos: priority setting
+ * @vlan_proto: VLAN protocol
+ *
+ * program VF Port VLAN ID and/or QoS
+ */
+int
+ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
+		     __be16 vlan_proto)
+{
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+	u16 local_vlan_proto = ntohs(vlan_proto);
+	struct device *dev;
+	struct ice_vf *vf;
+	int ret;
+
+	dev = ice_pf_to_dev(pf);
+
+	if (vlan_id >= VLAN_N_VID || qos > 7) {
+		dev_err(dev, "Invalid Port VLAN parameters for VF %d, ID %d, QoS %d\n",
+			vf_id, vlan_id, qos);
+		return -EINVAL;
+	}
+
+	if (!ice_is_supported_port_vlan_proto(&pf->hw, local_vlan_proto)) {
+		dev_err(dev, "VF VLAN protocol 0x%04x is not supported\n",
+			local_vlan_proto);
+		return -EPROTONOSUPPORT;
+	}
+
+	vf = ice_get_vf_by_id(pf, vf_id);
+	if (!vf)
+		return -EINVAL;
+
+	ret = ice_check_vf_ready_for_cfg(vf);
+	if (ret)
+		goto out_put_vf;
+
+	if (ice_vf_get_port_vlan_prio(vf) == qos &&
+	    ice_vf_get_port_vlan_tpid(vf) == local_vlan_proto &&
+	    ice_vf_get_port_vlan_id(vf) == vlan_id) {
+		/* duplicate request, so just return success */
+		dev_dbg(dev, "Duplicate port VLAN %u, QoS %u, TPID 0x%04x request\n",
+			vlan_id, qos, local_vlan_proto);
+		ret = 0;
+		goto out_put_vf;
+	}
+
+	mutex_lock(&vf->cfg_lock);
+
+	vf->port_vlan_info = ICE_VLAN(local_vlan_proto, vlan_id, qos);
+	if (ice_vf_is_port_vlan_ena(vf))
+		dev_info(dev, "Setting VLAN %u, QoS %u, TPID 0x%04x on VF %d\n",
+			 vlan_id, qos, local_vlan_proto, vf_id);
+	else
+		dev_info(dev, "Clearing port VLAN on VF %d\n", vf_id);
+
+	ice_vc_reset_vf(vf);
+	mutex_unlock(&vf->cfg_lock);
+
+out_put_vf:
+	ice_put_vf(vf);
+	return ret;
+}
+
 /**
  * ice_print_vf_rx_mdd_event - print VF Rx malicious driver detect event
  * @vf: pointer to the VF structure
-- 
2.35.1.129.gb80121027d12

