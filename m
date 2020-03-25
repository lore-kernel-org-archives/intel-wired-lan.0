From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 24 Mar 2020 17:38:21 -0700
Subject: [Intel-wired-lan] [PATCH 07/10] igc: Remove '\n' from log strings
 in igc_i225.c
In-Reply-To: <20200325003824.5487-1-andre.guedes@intel.com>
References: <20200325003824.5487-1-andre.guedes@intel.com>
Message-ID: <20200325003824.5487-8-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

To keep log strings in igc_i225.c consistent with the rest of the driver
code, this patch removes the '\n' character at the end. The newline
character is automatically added by netdev_dbg() so there is no changes
in the output.

Note: hw_dbg() is a macro that expands to netdev_dbg().

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_i225.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
index c25f555aaf82..a5856ae87a7e 100644
--- a/drivers/net/ethernet/intel/igc/igc_i225.c
+++ b/drivers/net/ethernet/intel/igc/igc_i225.c
@@ -71,7 +71,7 @@ static s32 igc_get_hw_semaphore_i225(struct igc_hw *hw)
 
 		/* If we do not have the semaphore here, we have to give up. */
 		if (i == timeout) {
-			hw_dbg("Driver can't access device - SMBI bit is set.\n");
+			hw_dbg("Driver can't access device - SMBI bit is set");
 			return -IGC_ERR_NVM;
 		}
 	}
@@ -91,7 +91,7 @@ static s32 igc_get_hw_semaphore_i225(struct igc_hw *hw)
 	if (i == timeout) {
 		/* Release semaphores */
 		igc_put_hw_semaphore(hw);
-		hw_dbg("Driver can't access the NVM\n");
+		hw_dbg("Driver can't access the NVM");
 		return -IGC_ERR_NVM;
 	}
 
@@ -131,7 +131,7 @@ s32 igc_acquire_swfw_sync_i225(struct igc_hw *hw, u16 mask)
 	}
 
 	if (i == timeout) {
-		hw_dbg("Driver can't access resource, SW_FW_SYNC timeout.\n");
+		hw_dbg("Driver can't access resource, SW_FW_SYNC timeout");
 		ret_val = -IGC_ERR_SWFW_SYNC;
 		goto out;
 	}
@@ -228,7 +228,7 @@ static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
 	 */
 	if (offset >= nvm->word_size || (words > (nvm->word_size - offset)) ||
 	    words == 0) {
-		hw_dbg("nvm parameter(s) out of bounds\n");
+		hw_dbg("nvm parameter(s) out of bounds");
 		ret_val = -IGC_ERR_NVM;
 		goto out;
 	}
@@ -250,7 +250,7 @@ static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
 		}
 
 		if (ret_val) {
-			hw_dbg("Shadow RAM write EEWR timed out\n");
+			hw_dbg("Shadow RAM write EEWR timed out");
 			break;
 		}
 	}
@@ -369,7 +369,7 @@ static s32 igc_update_flash_i225(struct igc_hw *hw)
 
 	ret_val = igc_pool_flash_update_done_i225(hw);
 	if (ret_val == -IGC_ERR_NVM) {
-		hw_dbg("Flash update time out\n");
+		hw_dbg("Flash update time out");
 		goto out;
 	}
 
@@ -378,9 +378,9 @@ static s32 igc_update_flash_i225(struct igc_hw *hw)
 
 	ret_val = igc_pool_flash_update_done_i225(hw);
 	if (ret_val)
-		hw_dbg("Flash update time out\n");
+		hw_dbg("Flash update time out");
 	else
-		hw_dbg("Flash update complete\n");
+		hw_dbg("Flash update complete");
 
 out:
 	return ret_val;
@@ -406,7 +406,7 @@ static s32 igc_update_nvm_checksum_i225(struct igc_hw *hw)
 	 */
 	ret_val = igc_read_nvm_eerd(hw, 0, 1, &nvm_data);
 	if (ret_val) {
-		hw_dbg("EEPROM read failed\n");
+		hw_dbg("EEPROM read failed");
 		goto out;
 	}
 
@@ -423,7 +423,7 @@ static s32 igc_update_nvm_checksum_i225(struct igc_hw *hw)
 		ret_val = igc_read_nvm_eerd(hw, i, 1, &nvm_data);
 		if (ret_val) {
 			hw->nvm.ops.release(hw);
-			hw_dbg("NVM Read Error while updating checksum.\n");
+			hw_dbg("NVM Read Error while updating checksum");
 			goto out;
 		}
 		checksum += nvm_data;
@@ -433,7 +433,7 @@ static s32 igc_update_nvm_checksum_i225(struct igc_hw *hw)
 				     &checksum);
 	if (ret_val) {
 		hw->nvm.ops.release(hw);
-		hw_dbg("NVM Write Error while updating checksum.\n");
+		hw_dbg("NVM Write Error while updating checksum");
 		goto out;
 	}
 
-- 
2.25.0

