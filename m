From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri,  4 Nov 2016 10:36:06 -0700
Subject: [Intel-wired-lan] [next PATCH S52 09/11] i40e: Add FEC for 25g
In-Reply-To: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
References: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478280968-8098-10-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch adds adminq support for Forward Error
Correction ("FEC")for 25g products.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: Iaff4910737c239d2c730e5c22a313ce9c37d3964
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 10 ++++++++++
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index a9f5d7e..a7e30a9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1686,6 +1686,8 @@ struct i40e_aq_get_phy_abilities_resp {
 #define I40E_AQ_PHY_LINK_ENABLED	0x08
 #define I40E_AQ_PHY_AN_ENABLED		0x10
 #define I40E_AQ_PHY_FLAG_MODULE_QUAL	0x20
+#define I40E_AQ_PHY_FEC_ABILITY_KR	0x40
+#define I40E_AQ_PHY_FEC_ABILITY_RS	0x80
 	__le16	eee_capability;
 #define I40E_AQ_EEE_100BASE_TX		0x0002
 #define I40E_AQ_EEE_1000BASE_T		0x0004
@@ -1729,6 +1731,12 @@ struct i40e_aq_set_phy_config { /* same bits as above in all */
 #define I40E_AQ_PHY_TYPE_EXT_25G_CR	0X02
 #define I40E_AQ_PHY_TYPE_EXT_25G_SR	0x04
 #define I40E_AQ_PHY_TYPE_EXT_25G_LR	0x08
+	u8	fec_config;
+#define I40E_AQ_SET_FEC_ABILITY_KR	BIT(0)
+#define I40E_AQ_SET_FEC_ABILITY_RS	BIT(1)
+#define I40E_AQ_SET_FEC_REQUEST_KR	BIT(2)
+#define I40E_AQ_SET_FEC_REQUEST_RS	BIT(3)
+#define I40E_AQ_SET_FEC_AUTO		BIT(4)
 	u8	reserved;
 };
 
@@ -1819,6 +1827,8 @@ struct i40e_aqc_get_link_status {
 	u8	loopback; /* use defines from i40e_aqc_set_lb_mode */
 	__le16	max_frame_size;
 	u8	config;
+#define I40E_AQ_CONFIG_FEC_KR_ENA	0x01
+#define I40E_AQ_CONFIG_FEC_RS_ENA	0x02
 #define I40E_AQ_CONFIG_CRC_ENA		0x04
 #define I40E_AQ_CONFIG_PACING_MASK	0x78
 	u8	external_power_ability;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index 7242325..e7eae19 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -1683,6 +1683,8 @@ struct i40e_aq_get_phy_abilities_resp {
 #define I40E_AQ_PHY_LINK_ENABLED	0x08
 #define I40E_AQ_PHY_AN_ENABLED		0x10
 #define I40E_AQ_PHY_FLAG_MODULE_QUAL	0x20
+#define I40E_AQ_PHY_FEC_ABILITY_KR	0x40
+#define I40E_AQ_PHY_FEC_ABILITY_RS	0x80
 	__le16	eee_capability;
 #define I40E_AQ_EEE_100BASE_TX		0x0002
 #define I40E_AQ_EEE_1000BASE_T		0x0004
@@ -1726,6 +1728,12 @@ struct i40e_aq_set_phy_config { /* same bits as above in all */
 #define I40E_AQ_PHY_TYPE_EXT_25G_CR	0X02
 #define I40E_AQ_PHY_TYPE_EXT_25G_SR	0x04
 #define I40E_AQ_PHY_TYPE_EXT_25G_LR	0x08
+	u8	fec_config;
+#define I40E_AQ_SET_FEC_ABILITY_KR	BIT(0)
+#define I40E_AQ_SET_FEC_ABILITY_RS	BIT(1)
+#define I40E_AQ_SET_FEC_REQUEST_KR	BIT(2)
+#define I40E_AQ_SET_FEC_REQUEST_RS	BIT(3)
+#define I40E_AQ_SET_FEC_AUTO		BIT(4)
 	u8	reserved;
 };
 
@@ -1816,6 +1824,8 @@ struct i40e_aqc_get_link_status {
 	u8	loopback; /* use defines from i40e_aqc_set_lb_mode */
 	__le16	max_frame_size;
 	u8	config;
+#define I40E_AQ_CONFIG_FEC_KR_ENA	0x01
+#define I40E_AQ_CONFIG_FEC_RS_ENA	0x02
 #define I40E_AQ_CONFIG_CRC_ENA		0x04
 #define I40E_AQ_CONFIG_PACING_MASK	0x78
 	u8	external_power_ability;
-- 
2.4.11

