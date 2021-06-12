From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sat, 12 Jun 2021 20:02:20 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Add support for the next
 LOM generation
Message-ID: <20210612170220.3930002-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add devices IDs for the next LOM generations that will be
available on the next Intel Client platforms
This patch provides the initial support for these devices

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/hw.h     | 4 ++++
 drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index 36ff936918c9..bcf680e83811 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -98,10 +98,14 @@ struct e1000_hw;
 #define E1000_DEV_ID_PCH_TGP_I219_V14		0x15FA
 #define E1000_DEV_ID_PCH_TGP_I219_LM15		0x15F4
 #define E1000_DEV_ID_PCH_TGP_I219_V15		0x15F5
+#define E1000_DEV_ID_PCH_RPL_I219_LM23		0x0DC5
+#define E1000_DEV_ID_PCH_RPL_I219_V23		0x0DC6
 #define E1000_DEV_ID_PCH_ADP_I219_LM16		0x1A1E
 #define E1000_DEV_ID_PCH_ADP_I219_V16		0x1A1F
 #define E1000_DEV_ID_PCH_ADP_I219_LM17		0x1A1C
 #define E1000_DEV_ID_PCH_ADP_I219_V17		0x1A1D
+#define E1000_DEV_ID_PCH_RPL_I219_LM22		0x0DC7
+#define E1000_DEV_ID_PCH_RPL_I219_V22		0x0DC8
 #define E1000_DEV_ID_PCH_MTP_I219_LM18		0x550A
 #define E1000_DEV_ID_PCH_MTP_I219_V18		0x550B
 #define E1000_DEV_ID_PCH_MTP_I219_LM19		0x550C
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6a20c7f82fc9..2ad61efa85bd 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7906,10 +7906,14 @@ static const struct pci_device_id e1000_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V14), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM15), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V15), board_pch_cnp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_LM23), board_pch_cnp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_V23), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM16), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V16), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM17), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V17), board_pch_cnp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_LM22), board_pch_cnp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_V22), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_LM18), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_V18), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_LM19), board_pch_cnp },
-- 
2.25.1

