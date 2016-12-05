From: Ryan Schaefer <ryanschaefer23@gmail.com>
Date: Mon,  5 Dec 2016 09:02:13 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Switch to ETHTOOL_xLINKSETTINGS API
Message-ID: <1480957333-4451-1-git-send-email-ryanschaefer23@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Switch to new ethtool api in preparation for support of advertising
2.5GBaseT and 5GBaseT.

Fixes a bug introduced in 9a799d7, which sets 1000baseT supported
flags instead of 100baseT flag.

Signed-off-by: Ryan Schaefer <ryanschaefer23@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 237 ++++++++++++++---------
 include/linux/ethtool.h                          |  34 ++++
 2 files changed, 178 insertions(+), 93 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index fd192bf..89afc48 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -158,29 +158,41 @@ static const char ixgbe_gstrings_test[][ETH_GSTRING_LEN] = {
 
 #define ixgbe_isbackplane(type) ((type) == ixgbe_media_type_backplane)
 
-static u32 ixgbe_get_supported_10gtypes(struct ixgbe_hw *hw)
+static void ixgbe_set_supported_10gtypes(struct ixgbe_hw *hw,
+					 struct ethtool_link_ksettings *cmd)
 {
-	if (!ixgbe_isbackplane(hw->phy.media_type))
-		return SUPPORTED_10000baseT_Full;
+	if (!ixgbe_isbackplane(hw->phy.media_type)) {
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     10000baseT_Full);
+		return;
+	}
 
 	switch (hw->device_id) {
 	case IXGBE_DEV_ID_82598:
 	case IXGBE_DEV_ID_82599_KX4:
 	case IXGBE_DEV_ID_82599_KX4_MEZZ:
 	case IXGBE_DEV_ID_X550EM_X_KX4:
-		return SUPPORTED_10000baseKX4_Full;
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     10000baseKX4_Full);
+		break;
 	case IXGBE_DEV_ID_82598_BX:
 	case IXGBE_DEV_ID_82599_KR:
 	case IXGBE_DEV_ID_X550EM_X_KR:
-		return SUPPORTED_10000baseKR_Full;
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     10000baseKR_Full);
+		break;
 	default:
-		return SUPPORTED_10000baseKX4_Full |
-		       SUPPORTED_10000baseKR_Full;
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     10000baseKX4_Full);
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     10000baseKR_Full);
+		break;
 	}
+	return;
 }
 
-static int ixgbe_get_settings(struct net_device *netdev,
-			      struct ethtool_cmd *ecmd)
+static int ixgbe_get_link_ksettings(struct net_device *netdev,
+				    struct ethtool_link_ksettings *cmd)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
@@ -191,46 +203,66 @@ static int ixgbe_get_settings(struct net_device *netdev,
 
 	/* set the supported link speeds */
 	if (supported_link & IXGBE_LINK_SPEED_10GB_FULL)
-		ecmd->supported |= ixgbe_get_supported_10gtypes(hw);
-	if (supported_link & IXGBE_LINK_SPEED_1GB_FULL)
-		ecmd->supported |= (ixgbe_isbackplane(hw->phy.media_type)) ?
-				   SUPPORTED_1000baseKX_Full :
-				   SUPPORTED_1000baseT_Full;
+		ixgbe_set_supported_10gtypes(hw, cmd);
+	if (supported_link & IXGBE_LINK_SPEED_1GB_FULL) {
+		if (ixgbe_isbackplane(hw->phy.media_type))
+			ethtool_link_ksettings_add_link_mode(cmd, supported,
+							     1000baseKX_Full);
+		else
+			ethtool_link_ksettings_add_link_mode(cmd, supported,
+							     1000baseT_Full);
+	}
 	if (supported_link & IXGBE_LINK_SPEED_100_FULL)
-		ecmd->supported |= ixgbe_isbackplane(hw->phy.media_type) ?
-				   SUPPORTED_1000baseKX_Full :
-				   SUPPORTED_1000baseT_Full;
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     100baseT_Full);
 
 	/* default advertised speed if phy.autoneg_advertised isn't set */
-	ecmd->advertising = ecmd->supported;
+	ethtool_link_ksettings_copy_link_mode(cmd, advertising, supported);
 	/* set the advertised speeds */
 	if (hw->phy.autoneg_advertised) {
-		ecmd->advertising = 0;
+		ethtool_link_ksettings_zero_link_mode(cmd, advertising);
 		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_100_FULL)
-			ecmd->advertising |= ADVERTISED_100baseT_Full;
-		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_10GB_FULL)
-			ecmd->advertising |= ecmd->supported & ADVRTSD_MSK_10G;
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     100baseT_Full);
+		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_10GB_FULL) {
+			if (ethtool_link_ksettings_test_link_mode(cmd,
+						supported, 10000baseT_Full))
+				ethtool_link_ksettings_add_link_mode(cmd,
+						advertising, 10000baseT_Full);
+
+			if (ethtool_link_ksettings_test_link_mode(cmd,
+						supported, 10000baseKX4_Full))
+				ethtool_link_ksettings_add_link_mode(cmd,
+						advertising, 10000baseKX4_Full);
+
+			if (ethtool_link_ksettings_test_link_mode(cmd,
+						supported, 10000baseKR_Full))
+				ethtool_link_ksettings_add_link_mode(cmd,
+						advertising, 10000baseKR_Full);
+		}
 		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_1GB_FULL) {
-			if (ecmd->supported & SUPPORTED_1000baseKX_Full)
-				ecmd->advertising |= ADVERTISED_1000baseKX_Full;
+			if (ethtool_link_ksettings_test_link_mode(cmd,
+						supported, 1000baseKX_Full))
+				ethtool_link_ksettings_add_link_mode(cmd,
+						advertising, 1000baseKX_Full);
 			else
-				ecmd->advertising |= ADVERTISED_1000baseT_Full;
+				ethtool_link_ksettings_add_link_mode(cmd,
+						advertising, 1000baseT_Full);
 		}
 	} else {
 		if (hw->phy.multispeed_fiber && !autoneg) {
 			if (supported_link & IXGBE_LINK_SPEED_10GB_FULL)
-				ecmd->advertising = ADVERTISED_10000baseT_Full;
+				ethtool_link_ksettings_add_link_mode(cmd,
+						advertising, 1000baseT_Full);
 		}
 	}
 
 	if (autoneg) {
-		ecmd->supported |= SUPPORTED_Autoneg;
-		ecmd->advertising |= ADVERTISED_Autoneg;
-		ecmd->autoneg = AUTONEG_ENABLE;
+		ethtool_link_ksettings_add_link_mode(cmd, supported, Autoneg);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising, Autoneg);
+		cmd->base.autoneg = AUTONEG_ENABLE;
 	} else
-		ecmd->autoneg = AUTONEG_DISABLE;
-
-	ecmd->transceiver = XCVR_EXTERNAL;
+		cmd->base.autoneg = AUTONEG_DISABLE;
 
 	/* Determine the remaining settings based on the PHY type. */
 	switch (adapter->hw.phy.type) {
@@ -238,14 +270,14 @@ static int ixgbe_get_settings(struct net_device *netdev,
 	case ixgbe_phy_aq:
 	case ixgbe_phy_x550em_ext_t:
 	case ixgbe_phy_cu_unknown:
-		ecmd->supported |= SUPPORTED_TP;
-		ecmd->advertising |= ADVERTISED_TP;
-		ecmd->port = PORT_TP;
+		ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
+		cmd->base.port = PORT_TP;
 		break;
 	case ixgbe_phy_qt:
-		ecmd->supported |= SUPPORTED_FIBRE;
-		ecmd->advertising |= ADVERTISED_FIBRE;
-		ecmd->port = PORT_FIBRE;
+		ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
+		cmd->base.port = PORT_FIBRE;
 		break;
 	case ixgbe_phy_nl:
 	case ixgbe_phy_sfp_passive_tyco:
@@ -263,9 +295,11 @@ static int ixgbe_get_settings(struct net_device *netdev,
 		case ixgbe_sfp_type_da_cu:
 		case ixgbe_sfp_type_da_cu_core0:
 		case ixgbe_sfp_type_da_cu_core1:
-			ecmd->supported |= SUPPORTED_FIBRE;
-			ecmd->advertising |= ADVERTISED_FIBRE;
-			ecmd->port = PORT_DA;
+			ethtool_link_ksettings_add_link_mode(cmd, supported,
+							     FIBRE);
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     FIBRE);
+			cmd->base.port = PORT_DA;
 			break;
 		case ixgbe_sfp_type_sr:
 		case ixgbe_sfp_type_lr:
@@ -275,91 +309,103 @@ static int ixgbe_get_settings(struct net_device *netdev,
 		case ixgbe_sfp_type_1g_sx_core1:
 		case ixgbe_sfp_type_1g_lx_core0:
 		case ixgbe_sfp_type_1g_lx_core1:
-			ecmd->supported |= SUPPORTED_FIBRE;
-			ecmd->advertising |= ADVERTISED_FIBRE;
-			ecmd->port = PORT_FIBRE;
+			ethtool_link_ksettings_add_link_mode(cmd, supported,
+							     FIBRE);
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     FIBRE);
+			cmd->base.port = PORT_FIBRE;
 			break;
 		case ixgbe_sfp_type_not_present:
-			ecmd->supported |= SUPPORTED_FIBRE;
-			ecmd->advertising |= ADVERTISED_FIBRE;
-			ecmd->port = PORT_NONE;
+			ethtool_link_ksettings_add_link_mode(cmd, supported,
+							     FIBRE);
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     FIBRE);
+			cmd->base.port = PORT_NONE;
 			break;
 		case ixgbe_sfp_type_1g_cu_core0:
 		case ixgbe_sfp_type_1g_cu_core1:
-			ecmd->supported |= SUPPORTED_TP;
-			ecmd->advertising |= ADVERTISED_TP;
-			ecmd->port = PORT_TP;
+			ethtool_link_ksettings_add_link_mode(cmd, supported,
+							     TP);
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     TP);
+			cmd->base.port = PORT_TP;
 			break;
 		case ixgbe_sfp_type_unknown:
 		default:
-			ecmd->supported |= SUPPORTED_FIBRE;
-			ecmd->advertising |= ADVERTISED_FIBRE;
-			ecmd->port = PORT_OTHER;
+			ethtool_link_ksettings_add_link_mode(cmd, supported,
+							     FIBRE);
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     FIBRE);
+			cmd->base.port = PORT_OTHER;
 			break;
 		}
 		break;
 	case ixgbe_phy_xaui:
-		ecmd->supported |= SUPPORTED_FIBRE;
-		ecmd->advertising |= ADVERTISED_FIBRE;
-		ecmd->port = PORT_NONE;
+		ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
+		cmd->base.port = PORT_NONE;
 		break;
 	case ixgbe_phy_unknown:
 	case ixgbe_phy_generic:
 	case ixgbe_phy_sfp_unsupported:
 	default:
-		ecmd->supported |= SUPPORTED_FIBRE;
-		ecmd->advertising |= ADVERTISED_FIBRE;
-		ecmd->port = PORT_OTHER;
+		ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
+		cmd->base.port = PORT_OTHER;
 		break;
 	}
 
 	/* Indicate pause support */
-	ecmd->supported |= SUPPORTED_Pause;
+	ethtool_link_ksettings_add_link_mode(cmd, supported, Pause);
 
 	switch (hw->fc.requested_mode) {
 	case ixgbe_fc_full:
-		ecmd->advertising |= ADVERTISED_Pause;
+		ethtool_link_ksettings_add_link_mode(cmd, advertising, Pause);
 		break;
 	case ixgbe_fc_rx_pause:
-		ecmd->advertising |= ADVERTISED_Pause |
-				     ADVERTISED_Asym_Pause;
+		ethtool_link_ksettings_add_link_mode(cmd, advertising, Pause);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     Asym_Pause);
 		break;
 	case ixgbe_fc_tx_pause:
-		ecmd->advertising |= ADVERTISED_Asym_Pause;
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     Asym_Pause);
 		break;
 	default:
-		ecmd->advertising &= ~(ADVERTISED_Pause |
-				       ADVERTISED_Asym_Pause);
+		ethtool_link_ksettings_remove_link_mode(cmd, advertising,
+							Pause);
+		ethtool_link_ksettings_remove_link_mode(cmd, advertising,
+							Asym_Pause);
 	}
 
 	if (netif_carrier_ok(netdev)) {
 		switch (adapter->link_speed) {
 		case IXGBE_LINK_SPEED_10GB_FULL:
-			ethtool_cmd_speed_set(ecmd, SPEED_10000);
+			cmd->base.speed = SPEED_10000;
 			break;
 		case IXGBE_LINK_SPEED_2_5GB_FULL:
-			ethtool_cmd_speed_set(ecmd, SPEED_2500);
+			cmd->base.speed = SPEED_2500;
 			break;
 		case IXGBE_LINK_SPEED_1GB_FULL:
-			ethtool_cmd_speed_set(ecmd, SPEED_1000);
+			cmd->base.speed = SPEED_1000;
 			break;
 		case IXGBE_LINK_SPEED_100_FULL:
-			ethtool_cmd_speed_set(ecmd, SPEED_100);
+			cmd->base.speed = SPEED_100;
 			break;
 		default:
 			break;
 		}
-		ecmd->duplex = DUPLEX_FULL;
+		cmd->base.duplex = DUPLEX_FULL;
 	} else {
-		ethtool_cmd_speed_set(ecmd, SPEED_UNKNOWN);
-		ecmd->duplex = DUPLEX_UNKNOWN;
+		cmd->base.speed = SPEED_UNKNOWN;
+		cmd->base.duplex = DUPLEX_UNKNOWN;
 	}
 
 	return 0;
 }
 
-static int ixgbe_set_settings(struct net_device *netdev,
-			      struct ethtool_cmd *ecmd)
+static int ixgbe_set_link_ksettings(struct net_device *netdev,
+				    const struct ethtool_link_ksettings *cmd)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
@@ -372,30 +418,34 @@ static int ixgbe_set_settings(struct net_device *netdev,
 		 * this function does not support duplex forcing, but can
 		 * limit the advertising of the adapter to the specified speed
 		 */
-		if (ecmd->advertising & ~ecmd->supported)
+		if (!ethtool_link_ksettings_subset_link_mode(cmd, advertising,
+							     supported))
 			return -EINVAL;
 
 		/* only allow one speed at a time if no autoneg */
-		if (!ecmd->autoneg && hw->phy.multispeed_fiber) {
-			if (ecmd->advertising ==
-			    (ADVERTISED_10000baseT_Full |
-			     ADVERTISED_1000baseT_Full))
+		if (!cmd->base.autoneg && hw->phy.multispeed_fiber)
+			if (ethtool_link_ksettings_test_link_mode(cmd,
+						advertising, 10000baseT_Full) ||
+			    ethtool_link_ksettings_test_link_mode(cmd,
+						advertising, 1000baseT_Full))
 				return -EINVAL;
-		}
 
 		old = hw->phy.autoneg_advertised;
 		advertised = 0;
-		if (ecmd->advertising & ADVERTISED_10000baseT_Full)
+		if (ethtool_link_ksettings_test_link_mode(cmd,
+					advertising, 10000baseT_Full))
 			advertised |= IXGBE_LINK_SPEED_10GB_FULL;
-
-		if (ecmd->advertising & ADVERTISED_1000baseT_Full)
+		if (ethtool_link_ksettings_test_link_mode(cmd,
+							  advertising,
+							  1000baseT_Full))
 			advertised |= IXGBE_LINK_SPEED_1GB_FULL;
-
-		if (ecmd->advertising & ADVERTISED_100baseT_Full)
+		if (ethtool_link_ksettings_test_link_mode(cmd,
+							  advertising,
+							  100baseT_Full))
 			advertised |= IXGBE_LINK_SPEED_100_FULL;
-
 		if (old == advertised)
 			return err;
+
 		/* this sets the link speed and restarts auto-neg */
 		while (test_and_set_bit(__IXGBE_IN_SFP_INIT, &adapter->state))
 			usleep_range(1000, 2000);
@@ -409,10 +459,11 @@ static int ixgbe_set_settings(struct net_device *netdev,
 		clear_bit(__IXGBE_IN_SFP_INIT, &adapter->state);
 	} else {
 		/* in this case we currently only support 10Gb/FULL */
-		u32 speed = ethtool_cmd_speed(ecmd);
-		if ((ecmd->autoneg == AUTONEG_ENABLE) ||
-		    (ecmd->advertising != ADVERTISED_10000baseT_Full) ||
-		    (speed + ecmd->duplex != SPEED_10000 + DUPLEX_FULL))
+		u32 speed = cmd->base.speed;
+		if ((cmd->base.autoneg == AUTONEG_ENABLE) ||
+		    (!ethtool_link_ksettings_test_link_mode(cmd, advertising,
+							    10000baseT_Full)) ||
+		    (speed + cmd->base.duplex != SPEED_10000 + DUPLEX_FULL))
 			return -EINVAL;
 	}
 
@@ -3238,8 +3289,8 @@ static int ixgbe_get_module_eeprom(struct net_device *dev,
 }
 
 static const struct ethtool_ops ixgbe_ethtool_ops = {
-	.get_settings           = ixgbe_get_settings,
-	.set_settings           = ixgbe_set_settings,
+	.get_link_ksettings     = ixgbe_get_link_ksettings,
+	.set_link_ksettings     = ixgbe_set_link_ksettings,
 	.get_drvinfo            = ixgbe_get_drvinfo,
 	.get_regs_len           = ixgbe_get_regs_len,
 	.get_regs               = ixgbe_get_regs,
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 9ded8c6..94434a6 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -124,6 +124,29 @@ struct ethtool_link_ksettings {
 	bitmap_zero((ptr)->link_modes.name, __ETHTOOL_LINK_MODE_MASK_NBITS)
 
 /**
+ * ethtool_link_ksettings_subset_link_mode - check if link mode mask
+ * modes are a subset of one another
+ *   @ptr : pointer to struct ethtool_link_ksettings
+ *   @src1 : one of supported/advertising/lp_advertising
+ *   @src2 : one of supported/advertising/lp_advertising
+ *
+ * Returns true/false
+ */
+#define ethtool_link_ksettings_subset_link_mode(ptr, src1, src2)	\
+	bitmap_subset((ptr)->link_modes.src1, (ptr)->link_modes.src2,	\
+	__ETHTOOL_LINK_MODE_MASK_NBITS)
+
+/**
+ * ethtool_link_ksettings_copy_link_mode - mask ksettings mask
+ *   @ptr : pointer to struct ethtool_link_ksettings
+ *   @dst : one of supported/advertising/lp_advertising
+ *   @src : one of supported/advertising/lp_advertising
+ */
+#define ethtool_link_ksettings_copy_link_mode(ptr, dst, src)	\
+	bitmap_copy((ptr)->link_modes.dst, (ptr)->link_modes.src,	\
+	 __ETHTOOL_LINK_MODE_MASK_NBITS)				\
+
+/**
  * ethtool_link_ksettings_add_link_mode - set bit in link_ksettings
  * link mode mask
  *   @ptr : pointer to struct ethtool_link_ksettings
@@ -135,6 +158,17 @@ struct ethtool_link_ksettings {
 	__set_bit(ETHTOOL_LINK_MODE_ ## mode ## _BIT, (ptr)->link_modes.name)
 
 /**
+ * ethtool_link_ksettings_remove_link_mode - set bit in link_ksettings
+ * link mode mask
+ *   @ptr : pointer to struct ethtool_link_ksettings
+ *   @name : one of supported/advertising/lp_advertising
+ *   @mode : one of the ETHTOOL_LINK_MODE_*_BIT
+ * (not atomic, no bound checking)
+ */
+#define ethtool_link_ksettings_remove_link_mode(ptr, name, mode)	\
+	__clear_bit(ETHTOOL_LINK_MODE_ ## mode ## _BIT, (ptr)->link_modes.name)
+
+/**
  * ethtool_link_ksettings_test_link_mode - test bit in ksettings link mode mask
  *   @ptr : pointer to struct ethtool_link_ksettings
  *   @name : one of supported/advertising/lp_advertising
-- 
2.7.4

