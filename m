From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:54:58 -0700
Subject: [Intel-wired-lan] [PATCH S46 1/9] ice: Reset VF for all port VLAN
 changes from host
Message-ID: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently the PF is modifying the VF's port VLAN on the fly when
configured via iproute. This is okay for most cases, but if the VF
already has guest VLANs configured the PF has to remove all of those
filters so only VLAN tagged traffic that matches the port VLAN will
pass. Instead of adding functionality to track which guest VLANs have
been added, just reset the VF each time port VLAN parameters are
modified.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 42 +++----------------
 1 file changed, 5 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index abc4f2dba388..0ca614fa97bb 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -3269,7 +3269,6 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 		     __be16 vlan_proto)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
-	struct ice_vsi *vsi;
 	struct device *dev;
 	struct ice_vf *vf;
 	u16 vlanprio;
@@ -3291,8 +3290,6 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 	}
 
 	vf = &pf->vf[vf_id];
-	vsi = pf->vsi[vf->lan_vsi_idx];
-
 	ret = ice_check_vf_ready_for_cfg(vf);
 	if (ret)
 		return ret;
@@ -3305,44 +3302,15 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 		return 0;
 	}
 
-	if (vlan_id || qos) {
-		/* remove VLAN 0 filter set by default when transitioning from
-		 * no port VLAN to a port VLAN. No change to old port VLAN on
-		 * failure.
-		 */
-		ret = ice_vsi_kill_vlan(vsi, 0);
-		if (ret)
-			return ret;
-		ret = ice_vsi_manage_pvid(vsi, vlanprio, true);
-		if (ret)
-			return ret;
-	} else {
-		/* add VLAN 0 filter back when transitioning from port VLAN to
-		 * no port VLAN. No change to old port VLAN on failure.
-		 */
-		ret = ice_vsi_add_vlan(vsi, 0, ICE_FWD_TO_VSI);
-		if (ret)
-			return ret;
-		ret = ice_vsi_manage_pvid(vsi, 0, false);
-		if (ret)
-			return ret;
-	}
+	vf->port_vlan_info = vlanprio;
 
-	if (vlan_id) {
+	if (vf->port_vlan_info)
 		dev_info(dev, "Setting VLAN %d, QoS 0x%x on VF %d\n",
 			 vlan_id, qos, vf_id);
+	else
+		dev_info(dev, "Clearing port VLAN on VF %d\n", vf_id);
 
-		/* add VLAN filter for the port VLAN */
-		ret = ice_vsi_add_vlan(vsi, vlan_id, ICE_FWD_TO_VSI);
-		if (ret)
-			return ret;
-	}
-	/* remove old port VLAN filter with valid VLAN ID or QoS fields */
-	if (vf->port_vlan_info)
-		ice_vsi_kill_vlan(vsi, vf->port_vlan_info & VLAN_VID_MASK);
-
-	/* keep port VLAN information persistent on resets */
-	vf->port_vlan_info = le16_to_cpu(vsi->info.pvid);
+	ice_vc_reset_vf(vf);
 
 	return 0;
 }
-- 
2.20.1

