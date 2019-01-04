From: Jan-Marek Glogowski <glogow@fbihome.de>
Date: Fri,  4 Jan 2019 14:31:07 +0100
Subject: [Intel-wired-lan] [PATCH 3/3] e1000e: add some status debug output
In-Reply-To: <1546608667-25498-1-git-send-email-glogow@fbihome.de>
References: <e080046a-6630-ad07-ebbb-603e820766f4@fbihome.de>
 <1546608667-25498-1-git-send-email-glogow@fbihome.de>
Message-ID: <1546608667-25498-4-git-send-email-glogow@fbihome.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add dynamic debug info for flow control advertising and dump
the status when extracting speed and duplex from it.

Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
---
 drivers/net/ethernet/intel/e1000e/mac.c | 10 +++++++---
 drivers/net/ethernet/intel/e1000e/phy.c |  6 +++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index ada8fbb..daa7be8 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -1310,10 +1310,14 @@ s32 e1000e_get_speed_and_duplex_copper(struct e1000_hw *hw, u16 *speed,
 
 	status = er32(STATUS);
 
-	if (status & E1000_STATUS_AUTONEG)
+	if (status & E1000_STATUS_AUTONEG) {
+		e_dbg("status 0x%x => in auto-neg, no valid config\n", status);
 		return 1;
-	if (!(status & E1000_STATUS_LU))
+	}
+	if (!(status & E1000_STATUS_LU)) {
+		e_dbg("status 0x%x => no link, no valid config\n", status);
 		return 1;
+	}
 
 	if (status & E1000_STATUS_SPEED_1000)
 		*speed = SPEED_1000;
@@ -1327,7 +1331,7 @@ s32 e1000e_get_speed_and_duplex_copper(struct e1000_hw *hw, u16 *speed,
 	else
 		*duplex = HALF_DUPLEX;
 
-	e_dbg("%u Mbps, %s Duplex\n",
+	e_dbg("status 0x%x => %u Mbps, %s Duplex\n", status,
 	      *speed == SPEED_1000 ? 1000 : *speed == SPEED_100 ? 100 : 10,
 	      *duplex == FULL_DUPLEX ? "Full" : "Half");
 
diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index 4223301..91da35c 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -1011,6 +1011,7 @@ static s32 e1000_phy_setup_autoneg(struct e1000_hw *hw)
 		 */
 		mii_autoneg_adv_reg &=
 		    ~(ADVERTISE_PAUSE_ASYM | ADVERTISE_PAUSE_CAP);
+		e_dbg("Advertise no flow control\n");
 		break;
 	case e1000_fc_rx_pause:
 		/* Rx Flow control is enabled, and Tx Flow control is
@@ -1024,6 +1025,7 @@ static s32 e1000_phy_setup_autoneg(struct e1000_hw *hw)
 		 */
 		mii_autoneg_adv_reg |=
 		    (ADVERTISE_PAUSE_ASYM | ADVERTISE_PAUSE_CAP);
+		e_dbg("Advertise no flow control\n");
 		break;
 	case e1000_fc_tx_pause:
 		/* Tx Flow control is enabled, and Rx Flow control is
@@ -1031,6 +1033,7 @@ static s32 e1000_phy_setup_autoneg(struct e1000_hw *hw)
 		 */
 		mii_autoneg_adv_reg |= ADVERTISE_PAUSE_ASYM;
 		mii_autoneg_adv_reg &= ~ADVERTISE_PAUSE_CAP;
+		e_dbg("Advertise Tx flow control\n");
 		break;
 	case e1000_fc_full:
 		/* Flow control (both Rx and Tx) is enabled by a software
@@ -1038,6 +1041,7 @@ static s32 e1000_phy_setup_autoneg(struct e1000_hw *hw)
 		 */
 		mii_autoneg_adv_reg |=
 		    (ADVERTISE_PAUSE_ASYM | ADVERTISE_PAUSE_CAP);
+		e_dbg("Advertise Tx and Rx flow control\n");
 		break;
 	default:
 		e_dbg("Flow control param set incorrectly\n");
@@ -1048,7 +1052,7 @@ static s32 e1000_phy_setup_autoneg(struct e1000_hw *hw)
 	if (ret_val)
 		return ret_val;
 
-	e_dbg("Auto-Neg Advertising %x\n", mii_autoneg_adv_reg);
+	e_dbg("Auto-Neg Advertising 0x%x\n", mii_autoneg_adv_reg);
 
 	if (phy->autoneg_mask & ADVERTISE_1000_FULL)
 		ret_val = e1e_wphy(hw, MII_CTRL1000, mii_1000t_ctrl_reg);
-- 
2.1.4

