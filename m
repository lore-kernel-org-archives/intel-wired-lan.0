From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue,  3 Mar 2020 20:26:10 +0200
Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Remove copper fiber switch
 control
Message-ID: <20200303182610.35628-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i225 device support copper mode only
PHY signal detect indication for copper fiber switch
not applicable to i225 part

v1 -> v2:
Address community comments and leave igc_ethtool.c no changes

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 2 --
 drivers/net/ethernet/intel/igc/igc_main.c    | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index dd0c86ce09ed..e5116337b68d 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -91,8 +91,6 @@
 #define IGC_CTRL_RFCE		0x08000000  /* Receive Flow Control enable */
 #define IGC_CTRL_TFCE		0x10000000  /* Transmit flow control enable */
 
-#define IGC_CONNSW_AUTOSENSE_EN	0x1
-
 /* As per the EAS the maximum supported size is 9.5KB (9728 bytes) */
 #define MAX_JUMBO_FRAME_SIZE	0x2600
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index d406aaea24af..47009fe0cbde 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4036,7 +4036,6 @@ static void igc_watchdog_task(struct work_struct *work)
 	struct igc_hw *hw = &adapter->hw;
 	struct igc_phy_info *phy = &hw->phy;
 	u16 phy_data, retry_count = 20;
-	u32 connsw;
 	u32 link;
 	int i;
 
@@ -4049,14 +4048,6 @@ static void igc_watchdog_task(struct work_struct *work)
 			link = false;
 	}
 
-	/* Force link down if we have fiber to swap to */
-	if (adapter->flags & IGC_FLAG_MAS_ENABLE) {
-		if (hw->phy.media_type == igc_media_type_copper) {
-			connsw = rd32(IGC_CONNSW);
-			if (!(connsw & IGC_CONNSW_AUTOSENSE_EN))
-				link = 0;
-		}
-	}
 	if (link) {
 		/* Cancel scheduled suspend requests. */
 		pm_runtime_resume(netdev->dev.parent);
-- 
2.11.0

