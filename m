From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Mar 2021 15:35:10 -0700
Subject: [Intel-wired-lan] [PATCH S57 07/14] ice: Fix error return codes in
 ice_set_link_ksettings
In-Reply-To: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
Message-ID: <20210325223517.17722-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

Return more appropriate error codes so that the right error
message is communicated to the user by ethtool.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 989b0b0e3cad..643012b0cc67 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2212,7 +2212,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 	pi = np->vsi->port_info;
 
 	if (!pi)
-		return -EOPNOTSUPP;
+		return -EIO;
 
 	if (pi->phy.media_type != ICE_MEDIA_BASET &&
 	    pi->phy.media_type != ICE_MEDIA_FIBER &&
@@ -2229,7 +2229,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP_MEDIA,
 				     phy_caps, NULL);
 	if (status) {
-		err = -EAGAIN;
+		err = -EIO;
 		goto done;
 	}
 
@@ -2252,7 +2252,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 			   __ETHTOOL_LINK_MODE_MASK_NBITS)) {
 		if (!test_bit(ICE_FLAG_LINK_LENIENT_MODE_ENA, pf->flags))
 			netdev_info(netdev, "The selected speed is not supported by the current media. Please select a link speed that is supported by the current media.\n");
-		err = -EINVAL;
+		err = -EOPNOTSUPP;
 		goto done;
 	}
 
@@ -2304,7 +2304,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 	pi->phy.get_link_info = true;
 	status = ice_get_link_status(pi, &linkup);
 	if (status) {
-		err = -EAGAIN;
+		err = -EIO;
 		goto done;
 	}
 
@@ -2335,7 +2335,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 	/* check if there is a PHY type for the requested advertised speed */
 	if (!(phy_type_low || phy_type_high)) {
 		netdev_info(netdev, "The selected speed is not supported by the current media. Please select a link speed that is supported by the current media.\n");
-		err = -EAGAIN;
+		err = -EOPNOTSUPP;
 		goto done;
 	}
 
@@ -2359,7 +2359,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 					      pf->nvm_phy_type_lo;
 		} else {
 			netdev_info(netdev, "The selected speed is not supported by the current media. Please select a link speed that is supported by the current media.\n");
-			err = -EAGAIN;
+			err = -EOPNOTSUPP;
 			goto done;
 		}
 	}
@@ -2378,7 +2378,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 	status = ice_aq_set_phy_cfg(&pf->hw, pi, &config, NULL);
 	if (status) {
 		netdev_info(netdev, "Set phy config failed,\n");
-		err = -EAGAIN;
+		err = -EIO;
 		goto done;
 	}
 
-- 
2.20.1

