From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 9 May 2019 13:10:51 +0300
Subject: [Intel-wired-lan] [PATCH] i40e/i40evf: cleanup
 i40e_update_nvm_checksum()
Message-ID: <20190509101051.GB7024@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Smatch complains that we use 'checksum' when it's uninitialized.

    drivers/net/ethernet/intel/i40e/i40e_nvm.c:581 i40e_update_nvm_checksum()
    error: uninitialized symbol 'checksum'.

This is true, but it harmless because we don't use it again.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index c508b75c3c09..a60ab9d48065 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -578,12 +578,11 @@ i40e_status i40e_update_nvm_checksum(struct i40e_hw *hw)
 	__le16 le_sum;
 
 	ret_code = i40e_calc_nvm_checksum(hw, &checksum);
+	if (ret_code)
+		return ret_code;
 	le_sum = cpu_to_le16(checksum);
-	if (!ret_code)
-		ret_code = i40e_write_nvm_aq(hw, 0x00, I40E_SR_SW_CHECKSUM_WORD,
-					     1, &le_sum, true);
-
-	return ret_code;
+	return i40e_write_nvm_aq(hw, 0x00, I40E_SR_SW_CHECKSUM_WORD, 1,
+				 &le_sum, true);
 }
 
 /**
-- 
2.18.0

