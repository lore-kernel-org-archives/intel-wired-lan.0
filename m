From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  3 Sep 2015 17:18:52 -0400
Subject: [Intel-wired-lan] [next PATCH S15 05/15] i40e: Remove 100M SGMII
	unless hw is X722
In-Reply-To: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441315142-173025-6-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Only the X722 device now supports 100M SGMII, and nothing supports
100M on 1000Base_T.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I6f44dcd818944edd40041410e6de380f4a359a0c
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 42 ++++++++++++++++----------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 185ac91..a22f1d9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -255,7 +255,8 @@ static void i40e_partition_setting_complaint(struct i40e_pf *pf)
  **/
 static void i40e_get_settings_link_up(struct i40e_hw *hw,
 				      struct ethtool_cmd *ecmd,
-				      struct net_device *netdev)
+				      struct net_device *netdev,
+				      struct i40e_pf *pf)
 {
 	struct i40e_link_status *hw_link_info = &hw->phy.link_info;
 	u32 link_speed = hw_link_info->link_speed;
@@ -299,16 +300,18 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 		break;
 	case I40E_PHY_TYPE_10GBASE_T:
 	case I40E_PHY_TYPE_1000BASE_T:
-	case I40E_PHY_TYPE_100BASE_TX:
 		ecmd->supported = SUPPORTED_Autoneg |
 				  SUPPORTED_10000baseT_Full |
-				  SUPPORTED_1000baseT_Full |
-				  SUPPORTED_100baseT_Full;
+				  SUPPORTED_1000baseT_Full;
 		ecmd->advertising = ADVERTISED_Autoneg;
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
 			ecmd->advertising |= ADVERTISED_10000baseT_Full;
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
 			ecmd->advertising |= ADVERTISED_1000baseT_Full;
+		break;
+	case I40E_PHY_TYPE_100BASE_TX:
+		ecmd->supported = SUPPORTED_Autoneg |
+				  SUPPORTED_100baseT_Full;
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_100MB)
 			ecmd->advertising |= ADVERTISED_100baseT_Full;
 		break;
@@ -328,12 +331,15 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 		break;
 	case I40E_PHY_TYPE_SGMII:
 		ecmd->supported = SUPPORTED_Autoneg |
-				  SUPPORTED_1000baseT_Full |
-				  SUPPORTED_100baseT_Full;
+				  SUPPORTED_1000baseT_Full;
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
 			ecmd->advertising |= ADVERTISED_1000baseT_Full;
-		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_100MB)
-			ecmd->advertising |= ADVERTISED_100baseT_Full;
+		if (pf->hw.mac.type == I40E_MAC_X722) {
+			ecmd->supported |= SUPPORTED_100baseT_Full;
+			if (hw_link_info->requested_speeds &
+			    I40E_LINK_SPEED_100MB)
+				ecmd->advertising |= ADVERTISED_100baseT_Full;
+		}
 		break;
 	/* Backplane is set based on supported phy types in get_settings
 	 * so don't set anything here but don't warn either
@@ -381,7 +387,8 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
  * Reports link settings that can be determined when link is down
  **/
 static void i40e_get_settings_link_down(struct i40e_hw *hw,
-					struct ethtool_cmd *ecmd)
+					struct ethtool_cmd *ecmd,
+					struct i40e_pf *pf)
 {
 	enum i40e_aq_capabilities_phy_type phy_types = hw->phy.phy_types;
 
@@ -392,11 +399,13 @@ static void i40e_get_settings_link_down(struct i40e_hw *hw,
 	ecmd->advertising = 0x0;
 	if (phy_types & I40E_CAP_PHY_TYPE_SGMII) {
 		ecmd->supported |= SUPPORTED_Autoneg |
-				   SUPPORTED_1000baseT_Full |
-				   SUPPORTED_100baseT_Full;
+				SUPPORTED_1000baseT_Full;
 		ecmd->advertising |= ADVERTISED_Autoneg |
-				     ADVERTISED_1000baseT_Full |
-				     ADVERTISED_100baseT_Full;
+				     ADVERTISED_1000baseT_Full;
+		if (pf->hw.mac.type == I40E_MAC_X722) {
+			ecmd->supported |= SUPPORTED_100baseT_Full;
+			ecmd->advertising |= ADVERTISED_100baseT_Full;
+		}
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_XAUI ||
 	    phy_types & I40E_CAP_PHY_TYPE_XFI ||
@@ -425,7 +434,8 @@ static void i40e_get_settings_link_down(struct i40e_hw *hw,
 		ecmd->advertising |= ADVERTISED_Autoneg |
 				    ADVERTISED_40000baseCR4_Full;
 	}
-	if (phy_types & I40E_CAP_PHY_TYPE_100BASE_TX) {
+	if ((phy_types & I40E_CAP_PHY_TYPE_100BASE_TX) &&
+	    !(phy_types & I40E_CAP_PHY_TYPE_1000BASE_T)) {
 		ecmd->supported |= SUPPORTED_Autoneg |
 				   SUPPORTED_100baseT_Full;
 		ecmd->advertising |= ADVERTISED_Autoneg |
@@ -467,9 +477,9 @@ static int i40e_get_settings(struct net_device *netdev,
 	bool link_up = hw_link_info->link_info & I40E_AQ_LINK_UP;
 
 	if (link_up)
-		i40e_get_settings_link_up(hw, ecmd, netdev);
+		i40e_get_settings_link_up(hw, ecmd, netdev, pf);
 	else
-		i40e_get_settings_link_down(hw, ecmd);
+		i40e_get_settings_link_down(hw, ecmd, pf);
 
 	/* Now set the settings that don't rely on link being up/down */
 
-- 
1.9.3

