From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 26 Aug 2015 15:14:10 -0400
Subject: [Intel-wired-lan] [next PATCH S11 04/15] i40e/i40evf: add driver
	support for new device ids
In-Reply-To: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440616461-110869-5-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Early addition of new a device id.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I61a8c8556fdf4f5714be4e4089689e374f30293c
---
 drivers/net/ethernet/intel/i40e/i40e_common.c   | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c  | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 1 +
 drivers/net/ethernet/intel/i40e/i40e_type.h     | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_common.c | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_type.h   | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 1e81f4e..7a70abc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -51,6 +51,7 @@ static i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		case I40E_DEV_ID_QSFP_B:
 		case I40E_DEV_ID_QSFP_C:
 		case I40E_DEV_ID_10G_BASE_T:
+		case I40E_DEV_ID_10G_BASE_T4:
 		case I40E_DEV_ID_20G_KR2:
 		case I40E_DEV_ID_20G_KR2_A:
 			hw->mac.type = I40E_MAC_XL710;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 1345de2..928bd5a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -425,6 +425,7 @@ static void i40e_get_settings_link_down(struct i40e_hw *hw,
 		ecmd->advertising = ADVERTISED_10000baseKR_Full;
 		break;
 	case I40E_DEV_ID_10G_BASE_T:
+	case I40E_DEV_ID_10G_BASE_T4:
 		ecmd->supported = SUPPORTED_10000baseT_Full |
 				  SUPPORTED_1000baseT_Full |
 				  SUPPORTED_100baseT_Full;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 28ab759..bf181e9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -76,6 +76,7 @@ static const struct pci_device_id i40e_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_B), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_C), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T), 0},
+	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T4), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_20G_KR2), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_1G_BASE_T_X722), 0},
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 91d0b9e..f45f372 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -46,6 +46,7 @@
 #define I40E_DEV_ID_10G_BASE_T		0x1586
 #define I40E_DEV_ID_20G_KR2		0x1587
 #define I40E_DEV_ID_20G_KR2_A		0x1588
+#define I40E_DEV_ID_10G_BASE_T4		0x1589
 #define I40E_DEV_ID_VF			0x154C
 #define I40E_DEV_ID_VF_HV		0x1571
 #define I40E_DEV_ID_SFP_X722		0x37D0
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index 1950db1..96e48ee 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -51,6 +51,7 @@ i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		case I40E_DEV_ID_QSFP_B:
 		case I40E_DEV_ID_QSFP_C:
 		case I40E_DEV_ID_10G_BASE_T:
+		case I40E_DEV_ID_10G_BASE_T4:
 		case I40E_DEV_ID_20G_KR2:
 		case I40E_DEV_ID_20G_KR2_A:
 			hw->mac.type = I40E_MAC_XL710;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index ae9498c..43782ed 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -46,6 +46,7 @@
 #define I40E_DEV_ID_10G_BASE_T		0x1586
 #define I40E_DEV_ID_20G_KR2		0x1587
 #define I40E_DEV_ID_20G_KR2_A		0x1588
+#define I40E_DEV_ID_10G_BASE_T4		0x1589
 #define I40E_DEV_ID_VF			0x154C
 #define I40E_DEV_ID_VF_HV		0x1571
 #define I40E_DEV_ID_SFP_X722		0x37D0
-- 
1.9.3

