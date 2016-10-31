From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 31 Oct 2016 12:11:58 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix check for
	ixgbe_phy_x550em_ext_t reset
Message-ID: <1477941118-17973-1-git-send-email-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The generic PHY reset check we had previously is not sufficient for the
ixgbe_phy_x550em_ext_t PHY type.  Check 1.CC02.0 instead - same as
ixgbe_init_ext_t_x550().

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index e27798d9..b1711ff 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -451,10 +451,27 @@ s32 ixgbe_reset_phy_generic(struct ixgbe_hw *hw)
 	 */
 	for (i = 0; i < 30; i++) {
 		msleep(100);
-		hw->phy.ops.read_reg(hw, MDIO_CTRL1, MDIO_MMD_PHYXS, &ctrl);
-		if (!(ctrl & MDIO_CTRL1_RESET)) {
-			udelay(2);
-			break;
+		if (hw->phy.type == ixgbe_phy_x550em_ext_t) {
+			status = hw->phy.ops.read_reg(hw,
+						  IXGBE_MDIO_TX_VENDOR_ALARMS_3,
+						  MDIO_MMD_PMAPMD, &ctrl);
+			if (status)
+				return status;
+
+			if (ctrl & IXGBE_MDIO_TX_VENDOR_ALARMS_3_RST_MASK) {
+				udelay(2);
+				break;
+			}
+		} else {
+			status = hw->phy.ops.read_reg(hw, MDIO_CTRL1,
+						      MDIO_MMD_PHYXS, &ctrl);
+			if (status)
+				return status;
+
+			if (!(ctrl & MDIO_CTRL1_RESET)) {
+				udelay(2);
+				break;
+			}
 		}
 	}
 
-- 
2.4.0

