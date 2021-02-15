From: Chen Lin <chen45464546@163.com>
Date: Mon, 15 Feb 2021 20:04:58 +0800
Subject: [Intel-wired-lan] [PATCH] net: intel: Remove unused function
 pointer typedef ixgbe_mc_addr_itr
Message-ID: <1613390698-3637-1-git-send-email-chen45464546@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Chen Lin <chen.lin5@zte.com.cn>

Remove the 'ixgbe_mc_addr_itr' typedef as it is not used.

Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    4 ----
 drivers/net/ethernet/intel/ixgbevf/vf.h       |    3 ---
 2 files changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 2be1c4c..e4da5ac 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3383,10 +3383,6 @@ struct ixgbe_hw_stats {
 /* forward declaration */
 struct ixgbe_hw;
 
-/* iterator type for walking multicast address lists */
-typedef u8* (*ixgbe_mc_addr_itr) (struct ixgbe_hw *hw, u8 **mc_addr_ptr,
-				  u32 *vmdq);
-
 /* Function pointer table */
 struct ixgbe_eeprom_operations {
 	s32 (*init_params)(struct ixgbe_hw *);
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.h b/drivers/net/ethernet/intel/ixgbevf/vf.h
index d1e9e30..1d8209d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.h
@@ -16,9 +16,6 @@
 
 struct ixgbe_hw;
 
-/* iterator type for walking multicast address lists */
-typedef u8* (*ixgbe_mc_addr_itr) (struct ixgbe_hw *hw, u8 **mc_addr_ptr,
-				  u32 *vmdq);
 struct ixgbe_mac_operations {
 	s32 (*init_hw)(struct ixgbe_hw *);
 	s32 (*reset_hw)(struct ixgbe_hw *);
-- 
1.7.9.5


