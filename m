From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Fri, 21 Oct 2016 21:10:54 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe: Update setup PHY link to unset all
	speeds
Message-ID: <1477098654-29228-1-git-send-email-donald.c.skidmore@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch updates ixgbe_setup_phy_link_generic to set/unset
auto-negotiation for all speeds. This ensures that unsupported
speeds are unset. This is necessary since the PHY NVM may
advertise unsupported speeds.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 77 ++++++++++++++--------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 2019db5..e27798d9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -678,53 +678,52 @@ s32 ixgbe_setup_phy_link_generic(struct ixgbe_hw *hw)
 
 	ixgbe_get_copper_link_capabilities_generic(hw, &speed, &autoneg);
 
-	if (speed & IXGBE_LINK_SPEED_10GB_FULL) {
-		/* Set or unset auto-negotiation 10G advertisement */
-		hw->phy.ops.read_reg(hw, MDIO_AN_10GBT_CTRL,
-				     MDIO_MMD_AN,
-				     &autoneg_reg);
+	/* Set or unset auto-negotiation 10G advertisement */
+	hw->phy.ops.read_reg(hw, MDIO_AN_10GBT_CTRL, MDIO_MMD_AN, &autoneg_reg);
 
-		autoneg_reg &= ~MDIO_AN_10GBT_CTRL_ADV10G;
-		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_10GB_FULL)
-			autoneg_reg |= MDIO_AN_10GBT_CTRL_ADV10G;
+	autoneg_reg &= ~MDIO_AN_10GBT_CTRL_ADV10G;
+	if ((hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_10GB_FULL) &&
+	    (speed & IXGBE_LINK_SPEED_10GB_FULL))
+		autoneg_reg |= MDIO_AN_10GBT_CTRL_ADV10G;
 
-		hw->phy.ops.write_reg(hw, MDIO_AN_10GBT_CTRL,
-				      MDIO_MMD_AN,
-				      autoneg_reg);
-	}
+	hw->phy.ops.write_reg(hw, MDIO_AN_10GBT_CTRL, MDIO_MMD_AN, autoneg_reg);
 
-	if (speed & IXGBE_LINK_SPEED_1GB_FULL) {
-		/* Set or unset auto-negotiation 1G advertisement */
-		hw->phy.ops.read_reg(hw,
-				     IXGBE_MII_AUTONEG_VENDOR_PROVISION_1_REG,
-				     MDIO_MMD_AN,
-				     &autoneg_reg);
-
-		autoneg_reg &= ~IXGBE_MII_1GBASE_T_ADVERTISE;
-		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_1GB_FULL)
-			autoneg_reg |= IXGBE_MII_1GBASE_T_ADVERTISE;
+	hw->phy.ops.read_reg(hw, IXGBE_MII_AUTONEG_VENDOR_PROVISION_1_REG,
+			     MDIO_MMD_AN, &autoneg_reg);
 
-		hw->phy.ops.write_reg(hw,
-				      IXGBE_MII_AUTONEG_VENDOR_PROVISION_1_REG,
-				      MDIO_MMD_AN,
-				      autoneg_reg);
+	if (hw->mac.type == ixgbe_mac_X550) {
+		/* Set or unset auto-negotiation 5G advertisement */
+		autoneg_reg &= ~IXGBE_MII_5GBASE_T_ADVERTISE;
+		if ((hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_5GB_FULL) &&
+		    (speed & IXGBE_LINK_SPEED_5GB_FULL))
+			autoneg_reg |= IXGBE_MII_5GBASE_T_ADVERTISE;
+
+		/* Set or unset auto-negotiation 2.5G advertisement */
+		autoneg_reg &= ~IXGBE_MII_2_5GBASE_T_ADVERTISE;
+		if ((hw->phy.autoneg_advertised &
+		     IXGBE_LINK_SPEED_2_5GB_FULL) &&
+		    (speed & IXGBE_LINK_SPEED_2_5GB_FULL))
+			autoneg_reg |= IXGBE_MII_2_5GBASE_T_ADVERTISE;
 	}
 
-	if (speed & IXGBE_LINK_SPEED_100_FULL) {
-		/* Set or unset auto-negotiation 100M advertisement */
-		hw->phy.ops.read_reg(hw, MDIO_AN_ADVERTISE,
-				     MDIO_MMD_AN,
-				     &autoneg_reg);
+	/* Set or unset auto-negotiation 1G advertisement */
+	autoneg_reg &= ~IXGBE_MII_1GBASE_T_ADVERTISE;
+	if ((hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_1GB_FULL) &&
+	    (speed & IXGBE_LINK_SPEED_1GB_FULL))
+		autoneg_reg |= IXGBE_MII_1GBASE_T_ADVERTISE;
 
-		autoneg_reg &= ~(ADVERTISE_100FULL |
-				 ADVERTISE_100HALF);
-		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_100_FULL)
-			autoneg_reg |= ADVERTISE_100FULL;
+	hw->phy.ops.write_reg(hw, IXGBE_MII_AUTONEG_VENDOR_PROVISION_1_REG,
+			      MDIO_MMD_AN, autoneg_reg);
 
-		hw->phy.ops.write_reg(hw, MDIO_AN_ADVERTISE,
-				      MDIO_MMD_AN,
-				      autoneg_reg);
-	}
+	/* Set or unset auto-negotiation 100M advertisement */
+	hw->phy.ops.read_reg(hw, MDIO_AN_ADVERTISE, MDIO_MMD_AN, &autoneg_reg);
+
+	autoneg_reg &= ~(ADVERTISE_100FULL | ADVERTISE_100HALF);
+	if ((hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_100_FULL) &&
+	    (speed & IXGBE_LINK_SPEED_100_FULL))
+		autoneg_reg |= ADVERTISE_100FULL;
+
+	hw->phy.ops.write_reg(hw, MDIO_AN_ADVERTISE, MDIO_MMD_AN, autoneg_reg);
 
 	/* Blocked by MNG FW so don't reset PHY */
 	if (ixgbe_check_reset_blocked(hw))
-- 
2.4.3

