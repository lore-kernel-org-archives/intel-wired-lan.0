From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Mar 2021 15:35:07 -0700
Subject: [Intel-wired-lan] [PATCH S57 04/14] ice: Ignore EMODE return for
 opcode 0x0605
In-Reply-To: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
Message-ID: <20210325223517.17722-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

When link is owned by manageability, the driver is not allowed to fiddle
with link. FW returns ICE_AQ_RC_EMODE if the driver attempts to do so.
This patch adds a new function ice_set_link which abstracts the call to
ice_aq_set_link_restart_an and provides a clean way to turn on/off link.

While making this change, I also spotted that an int variable was being
used to hold both an ice_status return code and the Linux errno return
code. This pattern more often than not results in the driver inadvertently
returning ice_status back to kernel which is a major boo-boo. Clean it up.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 17 ++------
 drivers/net/ethernet/intel/ice/ice_lib.c     | 37 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h     |  2 +
 drivers/net/ethernet/intel/ice/ice_main.c    | 41 ++++++++------------
 4 files changed, 59 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 49baf73a3c2c..af02bbbc3647 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1095,24 +1095,15 @@ static int ice_nway_reset(struct net_device *netdev)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
-	struct ice_port_info *pi;
-	enum ice_status status;
+	int err;
 
-	pi = vsi->port_info;
 	/* If VSI state is up, then restart autoneg with link up */
 	if (!test_bit(ICE_DOWN, vsi->back->state))
-		status = ice_aq_set_link_restart_an(pi, true, NULL);
+		err = ice_set_link(vsi, true);
 	else
-		status = ice_aq_set_link_restart_an(pi, false, NULL);
+		err = ice_set_link(vsi, false);
 
-	if (status) {
-		netdev_info(netdev, "link restart failed, err %s aq_err %s\n",
-			    ice_stat_str(status),
-			    ice_aq_str(pi->hw->adminq.sq_last_status));
-		return -EIO;
-	}
-
-	return 0;
+	return err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 4136ab9b2950..5cbb4b0f682b 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3454,3 +3454,40 @@ int ice_clear_dflt_vsi(struct ice_sw *sw)
 
 	return 0;
 }
+
+/**
+ * ice_set_link - turn on/off physical link
+ * @vsi: VSI to modify physical link on
+ * @ena: turn on/off physical link
+ */
+int ice_set_link(struct ice_vsi *vsi, bool ena)
+{
+	struct device *dev = ice_pf_to_dev(vsi->back);
+	struct ice_port_info *pi = vsi->port_info;
+	struct ice_hw *hw = pi->hw;
+	enum ice_status status;
+
+	if (vsi->type != ICE_VSI_PF)
+		return -EINVAL;
+
+	status = ice_aq_set_link_restart_an(pi, ena, NULL);
+
+	/* if link is owned by manageability, FW will return ICE_AQ_RC_EMODE.
+	 * this is not a fatal error, so print a warning message and return
+	 * a success code. Return an error if FW returns an error code other
+	 * than ICE_AQ_RC_EMODE
+	 */
+	if (status == ICE_ERR_AQ_ERROR) {
+		if (hw->adminq.sq_last_status == ICE_AQ_RC_EMODE)
+			dev_warn(dev, "can't set link to %s, err %s aq_err %s. not fatal, continuing\n",
+				 (ena ? "ON" : "OFF"), ice_stat_str(status),
+				 ice_aq_str(hw->adminq.sq_last_status));
+	} else if (status) {
+		dev_err(dev, "can't set link to %s, err %s aq_err %s\n",
+			(ena ? "ON" : "OFF"), ice_stat_str(status),
+			ice_aq_str(hw->adminq.sq_last_status));
+		return -EIO;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 4b16394da354..92d2d23ce920 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -49,6 +49,8 @@ int ice_cfg_vlan_pruning(struct ice_vsi *vsi, bool ena, bool vlan_promisc);
 
 void ice_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create);
 
+int ice_set_link(struct ice_vsi *vsi, bool ena);
+
 #ifdef CONFIG_DCB
 int ice_vsi_cfg_tc(struct ice_vsi *vsi, u8 ena_tc);
 #endif /* CONFIG_DCB */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4c4ce4379eb4..fc95b634fee9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -887,10 +887,10 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_phy_info *phy_info;
+	enum ice_status status;
 	struct ice_vsi *vsi;
 	u16 old_link_speed;
 	bool old_link;
-	int result;
 
 	phy_info = &pi->phy;
 	phy_info->link_info_old = phy_info->link_info;
@@ -901,10 +901,11 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 	/* update the link info structures and re-enable link events,
 	 * don't bail on failure due to other book keeping needed
 	 */
-	result = ice_update_link_info(pi);
-	if (result)
-		dev_dbg(dev, "Failed to update link status and re-enable link events for port %d\n",
-			pi->lport);
+	status = ice_update_link_info(pi);
+	if (status)
+		dev_dbg(dev, "Failed to update link status on port %d, err %s aq_err %s\n",
+			pi->lport, ice_stat_str(status),
+			ice_aq_str(pi->hw->adminq.sq_last_status));
 
 	/* Check if the link state is up after updating link info, and treat
 	 * this event as an UP event since the link is actually UP now.
@@ -920,18 +921,12 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 	if (!test_bit(ICE_FLAG_NO_MEDIA, pf->flags) &&
 	    !(pi->phy.link_info.link_info & ICE_AQ_MEDIA_AVAILABLE)) {
 		set_bit(ICE_FLAG_NO_MEDIA, pf->flags);
-
-		result = ice_aq_set_link_restart_an(pi, false, NULL);
-		if (result) {
-			dev_dbg(dev, "Failed to set link down, VSI %d error %d\n",
-				vsi->vsi_num, result);
-			return result;
-		}
+		ice_set_link(vsi, false);
 	}
 
 	/* if the old link up/down and speed is the same as the new */
 	if (link_up == old_link && link_speed == old_link_speed)
-		return result;
+		return 0;
 
 	if (ice_is_dcb_active(pf)) {
 		if (test_bit(ICE_FLAG_DCB_ENA, pf->flags))
@@ -945,7 +940,7 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 
 	ice_vc_notify_link_state(pf);
 
-	return result;
+	return 0;
 }
 
 /**
@@ -6722,6 +6717,7 @@ int ice_open_internal(struct net_device *netdev)
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
 	struct ice_port_info *pi;
+	enum ice_status status;
 	int err;
 
 	if (test_bit(ICE_NEEDS_RESTART, pf->state)) {
@@ -6732,11 +6728,11 @@ int ice_open_internal(struct net_device *netdev)
 	netif_carrier_off(netdev);
 
 	pi = vsi->port_info;
-	err = ice_update_link_info(pi);
-	if (err) {
-		netdev_err(netdev, "Failed to get link info, error %d\n",
-			   err);
-		return err;
+	status = ice_update_link_info(pi);
+	if (status) {
+		netdev_err(netdev, "Failed to get link info, error %s\n",
+			   ice_stat_str(status));
+		return -EIO;
 	}
 
 	/* Set PHY if there is media, otherwise, turn off PHY */
@@ -6759,12 +6755,7 @@ int ice_open_internal(struct net_device *netdev)
 		}
 	} else {
 		set_bit(ICE_FLAG_NO_MEDIA, pf->flags);
-		err = ice_aq_set_link_restart_an(pi, false, NULL);
-		if (err) {
-			netdev_err(netdev, "Failed to set PHY state, VSI %d error %d\n",
-				   vsi->vsi_num, err);
-			return err;
-		}
+		ice_set_link(vsi, false);
 	}
 
 	err = ice_vsi_open(vsi);
-- 
2.20.1

