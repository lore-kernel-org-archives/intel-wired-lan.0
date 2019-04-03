From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed,  3 Apr 2019 16:58:04 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix double definitions
Message-ID: <20190403135804.9229-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Collision threshold and threshold's shift has been defined twice.
This patch comes to fix that.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index a9a30268de59..6f17ed3de995 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -264,9 +264,6 @@
 #define IGC_TCTL_RTLC		0x01000000 /* Re-transmit on late collision */
 #define IGC_TCTL_MULR		0x10000000 /* Multiple request support */
 
-#define IGC_CT_SHIFT			4
-#define IGC_COLLISION_THRESHOLD		15
-
 /* Flow Control Constants */
 #define FLOW_CONTROL_ADDRESS_LOW	0x00C28001
 #define FLOW_CONTROL_ADDRESS_HIGH	0x00000100
-- 
2.11.0

