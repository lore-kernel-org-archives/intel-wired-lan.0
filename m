From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu, 18 Apr 2019 10:11:08 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add flow control support
Message-ID: <20190418071108.35151-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change adds flow control settings. This is required to
enable the legacy flow control support.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h |  3 +++
 drivers/net/ethernet/intel/igc/igc_main.c    | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 5f6bc67cb33b..fc0ccfe38a20 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -66,6 +66,9 @@
 
 #define IGC_CONNSW_AUTOSENSE_EN	0x1
 
+/* As per the EAS the maximum supported size is 9.5KB (9728 bytes) */
+#define MAX_JUMBO_FRAME_SIZE	0x2600
+
 /* PBA constants */
 #define IGC_PBA_34K		0x0022
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index cb8477b84d37..810d44fb77bf 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -72,6 +72,28 @@ void igc_reset(struct igc_adapter *adapter)
 {
 	struct pci_dev *pdev = adapter->pdev;
 	struct igc_hw *hw = &adapter->hw;
+	struct igc_fc_info *fc = &hw->fc;
+	u32 pba, hwm;
+
+	/* Repartition PBA for greater than 9k mtu if required
+	 */
+	pba = IGC_PBA_34K;
+
+	/* flow control settings
+	 * The high water mark must be low enough to fit one full frame
+	 * after transmitting the pause frame.  As such we must have enough
+	 * space to allow for us to complete our current transmit and then
+	 * receive the frame that is in progress from the link partner.
+	 * Set it to:
+	 * - the full Rx FIFO size minus one full Tx plus one full Rx frame
+	 */
+	hwm = (pba << 10) - (adapter->max_frame_size + MAX_JUMBO_FRAME_SIZE);
+
+	fc->high_water = hwm & 0xFFFFFFF0;	/* 16-byte granularity */
+	fc->low_water = fc->high_water - 16;
+	fc->pause_time = 0xFFFF;
+	fc->send_xon = 1;
+	fc->current_mode = fc->requested_mode;
 
 	hw->mac.ops.reset_hw(hw);
 
-- 
2.11.0

