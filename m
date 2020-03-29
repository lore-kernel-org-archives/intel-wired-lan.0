From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 29 Mar 2020 12:01:51 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unneeded definition
Message-ID: <20200329090151.42247-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

PHY_FORCE_LIMIT definition not in use and could be removed
i225 parts support auto negitiation mechanism

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 63d3d34763da..824eb5276149 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -47,7 +47,6 @@
 /* Loop limit on how long we wait for auto-negotiation to complete */
 #define COPPER_LINK_UP_LIMIT		10
 #define PHY_AUTO_NEG_LIMIT		45
-#define PHY_FORCE_LIMIT			20
 
 /* Number of 100 microseconds we wait for PCI Express master disable */
 #define MASTER_DISABLE_TIMEOUT		800
-- 
2.11.0

