From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:16:58 -0400
Subject: [Intel-wired-lan] [next PATCH S17 09/11] i40e: Fix order of checks
	when enabling/disabling autoneg in ethtool
In-Reply-To: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443464220-148318-10-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We were previously checking if autoneg was allowed to change before
checking if autoneg was changing. We need to do this in the other order
or else we will erroneously return EINVAL when autoneg is not changing.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: Iff9f7d1c9bddc1ad1e5d227d4f42754f90155410
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 29 ++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index d196e0b..fcbe719 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -661,28 +661,31 @@ static int i40e_set_settings(struct net_device *netdev,
 
 	/* Check autoneg */
 	if (autoneg == AUTONEG_ENABLE) {
-		/* If autoneg is not supported, return error */
-		if (!(safe_ecmd.supported & SUPPORTED_Autoneg)) {
-			netdev_info(netdev, "Autoneg not supported on this phy\n");
-			return -EINVAL;
-		}
 		/* If autoneg was not already enabled */
 		if (!(hw->phy.link_info.an_info & I40E_AQ_AN_COMPLETED)) {
+			/* If autoneg is not supported, return error */
+			if (!(safe_ecmd.supported & SUPPORTED_Autoneg)) {
+				netdev_info(netdev, "Autoneg not supported on this phy\n");
+				return -EINVAL;
+			}
+			/* Autoneg is allowed to change */
 			config.abilities = abilities.abilities |
 					   I40E_AQ_PHY_ENABLE_AN;
 			change = true;
 		}
 	} else {
-		/* If autoneg is supported 10GBASE_T is the only phy that
-		 * can disable it, so otherwise return error
-		 */
-		if (safe_ecmd.supported & SUPPORTED_Autoneg &&
-		    hw->phy.link_info.phy_type != I40E_PHY_TYPE_10GBASE_T) {
-			netdev_info(netdev, "Autoneg cannot be disabled on this phy\n");
-			return -EINVAL;
-		}
 		/* If autoneg is currently enabled */
 		if (hw->phy.link_info.an_info & I40E_AQ_AN_COMPLETED) {
+			/* If autoneg is supported 10GBASE_T is the only phy
+			 * that can disable it, so otherwise return error
+			 */
+			if (safe_ecmd.supported & SUPPORTED_Autoneg &&
+			    hw->phy.link_info.phy_type !=
+			    I40E_PHY_TYPE_10GBASE_T) {
+				netdev_info(netdev, "Autoneg cannot be disabled on this phy\n");
+				return -EINVAL;
+			}
+			/* Autoneg is allowed to change */
 			config.abilities = abilities.abilities &
 					   ~I40E_AQ_PHY_ENABLE_AN;
 			change = true;
-- 
1.9.3

