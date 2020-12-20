From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 20 Dec 2020 11:15:36 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused FUNC_1 mask
Message-ID: <20201220091536.2149986-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

FUNC_1 mask not in use in i225 device and could be removed

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 84355a5f79e8..4fc9ef978ad3 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -179,7 +179,6 @@
 #define IGC_STATUS_LU		0x00000002      /* Link up.0=no,1=link */
 #define IGC_STATUS_FUNC_MASK	0x0000000C      /* PCI Function Mask */
 #define IGC_STATUS_FUNC_SHIFT	2
-#define IGC_STATUS_FUNC_1	0x00000004      /* Function 1 */
 #define IGC_STATUS_TXOFF	0x00000010      /* transmission paused */
 #define IGC_STATUS_SPEED_100	0x00000040      /* Speed 100Mb/s */
 #define IGC_STATUS_SPEED_1000	0x00000080      /* Speed 1000Mb/s */
-- 
2.25.1

