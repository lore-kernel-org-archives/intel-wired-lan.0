From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu, 28 May 2020 10:11:11 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove Sequence Error Counter
Message-ID: <20200528071111.9808-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Accordance to the i225 datasheet sequence error counter does not
applicable to the i225 device.
This patch comes to clean up this counter.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.c  | 1 -
 drivers/net/ethernet/intel/igc/igc_main.c | 1 -
 drivers/net/ethernet/intel/igc/igc_regs.h | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index a5a087e1ac02..fb496617e8e1 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -243,7 +243,6 @@ void igc_clear_hw_cntrs_base(struct igc_hw *hw)
 	rd32(IGC_COLC);
 	rd32(IGC_RERC);
 	rd32(IGC_DC);
-	rd32(IGC_SEC);
 	rd32(IGC_RLEC);
 	rd32(IGC_XONRXC);
 	rd32(IGC_XONTXC);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 26f5ce23e255..0be6153195f2 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3705,7 +3705,6 @@ void igc_update_stats(struct igc_adapter *adapter)
 	adapter->stats.prc511 += rd32(IGC_PRC511);
 	adapter->stats.prc1023 += rd32(IGC_PRC1023);
 	adapter->stats.prc1522 += rd32(IGC_PRC1522);
-	adapter->stats.sec += rd32(IGC_SEC);
 
 	mpc = rd32(IGC_MPC);
 	adapter->stats.mpc += mpc;
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index 5a4873dddcbf..48f46ee96bfd 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -137,7 +137,6 @@
 #define IGC_RERC	0x0402C  /* Receive Error Count - R/clr */
 #define IGC_DC		0x04030  /* Defer Count - R/clr */
 #define IGC_TNCRS	0x04034  /* Tx-No CRS - R/clr */
-#define IGC_SEC		0x04038  /* Sequence Error Count - R/clr */
 #define IGC_CEXTERR	0x0403C  /* Carrier Extension Error Count - R/clr */
 #define IGC_RLEC	0x04040  /* Receive Length Error Count - R/clr */
 #define IGC_XONRXC	0x04048  /* XON Rx Count - R/clr */
-- 
2.11.0

