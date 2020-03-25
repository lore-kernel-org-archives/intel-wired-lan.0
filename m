From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 24 Mar 2020 17:38:22 -0700
Subject: [Intel-wired-lan] [PATCH 08/10] igc: Remove '\n' from log strings
 in igc_mac.c
In-Reply-To: <20200325003824.5487-1-andre.guedes@intel.com>
References: <20200325003824.5487-1-andre.guedes@intel.com>
Message-ID: <20200325003824.5487-9-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

To keep log strings in igc_mac.c consistent with the rest of the driver
code, this patch removes the '\n' character at the end. The newline
character is automatically added by netdev_dbg() so there is no changes
in the output.

Note: hw_dbg() is a macro that expands to netdev_dbg().

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.c | 42 ++++++++++++------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 12aa6b5fcb5d..2cd52b5c203d 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -37,7 +37,7 @@ s32 igc_disable_pcie_master(struct igc_hw *hw)
 	}
 
 	if (!timeout) {
-		hw_dbg("Master requests are pending.\n");
+		hw_dbg("Master requests are pending");
 		ret_val = -IGC_ERR_MASTER_REQUESTS_PENDING;
 		goto out;
 	}
@@ -61,12 +61,12 @@ void igc_init_rx_addrs(struct igc_hw *hw, u16 rar_count)
 	u32 i;
 
 	/* Setup the receive address */
-	hw_dbg("Programming MAC Address into RAR[0]\n");
+	hw_dbg("Programming MAC Address into RAR[0]");
 
 	hw->mac.ops.rar_set(hw, hw->mac.addr, 0);
 
 	/* Zero out the other (rar_entry_count - 1) receive addresses */
-	hw_dbg("Clearing RAR[1-%u]\n", rar_count - 1);
+	hw_dbg("Clearing RAR[1-%u]", rar_count - 1);
 	for (i = 1; i < rar_count; i++)
 		hw->mac.ops.rar_set(hw, mac_addr, i);
 }
@@ -138,7 +138,7 @@ s32 igc_setup_link(struct igc_hw *hw)
 	 */
 	hw->fc.current_mode = hw->fc.requested_mode;
 
-	hw_dbg("After fix-ups FlowControl is now = %x\n", hw->fc.current_mode);
+	hw_dbg("After fix-ups FlowControl is now = %x", hw->fc.current_mode);
 
 	/* Call the necessary media_type subroutine to configure the link. */
 	ret_val = hw->mac.ops.setup_physical_interface(hw);
@@ -150,7 +150,7 @@ s32 igc_setup_link(struct igc_hw *hw)
 	 * control is disabled, because it does not hurt anything to
 	 * initialize these registers.
 	 */
-	hw_dbg("Initializing the Flow Control address, type and timer regs\n");
+	hw_dbg("Initializing the Flow Control address, type and timer regs");
 	wr32(IGC_FCT, FLOW_CONTROL_TYPE);
 	wr32(IGC_FCAH, FLOW_CONTROL_ADDRESS_HIGH);
 	wr32(IGC_FCAL, FLOW_CONTROL_ADDRESS_LOW);
@@ -197,7 +197,7 @@ s32 igc_force_mac_fc(struct igc_hw *hw)
 	 *      3:  Both Rx and TX flow control (symmetric) is enabled.
 	 *  other:  No other values should be possible at this point.
 	 */
-	hw_dbg("hw->fc.current_mode = %u\n", hw->fc.current_mode);
+	hw_dbg("hw->fc.current_mode = %u", hw->fc.current_mode);
 
 	switch (hw->fc.current_mode) {
 	case igc_fc_none:
@@ -215,7 +215,7 @@ s32 igc_force_mac_fc(struct igc_hw *hw)
 		ctrl |= (IGC_CTRL_TFCE | IGC_CTRL_RFCE);
 		break;
 	default:
-		hw_dbg("Flow control param set incorrectly\n");
+		hw_dbg("Flow control param set incorrectly");
 		ret_val = -IGC_ERR_CONFIG;
 		goto out;
 	}
@@ -419,7 +419,7 @@ s32 igc_check_for_copper_link(struct igc_hw *hw)
 	 */
 	ret_val = igc_config_fc_after_link_up(hw);
 	if (ret_val)
-		hw_dbg("Error configuring flow control\n");
+		hw_dbg("Error configuring flow control");
 
 out:
 	return ret_val;
@@ -473,7 +473,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	}
 
 	if (ret_val) {
-		hw_dbg("Error forcing flow control settings\n");
+		hw_dbg("Error forcing flow control settings");
 		goto out;
 	}
 
@@ -497,7 +497,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 			goto out;
 
 		if (!(mii_status_reg & MII_SR_AUTONEG_COMPLETE)) {
-			hw_dbg("Copper PHY and Auto Neg has not completed.\n");
+			hw_dbg("Copper PHY and Auto Neg has not completed");
 			goto out;
 		}
 
@@ -558,10 +558,10 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 			 */
 			if (hw->fc.requested_mode == igc_fc_full) {
 				hw->fc.current_mode = igc_fc_full;
-				hw_dbg("Flow Control = FULL.\n");
+				hw_dbg("Flow Control = FULL");
 			} else {
 				hw->fc.current_mode = igc_fc_rx_pause;
-				hw_dbg("Flow Control = RX PAUSE frames only.\n");
+				hw_dbg("Flow Control = RX PAUSE frames only");
 			}
 		}
 
@@ -577,7 +577,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 			 (mii_nway_lp_ability_reg & NWAY_LPAR_PAUSE) &&
 			 (mii_nway_lp_ability_reg & NWAY_LPAR_ASM_DIR)) {
 			hw->fc.current_mode = igc_fc_tx_pause;
-			hw_dbg("Flow Control = TX PAUSE frames only.\n");
+			hw_dbg("Flow Control = TX PAUSE frames only");
 		}
 		/* For transmitting PAUSE frames ONLY.
 		 *
@@ -591,7 +591,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 			 !(mii_nway_lp_ability_reg & NWAY_LPAR_PAUSE) &&
 			 (mii_nway_lp_ability_reg & NWAY_LPAR_ASM_DIR)) {
 			hw->fc.current_mode = igc_fc_rx_pause;
-			hw_dbg("Flow Control = RX PAUSE frames only.\n");
+			hw_dbg("Flow Control = RX PAUSE frames only");
 		}
 		/* Per the IEEE spec, at this point flow control should be
 		 * disabled.  However, we want to consider that we could
@@ -617,10 +617,10 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 			 (hw->fc.requested_mode == igc_fc_tx_pause) ||
 			 (hw->fc.strict_ieee)) {
 			hw->fc.current_mode = igc_fc_none;
-			hw_dbg("Flow Control = NONE.\n");
+			hw_dbg("Flow Control = NONE");
 		} else {
 			hw->fc.current_mode = igc_fc_rx_pause;
-			hw_dbg("Flow Control = RX PAUSE frames only.\n");
+			hw_dbg("Flow Control = RX PAUSE frames only");
 		}
 
 		/* Now we need to do one last check...  If we auto-
@@ -629,7 +629,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 		 */
 		ret_val = hw->mac.ops.get_speed_and_duplex(hw, &speed, &duplex);
 		if (ret_val) {
-			hw_dbg("Error getting link speed and duplex\n");
+			hw_dbg("Error getting link speed and duplex");
 			goto out;
 		}
 
@@ -641,7 +641,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 		 */
 		ret_val = igc_force_mac_fc(hw);
 		if (ret_val) {
-			hw_dbg("Error forcing flow control settings\n");
+			hw_dbg("Error forcing flow control settings");
 			goto out;
 		}
 	}
@@ -669,7 +669,7 @@ s32 igc_get_auto_rd_done(struct igc_hw *hw)
 	}
 
 	if (i == AUTO_READ_DONE_TIMEOUT) {
-		hw_dbg("Auto read by HW from NVM has not completed.\n");
+		hw_dbg("Auto read by HW from NVM has not completed");
 		ret_val = -IGC_ERR_RESET;
 		goto out;
 	}
@@ -716,10 +716,10 @@ s32 igc_get_speed_and_duplex_copper(struct igc_hw *hw, u16 *speed,
 
 	if (status & IGC_STATUS_FD) {
 		*duplex = FULL_DUPLEX;
-		hw_dbg("Full Duplex\n");
+		hw_dbg("Full Duplex");
 	} else {
 		*duplex = HALF_DUPLEX;
-		hw_dbg("Half Duplex\n");
+		hw_dbg("Half Duplex");
 	}
 
 	return 0;
-- 
2.25.0

