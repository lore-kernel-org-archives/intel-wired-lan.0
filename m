From: Veola <veola.nazareth@intel.com>
Date: Wed, 11 Nov 2015 16:22:59 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: report correct media type for KR,
 KX and KX4 interfaces
Message-ID: <20151111232259.4471.80984.stgit@larettin-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ethtool reports backplane type interfaces as 1000/10000baseT link modes.
This has been corrected to report the media as KR, KX or KX4 based on the backplane interface present.

Signed-off-by: Veola <veola.nazareth@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   54 +++++++++++++++++-----
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index d681273..1222677 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -151,6 +151,34 @@ static const char ixgbe_gstrings_test[][ETH_GSTRING_LEN] = {
 };
 #define IXGBE_TEST_LEN sizeof(ixgbe_gstrings_test) / ETH_GSTRING_LEN
 
+/* currently supported speeds for 10G */
+#define ADVRTSD_MSK_10G (SUPPORTED_10000baseT_Full | \
+			 SUPPORTED_10000baseKX4_Full | \
+			 SUPPORTED_10000baseKR_Full)
+
+#define ixgbe_isbackplane(type) ((type) == ixgbe_media_type_backplane)
+
+static u32 ixgbe_get_supported_10gtypes(struct ixgbe_hw *hw)
+{
+	if (!ixgbe_isbackplane(hw->phy.media_type))
+		return SUPPORTED_10000baseT_Full;
+
+	switch (hw->device_id) {
+	case IXGBE_DEV_ID_82598:
+	case IXGBE_DEV_ID_82599_KX4:
+	case IXGBE_DEV_ID_82599_KX4_MEZZ:
+	case IXGBE_DEV_ID_X550EM_X_KX4:
+		return SUPPORTED_10000baseKX4_Full;
+	case IXGBE_DEV_ID_82598_BX:
+	case IXGBE_DEV_ID_82599_KR:
+	case IXGBE_DEV_ID_X550EM_X_KR:
+		return SUPPORTED_10000baseKR_Full;
+	default:
+		return SUPPORTED_10000baseKX4_Full |
+		       SUPPORTED_10000baseKR_Full;
+	}
+}
+
 static int ixgbe_get_settings(struct net_device *netdev,
 			      struct ethtool_cmd *ecmd)
 {
@@ -165,33 +193,33 @@ static int ixgbe_get_settings(struct net_device *netdev,
 
 	/* set the supported link speeds */
 	if (supported_link & IXGBE_LINK_SPEED_10GB_FULL)
-		ecmd->supported |= SUPPORTED_10000baseT_Full;
+		ecmd->supported |= ixgbe_get_supported_10gtypes(hw);
 	if (supported_link & IXGBE_LINK_SPEED_2_5GB_FULL)
 		ecmd->supported |= SUPPORTED_2500baseX_Full;
 	if (supported_link & IXGBE_LINK_SPEED_1GB_FULL)
-		ecmd->supported |= SUPPORTED_1000baseT_Full;
+		ecmd->supported |= (ixgbe_isbackplane(hw->phy.media_type)) ?
+			SUPPORTED_1000baseKX_Full : SUPPORTED_1000baseT_Full;
 	if (supported_link & IXGBE_LINK_SPEED_100_FULL)
 		ecmd->supported |= SUPPORTED_100baseT_Full;
 
+	/* default advertised speed if phy.autoneg_advertised isn't set */
+	ecmd->advertising = ecmd->supported;
 	/* set the advertised speeds */
 	if (hw->phy.autoneg_advertised) {
+		ecmd->advertising = 0;
 		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_100_FULL)
 			ecmd->advertising |= ADVERTISED_100baseT_Full;
 		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_10GB_FULL)
-			ecmd->advertising |= ADVERTISED_10000baseT_Full;
+			ecmd->advertising |= ecmd->supported & ADVRTSD_MSK_10G;
 		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_2_5GB_FULL)
 			ecmd->advertising |= ADVERTISED_2500baseX_Full;
-		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_1GB_FULL)
-			ecmd->advertising |= ADVERTISED_1000baseT_Full;
+		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_1GB_FULL) {
+			if (ecmd->supported & SUPPORTED_1000baseKX_Full)
+				ecmd->advertising |= ADVERTISED_1000baseKX_Full;
+			else
+				ecmd->advertising |= ADVERTISED_1000baseT_Full;
+		}
 	} else {
-		/* default modes in case phy.autoneg_advertised isn't set */
-		if (supported_link & IXGBE_LINK_SPEED_10GB_FULL)
-			ecmd->advertising |= ADVERTISED_10000baseT_Full;
-		if (supported_link & IXGBE_LINK_SPEED_1GB_FULL)
-			ecmd->advertising |= ADVERTISED_1000baseT_Full;
-		if (supported_link & IXGBE_LINK_SPEED_100_FULL)
-			ecmd->advertising |= ADVERTISED_100baseT_Full;
-
 		if (hw->phy.multispeed_fiber && !autoneg) {
 			if (supported_link & IXGBE_LINK_SPEED_10GB_FULL)
 				ecmd->advertising = ADVERTISED_10000baseT_Full;

