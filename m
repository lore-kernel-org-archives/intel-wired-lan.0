From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 29 Mar 2020 14:35:54 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unneeded register
Message-ID: <20200329113554.34873-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Flow control status register not applicable for i225 parts
This patch come to  clean up it

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_regs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index 7bfba20bf207..82158176634c 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -35,7 +35,6 @@
 #define IGC_FCRTL		0x02160  /* FC Receive Threshold Low - RW */
 #define IGC_FCRTH		0x02168  /* FC Receive Threshold High - RW */
 #define IGC_FCRTV		0x02460  /* FC Refresh Timer Value - RW */
-#define IGC_FCSTS		0x02464  /* FC Status - RO */
 
 /* PCIe Register Description */
 #define IGC_GCR			0x05B00  /* PCIe control- RW */
-- 
2.11.0

