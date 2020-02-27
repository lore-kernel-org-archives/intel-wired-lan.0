From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 27 Feb 2020 10:14:58 -0800
Subject: [Intel-wired-lan] [PATCH S40 08/15] ice: renegotiate link after FW
 DCB on
In-Reply-To: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
Message-ID: <20200227181505.61720-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

When switching from SW DCB to FW DCB it is necessary
to renegotiate DCBx so that the FW agent can have up
to date information about the DCB settings of the link
partner.

Perform an autoneg restart on the link when activating
FW DCB.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 53 +++++++++++---------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index c9c217202046..c67cfae64f2b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1131,6 +1131,33 @@ ice_get_fecparam(struct net_device *netdev, struct ethtool_fecparam *fecparam)
 	return err;
 }
 
+/**
+ * ice_nway_reset - restart autonegotiation
+ * @netdev: network interface device structure
+ */
+static int ice_nway_reset(struct net_device *netdev)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_vsi *vsi = np->vsi;
+	struct ice_port_info *pi;
+	enum ice_status status;
+
+	pi = vsi->port_info;
+	/* If VSI state is up, then restart autoneg with link up */
+	if (!test_bit(__ICE_DOWN, vsi->back->state))
+		status = ice_aq_set_link_restart_an(pi, true, NULL);
+	else
+		status = ice_aq_set_link_restart_an(pi, false, NULL);
+
+	if (status) {
+		netdev_info(netdev, "link restart failed, err %d aq_err %d\n",
+			    status, pi->hw->adminq.sq_last_status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /**
  * ice_get_priv_flags - report device private flags
  * @netdev: network interface device structure
@@ -1264,6 +1291,8 @@ static int ice_set_priv_flags(struct net_device *netdev, u32 flags)
 			status = ice_cfg_lldp_mib_change(&pf->hw, true);
 			if (status)
 				dev_dbg(dev, "Fail to enable MIB change events\n");
+
+			ice_nway_reset(netdev);
 		}
 	}
 	if (test_bit(ICE_FLAG_LEGACY_RX, change_flags)) {
@@ -2775,30 +2804,6 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring)
 	return err;
 }
 
-static int ice_nway_reset(struct net_device *netdev)
-{
-	/* restart autonegotiation */
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = np->vsi;
-	struct ice_port_info *pi;
-	enum ice_status status;
-
-	pi = vsi->port_info;
-	/* If VSI state is up, then restart autoneg with link up */
-	if (!test_bit(__ICE_DOWN, vsi->back->state))
-		status = ice_aq_set_link_restart_an(pi, true, NULL);
-	else
-		status = ice_aq_set_link_restart_an(pi, false, NULL);
-
-	if (status) {
-		netdev_info(netdev, "link restart failed, err %d aq_err %d\n",
-			    status, pi->hw->adminq.sq_last_status);
-		return -EIO;
-	}
-
-	return 0;
-}
-
 /**
  * ice_get_pauseparam - Get Flow Control status
  * @netdev: network interface device structure
-- 
2.20.1

