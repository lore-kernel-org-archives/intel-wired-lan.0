From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Fri, 05 Jun 2015 00:51:34 -0400
Subject: [Intel-wired-lan] [net-next PATCH 2 11/13] ixgbe: fix X550 devices
	init flow
In-Reply-To: <20150605045038.26373.94842.stgit@dcs-desk.jf.intel.com>
References: <20150605045038.26373.94842.stgit@dcs-desk.jf.intel.com>
Message-ID: <20150605045134.26373.50079.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reviewing the X550 copper initi flow with the Si team resulted in a
new simplified flow.  We no longer wait for the PHY FW initialization
complete bit to be set as this bit is only set once by the PHY at power
on and then cleared on the first read. So only the first instance of
running SW (or possibly MAC FW) needs to initialize the PHY.

The PHY initialization has been simplified and now only requires that
the PHY FW be un-stalled
low-power mode or enabled the transceiver

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   68 +++++++------------------
 1 file changed, 19 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 7b9b124..4c5d94e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1516,65 +1516,35 @@ static s32 ixgbe_init_ext_t_x550em(struct ixgbe_hw *hw)
 {
 	s32 status;
 	u16 reg;
-	u32 retries = 2;
 
-	do {
-		/* decrement retries counter and exit if we hit 0 */
-		if (retries < 1) {
-			hw_dbg(hw, "External PHY not yet finished resetting.");
-			return IXGBE_ERR_PHY;
-		}
-		retries--;
-
-		status = hw->phy.ops.read_reg(hw,
-					      IXGBE_MDIO_TX_VENDOR_ALARMS_3,
-					      IXGBE_MDIO_PMA_PMD_DEV_TYPE,
-					      &reg);
-		if (status)
-			return status;
-
-		/* Verify PHY FW reset has completed */
-	} while ((reg & IXGBE_MDIO_TX_VENDOR_ALARMS_3_RST_MASK) != 1);
-
-	/* Set port to low power mode */
-	status = hw->phy.ops.read_reg(hw,
-				      IXGBE_MDIO_VENDOR_SPECIFIC_1_CONTROL,
-				      IXGBE_MDIO_VENDOR_SPECIFIC_1_DEV_TYPE,
-				      &reg);
-	if (status)
-		return status;
-
-	/* Enable the transmitter */
 	status = hw->phy.ops.read_reg(hw,
-				      IXGBE_MDIO_PMD_STD_TX_DISABLE_CNTR,
+				      IXGBE_MDIO_TX_VENDOR_ALARMS_3,
 				      IXGBE_MDIO_PMA_PMD_DEV_TYPE,
 				      &reg);
 	if (status)
 		return status;
 
-	reg &= ~IXGBE_MDIO_PMD_GLOBAL_TX_DISABLE;
-
-	status = hw->phy.ops.write_reg(hw,
-				       IXGBE_MDIO_PMD_STD_TX_DISABLE_CNTR,
-				       IXGBE_MDIO_PMA_PMD_DEV_TYPE,
-				       reg);
-	if (status)
-		return status;
+	/* If PHY FW reset completed bit is set then this is the first
+	 * SW instance after a power on so the PHY FW must be un-stalled.
+	 */
+	if (reg & IXGBE_MDIO_TX_VENDOR_ALARMS_3_RST_MASK) {
+		status = hw->phy.ops.read_reg(hw,
+					IXGBE_MDIO_GLOBAL_RES_PR_10,
+					IXGBE_MDIO_VENDOR_SPECIFIC_1_DEV_TYPE,
+					&reg);
+		if (status)
+			return status;
 
-	/* Un-stall the PHY FW */
-	status = hw->phy.ops.read_reg(hw,
-				      IXGBE_MDIO_GLOBAL_RES_PR_10,
-				      IXGBE_MDIO_VENDOR_SPECIFIC_1_DEV_TYPE,
-				      &reg);
-	if (status)
-		return status;
+		reg &= ~IXGBE_MDIO_POWER_UP_STALL;
 
-	reg &= ~IXGBE_MDIO_POWER_UP_STALL;
+		status = hw->phy.ops.write_reg(hw,
+					IXGBE_MDIO_GLOBAL_RES_PR_10,
+					IXGBE_MDIO_VENDOR_SPECIFIC_1_DEV_TYPE,
+					reg);
+		if (status)
+			return status;
+	}
 
-	status = hw->phy.ops.write_reg(hw,
-				       IXGBE_MDIO_GLOBAL_RES_PR_10,
-				       IXGBE_MDIO_VENDOR_SPECIFIC_1_DEV_TYPE,
-				       reg);
 	return status;
 }
 

