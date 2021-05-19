From: Guangbin Huang <huangguangbin2@huawei.com>
Date: Wed, 19 May 2021 14:14:42 +0800
Subject: [Intel-wired-lan] [PATCH net-next 2/5] net: e1000: remove repeated
 words for e1000_hw.c
In-Reply-To: <1621404885-20075-1-git-send-email-huangguangbin2@huawei.com>
References: <1621404885-20075-1-git-send-email-huangguangbin2@huawei.com>
Message-ID: <1621404885-20075-3-git-send-email-huangguangbin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Hao Chen <chenhao288@hisilicon.com>

There are double "in" and "to" in comments, so remove the redundant one.

Signed-off-by: Hao Chen <chenhao288@hisilicon.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
---
 drivers/net/ethernet/intel/e1000/e1000_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index 19cf36360933..1042e79a1397 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -2522,7 +2522,7 @@ s32 e1000_check_for_link(struct e1000_hw *hw)
 				 * turn it on. For compatibility with a TBI link
 				 * partner, we will store bad packets. Some
 				 * frames have an additional byte on the end and
-				 * will look like CRC errors to to the hardware.
+				 * will look like CRC errors to the hardware.
 				 */
 				if (!hw->tbi_compatibility_on) {
 					hw->tbi_compatibility_on = true;
@@ -2723,7 +2723,7 @@ static void e1000_shift_out_mdi_bits(struct e1000_hw *hw, u32 data, u16 count)
  * e1000_shift_in_mdi_bits - Shifts data bits in from the PHY
  * @hw: Struct containing variables accessed by shared code
  *
- * Bits are shifted in in MSB to LSB order.
+ * Bits are shifted in MSB to LSB order.
  */
 static u16 e1000_shift_in_mdi_bits(struct e1000_hw *hw)
 {
-- 
2.8.1

