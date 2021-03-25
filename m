From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Mar 2021 15:35:11 -0700
Subject: [Intel-wired-lan] [PATCH S57 08/14] ice: Replace some memsets and
 memcpys with assignment
In-Reply-To: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
Message-ID: <20210325223517.17722-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

In ice_set_link_ksettings, use assignment instead of memset/memcpy
where possible

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 643012b0cc67..273647188f69 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2195,8 +2195,9 @@ ice_set_link_ksettings(struct net_device *netdev,
 		       const struct ethtool_link_ksettings *ks)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ethtool_link_ksettings safe_ks, copy_ks;
 	u8 autoneg, timeout = TEST_SET_BITS_TIMEOUT;
+	struct ethtool_link_ksettings copy_ks = *ks;
+	struct ethtool_link_ksettings safe_ks = {};
 	struct ice_aqc_get_phy_caps_data *phy_caps;
 	struct ice_aqc_set_phy_cfg_data config;
 	u16 adv_link_speed, curr_link_speed;
@@ -2233,14 +2234,9 @@ ice_set_link_ksettings(struct net_device *netdev,
 		goto done;
 	}
 
-	/* copy the ksettings to copy_ks to avoid modifying the original */
-	memcpy(&copy_ks, ks, sizeof(copy_ks));
-
 	/* save autoneg out of ksettings */
 	autoneg = copy_ks.base.autoneg;
 
-	memset(&safe_ks, 0, sizeof(safe_ks));
-
 	/* Get link modes supported by hardware.*/
 	ice_phy_type_to_ethtool(netdev, &safe_ks);
 
@@ -2289,7 +2285,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 	 * configuration is initialized during probe from PHY capabilities
 	 * software mode, and updated on set PHY configuration.
 	 */
-	memcpy(&config, &pi->phy.curr_user_phy_cfg, sizeof(config));
+	config = pi->phy.curr_user_phy_cfg;
 
 	config.caps |= ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
 
-- 
2.20.1

