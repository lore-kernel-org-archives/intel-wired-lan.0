From: Wang Hai <wanghai38@huawei.com>
Date: Thu, 10 Sep 2020 23:12:04 +0800
Subject: [Intel-wired-lan] [PATCH net-next] igb: Fix some kernel-doc
 warnings in e1000_82575.c
Message-ID: <20200910151204.36198-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fixes the following W=1 kernel build warning(s):

drivers/net/ethernet/intel/igb/e1000_82575.c:2563: warning: Excess function parameter 'addr' description in '__igb_access_emi_reg'
drivers/net/ethernet/intel/igb/e1000_82575.c:2599: warning: Excess function parameter 'adv100m' description in 'igb_set_eee_i350'
drivers/net/ethernet/intel/igb/e1000_82575.c:2655: warning: Excess function parameter 'adv100m' description in 'igb_set_eee_i354'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index a32391e82762..50863fd87d53 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -2554,7 +2554,7 @@ static s32 igb_update_nvm_checksum_i350(struct e1000_hw *hw)
 /**
  *  __igb_access_emi_reg - Read/write EMI register
  *  @hw: pointer to the HW structure
- *  @addr: EMI address to program
+ *  @address: EMI address to program
  *  @data: pointer to value to read/write from/to the EMI address
  *  @read: boolean flag to indicate read or write
  **/
@@ -2590,7 +2590,7 @@ s32 igb_read_emi_reg(struct e1000_hw *hw, u16 addr, u16 *data)
  *  igb_set_eee_i350 - Enable/disable EEE support
  *  @hw: pointer to the HW structure
  *  @adv1G: boolean flag enabling 1G EEE advertisement
- *  @adv100m: boolean flag enabling 100M EEE advertisement
+ *  @adv100M: boolean flag enabling 100M EEE advertisement
  *
  *  Enable/disable EEE based on setting in dev_spec structure.
  *
@@ -2646,7 +2646,7 @@ s32 igb_set_eee_i350(struct e1000_hw *hw, bool adv1G, bool adv100M)
  *  igb_set_eee_i354 - Enable/disable EEE support
  *  @hw: pointer to the HW structure
  *  @adv1G: boolean flag enabling 1G EEE advertisement
- *  @adv100m: boolean flag enabling 100M EEE advertisement
+ *  @adv100M: boolean flag enabling 100M EEE advertisement
  *
  *  Enable/disable EEE legacy mode based on setting in dev_spec structure.
  *
-- 
2.17.1

