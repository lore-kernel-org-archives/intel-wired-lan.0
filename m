From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Mar 2019 15:08:31 -0700
Subject: [Intel-wired-lan] [next PATCH S4 02/11] i40e: add new pci id for
 X710/XXV710 N3000 cards
In-Reply-To: <20190329220840.51187-1-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
Message-ID: <20190329220840.51187-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

New device ids are created to support X710/XXV710 N3000 cards.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 2 ++
 drivers/net/ethernet/intel/i40e/i40e_devids.h | 2 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index e7d500f92a90..8de6e007b4a0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -32,6 +32,8 @@ static i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		case I40E_DEV_ID_20G_KR2_A:
 		case I40E_DEV_ID_25G_B:
 		case I40E_DEV_ID_25G_SFP28:
+		case I40E_DEV_ID_X710_N3000:
+		case I40E_DEV_ID_XXV710_N3000:
 			hw->mac.type = I40E_MAC_XL710;
 			break;
 		case I40E_DEV_ID_KX_X722:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devids.h b/drivers/net/ethernet/intel/i40e/i40e_devids.h
index 334b05ff685a..16be4d5286bd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devids.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_devids.h
@@ -5,6 +5,8 @@
 #define _I40E_DEVIDS_H_
 
 /* Device IDs */
+#define I40E_DEV_ID_X710_N3000		0x0CF8
+#define I40E_DEV_ID_XXV710_N3000	0x0D58
 #define I40E_DEV_ID_SFP_XL710		0x1572
 #define I40E_DEV_ID_QEMU		0x1574
 #define I40E_DEV_ID_KX_B		0x1580
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index cadee0e3ba94..9fe040f4049d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -77,6 +77,8 @@ static const struct pci_device_id i40e_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_I_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_20G_KR2), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_20G_KR2_A), 0},
+	{PCI_VDEVICE(INTEL, I40E_DEV_ID_X710_N3000), 0},
+	{PCI_VDEVICE(INTEL, I40E_DEV_ID_XXV710_N3000), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_25G_B), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_25G_SFP28), 0},
 	/* required last entry */
-- 
2.19.2

