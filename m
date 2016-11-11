From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 10 Nov 2016 16:01:33 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Support 2.5Gb and 5Gb speed
Message-ID: <1478822493-29862-1-git-send-email-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Though not advertised through ethtool, if the link partner advertises a
2.5Gb or 5Gb connection, and the adapter supports it, allow the speed to be
used.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  3 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c     | 10 +++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index fd192bf..55c8a23 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -337,6 +337,9 @@ static int ixgbe_get_settings(struct net_device *netdev,
 		case IXGBE_LINK_SPEED_10GB_FULL:
 			ethtool_cmd_speed_set(ecmd, SPEED_10000);
 			break;
+		case IXGBE_LINK_SPEED_5GB_FULL:
+			ethtool_cmd_speed_set(ecmd, SPEED_5000);
+			break;
 		case IXGBE_LINK_SPEED_2_5GB_FULL:
 			ethtool_cmd_speed_set(ecmd, SPEED_2500);
 			break;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 4aa6793..372a1c8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -768,9 +768,7 @@ s32 ixgbe_setup_phy_link_speed_generic(struct ixgbe_hw *hw,
 				       ixgbe_link_speed speed,
 				       bool autoneg_wait_to_complete)
 {
-
-	/*
-	 * Clear autoneg_advertised and set new values based on input link
+	/* Clear autoneg_advertised and set new values based on input link
 	 * speed.
 	 */
 	hw->phy.autoneg_advertised = 0;
@@ -778,6 +776,12 @@ s32 ixgbe_setup_phy_link_speed_generic(struct ixgbe_hw *hw,
 	if (speed & IXGBE_LINK_SPEED_10GB_FULL)
 		hw->phy.autoneg_advertised |= IXGBE_LINK_SPEED_10GB_FULL;
 
+	if (speed & IXGBE_LINK_SPEED_5GB_FULL)
+		hw->phy.autoneg_advertised |= IXGBE_LINK_SPEED_5GB_FULL;
+
+	if (speed & IXGBE_LINK_SPEED_2_5GB_FULL)
+		hw->phy.autoneg_advertised |= IXGBE_LINK_SPEED_2_5GB_FULL;
+
 	if (speed & IXGBE_LINK_SPEED_1GB_FULL)
 		hw->phy.autoneg_advertised |= IXGBE_LINK_SPEED_1GB_FULL;
 
-- 
2.4.0

