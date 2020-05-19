From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 19 May 2020 17:55:42 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add Receive Error Counter
Message-ID: <20200519145542.42170-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Receive error counter reflect total number of non-filtered
packets received with errors. This includes: CRC error,
symbol error, rx data error and carrier extend error.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.c  | 1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 drivers/net/ethernet/intel/igc/igc_regs.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 9de70a24cb9e..a5a087e1ac02 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -241,6 +241,7 @@ void igc_clear_hw_cntrs_base(struct igc_hw *hw)
 	rd32(IGC_MCC);
 	rd32(IGC_LATECOL);
 	rd32(IGC_COLC);
+	rd32(IGC_RERC);
 	rd32(IGC_DC);
 	rd32(IGC_SEC);
 	rd32(IGC_RLEC);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index aac004944f99..fb67e7990304 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3745,6 +3745,7 @@ void igc_update_stats(struct igc_adapter *adapter)
 
 	adapter->stats.tpt += rd32(IGC_TPT);
 	adapter->stats.colc += rd32(IGC_COLC);
+	adapter->stats.colc += rd32(IGC_RERC);
 
 	adapter->stats.algnerrc += rd32(IGC_ALGNERRC);
 
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index f50a7bf6a793..5a4873dddcbf 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -134,6 +134,7 @@
 #define IGC_MCC		0x0401C  /* Multiple Collision Count - R/clr */
 #define IGC_LATECOL	0x04020  /* Late Collision Count - R/clr */
 #define IGC_COLC	0x04028  /* Collision Count - R/clr */
+#define IGC_RERC	0x0402C  /* Receive Error Count - R/clr */
 #define IGC_DC		0x04030  /* Defer Count - R/clr */
 #define IGC_TNCRS	0x04034  /* Tx-No CRS - R/clr */
 #define IGC_SEC		0x04038  /* Sequence Error Count - R/clr */
-- 
2.11.0

