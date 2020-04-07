From: Andre Guedes <andre.guedes@intel.com>
Date: Tue,  7 Apr 2020 14:07:07 -0700
Subject: [Intel-wired-lan] [PATCH 1/5] igc: Remove duplicated IGC_RXPBS macro
In-Reply-To: <20200407210711.24371-1-andre.guedes@intel.com>
References: <20200407210711.24371-1-andre.guedes@intel.com>
Message-ID: <20200407210711.24371-2-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch remove the IGC_RXPBS macro defined in line 233 since it is
already defined in line 18 with the exactly same value.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_regs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index a01d93bf5028..1cbd428adfbe 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -227,8 +227,6 @@
 
 #define IGC_FTQF(_n)	(0x059E0 + (4 * (_n)))  /* 5-tuple Queue Fltr */
 
-#define IGC_RXPBS	0x02404  /* Rx Packet Buffer Size - RW */
-
 /* Transmit Scheduling Registers */
 #define IGC_TQAVCTRL                   0x3570
 #define IGC_TXQCTL(_n)                 (0x3344 + 0x4 * (_n))
-- 
2.26.0

