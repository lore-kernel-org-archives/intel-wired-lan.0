From: Zheng Yongjun <zhengyongjun3@huawei.com>
Date: Sat, 19 Sep 2020 09:50:20 +0800
Subject: [Intel-wired-lan] [PATCH net-next] net: e1000: Remove set but not
 used variable
Message-ID: <20200919015020.22963-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/intel/e1000/e1000_hw.c: In function e1000_phy_init_script:
drivers/net/ethernet/intel/e1000/e1000_hw.c:132:6: warning: variable ?ret_val? set but not used [-Wunused-but-set-variable]

`ret_val` is never used, so remove it.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/net/ethernet/intel/e1000/e1000_hw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index 4e7a0810eaeb..f1dbd7b8ee32 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -129,7 +129,6 @@ static s32 e1000_set_phy_type(struct e1000_hw *hw)
  */
 static void e1000_phy_init_script(struct e1000_hw *hw)
 {
-	u32 ret_val;
 	u16 phy_saved_data;
 
 	if (hw->phy_init_script) {
@@ -138,7 +137,7 @@ static void e1000_phy_init_script(struct e1000_hw *hw)
 		/* Save off the current value of register 0x2F5B to be restored
 		 * at the end of this routine.
 		 */
-		ret_val = e1000_read_phy_reg(hw, 0x2F5B, &phy_saved_data);
+		e1000_read_phy_reg(hw, 0x2F5B, &phy_saved_data);
 
 		/* Disabled the PHY transmitter */
 		e1000_write_phy_reg(hw, 0x2F5B, 0x0003);
-- 
2.17.1

