From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue,  9 Nov 2021 11:42:16 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove obsolete mask
Message-ID: <20211109094216.132929-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

'IGC_CTRL_EXT_LINK_MODE_MASK' not in use. This patch comes to tidy up
obsolete define.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 910ad1a0d375..0666bf4b54d5 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -85,9 +85,6 @@
 
 #define IGC_WUFC_EXT_FILTER_MASK GENMASK(31, 8)
 
-/* Physical Func Reset Done Indication */
-#define IGC_CTRL_EXT_LINK_MODE_MASK	0x00C00000
-
 /* Loop limit on how long we wait for auto-negotiation to complete */
 #define COPPER_LINK_UP_LIMIT		10
 #define PHY_AUTO_NEG_LIMIT		45
-- 
2.25.1

