From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 24 Mar 2020 17:38:23 -0700
Subject: [Intel-wired-lan] [PATCH 09/10] igc: Remove '\n' from log messages
 in igc_nvm.c
In-Reply-To: <20200325003824.5487-1-andre.guedes@intel.com>
References: <20200325003824.5487-1-andre.guedes@intel.com>
Message-ID: <20200325003824.5487-10-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

To keep log strings in igc_nvm.c consistent with the rest of the driver
code, this patch removes the '\n' character at the end. The newline
character is automatically added by netdev_dbg() so there is no changes
in the output.

Note: hw_dbg() is a macro that expands to netdev_dbg().

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_nvm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.c b/drivers/net/ethernet/intel/igc/igc_nvm.c
index 58f81aba0144..ac01330a8232 100644
--- a/drivers/net/ethernet/intel/igc/igc_nvm.c
+++ b/drivers/net/ethernet/intel/igc/igc_nvm.c
@@ -63,7 +63,7 @@ s32 igc_acquire_nvm(struct igc_hw *hw)
 	if (!timeout) {
 		eecd &= ~IGC_EECD_REQ;
 		wr32(IGC_EECD, eecd);
-		hw_dbg("Could not acquire NVM grant\n");
+		hw_dbg("Could not acquire NVM grant");
 		ret_val = -IGC_ERR_NVM;
 	}
 
@@ -105,7 +105,7 @@ s32 igc_read_nvm_eerd(struct igc_hw *hw, u16 offset, u16 words, u16 *data)
 	 */
 	if (offset >= nvm->word_size || (words > (nvm->word_size - offset)) ||
 	    words == 0) {
-		hw_dbg("nvm parameter(s) out of bounds\n");
+		hw_dbg("nvm parameter(s) out of bounds");
 		ret_val = -IGC_ERR_NVM;
 		goto out;
 	}
@@ -167,14 +167,14 @@ s32 igc_validate_nvm_checksum(struct igc_hw *hw)
 	for (i = 0; i < (NVM_CHECKSUM_REG + 1); i++) {
 		ret_val = hw->nvm.ops.read(hw, i, 1, &nvm_data);
 		if (ret_val) {
-			hw_dbg("NVM Read Error\n");
+			hw_dbg("NVM Read Error");
 			goto out;
 		}
 		checksum += nvm_data;
 	}
 
 	if (checksum != (u16)NVM_SUM) {
-		hw_dbg("NVM Checksum Invalid\n");
+		hw_dbg("NVM Checksum Invalid");
 		ret_val = -IGC_ERR_NVM;
 		goto out;
 	}
@@ -200,7 +200,7 @@ s32 igc_update_nvm_checksum(struct igc_hw *hw)
 	for (i = 0; i < NVM_CHECKSUM_REG; i++) {
 		ret_val = hw->nvm.ops.read(hw, i, 1, &nvm_data);
 		if (ret_val) {
-			hw_dbg("NVM Read Error while updating checksum.\n");
+			hw_dbg("NVM Read Error while updating checksum");
 			goto out;
 		}
 		checksum += nvm_data;
@@ -208,7 +208,7 @@ s32 igc_update_nvm_checksum(struct igc_hw *hw)
 	checksum = (u16)NVM_SUM - checksum;
 	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
 	if (ret_val)
-		hw_dbg("NVM Write Error while updating checksum.\n");
+		hw_dbg("NVM Write Error while updating checksum");
 
 out:
 	return ret_val;
-- 
2.25.0

