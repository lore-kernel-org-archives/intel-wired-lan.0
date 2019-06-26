From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 26 Jun 2019 08:53:47 +0300
Subject: [Intel-wired-lan] [PATCH v1] igc: Update the MAC reset flow
Message-ID: <20190626055347.18154-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use Device Reset flow instead of Port Reset flow.
This flow performs a reset of the entire controller device,
resulting in a state nearly approximating the state
following a power-up reset or internal PCIe reset,
except for system PCI configration.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c    | 2 +-
 drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index 019107e46428..3b00b19125c8 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -40,7 +40,7 @@ static s32 igc_reset_hw_base(struct igc_hw *hw)
 	ctrl = rd32(IGC_CTRL);
 
 	hw_dbg("Issuing a global reset to MAC\n");
-	wr32(IGC_CTRL, ctrl | IGC_CTRL_RST);
+	wr32(IGC_CTRL, ctrl | IGC_CTRL_DEV_RST);
 
 	ret_val = igc_get_auto_rd_done(hw);
 	if (ret_val) {
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index fc0ccfe38a20..11b99acf4abe 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -54,7 +54,7 @@
 #define IGC_ERR_SWFW_SYNC		13
 
 /* Device Control */
-#define IGC_CTRL_RST		0x04000000  /* Global reset */
+#define IGC_CTRL_DEV_RST	0x20000000  /* Device reset */
 
 #define IGC_CTRL_PHY_RST	0x80000000  /* PHY Reset */
 #define IGC_CTRL_SLU		0x00000040  /* Set link up (Force Link) */
-- 
2.11.0

