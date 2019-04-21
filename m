From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 21 Apr 2019 11:17:23 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Cleanup the redundant code
Message-ID: <20190421081723.34232-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The default flow control settings for the i225 device is both
'rx' and 'tx' pause frames. There is no depend on the NVM value.
This patch comes to fix this and clean up the driver code.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index f7683d3ae47c..ba4646737288 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -8,7 +8,6 @@
 #include "igc_hw.h"
 
 /* forward declaration */
-static s32 igc_set_default_fc(struct igc_hw *hw);
 static s32 igc_set_fc_watermarks(struct igc_hw *hw);
 
 /**
@@ -96,13 +95,10 @@ s32 igc_setup_link(struct igc_hw *hw)
 		goto out;
 
 	/* If requested flow control is set to default, set flow control
-	 * based on the EEPROM flow control settings.
+	 * to the both 'rx' and 'tx' pause frames.
 	 */
-	if (hw->fc.requested_mode == igc_fc_default) {
-		ret_val = igc_set_default_fc(hw);
-		if (ret_val)
-			goto out;
-	}
+	if (hw->fc.requested_mode == igc_fc_default)
+		hw->fc.requested_mode = igc_fc_full;
 
 	/* We want to save off the original Flow Control configuration just
 	 * in case we get disconnected and then reconnected into a different
@@ -136,19 +132,6 @@ s32 igc_setup_link(struct igc_hw *hw)
 }
 
 /**
- * igc_set_default_fc - Set flow control default values
- * @hw: pointer to the HW structure
- *
- * Read the EEPROM for the default values for flow control and store the
- * values.
- */
-static s32 igc_set_default_fc(struct igc_hw *hw)
-{
-	hw->fc.requested_mode = igc_fc_full;
-	return 0;
-}
-
-/**
  * igc_force_mac_fc - Force the MAC's flow control settings
  * @hw: pointer to the HW structure
  *
-- 
2.11.0

