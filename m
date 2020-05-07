From: Jason Yan <yanaijie@huawei.com>
Date: Thu, 7 May 2020 19:09:15 +0800
Subject: [Intel-wired-lan] [PATCH net-next] igb: make
 igb_set_fc_watermarks() return void
Message-ID: <20200507110915.38349-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This function always return 0 now, we can make it return void to
simplify the code. This fixes the following coccicheck warning:

drivers/net/ethernet/intel/igb/e1000_mac.c:728:5-12: Unneeded variable:
"ret_val". Return "0" on line 751

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/net/ethernet/intel/igb/e1000_mac.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index 79ee0a747260..3254737c07a3 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
@@ -12,7 +12,7 @@
 #include "igb.h"
 
 static s32 igb_set_default_fc(struct e1000_hw *hw);
-static s32 igb_set_fc_watermarks(struct e1000_hw *hw);
+static void igb_set_fc_watermarks(struct e1000_hw *hw);
 
 /**
  *  igb_get_bus_info_pcie - Get PCIe bus information
@@ -687,7 +687,7 @@ s32 igb_setup_link(struct e1000_hw *hw)
 
 	wr32(E1000_FCTTV, hw->fc.pause_time);
 
-	ret_val = igb_set_fc_watermarks(hw);
+	igb_set_fc_watermarks(hw);
 
 out:
 
@@ -723,9 +723,8 @@ void igb_config_collision_dist(struct e1000_hw *hw)
  *  flow control XON frame transmission is enabled, then set XON frame
  *  tansmission as well.
  **/
-static s32 igb_set_fc_watermarks(struct e1000_hw *hw)
+static void igb_set_fc_watermarks(struct e1000_hw *hw)
 {
-	s32 ret_val = 0;
 	u32 fcrtl = 0, fcrth = 0;
 
 	/* Set the flow control receive threshold registers.  Normally,
@@ -747,8 +746,6 @@ static s32 igb_set_fc_watermarks(struct e1000_hw *hw)
 	}
 	wr32(E1000_FCRTL, fcrtl);
 	wr32(E1000_FCRTH, fcrth);
-
-	return ret_val;
 }
 
 /**
-- 
2.21.1

