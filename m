From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon,  3 Aug 2020 21:33:58 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add new device ID's
Message-ID: <20200803183358.1099864-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add new device ID's for the next step of the silicon and
reflect i221 and i226 parts

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c | 5 +++++
 drivers/net/ethernet/intel/igc/igc_hw.h   | 5 +++++
 drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index cc5a6cf531c7..fd37d2c203af 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -215,6 +215,11 @@ static s32 igc_get_invariants_base(struct igc_hw *hw)
 	case IGC_DEV_ID_I225_K2:
 	case IGC_DEV_ID_I225_LMVP:
 	case IGC_DEV_ID_I225_IT:
+	case IGC_DEV_ID_I226_LM:
+	case IGC_DEV_ID_I226_V:
+	case IGC_DEV_ID_I226_IT:
+	case IGC_DEV_ID_I221_V:
+	case IGC_DEV_ID_I226_BLANK_NVM:
 	case IGC_DEV_ID_I225_BLANK_NVM:
 		mac->type = igc_i225;
 		break;
diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index b9fe51b91c47..6defdb8a31fe 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -24,6 +24,11 @@
 #define IGC_DEV_ID_I225_K2			0x3101
 #define IGC_DEV_ID_I225_LMVP			0x5502
 #define IGC_DEV_ID_I225_IT			0x0D9F
+#define IGC_DEV_ID_I226_LM			0x125B
+#define IGC_DEV_ID_I226_V			0x125C
+#define IGC_DEV_ID_I226_IT			0x125D
+#define IGC_DEV_ID_I221_V			0x125E
+#define IGC_DEV_ID_I226_BLANK_NVM		0x125F
 #define IGC_DEV_ID_I225_BLANK_NVM		0x15FD
 
 /* Function pointers for the MAC. */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index d6b37d91cad9..6c95ccb61436 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -47,6 +47,11 @@ static const struct pci_device_id igc_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_K2), board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LMVP), board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_IT), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LM), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_V), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_IT), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I221_V), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_BLANK_NVM), board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_BLANK_NVM), board_base },
 	/* required last entry */
 	{0, }
-- 
2.25.1

