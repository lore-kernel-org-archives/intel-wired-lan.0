From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Mar 2019 15:08:40 -0700
Subject: [Intel-wired-lan] [next PATCH S4 11/11] i40e: Revert ShadowRAM
 checksum calculation change
In-Reply-To: <20190329220840.51187-1-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
Message-ID: <20190329220840.51187-11-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Maciej Paczkowski <maciej.paczkowski@intel.com>

The reason of this revert is unexpected issue found in NVM Update tool
during NVM image downgrade. The implementation is no longer needed
since the QV tools are already aware of new FW double ShadowRAM dump
mechanism.

This patch reverts ShadowRAM checksum calculation change introduced in
commit 9d12f0c4e436 ("i40e: Revert ShadowRAM checksum calculation change")

Signed-off-by: Maciej Paczkowski <maciej.paczkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 28 +++-------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index ee89779a9a6f..c508b75c3c09 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -574,36 +574,14 @@ static i40e_status i40e_calc_nvm_checksum(struct i40e_hw *hw,
 i40e_status i40e_update_nvm_checksum(struct i40e_hw *hw)
 {
 	i40e_status ret_code;
-	u16 checksum, checksum_sr;
+	u16 checksum;
 	__le16 le_sum;
 
 	ret_code = i40e_calc_nvm_checksum(hw, &checksum);
-	if (ret_code)
-		return ret_code;
-
 	le_sum = cpu_to_le16(checksum);
-	ret_code = i40e_write_nvm_aq(hw, 0x00, I40E_SR_SW_CHECKSUM_WORD,
-				     1, &le_sum, true);
-	if (ret_code)
-		return ret_code;
-
-	/* Due to changes in FW the SW is required to perform double SR-dump
-	 * in some cases. SR-dump is the process when internal shadow RAM is
-	 * dumped into flash bank. It is triggered by setting "last_command"
-	 * argument in i40e_write_nvm_aq function call.
-	 * Since FW 1.8 we need to calculate SR checksum again and update it
-	 * in flash if it is not equal to previously computed checksum.
-	 * This situation would occur only in FW >= 1.8
-	 */
-	ret_code = i40e_calc_nvm_checksum(hw, &checksum_sr);
-	if (ret_code)
-		return ret_code;
-	if (checksum_sr != checksum) {
-		le_sum = cpu_to_le16(checksum_sr);
-		ret_code = i40e_write_nvm_aq(hw, 0x00,
-					     I40E_SR_SW_CHECKSUM_WORD,
+	if (!ret_code)
+		ret_code = i40e_write_nvm_aq(hw, 0x00, I40E_SR_SW_CHECKSUM_WORD,
 					     1, &le_sum, true);
-	}
 
 	return ret_code;
 }
-- 
2.19.2

