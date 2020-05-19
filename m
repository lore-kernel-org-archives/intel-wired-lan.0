From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 19 May 2020 17:36:34 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove symbol error counter
Message-ID: <20200519143634.12765-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Accordance to the i225 datasheet symbol error counter does not
applicable to the i225 device.
This patch comes to clean up this counter.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.c  | 1 -
 drivers/net/ethernet/intel/igc/igc_main.c | 1 -
 drivers/net/ethernet/intel/igc/igc_regs.h | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 89445ab02a98..9de70a24cb9e 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -235,7 +235,6 @@ s32 igc_force_mac_fc(struct igc_hw *hw)
 void igc_clear_hw_cntrs_base(struct igc_hw *hw)
 {
 	rd32(IGC_CRCERRS);
-	rd32(IGC_SYMERRS);
 	rd32(IGC_MPC);
 	rd32(IGC_SCC);
 	rd32(IGC_ECOL);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 26dc437fa9da..aac004944f99 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3706,7 +3706,6 @@ void igc_update_stats(struct igc_adapter *adapter)
 	adapter->stats.prc511 += rd32(IGC_PRC511);
 	adapter->stats.prc1023 += rd32(IGC_PRC1023);
 	adapter->stats.prc1522 += rd32(IGC_PRC1522);
-	adapter->stats.symerrs += rd32(IGC_SYMERRS);
 	adapter->stats.sec += rd32(IGC_SEC);
 
 	mpc = rd32(IGC_MPC);
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index 9970242d0d75..f50a7bf6a793 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -127,7 +127,6 @@
 /* Statistics Register Descriptions */
 #define IGC_CRCERRS	0x04000  /* CRC Error Count - R/clr */
 #define IGC_ALGNERRC	0x04004  /* Alignment Error Count - R/clr */
-#define IGC_SYMERRS	0x04008  /* Symbol Error Count - R/clr */
 #define IGC_RXERRC	0x0400C  /* Receive Error Count - R/clr */
 #define IGC_MPC		0x04010  /* Missed Packet Count - R/clr */
 #define IGC_SCC		0x04014  /* Single Collision Count - R/clr */
-- 
2.11.0

