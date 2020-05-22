From: Hari <harichandrakanthan@gmail.com>
Date: Fri, 22 May 2020 16:00:24 +0530
Subject: [Intel-wired-lan] [PATCH] Fix typo in the comment
Message-ID: <20200522103024.9697-1-harichandrakanthan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Continuous Double "the" in a comment. Changed it to single "the"

Signed-off-by: Hari <harichandrakanthan@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index 48428d6a00be..623e516a9630 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -3960,7 +3960,7 @@ static s32 e1000_do_read_eeprom(struct e1000_hw *hw, u16 offset, u16 words,
  * @hw: Struct containing variables accessed by shared code
  *
  * Reads the first 64 16 bit words of the EEPROM and sums the values read.
- * If the the sum of the 64 16 bit words is 0xBABA, the EEPROM's checksum is
+ * If the sum of the 64 16 bit words is 0xBABA, the EEPROM's checksum is
  * valid.
  */
 s32 e1000_validate_eeprom_checksum(struct e1000_hw *hw)
-- 
2.17.1

