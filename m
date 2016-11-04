From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri,  4 Nov 2016 10:36:02 -0700
Subject: [Intel-wired-lan] [next PATCH S52 05/11] i40e/i40evf: Support for
	25G
In-Reply-To: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
References: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478280968-8098-6-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Kosiarz <michal.kosiarz@intel.com>

Add support for 25G device ID and new PHY types.

Signed-off-by: Michal Kosiarz <michal.kosiarz@intel.com>
Change-ID: Ie3029a9f4f900635c3b25efdec782e8904b61da4
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 4 ++++
 drivers/net/ethernet/intel/i40e/i40e_common.c       | 2 ++
 drivers/net/ethernet/intel/i40e/i40e_devids.h       | 2 ++
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 4 ++++
 drivers/net/ethernet/intel/i40evf/i40e_common.c     | 2 ++
 drivers/net/ethernet/intel/i40evf/i40e_devids.h     | 2 ++
 6 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 67e396b..313d262 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1642,6 +1642,10 @@ enum i40e_aq_phy_type {
 	I40E_PHY_TYPE_1000BASE_LX		= 0x1C,
 	I40E_PHY_TYPE_1000BASE_T_OPTICAL	= 0x1D,
 	I40E_PHY_TYPE_20GBASE_KR2		= 0x1E,
+	I40E_PHY_TYPE_25GBASE_KR		= 0x1F,
+	I40E_PHY_TYPE_25GBASE_CR		= 0x20,
+	I40E_PHY_TYPE_25GBASE_SR		= 0x21,
+	I40E_PHY_TYPE_25GBASE_LR		= 0x22,
 	I40E_PHY_TYPE_MAX
 };
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 33bcf23..33051ed 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -53,6 +53,8 @@ static i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		case I40E_DEV_ID_10G_BASE_T4:
 		case I40E_DEV_ID_20G_KR2:
 		case I40E_DEV_ID_20G_KR2_A:
+		case I40E_DEV_ID_25G_B:
+		case I40E_DEV_ID_25G_SFP28:
 			hw->mac.type = I40E_MAC_XL710;
 			break;
 		case I40E_DEV_ID_KX_X722:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devids.h b/drivers/net/ethernet/intel/i40e/i40e_devids.h
index dd4457d..8e46098 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devids.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_devids.h
@@ -39,6 +39,8 @@
 #define I40E_DEV_ID_20G_KR2		0x1587
 #define I40E_DEV_ID_20G_KR2_A		0x1588
 #define I40E_DEV_ID_10G_BASE_T4		0x1589
+#define I40E_DEV_ID_25G_B		0x158A
+#define I40E_DEV_ID_25G_SFP28		0x158B
 #define I40E_DEV_ID_KX_X722		0x37CE
 #define I40E_DEV_ID_QSFP_X722		0x37CF
 #define I40E_DEV_ID_SFP_X722		0x37D0
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index 40b0eaf..5cce63a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -1639,6 +1639,10 @@ enum i40e_aq_phy_type {
 	I40E_PHY_TYPE_1000BASE_LX		= 0x1C,
 	I40E_PHY_TYPE_1000BASE_T_OPTICAL	= 0x1D,
 	I40E_PHY_TYPE_20GBASE_KR2		= 0x1E,
+	I40E_PHY_TYPE_25GBASE_KR		= 0x1F,
+	I40E_PHY_TYPE_25GBASE_CR		= 0x20,
+	I40E_PHY_TYPE_25GBASE_SR		= 0x21,
+	I40E_PHY_TYPE_25GBASE_LR		= 0x22,
 	I40E_PHY_TYPE_MAX
 };
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index 7953c13..aa63b7f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -53,6 +53,8 @@ i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		case I40E_DEV_ID_10G_BASE_T4:
 		case I40E_DEV_ID_20G_KR2:
 		case I40E_DEV_ID_20G_KR2_A:
+		case I40E_DEV_ID_25G_B:
+		case I40E_DEV_ID_25G_SFP28:
 			hw->mac.type = I40E_MAC_XL710;
 			break;
 		case I40E_DEV_ID_SFP_X722:
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_devids.h b/drivers/net/ethernet/intel/i40evf/i40e_devids.h
index 7023570..21dcaee 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_devids.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_devids.h
@@ -39,6 +39,8 @@
 #define I40E_DEV_ID_20G_KR2		0x1587
 #define I40E_DEV_ID_20G_KR2_A		0x1588
 #define I40E_DEV_ID_10G_BASE_T4		0x1589
+#define I40E_DEV_ID_25G_B		0x158A
+#define I40E_DEV_ID_25G_SFP28		0x158B
 #define I40E_DEV_ID_VF			0x154C
 #define I40E_DEV_ID_VF_HV		0x1571
 #define I40E_DEV_ID_SFP_X722		0x37D0
-- 
2.4.11

