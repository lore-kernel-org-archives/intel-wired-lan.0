From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Thu, 17 Mar 2016 09:41:22 -0700
Subject: [Intel-wired-lan] [next PATCH S31 v3 04/12] i40e: Add new device ID
	for X722
In-Reply-To: <1458232890-110933-1-git-send-email-avinash.dayanand@intel.com>
References: <1458232890-110933-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1458232890-110933-5-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan 1452637417 -0500 <catherine.sullivan@intel.com>

The new device ID is 0x37D3 and it should follow the same flows and
branding string as for 0x37D0.

Testing Hints: Make sure the device loads.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c   | 1 +
 drivers/net/ethernet/intel/i40e/i40e_devids.h   | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_common.c | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_devids.h | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 8276a13..ebcc0d3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -60,6 +60,7 @@ static i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		case I40E_DEV_ID_SFP_X722:
 		case I40E_DEV_ID_1G_BASE_T_X722:
 		case I40E_DEV_ID_10G_BASE_T_X722:
+		case I40E_DEV_ID_SFP_I_X722:
 			hw->mac.type = I40E_MAC_X722;
 			break;
 		default:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devids.h b/drivers/net/ethernet/intel/i40e/i40e_devids.h
index 99257fc..dd4457d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devids.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_devids.h
@@ -44,6 +44,7 @@
 #define I40E_DEV_ID_SFP_X722		0x37D0
 #define I40E_DEV_ID_1G_BASE_T_X722	0x37D1
 #define I40E_DEV_ID_10G_BASE_T_X722	0x37D2
+#define I40E_DEV_ID_SFP_I_X722		0x37D3
 
 #define i40e_is_40G_device(d)		((d) == I40E_DEV_ID_QSFP_A  || \
 					 (d) == I40E_DEV_ID_QSFP_B  || \
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 31f6ee1..33b6c68 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -90,6 +90,7 @@ static const struct pci_device_id i40e_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_1G_BASE_T_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T_X722), 0},
+	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_I_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_20G_KR2), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_20G_KR2_A), 0},
 	/* required last entry */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index 771ac6a..4db0c03 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -58,6 +58,7 @@ i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		case I40E_DEV_ID_SFP_X722:
 		case I40E_DEV_ID_1G_BASE_T_X722:
 		case I40E_DEV_ID_10G_BASE_T_X722:
+		case I40E_DEV_ID_SFP_I_X722:
 			hw->mac.type = I40E_MAC_X722;
 			break;
 		case I40E_DEV_ID_X722_VF:
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_devids.h b/drivers/net/ethernet/intel/i40evf/i40e_devids.h
index ca8b58c..7023570 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_devids.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_devids.h
@@ -44,6 +44,7 @@
 #define I40E_DEV_ID_SFP_X722		0x37D0
 #define I40E_DEV_ID_1G_BASE_T_X722	0x37D1
 #define I40E_DEV_ID_10G_BASE_T_X722	0x37D2
+#define I40E_DEV_ID_SFP_I_X722		0x37D3
 #define I40E_DEV_ID_X722_VF		0x37CD
 #define I40E_DEV_ID_X722_VF_HV		0x37D9
 
-- 
2.4.3

