From: Alice Michael <alice.michael@intel.com>
Date: Wed,  6 Feb 2019 11:36:20 -0800
Subject: [Intel-wired-lan] [next PATCH S2 11/13] i40e: Report advertised
 link modes on 40GBASE_SR4
In-Reply-To: <20190206193622.69370-1-alice.michael@intel.com>
References: <20190206193622.69370-1-alice.michael@intel.com>
Message-ID: <20190206193622.69370-11-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>

Defined the advertised link mode field for 40000baseSR4_Full for
use with ethtool.

Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 4e347637e36a..14b52f8aedd0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -535,9 +535,12 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
 			ethtool_link_ksettings_add_link_mode(ks, advertising,
 							     1000baseT_Full);
 	}
-	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_SR4)
+	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_SR4) {
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     40000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     40000baseSR4_Full);
+	}
 	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_LR4)
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     40000baseLR4_Full);
@@ -724,6 +727,8 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 	case I40E_PHY_TYPE_40GBASE_SR4:
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     40000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     40000baseSR4_Full);
 		break;
 	case I40E_PHY_TYPE_40GBASE_LR4:
 		ethtool_link_ksettings_add_link_mode(ks, supported,
-- 
2.19.2

