From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon, 24 May 2021 09:09:01 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Indentation fixes
Message-ID: <20210524060901.3622163-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Minor fix of indentation in igc_defines.h

Fixes: 87938851b6efb ("igc: enable auxiliary PHC functions for the i225")
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 8f6ba2b8d9e6..26a6ca004697 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -99,8 +99,8 @@
 #define IGC_CTRL_RFCE		0x08000000  /* Receive Flow Control enable */
 #define IGC_CTRL_TFCE		0x10000000  /* Transmit flow control enable */
 
-#define IGC_CTRL_SDP0_DIR 0x00400000	/* SDP0 Data direction */
-#define IGC_CTRL_SDP1_DIR 0x00800000	/* SDP1 Data direction */
+#define IGC_CTRL_SDP0_DIR	0x00400000  /* SDP0 Data direction */
+#define IGC_CTRL_SDP1_DIR	0x00800000  /* SDP1 Data direction */
 
 /* As per the EAS the maximum supported size is 9.5KB (9728 bytes) */
 #define MAX_JUMBO_FRAME_SIZE	0x2600
-- 
2.25.1

