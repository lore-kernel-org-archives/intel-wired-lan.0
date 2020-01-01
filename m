From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed,  1 Jan 2020 08:49:13 +0200
Subject: [Intel-wired-lan] [PATCH v1] igc: Remove unused definition
Message-ID: <20200101064913.21138-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove the unused IGC_FUNC_0 definition and make the code cleaner

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 20f710645746..be7273c4b53f 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -22,8 +22,6 @@
 #define IGC_DEV_ID_I220_V			0x15F7
 #define IGC_DEV_ID_I225_K			0x3100
 
-#define IGC_FUNC_0				0
-
 /* Function pointers for the MAC. */
 struct igc_mac_operations {
 	s32 (*check_for_link)(struct igc_hw *hw);
-- 
2.11.0

