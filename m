From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 23 Jul 2015 16:54:39 -0400
Subject: [Intel-wired-lan] [next PATCH S9 10/15] i40e/i40evf: add new device
	id 1588
In-Reply-To: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1437684884-222825-11-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Add new device id and support for another 20Gb device.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: Ib1b61e5bb6201d84953f97cade39a6e3369c2cf2
---
 drivers/net/ethernet/intel/i40e/i40e_common.c   | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c  | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 2 ++
 drivers/net/ethernet/intel/i40e/i40e_type.h     | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_common.c | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_type.h   | 1 +
 6 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 114dc64..80c354c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -52,6 +52,7 @@ static i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		case I40E_DEV_ID_QSFP_C:
 		case I40E_DEV_ID_10G_BASE_T:
 		case I40E_DEV_ID_20G_KR2:
+		case I40E_DEV_ID_20G_KR2_A:
 			hw->mac.type = I40E_MAC_XL710;
 			break;
 		case I40E_DEV_ID_SFP_X722:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index e972b5e..dd2b620 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -437,6 +437,7 @@ static void i40e_get_settings_link_down(struct i40e_hw *hw,
 			ecmd->advertising |= ADVERTISED_100baseT_Full;
 		break;
 	case I40E_DEV_ID_20G_KR2:
+	case I40E_DEV_ID_20G_KR2_A:
 		/* backplane 20G */
 		ecmd->supported = SUPPORTED_20000baseKR2_Full;
 		ecmd->advertising = ADVERTISED_20000baseKR2_Full;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a43062e..4f0660f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -80,6 +80,8 @@ static const struct pci_device_id i40e_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_1G_BASE_T_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T_X722), 0},
+	{PCI_VDEVICE(INTEL, I40E_DEV_ID_20G_KR2), 0},
+	{PCI_VDEVICE(INTEL, I40E_DEV_ID_20G_KR2_A), 0},
 	/* required last entry */
 	{0, }
 };
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 4842239..91d0b9e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -45,6 +45,7 @@
 #define I40E_DEV_ID_QSFP_C		0x1585
 #define I40E_DEV_ID_10G_BASE_T		0x1586
 #define I40E_DEV_ID_20G_KR2		0x1587
+#define I40E_DEV_ID_20G_KR2_A		0x1588
 #define I40E_DEV_ID_VF			0x154C
 #define I40E_DEV_ID_VF_HV		0x1571
 #define I40E_DEV_ID_SFP_X722		0x37D0
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index d45d0ae..1950db1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -52,6 +52,7 @@ i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		case I40E_DEV_ID_QSFP_C:
 		case I40E_DEV_ID_10G_BASE_T:
 		case I40E_DEV_ID_20G_KR2:
+		case I40E_DEV_ID_20G_KR2_A:
 			hw->mac.type = I40E_MAC_XL710;
 			break;
 		case I40E_DEV_ID_SFP_X722:
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index 24a2693..ae9498c 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -45,6 +45,7 @@
 #define I40E_DEV_ID_QSFP_C		0x1585
 #define I40E_DEV_ID_10G_BASE_T		0x1586
 #define I40E_DEV_ID_20G_KR2		0x1587
+#define I40E_DEV_ID_20G_KR2_A		0x1588
 #define I40E_DEV_ID_VF			0x154C
 #define I40E_DEV_ID_VF_HV		0x1571
 #define I40E_DEV_ID_SFP_X722		0x37D0
-- 
1.9.3

