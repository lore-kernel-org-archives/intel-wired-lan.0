From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 12 Apr 2020 09:28:29 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused IGC_ICS_DRSTA
 define
Message-ID: <20200412062829.17781-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Device reset assert for interrupt cause register not in
use for i225 device.
This patch comes to clean up this define.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 1127ef81e374..37599c248263 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -244,7 +244,6 @@
 /* Interrupt Cause Set */
 #define IGC_ICS_LSC		IGC_ICR_LSC       /* Link Status Change */
 #define IGC_ICS_RXDMT0		IGC_ICR_RXDMT0    /* rx desc min. threshold */
-#define IGC_ICS_DRSTA		IGC_ICR_DRSTA     /* Device Reset Aserted */
 
 #define IGC_ICR_DOUTSYNC	0x10000000 /* NIC DMA out of sync */
 #define IGC_EITR_CNT_IGNR	0x80000000 /* Don't reset counters on write */
-- 
2.11.0

