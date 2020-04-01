From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed,  1 Apr 2020 11:43:20 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove PCIe Control register
Message-ID: <20200401084320.26165-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

GCR (PCIe Control) register not in use and should be removed
This patch clean up this register

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_regs.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index 96dee3c1a5f7..0d227c6e79d2 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -37,9 +37,6 @@
 #define IGC_FCRTV		0x02460  /* FC Refresh Timer Value - RW */
 #define IGC_FCSTS		0x02464  /* FC Status - RO */
 
-/* PCIe Register Description */
-#define IGC_GCR			0x05B00  /* PCIe control- RW */
-
 /* Semaphore registers */
 #define IGC_SW_FW_SYNC		0x05B5C  /* SW-FW Synchronization - RW */
 #define IGC_SWSM		0x05B50  /* SW Semaphore */
-- 
2.11.0

