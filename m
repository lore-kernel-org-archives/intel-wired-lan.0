From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 24 Mar 2020 17:38:19 -0700
Subject: [Intel-wired-lan] [PATCH 05/10] igc: Use netdev log helpers in
 igc_base.c
In-Reply-To: <20200325003824.5487-1-andre.guedes@intel.com>
References: <20200325003824.5487-1-andre.guedes@intel.com>
Message-ID: <20200325003824.5487-6-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch coverts one pr_debug() call to hw_dbg() in order to keep log
output aligned with the rest of the driver. hw_dbg() is actually a macro
defined in igc_hw.h that expands to netdev_dbg().

It also takes this opportunity to remove the '\n' character at the end
of messages since it is automatically added to by netdev_dbg().

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index f7fb18d8d8f5..9722db75064f 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -26,9 +26,9 @@ static s32 igc_reset_hw_base(struct igc_hw *hw)
 	 */
 	ret_val = igc_disable_pcie_master(hw);
 	if (ret_val)
-		hw_dbg("PCI-E Master disable polling has failed.\n");
+		hw_dbg("PCI-E Master disable polling has failed");
 
-	hw_dbg("Masking off all interrupts\n");
+	hw_dbg("Masking off all interrupts");
 	wr32(IGC_IMC, 0xffffffff);
 
 	wr32(IGC_RCTL, 0);
@@ -39,7 +39,7 @@ static s32 igc_reset_hw_base(struct igc_hw *hw)
 
 	ctrl = rd32(IGC_CTRL);
 
-	hw_dbg("Issuing a global reset to MAC\n");
+	hw_dbg("Issuing a global reset to MAC");
 	wr32(IGC_CTRL, ctrl | IGC_CTRL_DEV_RST);
 
 	ret_val = igc_get_auto_rd_done(hw);
@@ -48,7 +48,7 @@ static s32 igc_reset_hw_base(struct igc_hw *hw)
 		 * return with an error. This can happen in situations
 		 * where there is no eeprom and prevents getting link.
 		 */
-		hw_dbg("Auto Read Done did not complete\n");
+		hw_dbg("Auto Read Done did not complete");
 	}
 
 	/* Clear any pending interrupt events. */
@@ -177,7 +177,7 @@ static s32 igc_init_phy_params_base(struct igc_hw *hw)
 	 */
 	ret_val = hw->phy.ops.reset(hw);
 	if (ret_val) {
-		hw_dbg("Error resetting the PHY.\n");
+		hw_dbg("Error resetting the PHY");
 		goto out;
 	}
 
@@ -292,12 +292,12 @@ static s32 igc_init_hw_base(struct igc_hw *hw)
 	igc_init_rx_addrs(hw, rar_count);
 
 	/* Zero out the Multicast HASH table */
-	hw_dbg("Zeroing the MTA\n");
+	hw_dbg("Zeroing the MTA");
 	for (i = 0; i < mac->mta_reg_count; i++)
 		array_wr32(IGC_MTA, i, 0);
 
 	/* Zero out the Unicast HASH table */
-	hw_dbg("Zeroing the UTA\n");
+	hw_dbg("Zeroing the UTA");
 	for (i = 0; i < mac->uta_reg_count; i++)
 		array_wr32(IGC_UTA, i, 0);
 
@@ -367,7 +367,7 @@ void igc_rx_fifo_flush_base(struct igc_hw *hw)
 	}
 
 	if (ms_wait == 10)
-		pr_debug("Queue disable timed out after 10ms\n");
+		hw_dbg("Queue disable timed out after 10ms");
 
 	/* Clear RLPML, RCTL.SBP, RFCTL.LEF, and set RCTL.LPE so that all
 	 * incoming packets are rejected.  Set enable and wait 2ms so that
-- 
2.25.0

