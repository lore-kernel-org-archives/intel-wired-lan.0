From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 03 Oct 2016 17:09:58 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: remove SFP ixfi support
Message-ID: <20161004000958.22554.2468.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove SFP ixfi code since there is no HW that currently supports it.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   76 ++++---------------------
 1 file changed, 11 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 7644a82..d4b8f8c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1351,7 +1351,7 @@ ixgbe_setup_mac_link_sfp_x550em(struct ixgbe_hw *hw,
 				__always_unused bool autoneg_wait_to_complete)
 {
 	s32 status;
-	u16 slice, value;
+	u16 reg_slice, reg_val;
 	bool setup_linear = false;
 
 	/* Check if SFP module is supported and linear */
@@ -1367,71 +1367,17 @@ ixgbe_setup_mac_link_sfp_x550em(struct ixgbe_hw *hw,
 	if (status)
 		return status;
 
-	if (!(hw->phy.nw_mng_if_sel & IXGBE_NW_MNG_IF_SEL_INT_PHY_MODE)) {
-		/* Configure CS4227 LINE side to 10G SR. */
-		slice = IXGBE_CS4227_LINE_SPARE22_MSB + (hw->bus.lan_id << 12);
-		value = IXGBE_CS4227_SPEED_10G;
-		status = ixgbe_write_i2c_combined_generic(hw, IXGBE_CS4227,
-							  slice, value);
-		if (status)
-			goto i2c_err;
-
-		slice = IXGBE_CS4227_LINE_SPARE24_LSB + (hw->bus.lan_id << 12);
-		value = (IXGBE_CS4227_EDC_MODE_SR << 1) | 1;
-		status = ixgbe_write_i2c_combined_generic(hw, IXGBE_CS4227,
-							  slice, value);
-		if (status)
-			goto i2c_err;
-
-		/* Configure CS4227 for HOST connection rate then type. */
-		slice = IXGBE_CS4227_HOST_SPARE22_MSB + (hw->bus.lan_id << 12);
-		value = speed & IXGBE_LINK_SPEED_10GB_FULL ?
-			IXGBE_CS4227_SPEED_10G : IXGBE_CS4227_SPEED_1G;
-		status = ixgbe_write_i2c_combined_generic(hw, IXGBE_CS4227,
-							  slice, value);
-		if (status)
-			goto i2c_err;
-
-		slice = IXGBE_CS4227_HOST_SPARE24_LSB + (hw->bus.lan_id << 12);
-		if (setup_linear)
-			value = (IXGBE_CS4227_EDC_MODE_CX1 << 1) | 1;
-		else
-			value = (IXGBE_CS4227_EDC_MODE_SR << 1) | 1;
-		status = ixgbe_write_i2c_combined_generic(hw, IXGBE_CS4227,
-							  slice, value);
-		if (status)
-			goto i2c_err;
-
-		/* Setup XFI internal link. */
-		status = ixgbe_setup_ixfi_x550em(hw, &speed);
-		if (status) {
-			hw_dbg(hw, "setup_ixfi failed with %d\n", status);
-			return status;
-		}
-	} else {
-		/* Configure internal PHY for KR/KX. */
-		status = ixgbe_setup_kr_speed_x550em(hw, speed);
-		if (status) {
-			hw_dbg(hw, "setup_kr_speed failed with %d\n", status);
-			return status;
-		}
-
-		/* Configure CS4227 LINE side to proper mode. */
-		slice = IXGBE_CS4227_LINE_SPARE24_LSB + (hw->bus.lan_id << 12);
-		if (setup_linear)
-			value = (IXGBE_CS4227_EDC_MODE_CX1 << 1) | 1;
-		else
-			value = (IXGBE_CS4227_EDC_MODE_SR << 1) | 1;
-		status = ixgbe_write_i2c_combined_generic(hw, IXGBE_CS4227,
-							  slice, value);
-		if (status)
-			goto i2c_err;
-	}
-
-	return 0;
+	/* Configure internal PHY for KR/KX. */
+	ixgbe_setup_kr_speed_x550em(hw, speed);
 
-i2c_err:
-	hw_dbg(hw, "combined i2c access failed with %d\n", status);
+	/* Configure CS4227 LINE side to proper mode. */
+	reg_slice = IXGBE_CS4227_LINE_SPARE24_LSB + (hw->bus.lan_id << 12);
+	if (setup_linear)
+		reg_val = (IXGBE_CS4227_EDC_MODE_CX1 << 1) | 0x1;
+	else
+		reg_val = (IXGBE_CS4227_EDC_MODE_SR << 1) | 0x1;
+	status = ixgbe_write_i2c_combined_generic(hw, IXGBE_CS4227,
+						  reg_slice, reg_val);
 	return status;
 }
 

