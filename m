From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 23 Feb 2021 14:19:23 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove no need includes from
 igc_mac.h
Message-ID: <20210223121923.1503421-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

igc_defines.h and igc_phy.h included in igc_hw.h
Therefore no need to include these headers in igc_mac.h
where is include igc_hw.h

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.h b/drivers/net/ethernet/intel/igc/igc_mac.h
index b5963f86defb..04d0cadfa3d6 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.h
+++ b/drivers/net/ethernet/intel/igc/igc_mac.h
@@ -5,8 +5,6 @@
 #define _IGC_MAC_H_
 
 #include "igc_hw.h"
-#include "igc_phy.h"
-#include "igc_defines.h"
 
 /* forward declaration */
 s32 igc_disable_pcie_master(struct igc_hw *hw);
-- 
2.25.1

