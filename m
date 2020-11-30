From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon, 30 Nov 2020 11:24:04 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Clean up nvm_operations
 structure
Message-ID: <20201130092404.2694347-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

valid_led_default function pointer not in use and can
be removed from a nvm_operations structure

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 9da5f83ce456..4461f8b9a864 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -113,7 +113,6 @@ struct igc_nvm_operations {
 	s32 (*write)(struct igc_hw *hw, u16 offset, u16 i, u16 *data);
 	s32 (*update)(struct igc_hw *hw);
 	s32 (*validate)(struct igc_hw *hw);
-	s32 (*valid_led_default)(struct igc_hw *hw, u16 *data);
 };
 
 struct igc_phy_operations {
-- 
2.25.1

