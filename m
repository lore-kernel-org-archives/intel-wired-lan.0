From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue,  2 Jul 2019 14:39:55 +0300
Subject: [Intel-wired-lan] [PATCH v2] igc: Add more SKUs for i225 device
Message-ID: <20190702113955.6248-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add support for more SKUs.
v2: Fixed device id to I220

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c | 3 +++
 drivers/net/ethernet/intel/igc/igc_hw.h   | 3 +++
 drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index 59258d791106..9710a40ac56e 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -209,6 +209,9 @@ static s32 igc_get_invariants_base(struct igc_hw *hw)
 	switch (hw->device_id) {
 	case IGC_DEV_ID_I225_LM:
 	case IGC_DEV_ID_I225_V:
+	case IGC_DEV_ID_I225_I:
+	case IGC_DEV_ID_I220_V:
+	case IGC_DEV_ID_I225_K:
 		mac->type = igc_i225;
 		break;
 	default:
diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 9a338fbf671c..abb2d72911ff 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -18,6 +18,9 @@
 
 #define IGC_DEV_ID_I225_LM			0x15F2
 #define IGC_DEV_ID_I225_V			0x15F3
+#define IGC_DEV_ID_I225_I			0x15F8
+#define IGC_DEV_ID_I220_V			0x15F7
+#define IGC_DEV_ID_I225_K			0x3100
 
 #define IGC_FUNC_0				0
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 93f3b4e6185b..a70d9240ec4e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -36,6 +36,9 @@ static const struct igc_info *igc_info_tbl[] = {
 static const struct pci_device_id igc_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LM), board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_V), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_I), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I220_V), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_K), board_base },
 	/* required last entry */
 	{0, }
 };
-- 
2.11.0

