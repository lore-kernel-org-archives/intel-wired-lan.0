From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Thu, 25 Jun 2015 17:49:57 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Avoid needless phy access on
	copper phys
Message-ID: <20150626004957.67855.1341.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Avoid a needless phy access on copper phys to save the 10ms wait
time for each phy access. A helper function is introduced to
actually do the register access and process the contents.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |   64 +++++++++++++++++--------
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    1 
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 740e566cca07..90e2498638d3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -735,39 +735,61 @@ s32 ixgbe_setup_phy_link_speed_generic(struct ixgbe_hw *hw,
 }
 
 /**
- * ixgbe_get_copper_link_capabilities_generic - Determines link capabilities
+ * ixgbe_get_copper_speeds_supported - Get copper link speed from phy
  * @hw: pointer to hardware structure
- * @speed: pointer to link speed
- * @autoneg: boolean auto-negotiation value
  *
- * Determines the link capabilities by reading the AUTOC register.
+ * Determines the supported link capabilities by reading the PHY auto
+ * negotiation register.
  */
-s32 ixgbe_get_copper_link_capabilities_generic(struct ixgbe_hw *hw,
-					       ixgbe_link_speed *speed,
-					       bool *autoneg)
+static s32 ixgbe_get_copper_speeds_supported(struct ixgbe_hw *hw)
 {
-	s32 status;
 	u16 speed_ability;
-
-	*speed = 0;
-	*autoneg = true;
+	s32 status;
 
 	status = hw->phy.ops.read_reg(hw, MDIO_SPEED, MDIO_MMD_PMAPMD,
 				      &speed_ability);
+	if (status)
+		return status;
 
-	if (status == 0) {
-		if (speed_ability & MDIO_SPEED_10G)
-			*speed |= IXGBE_LINK_SPEED_10GB_FULL;
-		if (speed_ability & MDIO_PMA_SPEED_1000)
-			*speed |= IXGBE_LINK_SPEED_1GB_FULL;
-		if (speed_ability & MDIO_PMA_SPEED_100)
-			*speed |= IXGBE_LINK_SPEED_100_FULL;
+	if (speed_ability & MDIO_SPEED_10G)
+		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_10GB_FULL;
+	if (speed_ability & MDIO_PMA_SPEED_1000)
+		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_1GB_FULL;
+	if (speed_ability & MDIO_PMA_SPEED_100)
+		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_100_FULL;
+
+	switch (hw->mac.type) {
+	case ixgbe_mac_X550:
+		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_2_5GB_FULL;
+		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_5GB_FULL;
+		break;
+	case ixgbe_mac_X550EM_x:
+		hw->phy.speeds_supported &= ~IXGBE_LINK_SPEED_100_FULL;
+		break;
+	default:
+		break;
 	}
 
-	/* Internal PHY does not support 100 Mbps */
-	if (hw->mac.type == ixgbe_mac_X550EM_x)
-		*speed &= ~IXGBE_LINK_SPEED_100_FULL;
+	return 0;
+}
+
+/**
+ * ixgbe_get_copper_link_capabilities_generic - Determines link capabilities
+ * @hw: pointer to hardware structure
+ * @speed: pointer to link speed
+ * @autoneg: boolean auto-negotiation value
+ */
+s32 ixgbe_get_copper_link_capabilities_generic(struct ixgbe_hw *hw,
+					       ixgbe_link_speed *speed,
+					       bool *autoneg)
+{
+	s32 status = 0;
+
+	*autoneg = true;
+	if (!hw->phy.speeds_supported)
+		status = ixgbe_get_copper_speeds_supported(hw);
 
+	*speed = hw->phy.speeds_supported;
 	return status;
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index a3eec19c9fdf..63689192b149 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3384,6 +3384,7 @@ struct ixgbe_phy_info {
 	u32				phy_semaphore_mask;
 	bool                            reset_disable;
 	ixgbe_autoneg_advertised        autoneg_advertised;
+	ixgbe_link_speed		speeds_supported;
 	enum ixgbe_smart_speed          smart_speed;
 	bool                            smart_speed_active;
 	bool                            multispeed_fiber;

