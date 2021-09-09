From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu,  9 Sep 2021 09:46:18 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Change Device Reset to Port
 Reset
Message-ID: <20210909064618.3643764-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

_reset_hw_base method switched from port reset (CTRL[26]) to device reset
(CTRL[29]) since the FW was receiving an interrupt on CTRL[29].
FW code was later modified to also receive an interrupt on CTRL[26].
Since certain HW values are not reset to default by CTRL[29], we go back
to CTRL[26] for the HW reset, as it meets all current requirements.

This reverts commit bb4265ec24c13aacf3a613e64c701294b122beb7

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c    | 2 +-
 drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index 2612a58fc52a..f068b66b8025 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -40,7 +40,7 @@ static s32 igc_reset_hw_base(struct igc_hw *hw)
 	ctrl = rd32(IGC_CTRL);
 
 	hw_dbg("Issuing a global reset to MAC\n");
-	wr32(IGC_CTRL, ctrl | IGC_CTRL_DEV_RST);
+	wr32(IGC_CTRL, ctrl | IGC_CTRL_RST);
 
 	ret_val = igc_get_auto_rd_done(hw);
 	if (ret_val) {
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 8a9c54d38a16..fad27a4fea78 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -130,7 +130,7 @@
 #define IGC_ERR_SWFW_SYNC		13
 
 /* Device Control */
-#define IGC_CTRL_DEV_RST	0x20000000  /* Device reset */
+#define IGC_CTRL_RST		0x04000000  /* Global reset */
 
 #define IGC_CTRL_PHY_RST	0x80000000  /* PHY Reset */
 #define IGC_CTRL_SLU		0x00000040  /* Set link up (Force Link) */
-- 
2.25.1

