From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 19 Feb 2020 08:49:51 +0200
Subject: [Intel-wired-lan] [PATCH v2 1/1] e1000e: Fix typo in Alder Lake
 brand name
Message-ID: <20200219064951.43639-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Follow to commit e15ef7697361 ("e1000e: Add support for Alder Lake")
Fix typo in brand name string. Changing a "one" to an "I"

v1 -> v2: make a commit message clear

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/hw.h     | 8 ++++----
 drivers/net/ethernet/intel/e1000e/netdev.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index 61a0c7cb9ced..b1447221669e 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -98,10 +98,10 @@ struct e1000_hw;
 #define E1000_DEV_ID_PCH_TGP_I219_V14		0x15FA
 #define E1000_DEV_ID_PCH_TGP_I219_LM15		0x15F4
 #define E1000_DEV_ID_PCH_TGP_I219_V15		0x15F5
-#define E1000_DEV_ID_PCH_ADP_1219_LM16		0x1A1E
-#define E1000_DEV_ID_PCH_ADP_1219_V16		0x1A1F
-#define E1000_DEV_ID_PCH_ADP_1219_LM17		0x1A1C
-#define E1000_DEV_ID_PCH_ADP_1219_V17		0x1A1D
+#define E1000_DEV_ID_PCH_ADP_I219_LM16		0x1A1E
+#define E1000_DEV_ID_PCH_ADP_I219_V16		0x1A1F
+#define E1000_DEV_ID_PCH_ADP_I219_LM17		0x1A1C
+#define E1000_DEV_ID_PCH_ADP_I219_V17		0x1A1D
 
 #define E1000_REVISION_4	4
 
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 35f21add3732..fb92002cabee 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7763,10 +7763,10 @@ static const struct pci_device_id e1000_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V14), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM15), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V15), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_1219_LM16), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_1219_V16), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_1219_LM17), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_1219_V17), board_pch_cnp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM16), board_pch_cnp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V16), board_pch_cnp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM17), board_pch_cnp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V17), board_pch_cnp },
 
 	{ 0, 0, 0, 0, 0, 0, 0 }	/* terminate list */
 };
-- 
2.11.0

