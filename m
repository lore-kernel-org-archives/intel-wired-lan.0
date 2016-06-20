From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 20 Jun 2016 09:10:36 -0700
Subject: [Intel-wired-lan] [next PTACH S38-v2 4/7] i40e: Remove device ID
	0x37D4
In-Reply-To: <1466439039-16378-1-git-send-email-bimmy.pujari@intel.com>
References: <1466439039-16378-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1466439039-16378-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

This device ID is not needed, so take it out.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: I148d29f68a1f58b03980ecd83047a1b440f4f74d
---
Testing Hints: Make sure device ID does not appear in devids.h and we
compile, note that the ID will remain in the upstream pciid database.

 drivers/net/ethernet/intel/i40e/i40e_common.c   | 1 -
 drivers/net/ethernet/intel/i40e/i40e_devids.h   | 1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 1 -
 drivers/net/ethernet/intel/i40evf/i40e_common.c | 1 -
 drivers/net/ethernet/intel/i40evf/i40e_devids.h | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 3355f4d..9ffa409 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -61,7 +61,6 @@ static i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		case I40E_DEV_ID_1G_BASE_T_X722:
 		case I40E_DEV_ID_10G_BASE_T_X722:
 		case I40E_DEV_ID_SFP_I_X722:
-		case I40E_DEV_ID_QSFP_I_X722:
 			hw->mac.type = I40E_MAC_X722;
 			break;
 		default:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devids.h b/drivers/net/ethernet/intel/i40e/i40e_devids.h
index d701861..dd4457d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devids.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_devids.h
@@ -45,7 +45,6 @@
 #define I40E_DEV_ID_1G_BASE_T_X722	0x37D1
 #define I40E_DEV_ID_10G_BASE_T_X722	0x37D2
 #define I40E_DEV_ID_SFP_I_X722		0x37D3
-#define I40E_DEV_ID_QSFP_I_X722		0x37D4
 
 #define i40e_is_40G_device(d)		((d) == I40E_DEV_ID_QSFP_A  || \
 					 (d) == I40E_DEV_ID_QSFP_B  || \
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3b8d079..0898c9d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -91,7 +91,6 @@ static const struct pci_device_id i40e_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_1G_BASE_T_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_I_X722), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_I_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_20G_KR2), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_20G_KR2_A), 0},
 	/* required last entry */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index 8f64204..4db0c03 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -59,7 +59,6 @@ i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		case I40E_DEV_ID_1G_BASE_T_X722:
 		case I40E_DEV_ID_10G_BASE_T_X722:
 		case I40E_DEV_ID_SFP_I_X722:
-		case I40E_DEV_ID_QSFP_I_X722:
 			hw->mac.type = I40E_MAC_X722;
 			break;
 		case I40E_DEV_ID_X722_VF:
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_devids.h b/drivers/net/ethernet/intel/i40evf/i40e_devids.h
index d34972b..7023570 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_devids.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_devids.h
@@ -45,7 +45,6 @@
 #define I40E_DEV_ID_1G_BASE_T_X722	0x37D1
 #define I40E_DEV_ID_10G_BASE_T_X722	0x37D2
 #define I40E_DEV_ID_SFP_I_X722		0x37D3
-#define I40E_DEV_ID_QSFP_I_X722		0x37D4
 #define I40E_DEV_ID_X722_VF		0x37CD
 #define I40E_DEV_ID_X722_VF_HV		0x37D9
 
-- 
2.4.11

