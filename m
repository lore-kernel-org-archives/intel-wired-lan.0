From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 31 Aug 2021 10:39:02 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add new device ID
Message-ID: <20210831073902.1855742-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add new device ID for the next step of the silicon and
reflect the I226_LMVP part.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c | 1 +
 drivers/net/ethernet/intel/igc/igc_hw.h   | 1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index 30b1f02cef15..2612a58fc52a 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -202,6 +202,7 @@ static s32 igc_get_invariants_base(struct igc_hw *hw)
 	case IGC_DEV_ID_I225_K2:
 	case IGC_DEV_ID_I226_K:
 	case IGC_DEV_ID_I225_LMVP:
+	case IGC_DEV_ID_I226_LMVP:
 	case IGC_DEV_ID_I225_IT:
 	case IGC_DEV_ID_I226_LM:
 	case IGC_DEV_ID_I226_V:
diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 4461f8b9a864..772fd06e93ac 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -23,6 +23,7 @@
 #define IGC_DEV_ID_I225_K			0x3100
 #define IGC_DEV_ID_I225_K2			0x3101
 #define IGC_DEV_ID_I225_LMVP			0x5502
+#define IGC_DEV_ID_I226_LMVP			0x5503
 #define IGC_DEV_ID_I226_K			0x5504
 #define IGC_DEV_ID_I225_IT			0x0D9F
 #define IGC_DEV_ID_I226_LM			0x125B
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 21a3e232ad8b..d2efb2ad8c68 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -56,6 +56,7 @@ static const struct pci_device_id igc_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_K2), board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_K), board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LMVP), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LMVP), board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_IT), board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LM), board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_V), board_base },
-- 
2.25.1

