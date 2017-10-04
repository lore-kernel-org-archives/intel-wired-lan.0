From: Alan Brady <alan.brady@intel.com>
Date: Wed,  4 Oct 2017 10:58:36 -0700
Subject: [Intel-wired-lan] [PATCH 10/13 net-next] i40e: convert
	i40e_phy_type_to_ethtool to new API
In-Reply-To: <20171004175839.28364-1-alan.brady@intel.com>
References: <20171004175839.28364-1-alan.brady@intel.com>
Message-ID: <20171004175839.28364-11-alan.brady@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We are still largely using the old ethtool API macros.  This is
problematic because eventually they will be removed and they only
support 32 bits of PHY types.

This overhauls i40e_phy_type_to_ethtool to use only the new API.  Doing
this also allows us to provide much better support for newer 25G and 10G
PHY types which is included here as well.

The remaining usages of the old ethtool API will be addressed in other
patches in the series.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 227 ++++++++++++++++++-------
 1 file changed, 163 insertions(+), 64 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 6ac5c7f232c6..76530a83eb70 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -241,6 +241,29 @@ static const struct i40e_priv_flags i40e_gl_gstrings_priv_flags[] = {
 
 #define I40E_GL_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_gl_gstrings_priv_flags)
 
+#define I40E_ETHTOOL_LINK_MASK_SIZE \
+	BITS_TO_LONGS(__ETHTOOL_LINK_MODE_MASK_NBITS)
+
+/**
+ * i40e_intersect_link_mode_masks
+ * @dst: resulting intersection and first mask
+ * @src: mask to AND with
+ *
+ * Given two link mode masks, AND them together and save the result in dst.
+ */
+static void i40e_intersect_link_masks(struct ethtool_link_ksettings *dst,
+				      struct ethtool_link_ksettings *src)
+{
+	int idx = 0;
+
+	for (; idx < I40E_ETHTOOL_LINK_MASK_SIZE; idx++) {
+		dst->link_modes.supported[idx] &=
+			src->link_modes.supported[idx];
+		dst->link_modes.advertising[idx] &=
+			src->link_modes.advertising[idx];
+	}
+}
+
 /**
  * i40e_partition_setting_complaint - generic complaint for MFP restriction
  * @pf: the PF struct
@@ -254,95 +277,180 @@ static void i40e_partition_setting_complaint(struct i40e_pf *pf)
 /**
  * i40e_phy_type_to_ethtool - convert the phy_types to ethtool link modes
  * @pf: PF struct with phy_types
- * @supported: pointer to the ethtool supported variable to fill in
- * @advertising: pointer to the ethtool advertising variable to fill in
+ * @ks: ethtool link ksettings struct to fill out
  *
  **/
-static void i40e_phy_type_to_ethtool(struct i40e_pf *pf, u32 *supported,
-				     u32 *advertising)
+static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
+				     struct ethtool_link_ksettings *ks)
 {
 	struct i40e_link_status *hw_link_info = &pf->hw.phy.link_info;
 	u64 phy_types = pf->hw.phy.phy_types;
 
-	*supported = 0x0;
-	*advertising = 0x0;
+	ethtool_link_ksettings_zero_link_mode(ks, supported);
+	ethtool_link_ksettings_zero_link_mode(ks, advertising);
 
 	if (phy_types & I40E_CAP_PHY_TYPE_SGMII) {
-		*supported |= SUPPORTED_1000baseT_Full;
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     1000baseT_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
-			*advertising |= ADVERTISED_1000baseT_Full;
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     1000baseT_Full);
 		if (pf->hw_features & I40E_HW_100M_SGMII_CAPABLE) {
-			*supported |= SUPPORTED_100baseT_Full;
-			*advertising |= ADVERTISED_100baseT_Full;
+			ethtool_link_ksettings_add_link_mode(ks, supported,
+							     100baseT_Full);
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     100baseT_Full);
 		}
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_XAUI ||
 	    phy_types & I40E_CAP_PHY_TYPE_XFI ||
 	    phy_types & I40E_CAP_PHY_TYPE_SFI ||
 	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_SFPP_CU ||
-	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_AOC)
-		*supported |= SUPPORTED_10000baseT_Full;
-	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_CR1_CU ||
-	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_CR1 ||
-	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_T ||
-	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_SR ||
-	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_LR) {
-		*supported |= SUPPORTED_10000baseT_Full;
+	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_AOC) {
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     10000baseT_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     10000baseT_Full);
+	}
+	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_T) {
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     10000baseT_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
-			*advertising |= ADVERTISED_10000baseT_Full;
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     10000baseT_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_XLAUI ||
 	    phy_types & I40E_CAP_PHY_TYPE_XLPPI ||
 	    phy_types & I40E_CAP_PHY_TYPE_40GBASE_AOC)
-		*supported |= SUPPORTED_40000baseCR4_Full;
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     40000baseCR4_Full);
 	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_CR4_CU ||
 	    phy_types & I40E_CAP_PHY_TYPE_40GBASE_CR4) {
-		*supported |= SUPPORTED_40000baseCR4_Full;
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     40000baseCR4_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_40GB)
-			*advertising |= ADVERTISED_40000baseCR4_Full;
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     40000baseCR4_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_100BASE_TX) {
-		*supported |= SUPPORTED_100baseT_Full;
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     100baseT_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_100MB)
-			*advertising |= ADVERTISED_100baseT_Full;
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     100baseT_Full);
 	}
-	if (phy_types & I40E_CAP_PHY_TYPE_1000BASE_T ||
-	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_SX ||
-	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_LX ||
-	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_T_OPTICAL) {
-		*supported |= SUPPORTED_1000baseT_Full;
+	if (phy_types & I40E_CAP_PHY_TYPE_1000BASE_T) {
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     1000baseT_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
-			*advertising |= ADVERTISED_1000baseT_Full;
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     1000baseT_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_SR4)
-		*supported |= SUPPORTED_40000baseSR4_Full;
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     40000baseSR4_Full);
 	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_LR4)
-		*supported |= SUPPORTED_40000baseLR4_Full;
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     40000baseLR4_Full);
 	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_KR4) {
-		*supported |= SUPPORTED_40000baseKR4_Full;
-		*advertising |= ADVERTISED_40000baseKR4_Full;
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     40000baseLR4_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     40000baseLR4_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_20GBASE_KR2) {
-		*supported |= SUPPORTED_20000baseKR2_Full;
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     20000baseKR2_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_20GB)
-			*advertising |= ADVERTISED_20000baseKR2_Full;
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     20000baseKR2_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_KX4) {
-		*supported |= SUPPORTED_10000baseKX4_Full;
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     10000baseKX4_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
-			*advertising |= ADVERTISED_10000baseKX4_Full;
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     10000baseKX4_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_KR &&
 	    !(pf->hw_features & I40E_HW_HAVE_CRT_RETIMER)) {
-		*supported |= SUPPORTED_10000baseKR_Full;
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     10000baseKR_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
-			*advertising |= ADVERTISED_10000baseKR_Full;
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     10000baseKR_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_1000BASE_KX &&
 	    !(pf->hw_features & I40E_HW_HAVE_CRT_RETIMER)) {
-		*supported |= SUPPORTED_1000baseKX_Full;
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     1000baseKX_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     1000baseKX_Full);
+	}
+	/* need to add 25G PHY types */
+	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_KR) {
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     25000baseKR_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     25000baseKR_Full);
+	}
+	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_CR) {
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     25000baseCR_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     25000baseCR_Full);
+	}
+	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_SR ||
+	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_LR) {
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     25000baseSR_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     25000baseSR_Full);
+	}
+	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_AOC ||
+	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_ACC) {
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     25000baseCR_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     25000baseCR_Full);
+	}
+	/* need to add new 10G PHY types */
+	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_CR1 ||
+	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_CR1_CU) {
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     10000baseCR_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     10000baseCR_Full);
+	}
+	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_SR) {
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     10000baseSR_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     10000baseSR_Full);
+	}
+	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_LR) {
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     10000baseLR_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     10000baseLR_Full);
+	}
+	if (phy_types & I40E_CAP_PHY_TYPE_1000BASE_SX ||
+	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_LX ||
+	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_T_OPTICAL) {
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     1000baseX_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
-			*advertising |= ADVERTISED_1000baseKX_Full;
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     1000baseX_Full);
 	}
 	/* Autoneg PHY types */
 	if (phy_types & I40E_CAP_PHY_TYPE_SGMII ||
@@ -367,8 +475,10 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf, u32 *supported,
 	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_LX ||
 	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_KX ||
 	    phy_types & I40E_CAP_PHY_TYPE_100BASE_TX) {
-		*supported |= SUPPORTED_Autoneg;
-		*advertising |= ADVERTISED_Autoneg;
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     Autoneg);
 	}
 }
 
@@ -385,9 +495,8 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 				      struct i40e_pf *pf)
 {
 	struct i40e_link_status *hw_link_info = &hw->phy.link_info;
+	struct ethtool_link_ksettings cap_ksettings;
 	u32 link_speed = hw_link_info->link_speed;
-	u32 e_advertising = 0x0;
-	u32 e_supported = 0x0;
 	u32 supported, advertising;
 
 	ethtool_convert_link_mode_to_legacy_u32(&supported,
@@ -519,11 +628,13 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 	 * current PHY type, get what is supported by the NVM and intersect
 	 * them to get what is truly supported
 	 */
-	i40e_phy_type_to_ethtool(pf, &e_supported,
-				 &e_advertising);
-
-	supported = supported & e_supported;
-	advertising = advertising & e_advertising;
+	ethtool_convert_legacy_u32_to_link_mode(ks->link_modes.supported,
+						supported);
+	ethtool_convert_legacy_u32_to_link_mode(ks->link_modes.advertising,
+						advertising);
+	memset(&cap_ksettings, 0, sizeof(struct ethtool_link_ksettings));
+	i40e_phy_type_to_ethtool(pf, &cap_ksettings);
+	i40e_intersect_link_masks(ks, &cap_ksettings);
 
 	/* Set speed and duplex */
 	switch (link_speed) {
@@ -549,11 +660,6 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 		break;
 	}
 	ks->base.duplex = DUPLEX_FULL;
-
-	ethtool_convert_legacy_u32_to_link_mode(ks->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(ks->link_modes.advertising,
-						advertising);
 }
 
 /**
@@ -568,17 +674,10 @@ static void i40e_get_settings_link_down(struct i40e_hw *hw,
 					struct ethtool_link_ksettings *ks,
 					struct i40e_pf *pf)
 {
-	u32 supported, advertising;
-
 	/* link is down and the driver needs to fall back on
 	 * supported phy types to figure out what info to display
 	 */
-	i40e_phy_type_to_ethtool(pf, &supported, &advertising);
-
-	ethtool_convert_legacy_u32_to_link_mode(ks->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(ks->link_modes.advertising,
-						advertising);
+	i40e_phy_type_to_ethtool(pf, ks);
 
 	/* With no link speed and duplex are unknown */
 	ks->base.speed = SPEED_UNKNOWN;
-- 
2.14.1

