From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 10:40:54 -0700
Subject: [Intel-wired-lan] [PATCH S8 05/16] ice: Remove duplicate addition
 of VLANs in replay path
In-Reply-To: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026174105.11628-6-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ice_restore_vlan and active_vlans were originally put in place to
reprogram VLAN filters in the replay path. This is now done as part
of the much broader VSI rebuild/replay framework. So remove both
ice_restore_vlan and active_vlans

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h             |  1 -
 drivers/net/ethernet/intel/ice/ice_main.c        | 42 ++++--------------------
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  2 --
 3 files changed, 6 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index e5b37fa60884..1639e955f158 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -191,7 +191,6 @@ struct ice_vsi {
 	u64 tx_linearize;
 	DECLARE_BITMAP(state, __ICE_STATE_NBITS);
 	DECLARE_BITMAP(flags, ICE_VSI_FLAG_NBITS);
-	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	unsigned int current_netdev_flags;
 	u32 tx_restart;
 	u32 tx_busy;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index aee22f11a41a..338abb1b9233 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1622,7 +1622,6 @@ static int ice_vlan_rx_add_vid(struct net_device *netdev,
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
-	int ret;
 
 	if (vid >= VLAN_N_VID) {
 		netdev_err(netdev, "VLAN id requested %d is out of range %d\n",
@@ -1635,7 +1634,8 @@ static int ice_vlan_rx_add_vid(struct net_device *netdev,
 
 	/* Enable VLAN pruning when VLAN 0 is added */
 	if (unlikely(!vid)) {
-		ret = ice_cfg_vlan_pruning(vsi, true);
+		int ret = ice_cfg_vlan_pruning(vsi, true);
+
 		if (ret)
 			return ret;
 	}
@@ -1644,12 +1644,7 @@ static int ice_vlan_rx_add_vid(struct net_device *netdev,
 	 * needed to continue allowing all untagged packets since VLAN prune
 	 * list is applied to all packets by the switch
 	 */
-	ret = ice_vsi_add_vlan(vsi, vid);
-
-	if (!ret)
-		set_bit(vid, vsi->active_vlans);
-
-	return ret;
+	return ice_vsi_add_vlan(vsi, vid);
 }
 
 /**
@@ -1677,8 +1672,6 @@ static int ice_vlan_rx_kill_vid(struct net_device *netdev,
 	if (status)
 		return status;
 
-	clear_bit(vid, vsi->active_vlans);
-
 	/* Disable VLAN pruning when VLAN 0 is removed */
 	if (unlikely(!vid))
 		status = ice_cfg_vlan_pruning(vsi, false);
@@ -2515,31 +2508,6 @@ static int ice_vsi_vlan_setup(struct ice_vsi *vsi)
 	return ret;
 }
 
-/**
- * ice_restore_vlan - Reinstate VLANs when vsi/netdev comes back up
- * @vsi: the VSI being brought back up
- */
-static int ice_restore_vlan(struct ice_vsi *vsi)
-{
-	int err;
-	u16 vid;
-
-	if (!vsi->netdev)
-		return -EINVAL;
-
-	err = ice_vsi_vlan_setup(vsi);
-	if (err)
-		return err;
-
-	for_each_set_bit(vid, vsi->active_vlans, VLAN_N_VID) {
-		err = ice_vlan_rx_add_vid(vsi->netdev, htons(ETH_P_8021Q), vid);
-		if (err)
-			break;
-	}
-
-	return err;
-}
-
 /**
  * ice_vsi_cfg - Setup the VSI
  * @vsi: the VSI being configured
@@ -2552,7 +2520,9 @@ static int ice_vsi_cfg(struct ice_vsi *vsi)
 
 	if (vsi->netdev) {
 		ice_set_rx_mode(vsi->netdev);
-		err = ice_restore_vlan(vsi);
+
+		err = ice_vsi_vlan_setup(vsi);
+
 		if (err)
 			return err;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 45f10f8f01dc..9576b958622b 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2171,7 +2171,6 @@ static int ice_vc_process_vlan_msg(struct ice_vf *vf, u8 *msg, bool add_v)
 
 			if (!ice_vsi_add_vlan(vsi, vid)) {
 				vf->num_vlan++;
-				set_bit(vid, vsi->active_vlans);
 
 				/* Enable VLAN pruning when VLAN 0 is added */
 				if (unlikely(!vid))
@@ -2190,7 +2189,6 @@ static int ice_vc_process_vlan_msg(struct ice_vf *vf, u8 *msg, bool add_v)
 			 */
 			if (!ice_vsi_kill_vlan(vsi, vid)) {
 				vf->num_vlan--;
-				clear_bit(vid, vsi->active_vlans);
 
 				/* Disable VLAN pruning when removing VLAN 0 */
 				if (unlikely(!vid))
-- 
2.14.3

