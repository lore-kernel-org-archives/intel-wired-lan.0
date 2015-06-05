From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Fri, 05 Jun 2015 00:50:58 -0400
Subject: [Intel-wired-lan] [net-next PATCH 2 04/13] ixgbe: Restore ESDP
 settings after MAC reset
In-Reply-To: <20150605045038.26373.94842.stgit@dcs-desk.jf.intel.com>
References: <20150605045038.26373.94842.stgit@dcs-desk.jf.intel.com>
Message-ID: <20150605045058.26373.45769.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The I2C mux control relies on the SDP setting in the ESDP register
so it is necessary to restore the value after a MAC reset.  Combine
all this functionality in to a support function.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   38 ++++++++++++++-----------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 88f7862..c23ae7f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -26,6 +26,22 @@
 #include "ixgbe_common.h"
 #include "ixgbe_phy.h"
 
+/** ixgbe_setup_mux_ctl - Setup ESDP register for I2C mux control
+ *  @hw: pointer to hardware structure
+ **/
+static void ixgbe_setup_mux_ctl(struct ixgbe_hw *hw)
+{
+	u32 esdp = IXGBE_READ_REG(hw, IXGBE_ESDP);
+
+	if (hw->bus.lan_id) {
+		esdp &= ~(IXGBE_ESDP_SDP1_NATIVE | IXGBE_ESDP_SDP1);
+		esdp |= IXGBE_ESDP_SDP1_DIR;
+	}
+	esdp &= ~(IXGBE_ESDP_SDP0_NATIVE | IXGBE_ESDP_SDP0_DIR);
+	IXGBE_WRITE_REG(hw, IXGBE_ESDP, esdp);
+	IXGBE_WRITE_FLUSH(hw);
+}
+
 /** ixgbe_identify_phy_x550em - Get PHY type based on device id
  *  @hw: pointer to hardware structure
  *
@@ -33,18 +49,11 @@
  */
 static s32 ixgbe_identify_phy_x550em(struct ixgbe_hw *hw)
 {
-	u32 esdp = IXGBE_READ_REG(hw, IXGBE_ESDP);
-
 	switch (hw->device_id) {
 	case IXGBE_DEV_ID_X550EM_X_SFP:
 		/* set up for CS4227 usage */
 		hw->phy.phy_semaphore_mask = IXGBE_GSSR_SHARED_I2C_SM;
-		if (hw->bus.lan_id) {
-			esdp &= ~(IXGBE_ESDP_SDP1_NATIVE | IXGBE_ESDP_SDP1);
-			esdp |= IXGBE_ESDP_SDP1_DIR;
-		}
-		esdp &= ~(IXGBE_ESDP_SDP0_NATIVE | IXGBE_ESDP_SDP0_DIR);
-		IXGBE_WRITE_REG(hw, IXGBE_ESDP, esdp);
+		ixgbe_setup_mux_ctl(hw);
 
 		return ixgbe_identify_module_generic(hw);
 	case IXGBE_DEV_ID_X550EM_X_KX4:
@@ -1127,18 +1136,10 @@ static s32 ixgbe_init_phy_ops_X550em(struct ixgbe_hw *hw)
 {
 	struct ixgbe_phy_info *phy = &hw->phy;
 	s32 ret_val;
-	u32 esdp;
 
 	if (hw->device_id == IXGBE_DEV_ID_X550EM_X_SFP) {
-		esdp = IXGBE_READ_REG(hw, IXGBE_ESDP);
 		phy->phy_semaphore_mask = IXGBE_GSSR_SHARED_I2C_SM;
-
-		if (hw->bus.lan_id) {
-			esdp &= ~(IXGBE_ESDP_SDP1_NATIVE | IXGBE_ESDP_SDP1);
-			esdp |= IXGBE_ESDP_SDP1_DIR;
-		}
-		esdp &= ~(IXGBE_ESDP_SDP0_NATIVE | IXGBE_ESDP_SDP0_DIR);
-		IXGBE_WRITE_REG(hw, IXGBE_ESDP, esdp);
+		ixgbe_setup_mux_ctl(hw);
 	}
 
 	/* Identify the PHY or SFP module */
@@ -1366,6 +1367,9 @@ mac_reset_top:
 	hw->mac.num_rar_entries = 128;
 	hw->mac.ops.init_rx_addrs(hw);
 
+	if (hw->device_id == IXGBE_DEV_ID_X550EM_X_SFP)
+		ixgbe_setup_mux_ctl(hw);
+
 	return status;
 }
 

