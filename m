From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri,  4 Nov 2016 10:36:03 -0700
Subject: [Intel-wired-lan] [next PATCH S52 06/11] i40e: Add 25G PHY_TYPE
	capability defines
In-Reply-To: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
References: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478280968-8098-7-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch adds the phy capability 25G defines for use
in link speed reporting in the base drivers.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: I0c8c99f4d7d6b2fce2758e95242452a8f6f1092b
---
Testing Hints : Check that link reporting is as expected
with 25g hw.

 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 4 +++-
 drivers/net/ethernet/intel/i40e/i40e_type.h         | 6 +++++-
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 4 +++-
 drivers/net/ethernet/intel/i40evf/i40e_type.h       | 6 +++++-
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 313d262..3016f89 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1654,6 +1654,7 @@ enum i40e_aq_phy_type {
 #define I40E_LINK_SPEED_10GB_SHIFT	0x3
 #define I40E_LINK_SPEED_40GB_SHIFT	0x4
 #define I40E_LINK_SPEED_20GB_SHIFT	0x5
+#define I40E_LINK_SPEED_25GB_SHIFT	0x6
 
 enum i40e_aq_link_speed {
 	I40E_LINK_SPEED_UNKNOWN	= 0,
@@ -1661,7 +1662,8 @@ enum i40e_aq_link_speed {
 	I40E_LINK_SPEED_1GB	= BIT(I40E_LINK_SPEED_1000MB_SHIFT),
 	I40E_LINK_SPEED_10GB	= BIT(I40E_LINK_SPEED_10GB_SHIFT),
 	I40E_LINK_SPEED_40GB	= BIT(I40E_LINK_SPEED_40GB_SHIFT),
-	I40E_LINK_SPEED_20GB	= BIT(I40E_LINK_SPEED_20GB_SHIFT)
+	I40E_LINK_SPEED_20GB	= (1 << I40E_LINK_SPEED_20GB_SHIFT),
+	I40E_LINK_SPEED_25GB	= (1 << I40E_LINK_SPEED_25GB_SHIFT),
 };
 
 struct i40e_aqc_module_desc {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index e02cb73..49a4928 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -242,7 +242,11 @@ enum i40e_aq_capabilities_phy_type {
 	I40E_CAP_PHY_TYPE_1000BASE_LX	  = BIT(I40E_PHY_TYPE_1000BASE_LX),
 	I40E_CAP_PHY_TYPE_1000BASE_T_OPTICAL =
 					 BIT(I40E_PHY_TYPE_1000BASE_T_OPTICAL),
-	I40E_CAP_PHY_TYPE_20GBASE_KR2	  = BIT(I40E_PHY_TYPE_20GBASE_KR2)
+	I40E_CAP_PHY_TYPE_20GBASE_KR2	  = BIT(I40E_PHY_TYPE_20GBASE_KR2),
+	I40E_CAP_PHY_TYPE_25GBASE_KR	  = BIT(I40E_PHY_TYPE_25GBASE_KR),
+	I40E_CAP_PHY_TYPE_25GBASE_CR	  = BIT(I40E_PHY_TYPE_25GBASE_CR),
+	I40E_CAP_PHY_TYPE_25GBASE_SR	  = BIT(I40E_PHY_TYPE_25GBASE_SR),
+	I40E_CAP_PHY_TYPE_25GBASE_LR	  = BIT(I40E_PHY_TYPE_25GBASE_LR),
 };
 
 struct i40e_phy_info {
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index 5cce63a..afe3706 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -1651,6 +1651,7 @@ enum i40e_aq_phy_type {
 #define I40E_LINK_SPEED_10GB_SHIFT	0x3
 #define I40E_LINK_SPEED_40GB_SHIFT	0x4
 #define I40E_LINK_SPEED_20GB_SHIFT	0x5
+#define I40E_LINK_SPEED_25GB_SHIFT	0x6
 
 enum i40e_aq_link_speed {
 	I40E_LINK_SPEED_UNKNOWN	= 0,
@@ -1658,7 +1659,8 @@ enum i40e_aq_link_speed {
 	I40E_LINK_SPEED_1GB	= BIT(I40E_LINK_SPEED_1000MB_SHIFT),
 	I40E_LINK_SPEED_10GB	= BIT(I40E_LINK_SPEED_10GB_SHIFT),
 	I40E_LINK_SPEED_40GB	= BIT(I40E_LINK_SPEED_40GB_SHIFT),
-	I40E_LINK_SPEED_20GB	= BIT(I40E_LINK_SPEED_20GB_SHIFT)
+	I40E_LINK_SPEED_20GB	= (1 << I40E_LINK_SPEED_20GB_SHIFT),
+	I40E_LINK_SPEED_25GB	= (1 << I40E_LINK_SPEED_25GB_SHIFT),
 };
 
 struct i40e_aqc_module_desc {
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index 515484c..f1dc74e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -216,7 +216,11 @@ enum i40e_aq_capabilities_phy_type {
 	I40E_CAP_PHY_TYPE_1000BASE_LX	  = BIT(I40E_PHY_TYPE_1000BASE_LX),
 	I40E_CAP_PHY_TYPE_1000BASE_T_OPTICAL =
 					 BIT(I40E_PHY_TYPE_1000BASE_T_OPTICAL),
-	I40E_CAP_PHY_TYPE_20GBASE_KR2	  = BIT(I40E_PHY_TYPE_20GBASE_KR2)
+	I40E_CAP_PHY_TYPE_20GBASE_KR2	  = BIT(I40E_PHY_TYPE_20GBASE_KR2),
+	I40E_CAP_PHY_TYPE_25GBASE_KR	  = BIT(I40E_PHY_TYPE_25GBASE_KR),
+	I40E_CAP_PHY_TYPE_25GBASE_CR	  = BIT(I40E_PHY_TYPE_25GBASE_CR),
+	I40E_CAP_PHY_TYPE_25GBASE_SR	  = BIT(I40E_PHY_TYPE_25GBASE_SR),
+	I40E_CAP_PHY_TYPE_25GBASE_LR	  = BIT(I40E_PHY_TYPE_25GBASE_LR),
 };
 
 struct i40e_phy_info {
-- 
2.4.11

