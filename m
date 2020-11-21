From: xiakaixu1987@gmail.com <xiakaixu1987@gmail.com>
Date: Sat, 21 Nov 2020 18:17:27 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: remove the redundant value
 assignment in e1000_update_nvm_checksum_spt
Message-ID: <1605953847-12401-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kaixu Xia <kaixuxia@tencent.com>

Both of the statements are value assignment of the variable act_offset.
The first value assignment is overwritten by the second and is useless.
Remove it.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 9aa6fad8ed47..f05070ed18c9 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -3875,13 +3875,6 @@ static s32 e1000_update_nvm_checksum_spt(struct e1000_hw *hw)
 	if (ret_val)
 		goto release;
 
-	/* And invalidate the previously valid segment by setting
-	 * its signature word (0x13) high_byte to 0b. This can be
-	 * done without an erase because flash erase sets all bits
-	 * to 1's. We can write 1's to 0's without an erase
-	 */
-	act_offset = (old_bank_offset + E1000_ICH_NVM_SIG_WORD) * 2 + 1;
-
 	/* offset in words but we read dword */
 	act_offset = old_bank_offset + E1000_ICH_NVM_SIG_WORD - 1;
 	ret_val = e1000_read_flash_dword_ich8lan(hw, act_offset, &dword);
-- 
2.20.0

