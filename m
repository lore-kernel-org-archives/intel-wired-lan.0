From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  8 Nov 2019 06:23:19 -0800
Subject: [Intel-wired-lan] [PATCH S33 03/15] ice: Disallow VF VLAN opcodes
 if VLAN offloads disabled
In-Reply-To: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
Message-ID: <20191108142331.10221-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently if the host disables VLAN offloads on the VF by
not setting the VIRTCHNL_VF_OFFLOAD_VLAN capability bit
we will still honor VF VLAN configuration messages over
VIRTCHNL. These messages (i.e. enable/disable VLAN stripping
and VLAN filtering) should be blocked when the feature
is not supported. Fix that by adding a helper function to
determine if the VF is allowed to do VLAN operations based
on the host's VF configuration.

Also, mirror the VF communicated capabilities in the host's
VF configuration.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 2ac83ad3d1a6..3cb394bdfe51 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1686,6 +1686,9 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 	ether_addr_copy(vfres->vsi_res[0].default_mac_addr,
 			vf->dflt_lan_addr.addr);
 
+	/* match guest capabilities */
+	vf->driver_caps = vfres->vf_cap_flags;
+
 	set_bit(ICE_VF_STATE_ACTIVE, vf->vf_states);
 
 err:
@@ -2653,6 +2656,17 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 	return ret;
 }
 
+/**
+ * ice_vf_vlan_offload_ena - determine if capabilities support VLAN offloads
+ * @caps: VF driver negotiated capabilities
+ *
+ * Return true if VIRTCHNL_VF_OFFLOAD_VLAN capability is set, else return false
+ */
+static bool ice_vf_vlan_offload_ena(u32 caps)
+{
+	return !!(caps & VIRTCHNL_VF_OFFLOAD_VLAN);
+}
+
 /**
  * ice_vc_process_vlan_msg
  * @vf: pointer to the VF info
@@ -2679,6 +2693,11 @@ static int ice_vc_process_vlan_msg(struct ice_vf *vf, u8 *msg, bool add_v)
 		goto error_param;
 	}
 
+	if (!ice_vf_vlan_offload_ena(vf->driver_caps)) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto error_param;
+	}
+
 	if (!ice_vc_isvalid_vsi_id(vf, vfl->vsi_id)) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
@@ -2864,6 +2883,11 @@ static int ice_vc_ena_vlan_stripping(struct ice_vf *vf)
 		goto error_param;
 	}
 
+	if (!ice_vf_vlan_offload_ena(vf->driver_caps)) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto error_param;
+	}
+
 	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (ice_vsi_manage_vlan_stripping(vsi, true))
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
@@ -2890,6 +2914,11 @@ static int ice_vc_dis_vlan_stripping(struct ice_vf *vf)
 		goto error_param;
 	}
 
+	if (!ice_vf_vlan_offload_ena(vf->driver_caps)) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto error_param;
+	}
+
 	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (!vsi) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-- 
2.20.1

