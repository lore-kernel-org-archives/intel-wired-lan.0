From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 7 Sep 2018 11:38:44 +0800
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: remove redundant function
 ixgbe_fw_recovery_mode()
Message-ID: <20180907033844.4876-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There are no in-tree callers.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 970f71d..0bd1294 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -3485,17 +3485,6 @@ void ixgbe_set_vlan_anti_spoofing(struct ixgbe_hw *hw, bool enable, int vf)
 }
 
 /**
- * ixgbe_fw_recovery_mode - Check if in FW NVM recovery mode
- * @hw: pointer to hardware structure
- */
-bool ixgbe_fw_recovery_mode(struct ixgbe_hw *hw)
-{
-	if (hw->mac.ops.fw_recovery_mode)
-		return hw->mac.ops.fw_recovery_mode(hw);
-	return false;
-}
-
-/**
  *  ixgbe_get_device_caps_generic - Get additional device capabilities
  *  @hw: pointer to hardware structure
  *  @device_caps: the EEPROM word with the extra device capabilities
-- 
2.7.0


