From: Alice Michael <alice.michael@intel.com>
Date: Fri, 11 Aug 2017 11:23:54 -0400
Subject: [Intel-wired-lan] [next PATCH S78-V7 01/12] i40e: Fix reporting of
	supported link modes
In-Reply-To: <20170811152354.87886-1-alice.michael@intel.com>
References: <20170811152354.87886-1-alice.michael@intel.com>
Message-ID: <20170811152354.87886-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Filip Sadowski <filip.sadowski@intel.com>

This patch fixes incorrect reporting of supported link modes on some NICs.

Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 20 ++++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_common.c       | 11 ++++++++++-
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 20 ++++++++++++++++++--
 3 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index de1cd25..0477faa 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1734,6 +1734,8 @@ enum i40e_aq_phy_type {
 	I40E_PHY_TYPE_10GBASE_CR1_CU		= 0xB,
 	I40E_PHY_TYPE_10GBASE_AOC		= 0xC,
 	I40E_PHY_TYPE_40GBASE_AOC		= 0xD,
+	I40E_PHY_TYPE_UNRECOGNIZED		= 0xE,
+	I40E_PHY_TYPE_UNSUPPORTED		= 0xF,
 	I40E_PHY_TYPE_100BASE_TX		= 0x11,
 	I40E_PHY_TYPE_1000BASE_T		= 0x12,
 	I40E_PHY_TYPE_10GBASE_T			= 0x13,
@@ -1754,6 +1756,8 @@ enum i40e_aq_phy_type {
 	I40E_PHY_TYPE_25GBASE_LR		= 0x22,
 	I40E_PHY_TYPE_25GBASE_AOC		= 0x23,
 	I40E_PHY_TYPE_25GBASE_ACC		= 0x24,
+	I40E_PHY_TYPE_EMPTY			= 0xFE,
+	I40E_PHY_TYPE_DEFAULT			= 0xFF,
 
 	I40E_PHY_TYPE_MAX
 };
@@ -1947,19 +1951,31 @@ struct i40e_aqc_get_link_status {
 #define I40E_AQ_25G_SERDES_UCODE_ERR	0X04
 #define I40E_AQ_25G_NIMB_UCODE_ERR	0X05
 	u8	loopback; /* use defines from i40e_aqc_set_lb_mode */
+/* Since firmware API 1.7 loopback field keeps power class info as well */
+#define I40E_AQ_LOOPBACK_MASK		0x07
+#define I40E_AQ_PWR_CLASS_SHIFT_LB	6
+#define I40E_AQ_PWR_CLASS_MASK_LB	(0x03 << I40E_AQ_PWR_CLASS_SHIFT_LB)
 	__le16	max_frame_size;
 	u8	config;
 #define I40E_AQ_CONFIG_FEC_KR_ENA	0x01
 #define I40E_AQ_CONFIG_FEC_RS_ENA	0x02
 #define I40E_AQ_CONFIG_CRC_ENA		0x04
 #define I40E_AQ_CONFIG_PACING_MASK	0x78
-	u8	power_desc;
+	union {
+		struct {
+			u8	power_desc;
 #define I40E_AQ_LINK_POWER_CLASS_1	0x00
 #define I40E_AQ_LINK_POWER_CLASS_2	0x01
 #define I40E_AQ_LINK_POWER_CLASS_3	0x02
 #define I40E_AQ_LINK_POWER_CLASS_4	0x03
 #define I40E_AQ_PWR_CLASS_MASK		0x03
-	u8	reserved[4];
+			u8	reserved[4];
+		};
+		struct {
+			u8	link_type[4];
+			u8	link_type_ext;
+		};
+	};
 };
 
 I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 6104c44..8dbba6f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1828,7 +1828,7 @@ i40e_status i40e_aq_get_link_info(struct i40e_hw *hw,
 	hw_link_info->fec_info = resp->config & (I40E_AQ_CONFIG_FEC_KR_ENA |
 						 I40E_AQ_CONFIG_FEC_RS_ENA);
 	hw_link_info->ext_info = resp->ext_info;
-	hw_link_info->loopback = resp->loopback;
+	hw_link_info->loopback = resp->loopback & I40E_AQ_LOOPBACK_MASK;
 	hw_link_info->max_frame_size = le16_to_cpu(resp->max_frame_size);
 	hw_link_info->pacing = resp->config & I40E_AQ_CONFIG_PACING_MASK;
 
@@ -1859,6 +1859,15 @@ i40e_status i40e_aq_get_link_info(struct i40e_hw *hw,
 	     hw->aq.fw_min_ver < 40)) && hw_link_info->phy_type == 0xE)
 		hw_link_info->phy_type = I40E_PHY_TYPE_10GBASE_SFPP_CU;
 
+	if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
+	    hw->aq.api_min_ver >= 7) {
+		__le32 tmp;
+
+		memcpy(&tmp, resp->link_type, sizeof(tmp));
+		hw->phy.phy_types = le32_to_cpu(tmp);
+		hw->phy.phy_types |= ((u64)resp->link_type_ext << 32);
+	}
+
 	/* save link status information */
 	if (link)
 		*link = *hw_link_info;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index 7d382c1..e2581c6 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -1730,6 +1730,8 @@ enum i40e_aq_phy_type {
 	I40E_PHY_TYPE_10GBASE_CR1_CU		= 0xB,
 	I40E_PHY_TYPE_10GBASE_AOC		= 0xC,
 	I40E_PHY_TYPE_40GBASE_AOC		= 0xD,
+	I40E_PHY_TYPE_UNRECOGNIZED		= 0xE,
+	I40E_PHY_TYPE_UNSUPPORTED		= 0xF,
 	I40E_PHY_TYPE_100BASE_TX		= 0x11,
 	I40E_PHY_TYPE_1000BASE_T		= 0x12,
 	I40E_PHY_TYPE_10GBASE_T			= 0x13,
@@ -1750,6 +1752,8 @@ enum i40e_aq_phy_type {
 	I40E_PHY_TYPE_25GBASE_LR		= 0x22,
 	I40E_PHY_TYPE_25GBASE_AOC		= 0x23,
 	I40E_PHY_TYPE_25GBASE_ACC		= 0x24,
+	I40E_PHY_TYPE_EMPTY			= 0xFE,
+	I40E_PHY_TYPE_DEFAULT			= 0xFF,
 
 	I40E_PHY_TYPE_MAX
 };
@@ -1943,19 +1947,31 @@ struct i40e_aqc_get_link_status {
 #define I40E_AQ_25G_SERDES_UCODE_ERR	0X04
 #define I40E_AQ_25G_NIMB_UCODE_ERR	0X05
 	u8	loopback; /* use defines from i40e_aqc_set_lb_mode */
+/* Since firmware API 1.7 loopback field keeps power class info as well */
+#define I40E_AQ_LOOPBACK_MASK		0x07
+#define I40E_AQ_PWR_CLASS_SHIFT_LB	6
+#define I40E_AQ_PWR_CLASS_MASK_LB	(0x03 << I40E_AQ_PWR_CLASS_SHIFT_LB)
 	__le16	max_frame_size;
 	u8	config;
 #define I40E_AQ_CONFIG_FEC_KR_ENA	0x01
 #define I40E_AQ_CONFIG_FEC_RS_ENA	0x02
 #define I40E_AQ_CONFIG_CRC_ENA		0x04
 #define I40E_AQ_CONFIG_PACING_MASK	0x78
-	u8	power_desc;
+	union {
+		struct {
+			u8	power_desc;
 #define I40E_AQ_LINK_POWER_CLASS_1	0x00
 #define I40E_AQ_LINK_POWER_CLASS_2	0x01
 #define I40E_AQ_LINK_POWER_CLASS_3	0x02
 #define I40E_AQ_LINK_POWER_CLASS_4	0x03
 #define I40E_AQ_PWR_CLASS_MASK		0x03
-	u8	reserved[4];
+			u8	reserved[4];
+		};
+		struct {
+			u8	link_type[4];
+			u8	link_type_ext;
+		};
+	};
 };
 
 I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
-- 
2.9.4

