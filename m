From: Alice Michael <alice.michael@intel.com>
Date: Thu, 28 Feb 2019 09:52:51 -0800
Subject: [Intel-wired-lan] [next PATCH S3 5/9] i40e: Report advertised link
 modes on 40GBase_LR4, CR4 and fibre
In-Reply-To: <20190228175255.54754-1-alice.michael@intel.com>
References: <20190228175255.54754-1-alice.michael@intel.com>
Message-ID: <20190228175255.54754-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>

Add assignments for advertising 40GBase_LR4, 40GBase_CR4 and fibre

Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 14b52f8aedd0..304ae6799de3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -541,9 +541,12 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
 						     40000baseSR4_Full);
 	}
-	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_LR4)
+	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_LR4) {
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     40000baseLR4_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     40000baseLR4_Full);
+	}
 	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_KR4) {
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     40000baseLR4_Full);
@@ -723,6 +726,8 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 	case I40E_PHY_TYPE_40GBASE_AOC:
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     40000baseCR4_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     40000baseCR4_Full);
 		break;
 	case I40E_PHY_TYPE_40GBASE_SR4:
 		ethtool_link_ksettings_add_link_mode(ks, supported,
@@ -733,6 +738,8 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 	case I40E_PHY_TYPE_40GBASE_LR4:
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     40000baseLR4_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     40000baseLR4_Full);
 		break;
 	case I40E_PHY_TYPE_25GBASE_SR:
 	case I40E_PHY_TYPE_25GBASE_LR:
@@ -1038,6 +1045,7 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
 		break;
 	case I40E_MEDIA_TYPE_FIBER:
 		ethtool_link_ksettings_add_link_mode(ks, supported, FIBRE);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, FIBRE);
 		ks->base.port = PORT_FIBRE;
 		break;
 	case I40E_MEDIA_TYPE_UNKNOWN:
-- 
2.19.2

