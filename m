From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon,  1 May 2017 11:24:51 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 13/13] i40evf: Add support for
	Adaptive Virtual Function
In-Reply-To: <1493663091-27870-13-git-send-email-jesse.brandeburg@intel.com>
References: <1493663091-27870-1-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-2-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-3-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-4-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-5-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-6-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-7-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-8-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-9-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-10-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-11-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-12-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-13-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <1493663091-27870-14-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Preethi Banala <preethi.banala@intel.com>

Add device ID define and mac_type assignment needed for
Adaptive Virtual Function (VF Base Mode Support).

Also, update version to v3.0.0 in order to indicate
clearly that this is the first driver supporting the AVF
device ID.

Signed-off-by: Preethi Banala <preethi.banala@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index 9dec775..1dd1938 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -68,6 +68,7 @@ i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 			break;
 		case I40E_DEV_ID_VF:
 		case I40E_DEV_ID_VF_HV:
+		case I40E_DEV_ID_ADAPTIVE_VF:
 			hw->mac.type = I40E_MAC_VF;
 			break;
 		default:
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_devids.h b/drivers/net/ethernet/intel/i40evf/i40e_devids.h
index d76393c..0469e4b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_devids.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_devids.h
@@ -43,6 +43,7 @@
 #define I40E_DEV_ID_25G_SFP28		0x158B
 #define I40E_DEV_ID_VF			0x154C
 #define I40E_DEV_ID_VF_HV		0x1571
+#define I40E_DEV_ID_ADAPTIVE_VF		0x1889
 #define I40E_DEV_ID_SFP_X722		0x37D0
 #define I40E_DEV_ID_1G_BASE_T_X722	0x37D1
 #define I40E_DEV_ID_10G_BASE_T_X722	0x37D2
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 1b00274..3a3ca96 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -44,9 +44,9 @@
 
 #define DRV_KERN "-k"
 
-#define DRV_VERSION_MAJOR 2
-#define DRV_VERSION_MINOR 1
-#define DRV_VERSION_BUILD 14
+#define DRV_VERSION_MAJOR 3
+#define DRV_VERSION_MINOR 0
+#define DRV_VERSION_BUILD 0
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD) \
@@ -67,6 +67,7 @@
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_VF), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_VF_HV), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_X722_VF), 0},
+	{PCI_VDEVICE(INTEL, I40E_DEV_ID_ADAPTIVE_VF), 0},
 	/* required last entry */
 	{0, }
 };
-- 
1.8.3.1

