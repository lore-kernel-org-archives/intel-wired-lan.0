From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu,  4 Apr 2019 13:26:53 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Clean up unused pointers
Message-ID: <20190404102653.24472-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Few function pointers from phy_operations structure were unused.
This patch cleans those.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 7c88b7bd4799..1039a224ac80 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -114,11 +114,8 @@ struct igc_nvm_operations {
 
 struct igc_phy_operations {
 	s32 (*acquire)(struct igc_hw *hw);
-	s32 (*check_polarity)(struct igc_hw *hw);
 	s32 (*check_reset_block)(struct igc_hw *hw);
 	s32 (*force_speed_duplex)(struct igc_hw *hw);
-	s32 (*get_cfg_done)(struct igc_hw *hw);
-	s32 (*get_cable_length)(struct igc_hw *hw);
 	s32 (*get_phy_info)(struct igc_hw *hw);
 	s32 (*read_reg)(struct igc_hw *hw, u32 address, u16 *data);
 	void (*release)(struct igc_hw *hw);
-- 
2.11.0

