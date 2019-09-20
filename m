From: Alice Michael <alice.michael@intel.com>
Date: Fri, 20 Sep 2019 02:17:17 -0700
Subject: [Intel-wired-lan] [next PATCH S10 03/10] i40e: Wrong 'Advertised
 FEC modes' after set FEC to AUTO
In-Reply-To: <20190920091724.51767-1-alice.michael@intel.com>
References: <20190920091724.51767-1-alice.michael@intel.com>
Message-ID: <20190920091724.51767-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jaroslaw Gawin <jaroslawx.gawin@intel.com>

Fix display of parameters "Configured FEC encodings:" and "Advertised
FEC modes:" in ethtool.  Implemented by setting proper FEC bits in
?advertising? bitmask of link_modes struct and ?fec? bitmask in
ethtool_fecparam struct. Without this patch wrong FEC settings
can be shown.

Signed-off-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 13 ++++++--
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 32 +++++++++----------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index d37c6e0e5f08..f1d67267c983 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2570,9 +2570,16 @@ noinline_for_stack i40e_status i40e_update_link_info(struct i40e_hw *hw)
 		if (status)
 			return status;
 
-		hw->phy.link_info.req_fec_info =
-			abilities.fec_cfg_curr_mod_ext_info &
-			(I40E_AQ_REQUEST_FEC_KR | I40E_AQ_REQUEST_FEC_RS);
+		if (abilities.fec_cfg_curr_mod_ext_info &
+		    I40E_AQ_ENABLE_FEC_AUTO)
+			hw->phy.link_info.req_fec_info =
+				(I40E_AQ_REQUEST_FEC_KR |
+				 I40E_AQ_REQUEST_FEC_RS);
+		else
+			hw->phy.link_info.req_fec_info =
+				abilities.fec_cfg_curr_mod_ext_info &
+				(I40E_AQ_REQUEST_FEC_KR |
+				 I40E_AQ_REQUEST_FEC_RS);
 
 		memcpy(hw->phy.link_info.module_type, &abilities.module_type,
 		       sizeof(hw->phy.link_info.module_type));
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c814c756b4bb..765bc5174ead 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -761,7 +761,14 @@ static void i40e_get_settings_link_up_fec(u8 req_fec_info,
 	ethtool_link_ksettings_add_link_mode(ks, supported, FEC_RS);
 	ethtool_link_ksettings_add_link_mode(ks, supported, FEC_BASER);
 
-	if (I40E_AQ_SET_FEC_REQUEST_RS & req_fec_info) {
+	if ((I40E_AQ_SET_FEC_REQUEST_RS & req_fec_info) &&
+	    (I40E_AQ_SET_FEC_REQUEST_KR & req_fec_info)) {
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     FEC_NONE);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     FEC_BASER);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_RS);
+	} else if (I40E_AQ_SET_FEC_REQUEST_RS & req_fec_info) {
 		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_RS);
 	} else if (I40E_AQ_SET_FEC_REQUEST_KR & req_fec_info) {
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
@@ -769,12 +776,6 @@ static void i40e_get_settings_link_up_fec(u8 req_fec_info,
 	} else {
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
 						     FEC_NONE);
-		if (I40E_AQ_SET_FEC_AUTO & req_fec_info) {
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     FEC_RS);
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     FEC_BASER);
-		}
 	}
 }
 
@@ -1476,6 +1477,7 @@ static int i40e_get_fec_param(struct net_device *netdev,
 	struct i40e_hw *hw = &pf->hw;
 	i40e_status status = 0;
 	int err = 0;
+	u8 fec_cfg;
 
 	/* Get the current phy config */
 	memset(&abilities, 0, sizeof(abilities));
@@ -1487,18 +1489,16 @@ static int i40e_get_fec_param(struct net_device *netdev,
 	}
 
 	fecparam->fec = 0;
-	if (abilities.fec_cfg_curr_mod_ext_info & I40E_AQ_SET_FEC_AUTO)
+	fec_cfg = abilities.fec_cfg_curr_mod_ext_info;
+	if (fec_cfg & I40E_AQ_SET_FEC_AUTO)
 		fecparam->fec |= ETHTOOL_FEC_AUTO;
-	if ((abilities.fec_cfg_curr_mod_ext_info &
-	     I40E_AQ_SET_FEC_REQUEST_RS) ||
-	    (abilities.fec_cfg_curr_mod_ext_info &
-	     I40E_AQ_SET_FEC_ABILITY_RS))
+	else if (fec_cfg & (I40E_AQ_SET_FEC_REQUEST_RS |
+		 I40E_AQ_SET_FEC_ABILITY_RS))
 		fecparam->fec |= ETHTOOL_FEC_RS;
-	if ((abilities.fec_cfg_curr_mod_ext_info &
-	     I40E_AQ_SET_FEC_REQUEST_KR) ||
-	    (abilities.fec_cfg_curr_mod_ext_info & I40E_AQ_SET_FEC_ABILITY_KR))
+	else if (fec_cfg & (I40E_AQ_SET_FEC_REQUEST_KR |
+		 I40E_AQ_SET_FEC_ABILITY_KR))
 		fecparam->fec |= ETHTOOL_FEC_BASER;
-	if (abilities.fec_cfg_curr_mod_ext_info == 0)
+	if (fec_cfg == 0)
 		fecparam->fec |= ETHTOOL_FEC_OFF;
 
 	if (hw->phy.link_info.fec_info & I40E_AQ_CONFIG_FEC_KR_ENA)
-- 
2.21.0

