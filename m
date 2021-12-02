From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  2 Dec 2021 08:38:43 -0800
Subject: [Intel-wired-lan] [PATCH net-next v3 05/14] ice: Refactor
 vf->port_vlan_info to use ice_vlan
In-Reply-To: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
Message-ID: <20211202163852.36436-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

The current vf->port_vlan_info variable is a packed u16 that contains
the port VLAN ID and QoS/prio value. This is fine, but changes are
incoming that allow for an 802.1ad port VLAN. Add flexibility by
changing the vf->port_vlan_info member to be an ice_vlan structure.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 76 ++++++++++---------
 .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  3 +-
 2 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index d580120dbb93..4971e547432c 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -751,6 +751,21 @@ static int ice_vf_rebuild_host_tx_rate_cfg(struct ice_vf *vf)
 	return 0;
 }
 
+static u16 ice_vf_get_port_vlan_id(struct ice_vf *vf)
+{
+	return vf->port_vlan_info.vid;
+}
+
+static u8 ice_vf_get_port_vlan_prio(struct ice_vf *vf)
+{
+	return vf->port_vlan_info.prio;
+}
+
+static bool ice_vf_is_port_vlan_ena(struct ice_vf *vf)
+{
+	return (ice_vf_get_port_vlan_id(vf) || ice_vf_get_port_vlan_prio(vf));
+}
+
 /**
  * ice_vf_rebuild_host_vlan_cfg - add VLAN 0 filter or rebuild the Port VLAN
  * @vf: VF to add MAC filters for
@@ -760,16 +775,12 @@ static int ice_vf_rebuild_host_tx_rate_cfg(struct ice_vf *vf)
  */
 static int ice_vf_rebuild_host_vlan_cfg(struct ice_vf *vf)
 {
-	u8 vlan_prio = (vf->port_vlan_info & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
-	u16 vlan_id = vf->port_vlan_info & VLAN_VID_MASK;
 	struct device *dev = ice_pf_to_dev(vf->pf);
 	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
-	struct ice_vlan vlan;
 	int err;
 
-	vlan = ICE_VLAN(vlan_id, vlan_prio);
-	if (vf->port_vlan_info) {
-		err = vsi->vlan_ops.set_port_vlan(vsi, &vlan);
+	if (ice_vf_is_port_vlan_ena(vf)) {
+		err = vsi->vlan_ops.set_port_vlan(vsi, &vf->port_vlan_info);
 		if (err) {
 			dev_err(dev, "failed to configure port VLAN via VSI parameters for VF %u, error %d\n",
 				vf->vf_id, err);
@@ -777,12 +788,11 @@ static int ice_vf_rebuild_host_vlan_cfg(struct ice_vf *vf)
 		}
 	}
 
-	/* vlan_id will either be 0 or the port VLAN number */
-	err = vsi->vlan_ops.add_vlan(vsi, &vlan);
+	err = vsi->vlan_ops.add_vlan(vsi, &vf->port_vlan_info);
 	if (err) {
-		dev_err(dev, "failed to add %s VLAN %u filter for VF %u, error %d\n",
-			vf->port_vlan_info ? "port" : "", vlan_id, vf->vf_id,
-			err);
+		dev_err(dev, "failed to add VLAN %u filter for VF %u during VF rebuild, error %d\n",
+			ice_vf_is_port_vlan_ena(vf) ?
+			ice_vf_get_port_vlan_id(vf) : 0, vf->vf_id, err);
 		return err;
 	}
 
@@ -1255,9 +1265,9 @@ static int ice_vf_set_vsi_promisc(struct ice_vf *vf, struct ice_vsi *vsi, u8 pro
 	struct ice_hw *hw = &vsi->back->hw;
 	int status;
 
-	if (vf->port_vlan_info)
+	if (ice_vf_is_port_vlan_ena(vf))
 		status = ice_fltr_set_vsi_promisc(hw, vsi->idx, promisc_m,
-						  vf->port_vlan_info & VLAN_VID_MASK);
+						  ice_vf_get_port_vlan_id(vf));
 	else if (vsi->num_vlan > 1)
 		status = ice_fltr_set_vlan_vsi_promisc(hw, vsi, promisc_m);
 	else
@@ -1277,9 +1287,9 @@ static int ice_vf_clear_vsi_promisc(struct ice_vf *vf, struct ice_vsi *vsi, u8 p
 	struct ice_hw *hw = &vsi->back->hw;
 	int status;
 
-	if (vf->port_vlan_info)
+	if (ice_vf_is_port_vlan_ena(vf))
 		status = ice_fltr_clear_vsi_promisc(hw, vsi->idx, promisc_m,
-						    vf->port_vlan_info & VLAN_VID_MASK);
+						    ice_vf_get_port_vlan_id(vf));
 	else if (vsi->num_vlan > 1)
 		status = ice_fltr_clear_vlan_vsi_promisc(hw, vsi, promisc_m);
 	else
@@ -1654,7 +1664,7 @@ bool ice_reset_vf(struct ice_vf *vf, bool is_vflr)
 	 */
 	if (test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states) ||
 	    test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states)) {
-		if (vf->port_vlan_info || vsi->num_vlan)
+		if (ice_vf_is_port_vlan_ena(vf) || vsi->num_vlan)
 			promisc_m = ICE_UCAST_VLAN_PROMISC_BITS;
 		else
 			promisc_m = ICE_UCAST_PROMISC_BITS;
@@ -2277,7 +2287,7 @@ static u16 ice_vc_get_max_frame_size(struct ice_vf *vf)
 
 	max_frame_size = pi->phy.link_info.max_frame_size;
 
-	if (vf->port_vlan_info)
+	if (ice_vf_is_port_vlan_ena(vf))
 		max_frame_size -= VLAN_HLEN;
 
 	return max_frame_size;
@@ -2326,7 +2336,7 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	if (!vsi->info.pvid)
+	if (!ice_vf_is_port_vlan_ena(vf))
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_VLAN;
 
 	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_PF) {
@@ -3050,7 +3060,7 @@ static int ice_vc_cfg_promiscuous_mode_msg(struct ice_vf *vf, u8 *msg)
 
 	rm_promisc = !allmulti && !alluni;
 
-	if (vsi->num_vlan || vf->port_vlan_info) {
+	if (vsi->num_vlan || ice_vf_is_port_vlan_ena(vf)) {
 		if (rm_promisc)
 			ret = vsi->vlan_ops.ena_rx_filtering(vsi);
 		else
@@ -3086,7 +3096,7 @@ static int ice_vc_cfg_promiscuous_mode_msg(struct ice_vf *vf, u8 *msg)
 	} else {
 		u8 mcast_m, ucast_m;
 
-		if (vf->port_vlan_info || vsi->num_vlan > 1) {
+		if (ice_vf_is_port_vlan_ena(vf) || vsi->num_vlan > 1) {
 			mcast_m = ICE_MCAST_VLAN_PROMISC_BITS;
 			ucast_m = ICE_UCAST_VLAN_PROMISC_BITS;
 		} else {
@@ -3669,7 +3679,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 			/* add space for the port VLAN since the VF driver is not
 			 * expected to account for it in the MTU calculation
 			 */
-			if (vf->port_vlan_info)
+			if (ice_vf_is_port_vlan_ena(vf))
 				vsi->max_frame += VLAN_HLEN;
 
 			if (ice_vsi_cfg_single_rxq(vsi, q_idx)) {
@@ -4097,7 +4107,6 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct device *dev;
 	struct ice_vf *vf;
-	u16 vlanprio;
 	int ret;
 
 	dev = ice_pf_to_dev(pf);
@@ -4120,20 +4129,19 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 	if (ret)
 		return ret;
 
-	vlanprio = vlan_id | (qos << VLAN_PRIO_SHIFT);
-
-	if (vf->port_vlan_info == vlanprio) {
+	if (ice_vf_get_port_vlan_prio(vf) == qos &&
+	    ice_vf_get_port_vlan_id(vf) == vlan_id) {
 		/* duplicate request, so just return success */
-		dev_dbg(dev, "Duplicate pvid %d request\n", vlanprio);
+		dev_dbg(dev, "Duplicate port VLAN %u, QoS %u request\n",
+			vlan_id, qos);
 		return 0;
 	}
 
 	mutex_lock(&vf->cfg_lock);
 
-	vf->port_vlan_info = vlanprio;
-
-	if (vf->port_vlan_info)
-		dev_info(dev, "Setting VLAN %d, QoS 0x%x on VF %d\n",
+	vf->port_vlan_info = ICE_VLAN(vlan_id, qos);
+	if (ice_vf_is_port_vlan_ena(vf))
+		dev_info(dev, "Setting VLAN %u, QoS %u on VF %d\n",
 			 vlan_id, qos, vf_id);
 	else
 		dev_info(dev, "Clearing port VLAN on VF %d\n", vf_id);
@@ -4219,7 +4227,7 @@ static int ice_vc_process_vlan_msg(struct ice_vf *vf, u8 *msg, bool add_v)
 		goto error_param;
 	}
 
-	if (vsi->info.pvid) {
+	if (ice_vf_is_port_vlan_ena(vf)) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
 	}
@@ -4445,7 +4453,7 @@ static int ice_vf_init_vlan_stripping(struct ice_vf *vf)
 		return -EINVAL;
 
 	/* don't modify stripping if port VLAN is configured */
-	if (vsi->info.pvid)
+	if (ice_vf_is_port_vlan_ena(vf))
 		return 0;
 
 	if (ice_vf_vlan_offload_ena(vf->driver_caps))
@@ -4815,8 +4823,8 @@ ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi)
 	ether_addr_copy(ivi->mac, vf->hw_lan_addr.addr);
 
 	/* VF configuration for VLAN and applicable QoS */
-	ivi->vlan = vf->port_vlan_info & VLAN_VID_MASK;
-	ivi->qos = (vf->port_vlan_info & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
+	ivi->vlan = ice_vf_get_port_vlan_id(vf);
+	ivi->qos = ice_vf_get_port_vlan_prio(vf);
 
 	ivi->trusted = vf->trusted;
 	ivi->spoofchk = vf->spoofchk;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index 752487a1bdd6..5079a3b72698 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -5,6 +5,7 @@
 #define _ICE_VIRTCHNL_PF_H_
 #include "ice.h"
 #include "ice_virtchnl_fdir.h"
+#include "ice_vsi_vlan_ops.h"
 
 /* Restrict number of MAC Addr and VLAN that non-trusted VF can programmed */
 #define ICE_MAX_VLAN_PER_VF		8
@@ -119,7 +120,7 @@ struct ice_vf {
 	struct ice_time_mac legacy_last_added_umac;
 	DECLARE_BITMAP(txq_ena, ICE_MAX_RSS_QS_PER_VF);
 	DECLARE_BITMAP(rxq_ena, ICE_MAX_RSS_QS_PER_VF);
-	u16 port_vlan_info;		/* Port VLAN ID and QoS */
+	struct ice_vlan port_vlan_info;	/* Port VLAN ID and QoS */
 	u8 pf_set_mac:1;		/* VF MAC address set by VMM admin */
 	u8 trusted:1;
 	u8 spoofchk:1;
-- 
2.20.1

