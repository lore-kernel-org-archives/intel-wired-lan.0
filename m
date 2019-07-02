From: Alice Michael <alice.michael@intel.com>
Date: Tue,  2 Jul 2019 08:22:56 -0400
Subject: [Intel-wired-lan] [next PATCH S7 6/9] i40e: Update visual effect
 for advertised FEC mode.
In-Reply-To: <20190702122259.79070-1-alice.michael@intel.com>
References: <20190702122259.79070-1-alice.michael@intel.com>
Message-ID: <20190702122259.79070-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Czeslaw Zagorski <czeslawx.zagorski@intel.com>

Updates visual effect for advertised mode after setting desired mode.
The mode appears in advertised FEC mode correctly, when ethtool
interface command is called. Without this commit advertised FEC
is displayed regardless of the settings as "None BaseR RS".

Signed-off-by: Czeslaw Zagorski <czeslawx.zagorski@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 63 ++++++++++---------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 65e016f54f58..663de4fd7bbe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -710,6 +710,35 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
 	}
 }
 
+/**
+ * i40e_get_settings_link_up_fec - Get the FEC mode encoding from mask
+ * @req_fec_info: mask request fec info
+ * @ks: ethtool ksettings to fill in
+ **/
+static void i40e_get_settings_link_up_fec(u8 req_fec_info,
+					  struct ethtool_link_ksettings *ks)
+{
+	ethtool_link_ksettings_add_link_mode(ks, supported, FEC_NONE);
+	ethtool_link_ksettings_add_link_mode(ks, supported, FEC_RS);
+	ethtool_link_ksettings_add_link_mode(ks, supported, FEC_BASER);
+
+	if (I40E_AQ_SET_FEC_REQUEST_RS & req_fec_info) {
+		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_RS);
+	} else if (I40E_AQ_SET_FEC_REQUEST_KR & req_fec_info) {
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     FEC_BASER);
+	} else {
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     FEC_NONE);
+		if (I40E_AQ_SET_FEC_AUTO & req_fec_info) {
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     FEC_RS);
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     FEC_BASER);
+		}
+	}
+}
+
 /**
  * i40e_get_settings_link_up - Get the Link settings for when link is up
  * @hw: hw structure
@@ -769,13 +798,7 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 						     25000baseSR_Full);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
 						     25000baseSR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_NONE);
-		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_RS);
-		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_BASER);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_NONE);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_RS);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     FEC_BASER);
+		i40e_get_settings_link_up_fec(hw_link_info->req_fec_info, ks);
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     10000baseSR_Full);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
@@ -892,9 +915,6 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 						     40000baseKR4_Full);
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     25000baseKR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_NONE);
-		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_RS);
-		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_BASER);
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     20000baseKR2_Full);
 		ethtool_link_ksettings_add_link_mode(ks, supported,
@@ -908,10 +928,7 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 						     40000baseKR4_Full);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
 						     25000baseKR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_NONE);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_RS);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     FEC_BASER);
+		i40e_get_settings_link_up_fec(hw_link_info->req_fec_info, ks);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
 						     20000baseKR2_Full);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
@@ -929,13 +946,8 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 						     25000baseCR_Full);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
 						     25000baseCR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_NONE);
-		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_RS);
-		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_BASER);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_NONE);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_RS);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     FEC_BASER);
+		i40e_get_settings_link_up_fec(hw_link_info->req_fec_info, ks);
+
 		break;
 	case I40E_PHY_TYPE_25GBASE_AOC:
 	case I40E_PHY_TYPE_25GBASE_ACC:
@@ -945,13 +957,8 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 						     25000baseCR_Full);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
 						     25000baseCR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_NONE);
-		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_RS);
-		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_BASER);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_NONE);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_RS);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     FEC_BASER);
+		i40e_get_settings_link_up_fec(hw_link_info->req_fec_info, ks);
+
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     10000baseCR_Full);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
-- 
2.21.0

