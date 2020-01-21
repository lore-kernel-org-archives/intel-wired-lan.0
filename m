From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 21 Jan 2020 15:46:28 -0800
Subject: [Intel-wired-lan] [next-queue v2] e1000e: Add support for Tiger
 Lake device
Message-ID: <20200121234628.4123479-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Added support for a device id that is a part of the Intel Tiger Lake
platform.

Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
---
 drivers/net/ethernet/intel/e1000e/hw.h     | 1 +
 drivers/net/ethernet/intel/e1000e/netdev.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index a1dbf8df1c70..61a0c7cb9ced 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -97,6 +97,7 @@ struct e1000_hw;
 #define E1000_DEV_ID_PCH_TGP_I219_LM14		0x15F9
 #define E1000_DEV_ID_PCH_TGP_I219_V14		0x15FA
 #define E1000_DEV_ID_PCH_TGP_I219_LM15		0x15F4
+#define E1000_DEV_ID_PCH_TGP_I219_V15		0x15F5
 #define E1000_DEV_ID_PCH_ADP_1219_LM16		0x1A1E
 #define E1000_DEV_ID_PCH_ADP_1219_V16		0x1A1F
 #define E1000_DEV_ID_PCH_ADP_1219_LM17		0x1A1C
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 59db2a865aa8..35f21add3732 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7762,6 +7762,7 @@ static const struct pci_device_id e1000_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM14), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V14), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM15), board_pch_cnp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V15), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_1219_LM16), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_1219_V16), board_pch_cnp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_1219_LM17), board_pch_cnp },
-- 
2.24.1

