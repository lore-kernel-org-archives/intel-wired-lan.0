From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun,  7 Jun 2020 11:51:27 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove TCP segmentation TX
 fail counter
Message-ID: <20200607085127.29281-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

TCP segmentation TX context fail counter is not
applicable for i225 devices.
This patch comes to clean up this counter.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.c  | 1 -
 drivers/net/ethernet/intel/igc/igc_main.c | 1 -
 drivers/net/ethernet/intel/igc/igc_regs.h | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index f3f7717b6233..9a5e44ef45f4 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -289,7 +289,6 @@ void igc_clear_hw_cntrs_base(struct igc_hw *hw)
 	rd32(IGC_TNCRS);
 	rd32(IGC_HTDPMC);
 	rd32(IGC_TSCTC);
-	rd32(IGC_TSCTFC);
 
 	rd32(IGC_MGTPRC);
 	rd32(IGC_MGTPDC);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index b92e7e20ce78..5d70751e8ab3 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3740,7 +3740,6 @@ void igc_update_stats(struct igc_adapter *adapter)
 	adapter->stats.algnerrc += rd32(IGC_ALGNERRC);
 
 	adapter->stats.tsctc += rd32(IGC_TSCTC);
-	adapter->stats.tsctfc += rd32(IGC_TSCTFC);
 
 	adapter->stats.iac += rd32(IGC_IAC);
 	adapter->stats.icrxoc += rd32(IGC_ICRXOC);
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index eb3e8e70501d..1c46cec5a799 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -181,7 +181,6 @@
 #define IGC_MPTC	0x040F0  /* Multicast Packets Tx Count - R/clr */
 #define IGC_BPTC	0x040F4  /* Broadcast Packets Tx Count - R/clr */
 #define IGC_TSCTC	0x040F8  /* TCP Segmentation Context Tx - R/clr */
-#define IGC_TSCTFC	0x040FC  /* TCP Segmentation Context Tx Fail - R/clr */
 #define IGC_IAC		0x04100  /* Interrupt Assertion Count */
 #define IGC_ICTXPTC	0x0410C  /* Interrupt Cause Tx Pkt Timer Expire Count */
 #define IGC_ICTXATC	0x04110  /* Interrupt Cause Tx Abs Timer Expire Count */
-- 
2.11.0

