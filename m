From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Fri, 25 Mar 2022 10:54:56 +0100
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Add Inspur Ethernet
 Connection X722 for 10GbE SFP+ support
Message-ID: <20220325095456.20084-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add support for Inspur Ethernet Connection X722 for 10GbE SFP+ cards.
Make possible for the driver to bind to the card.

Testing Hints: no functionality loss for other cards, make sure the
device loads

Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 1 +
 drivers/net/ethernet/intel/i40e/i40e_devids.h | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 6aefffd..2819e26 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -47,6 +47,7 @@ i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		case I40E_DEV_ID_1G_BASE_T_X722:
 		case I40E_DEV_ID_10G_BASE_T_X722:
 		case I40E_DEV_ID_SFP_I_X722:
+		case I40E_DEV_ID_SFP_X722_A:
 			hw->mac.type = I40E_MAC_X722;
 			break;
 		default:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devids.h b/drivers/net/ethernet/intel/i40e/i40e_devids.h
index 1bcb0ec..2610338 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devids.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_devids.h
@@ -33,6 +33,7 @@
 #define I40E_DEV_ID_1G_BASE_T_X722	0x37D1
 #define I40E_DEV_ID_10G_BASE_T_X722	0x37D2
 #define I40E_DEV_ID_SFP_I_X722		0x37D3
+#define I40E_DEV_ID_SFP_X722_A		0x0DDA
 
 
 #endif /* _I40E_DEVIDS_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b7f11fd..c318770 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -77,6 +77,7 @@ static const struct pci_device_id i40e_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_1G_BASE_T_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_I_X722), 0},
+	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_X722_A), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_20G_KR2), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_20G_KR2_A), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_X710_N3000), 0},
-- 
2.27.0

