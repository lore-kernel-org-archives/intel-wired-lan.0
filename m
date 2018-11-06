From: wangyunjian <wangyunjian@huawei.com>
Date: Tue, 6 Nov 2018 16:27:12 +0800
Subject: [Intel-wired-lan] [PATCH net] igb: fix uninitialized variables
Message-ID: <1541492832-10412-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Yunjian Wang <wangyunjian@huawei.com>

This patch fixes the variable 'phy_word' may be used uninitialized.

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 drivers/net/ethernet/intel/igb/e1000_i210.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index c54ebed..c393cb2 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -842,6 +842,7 @@ s32 igb_pll_workaround_i210(struct e1000_hw *hw)
 		nvm_word = E1000_INVM_DEFAULT_AL;
 	tmp_nvm = nvm_word | E1000_INVM_PLL_WO_VAL;
 	igb_write_phy_reg_82580(hw, I347AT4_PAGE_SELECT, E1000_PHY_PLL_FREQ_PAGE);
+	phy_word = E1000_PHY_PLL_UNCONF;
 	for (i = 0; i < E1000_MAX_PLL_TRIES; i++) {
 		/* check current state directly from internal PHY */
 		igb_read_phy_reg_82580(hw, E1000_PHY_PLL_FREQ_REG, &phy_word);
-- 
1.8.3.1


