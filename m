From: Alice Michael <alice.michael@intel.com>
Date: Tue, 29 Aug 2017 05:32:40 -0400
Subject: [Intel-wired-lan] [next PATCH S79-V2 11/13] i40e: do not enter PHY
	debug mode while setting LEDs behaviour
In-Reply-To: <20170829093242.41026-1-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
Message-ID: <20170829093242.41026-11-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mariusz Stachura <mariusz.stachura@intel.com>

Previous implementation of LED set/get functions required to enter
PHY debug mode, in order to prevent access to it from FW and SW at
the same time. Reset of all ports was a unwanted side effect.

Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 5fab6c5..72da511 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2010,7 +2010,9 @@ static int i40e_set_phys_id(struct net_device *netdev,
 		if (!(pf->hw_features & I40E_HW_PHY_CONTROLS_LEDS)) {
 			pf->led_status = i40e_led_get(hw);
 		} else {
-			i40e_aq_set_phy_debug(hw, I40E_PHY_DEBUG_ALL, NULL);
+			if (!(hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE))
+				i40e_aq_set_phy_debug(hw, I40E_PHY_DEBUG_ALL,
+						      NULL);
 			ret = i40e_led_get_phy(hw, &temp_status,
 					       &pf->phy_led_val);
 			pf->led_status = temp_status;
@@ -2035,7 +2037,8 @@ static int i40e_set_phys_id(struct net_device *netdev,
 			ret = i40e_led_set_phy(hw, false, pf->led_status,
 					       (pf->phy_led_val |
 					       I40E_PHY_LED_MODE_ORIG));
-			i40e_aq_set_phy_debug(hw, 0, NULL);
+			if (!(hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE))
+				i40e_aq_set_phy_debug(hw, 0, NULL);
 		}
 		break;
 	default:
-- 
2.9.4

