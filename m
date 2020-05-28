From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu, 28 May 2020 10:25:21 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix wrong register name
Message-ID: <20200528072521.11228-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Accordance to the i225 datasheet this register address
used by Host Transimt Discarded Packet by MAC counter
and not by not applicable Carrier Extension Error counter.
This patch comes to fix this wrong definition.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.c  | 2 +-
 drivers/net/ethernet/intel/igc/igc_regs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index fb496617e8e1..410aeb01de5c 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -287,7 +287,7 @@ void igc_clear_hw_cntrs_base(struct igc_hw *hw)
 	rd32(IGC_ALGNERRC);
 	rd32(IGC_RXERRC);
 	rd32(IGC_TNCRS);
-	rd32(IGC_CEXTERR);
+	rd32(IGC_HTDPMC);
 	rd32(IGC_TSCTC);
 	rd32(IGC_TSCTFC);
 
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index 48f46ee96bfd..75e040a5d46f 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -137,7 +137,7 @@
 #define IGC_RERC	0x0402C  /* Receive Error Count - R/clr */
 #define IGC_DC		0x04030  /* Defer Count - R/clr */
 #define IGC_TNCRS	0x04034  /* Tx-No CRS - R/clr */
-#define IGC_CEXTERR	0x0403C  /* Carrier Extension Error Count - R/clr */
+#define IGC_HTDPMC	0x0403C  /* Host Transmit Discarded by MAC - R/clr */
 #define IGC_RLEC	0x04040  /* Receive Length Error Count - R/clr */
 #define IGC_XONRXC	0x04048  /* XON Rx Count - R/clr */
 #define IGC_XONTXC	0x0404C  /* XON Tx Count - R/clr */
-- 
2.11.0

