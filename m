From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  7 Jun 2017 14:36:18 -0700
Subject: [Intel-wired-lan] [PATCH 2/5] ixgbe: Enable LASI interrupts for
	X552 devices
In-Reply-To: <20170607213621.18256-1-anthony.l.nguyen@intel.com>
References: <20170607213621.18256-1-anthony.l.nguyen@intel.com>
Message-ID: <20170607213621.18256-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Enable LASI interrupts on X552 devices in order to receive notifications of
link configurations of the external PHY and support the configuration of
the internal iXFI link since iXFI does not support auto-negotiation.  This
is not required for X553 devices; add a check to avoid enabling LASI
interrupts for X553 devices.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 31 +++++++++++++++++++--------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index b90d676..a1bf67b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2404,17 +2404,30 @@ static s32 ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
 	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc);
 
 	/* Enable link status change alarm */
-	status = hw->phy.ops.read_reg(hw, IXGBE_MDIO_PMA_TX_VEN_LASI_INT_MASK,
-				      MDIO_MMD_AN, &reg);
-	if (status)
-		return status;
 
-	reg |= IXGBE_MDIO_PMA_TX_VEN_LASI_INT_EN;
+	/* Enable the LASI interrupts on X552 devices to receive notifications
+	 * of the link configurations of the external PHY and correspondingly
+	 * support the configuration of the internal iXFI link, since iXFI does
+	 * not support auto-negotiation. This is not required for X553 devices
+	 * having KR support, which performs auto-negotiations and which is used
+	 * as the internal link to the external PHY. Hence adding a check here
+	 * to avoid enabling LASI interrupts for X553 devices.
+	 */
+	if (hw->mac.type != ixgbe_mac_x550em_a) {
+		status = hw->phy.ops.read_reg(hw,
+					    IXGBE_MDIO_PMA_TX_VEN_LASI_INT_MASK,
+					    MDIO_MMD_AN, &reg);
+		if (status)
+			return status;
+
+		reg |= IXGBE_MDIO_PMA_TX_VEN_LASI_INT_EN;
 
-	status = hw->phy.ops.write_reg(hw, IXGBE_MDIO_PMA_TX_VEN_LASI_INT_MASK,
-				       MDIO_MMD_AN, reg);
-	if (status)
-		return status;
+		status = hw->phy.ops.write_reg(hw,
+					    IXGBE_MDIO_PMA_TX_VEN_LASI_INT_MASK,
+					    MDIO_MMD_AN, reg);
+		if (status)
+			return status;
+	}
 
 	/* Enable high temperature failure and global fault alarms */
 	status = hw->phy.ops.read_reg(hw, IXGBE_MDIO_GLOBAL_INT_MASK,
-- 
2.9.3

