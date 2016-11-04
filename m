From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri,  4 Nov 2016 10:36:05 -0700
Subject: [Intel-wired-lan] [next PATCH S52 08/11] i40e: Fix for new bits set
	and sizing for 25G support
In-Reply-To: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
References: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478280968-8098-9-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch adds FW API changes needed for 25G support
and changes data type and bit settings defines for new
25G support.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: I842dfdb3bb656bd2c79785d06104f955ea3b6f0a
---
Testing Hints :Check that code compiles and
25g devices are recognized, initialized and show correct
speed.

 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 22 ++++++-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        | 75 +++++++++++-----------
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 22 ++++++-
 drivers/net/ethernet/intel/i40evf/i40e_type.h      | 75 +++++++++++-----------
 5 files changed, 115 insertions(+), 83 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 3016f89..a9f5d7e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1696,7 +1696,13 @@ struct i40e_aq_get_phy_abilities_resp {
 	__le32	eeer_val;
 	u8	d3_lpan;
 #define I40E_AQ_SET_PHY_D3_LPAN_ENA	0x01
-	u8	reserved[3];
+	u8	phy_type_ext;
+#define I40E_AQ_PHY_TYPE_EXT_25G_KR	0X01
+#define I40E_AQ_PHY_TYPE_EXT_25G_CR	0X02
+#define I40E_AQ_PHY_TYPE_EXT_25G_SR	0x04
+#define I40E_AQ_PHY_TYPE_EXT_25G_LR	0x08
+	u8	mod_type_ext;
+	u8	ext_comp_code;
 	u8	phy_id[4];
 	u8	module_type[3];
 	u8	qualified_module_count;
@@ -1718,7 +1724,12 @@ struct i40e_aq_set_phy_config { /* same bits as above in all */
 	__le16	eee_capability;
 	__le32	eeer;
 	u8	low_power_ctrl;
-	u8	reserved[3];
+	u8	phy_type_ext;
+#define I40E_AQ_PHY_TYPE_EXT_25G_KR	0X01
+#define I40E_AQ_PHY_TYPE_EXT_25G_CR	0X02
+#define I40E_AQ_PHY_TYPE_EXT_25G_SR	0x04
+#define I40E_AQ_PHY_TYPE_EXT_25G_LR	0x08
+	u8	reserved;
 };
 
 I40E_CHECK_CMD_LENGTH(i40e_aq_set_phy_config);
@@ -1798,6 +1809,13 @@ struct i40e_aqc_get_link_status {
 #define I40E_AQ_LINK_TX_DRAINED		0x01
 #define I40E_AQ_LINK_TX_FLUSHED		0x03
 #define I40E_AQ_LINK_FORCED_40G		0x10
+/* 25G Error Codes */
+#define I40E_AQ_25G_NO_ERR		0X00
+#define I40E_AQ_25G_NOT_PRESENT		0X01
+#define I40E_AQ_25G_NVM_CRC_ERR		0X02
+#define I40E_AQ_25G_SBUS_UCODE_ERR	0X03
+#define I40E_AQ_25G_SERDES_UCODE_ERR	0X04
+#define I40E_AQ_25G_NIMB_UCODE_ERR	0X05
 	u8	loopback; /* use defines from i40e_aqc_set_lb_mode */
 	__le16	max_frame_size;
 	u8	config;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 33051ed..5ef7387 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1610,8 +1610,10 @@ i40e_status i40e_aq_get_phy_capabilities(struct i40e_hw *hw,
 	if (hw->aq.asq_last_status == I40E_AQ_RC_EIO)
 		status = I40E_ERR_UNKNOWN_PHY;
 
-	if (report_init)
+	if (report_init) {
 		hw->phy.phy_types = le32_to_cpu(abilities->phy_type);
+		hw->phy.phy_types |= ((u64)abilities->phy_type_ext << 32);
+	}
 
 	return status;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 49a4928..71795b1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -213,51 +213,48 @@ struct i40e_link_status {
 #define I40E_MODULE_TYPE_1000BASE_T	0x08
 };
 
-enum i40e_aq_capabilities_phy_type {
-	I40E_CAP_PHY_TYPE_SGMII		  = BIT(I40E_PHY_TYPE_SGMII),
-	I40E_CAP_PHY_TYPE_1000BASE_KX	  = BIT(I40E_PHY_TYPE_1000BASE_KX),
-	I40E_CAP_PHY_TYPE_10GBASE_KX4	  = BIT(I40E_PHY_TYPE_10GBASE_KX4),
-	I40E_CAP_PHY_TYPE_10GBASE_KR	  = BIT(I40E_PHY_TYPE_10GBASE_KR),
-	I40E_CAP_PHY_TYPE_40GBASE_KR4	  = BIT(I40E_PHY_TYPE_40GBASE_KR4),
-	I40E_CAP_PHY_TYPE_XAUI		  = BIT(I40E_PHY_TYPE_XAUI),
-	I40E_CAP_PHY_TYPE_XFI		  = BIT(I40E_PHY_TYPE_XFI),
-	I40E_CAP_PHY_TYPE_SFI		  = BIT(I40E_PHY_TYPE_SFI),
-	I40E_CAP_PHY_TYPE_XLAUI		  = BIT(I40E_PHY_TYPE_XLAUI),
-	I40E_CAP_PHY_TYPE_XLPPI		  = BIT(I40E_PHY_TYPE_XLPPI),
-	I40E_CAP_PHY_TYPE_40GBASE_CR4_CU  = BIT(I40E_PHY_TYPE_40GBASE_CR4_CU),
-	I40E_CAP_PHY_TYPE_10GBASE_CR1_CU  = BIT(I40E_PHY_TYPE_10GBASE_CR1_CU),
-	I40E_CAP_PHY_TYPE_10GBASE_AOC	  = BIT(I40E_PHY_TYPE_10GBASE_AOC),
-	I40E_CAP_PHY_TYPE_40GBASE_AOC	  = BIT(I40E_PHY_TYPE_40GBASE_AOC),
-	I40E_CAP_PHY_TYPE_100BASE_TX	  = BIT(I40E_PHY_TYPE_100BASE_TX),
-	I40E_CAP_PHY_TYPE_1000BASE_T	  = BIT(I40E_PHY_TYPE_1000BASE_T),
-	I40E_CAP_PHY_TYPE_10GBASE_T	  = BIT(I40E_PHY_TYPE_10GBASE_T),
-	I40E_CAP_PHY_TYPE_10GBASE_SR	  = BIT(I40E_PHY_TYPE_10GBASE_SR),
-	I40E_CAP_PHY_TYPE_10GBASE_LR	  = BIT(I40E_PHY_TYPE_10GBASE_LR),
-	I40E_CAP_PHY_TYPE_10GBASE_SFPP_CU = BIT(I40E_PHY_TYPE_10GBASE_SFPP_CU),
-	I40E_CAP_PHY_TYPE_10GBASE_CR1	  = BIT(I40E_PHY_TYPE_10GBASE_CR1),
-	I40E_CAP_PHY_TYPE_40GBASE_CR4	  = BIT(I40E_PHY_TYPE_40GBASE_CR4),
-	I40E_CAP_PHY_TYPE_40GBASE_SR4	  = BIT(I40E_PHY_TYPE_40GBASE_SR4),
-	I40E_CAP_PHY_TYPE_40GBASE_LR4	  = BIT(I40E_PHY_TYPE_40GBASE_LR4),
-	I40E_CAP_PHY_TYPE_1000BASE_SX	  = BIT(I40E_PHY_TYPE_1000BASE_SX),
-	I40E_CAP_PHY_TYPE_1000BASE_LX	  = BIT(I40E_PHY_TYPE_1000BASE_LX),
-	I40E_CAP_PHY_TYPE_1000BASE_T_OPTICAL =
-					 BIT(I40E_PHY_TYPE_1000BASE_T_OPTICAL),
-	I40E_CAP_PHY_TYPE_20GBASE_KR2	  = BIT(I40E_PHY_TYPE_20GBASE_KR2),
-	I40E_CAP_PHY_TYPE_25GBASE_KR	  = BIT(I40E_PHY_TYPE_25GBASE_KR),
-	I40E_CAP_PHY_TYPE_25GBASE_CR	  = BIT(I40E_PHY_TYPE_25GBASE_CR),
-	I40E_CAP_PHY_TYPE_25GBASE_SR	  = BIT(I40E_PHY_TYPE_25GBASE_SR),
-	I40E_CAP_PHY_TYPE_25GBASE_LR	  = BIT(I40E_PHY_TYPE_25GBASE_LR),
-};
-
 struct i40e_phy_info {
 	struct i40e_link_status link_info;
 	struct i40e_link_status link_info_old;
 	bool get_link_info;
 	enum i40e_media_type media_type;
 	/* all the phy types the NVM is capable of */
-	enum i40e_aq_capabilities_phy_type phy_types;
-};
-
+	u64 phy_types;
+};
+
+#define I40E_CAP_PHY_TYPE_SGMII BIT_ULL(I40E_PHY_TYPE_SGMII)
+#define I40E_CAP_PHY_TYPE_1000BASE_KX BIT_ULL(I40E_PHY_TYPE_1000BASE_KX)
+#define I40E_CAP_PHY_TYPE_10GBASE_KX4 BIT_ULL(I40E_PHY_TYPE_10GBASE_KX4)
+#define I40E_CAP_PHY_TYPE_10GBASE_KR BIT_ULL(I40E_PHY_TYPE_10GBASE_KR)
+#define I40E_CAP_PHY_TYPE_40GBASE_KR4 BIT_ULL(I40E_PHY_TYPE_40GBASE_KR4)
+#define I40E_CAP_PHY_TYPE_XAUI BIT_ULL(I40E_PHY_TYPE_XAUI)
+#define I40E_CAP_PHY_TYPE_XFI BIT_ULL(I40E_PHY_TYPE_XFI)
+#define I40E_CAP_PHY_TYPE_SFI BIT_ULL(I40E_PHY_TYPE_SFI)
+#define I40E_CAP_PHY_TYPE_XLAUI BIT_ULL(I40E_PHY_TYPE_XLAUI)
+#define I40E_CAP_PHY_TYPE_XLPPI BIT_ULL(I40E_PHY_TYPE_XLPPI)
+#define I40E_CAP_PHY_TYPE_40GBASE_CR4_CU BIT_ULL(I40E_PHY_TYPE_40GBASE_CR4_CU)
+#define I40E_CAP_PHY_TYPE_10GBASE_CR1_CU BIT_ULL(I40E_PHY_TYPE_10GBASE_CR1_CU)
+#define I40E_CAP_PHY_TYPE_10GBASE_AOC BIT_ULL(I40E_PHY_TYPE_10GBASE_AOC)
+#define I40E_CAP_PHY_TYPE_40GBASE_AOC BIT_ULL(I40E_PHY_TYPE_40GBASE_AOC)
+#define I40E_CAP_PHY_TYPE_100BASE_TX BIT_ULL(I40E_PHY_TYPE_100BASE_TX)
+#define I40E_CAP_PHY_TYPE_1000BASE_T BIT_ULL(I40E_PHY_TYPE_1000BASE_T)
+#define I40E_CAP_PHY_TYPE_10GBASE_T BIT_ULL(I40E_PHY_TYPE_10GBASE_T)
+#define I40E_CAP_PHY_TYPE_10GBASE_SR BIT_ULL(I40E_PHY_TYPE_10GBASE_SR)
+#define I40E_CAP_PHY_TYPE_10GBASE_LR BIT_ULL(I40E_PHY_TYPE_10GBASE_LR)
+#define I40E_CAP_PHY_TYPE_10GBASE_SFPP_CU BIT_ULL(I40E_PHY_TYPE_10GBASE_SFPP_CU)
+#define I40E_CAP_PHY_TYPE_10GBASE_CR1 BIT_ULL(I40E_PHY_TYPE_10GBASE_CR1)
+#define I40E_CAP_PHY_TYPE_40GBASE_CR4 BIT_ULL(I40E_PHY_TYPE_40GBASE_CR4)
+#define I40E_CAP_PHY_TYPE_40GBASE_SR4 BIT_ULL(I40E_PHY_TYPE_40GBASE_SR4)
+#define I40E_CAP_PHY_TYPE_40GBASE_LR4 BIT_ULL(I40E_PHY_TYPE_40GBASE_LR4)
+#define I40E_CAP_PHY_TYPE_1000BASE_SX BIT_ULL(I40E_PHY_TYPE_1000BASE_SX)
+#define I40E_CAP_PHY_TYPE_1000BASE_LX BIT_ULL(I40E_PHY_TYPE_1000BASE_LX)
+#define I40E_CAP_PHY_TYPE_1000BASE_T_OPTICAL \
+				BIT_ULL(I40E_PHY_TYPE_1000BASE_T_OPTICAL)
+#define I40E_CAP_PHY_TYPE_20GBASE_KR2 BIT_ULL(I40E_PHY_TYPE_20GBASE_KR2)
+#define I40E_CAP_PHY_TYPE_25GBASE_KR BIT_ULL(I40E_AQ_PHY_TYPE_EXT_25G_KR + 32)
+#define I40E_CAP_PHY_TYPE_25GBASE_CR BIT_ULL(I40E_AQ_PHY_TYPE_EXT_25G_CR + 32)
+#define I40E_CAP_PHY_TYPE_25GBASE_SR BIT_ULL(I40E_AQ_PHY_TYPE_EXT_25G_SR + 32)
+#define I40E_CAP_PHY_TYPE_25GBASE_LR BIT_ULL(I40E_AQ_PHY_TYPE_EXT_25G_LR + 32)
 #define I40E_HW_CAP_MAX_GPIO			30
 /* Capabilities of a PF or a VF or the whole device */
 struct i40e_hw_capabilities {
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index afe3706..7242325 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -1693,7 +1693,13 @@ struct i40e_aq_get_phy_abilities_resp {
 	__le32	eeer_val;
 	u8	d3_lpan;
 #define I40E_AQ_SET_PHY_D3_LPAN_ENA	0x01
-	u8	reserved[3];
+	u8	phy_type_ext;
+#define I40E_AQ_PHY_TYPE_EXT_25G_KR	0X01
+#define I40E_AQ_PHY_TYPE_EXT_25G_CR	0X02
+#define I40E_AQ_PHY_TYPE_EXT_25G_SR	0x04
+#define I40E_AQ_PHY_TYPE_EXT_25G_LR	0x08
+	u8	mod_type_ext;
+	u8	ext_comp_code;
 	u8	phy_id[4];
 	u8	module_type[3];
 	u8	qualified_module_count;
@@ -1715,7 +1721,12 @@ struct i40e_aq_set_phy_config { /* same bits as above in all */
 	__le16	eee_capability;
 	__le32	eeer;
 	u8	low_power_ctrl;
-	u8	reserved[3];
+	u8	phy_type_ext;
+#define I40E_AQ_PHY_TYPE_EXT_25G_KR	0X01
+#define I40E_AQ_PHY_TYPE_EXT_25G_CR	0X02
+#define I40E_AQ_PHY_TYPE_EXT_25G_SR	0x04
+#define I40E_AQ_PHY_TYPE_EXT_25G_LR	0x08
+	u8	reserved;
 };
 
 I40E_CHECK_CMD_LENGTH(i40e_aq_set_phy_config);
@@ -1795,6 +1806,13 @@ struct i40e_aqc_get_link_status {
 #define I40E_AQ_LINK_TX_DRAINED		0x01
 #define I40E_AQ_LINK_TX_FLUSHED		0x03
 #define I40E_AQ_LINK_FORCED_40G		0x10
+/* 25G Error Codes */
+#define I40E_AQ_25G_NO_ERR		0X00
+#define I40E_AQ_25G_NOT_PRESENT		0X01
+#define I40E_AQ_25G_NVM_CRC_ERR		0X02
+#define I40E_AQ_25G_SBUS_UCODE_ERR	0X03
+#define I40E_AQ_25G_SERDES_UCODE_ERR	0X04
+#define I40E_AQ_25G_NIMB_UCODE_ERR	0X05
 	u8	loopback; /* use defines from i40e_aqc_set_lb_mode */
 	__le16	max_frame_size;
 	u8	config;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index f1dc74e..493c803 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -187,51 +187,48 @@ struct i40e_link_status {
 #define I40E_MODULE_TYPE_1000BASE_T	0x08
 };
 
-enum i40e_aq_capabilities_phy_type {
-	I40E_CAP_PHY_TYPE_SGMII		  = BIT(I40E_PHY_TYPE_SGMII),
-	I40E_CAP_PHY_TYPE_1000BASE_KX	  = BIT(I40E_PHY_TYPE_1000BASE_KX),
-	I40E_CAP_PHY_TYPE_10GBASE_KX4	  = BIT(I40E_PHY_TYPE_10GBASE_KX4),
-	I40E_CAP_PHY_TYPE_10GBASE_KR	  = BIT(I40E_PHY_TYPE_10GBASE_KR),
-	I40E_CAP_PHY_TYPE_40GBASE_KR4	  = BIT(I40E_PHY_TYPE_40GBASE_KR4),
-	I40E_CAP_PHY_TYPE_XAUI		  = BIT(I40E_PHY_TYPE_XAUI),
-	I40E_CAP_PHY_TYPE_XFI		  = BIT(I40E_PHY_TYPE_XFI),
-	I40E_CAP_PHY_TYPE_SFI		  = BIT(I40E_PHY_TYPE_SFI),
-	I40E_CAP_PHY_TYPE_XLAUI		  = BIT(I40E_PHY_TYPE_XLAUI),
-	I40E_CAP_PHY_TYPE_XLPPI		  = BIT(I40E_PHY_TYPE_XLPPI),
-	I40E_CAP_PHY_TYPE_40GBASE_CR4_CU  = BIT(I40E_PHY_TYPE_40GBASE_CR4_CU),
-	I40E_CAP_PHY_TYPE_10GBASE_CR1_CU  = BIT(I40E_PHY_TYPE_10GBASE_CR1_CU),
-	I40E_CAP_PHY_TYPE_10GBASE_AOC	  = BIT(I40E_PHY_TYPE_10GBASE_AOC),
-	I40E_CAP_PHY_TYPE_40GBASE_AOC	  = BIT(I40E_PHY_TYPE_40GBASE_AOC),
-	I40E_CAP_PHY_TYPE_100BASE_TX	  = BIT(I40E_PHY_TYPE_100BASE_TX),
-	I40E_CAP_PHY_TYPE_1000BASE_T	  = BIT(I40E_PHY_TYPE_1000BASE_T),
-	I40E_CAP_PHY_TYPE_10GBASE_T	  = BIT(I40E_PHY_TYPE_10GBASE_T),
-	I40E_CAP_PHY_TYPE_10GBASE_SR	  = BIT(I40E_PHY_TYPE_10GBASE_SR),
-	I40E_CAP_PHY_TYPE_10GBASE_LR	  = BIT(I40E_PHY_TYPE_10GBASE_LR),
-	I40E_CAP_PHY_TYPE_10GBASE_SFPP_CU = BIT(I40E_PHY_TYPE_10GBASE_SFPP_CU),
-	I40E_CAP_PHY_TYPE_10GBASE_CR1	  = BIT(I40E_PHY_TYPE_10GBASE_CR1),
-	I40E_CAP_PHY_TYPE_40GBASE_CR4	  = BIT(I40E_PHY_TYPE_40GBASE_CR4),
-	I40E_CAP_PHY_TYPE_40GBASE_SR4	  = BIT(I40E_PHY_TYPE_40GBASE_SR4),
-	I40E_CAP_PHY_TYPE_40GBASE_LR4	  = BIT(I40E_PHY_TYPE_40GBASE_LR4),
-	I40E_CAP_PHY_TYPE_1000BASE_SX	  = BIT(I40E_PHY_TYPE_1000BASE_SX),
-	I40E_CAP_PHY_TYPE_1000BASE_LX	  = BIT(I40E_PHY_TYPE_1000BASE_LX),
-	I40E_CAP_PHY_TYPE_1000BASE_T_OPTICAL =
-					 BIT(I40E_PHY_TYPE_1000BASE_T_OPTICAL),
-	I40E_CAP_PHY_TYPE_20GBASE_KR2	  = BIT(I40E_PHY_TYPE_20GBASE_KR2),
-	I40E_CAP_PHY_TYPE_25GBASE_KR	  = BIT(I40E_PHY_TYPE_25GBASE_KR),
-	I40E_CAP_PHY_TYPE_25GBASE_CR	  = BIT(I40E_PHY_TYPE_25GBASE_CR),
-	I40E_CAP_PHY_TYPE_25GBASE_SR	  = BIT(I40E_PHY_TYPE_25GBASE_SR),
-	I40E_CAP_PHY_TYPE_25GBASE_LR	  = BIT(I40E_PHY_TYPE_25GBASE_LR),
-};
-
 struct i40e_phy_info {
 	struct i40e_link_status link_info;
 	struct i40e_link_status link_info_old;
 	bool get_link_info;
 	enum i40e_media_type media_type;
 	/* all the phy types the NVM is capable of */
-	enum i40e_aq_capabilities_phy_type phy_types;
-};
-
+	u64 phy_types;
+};
+
+#define I40E_CAP_PHY_TYPE_SGMII BIT_ULL(I40E_PHY_TYPE_SGMII)
+#define I40E_CAP_PHY_TYPE_1000BASE_KX BIT_ULL(I40E_PHY_TYPE_1000BASE_KX)
+#define I40E_CAP_PHY_TYPE_10GBASE_KX4 BIT_ULL(I40E_PHY_TYPE_10GBASE_KX4)
+#define I40E_CAP_PHY_TYPE_10GBASE_KR BIT_ULL(I40E_PHY_TYPE_10GBASE_KR)
+#define I40E_CAP_PHY_TYPE_40GBASE_KR4 BIT_ULL(I40E_PHY_TYPE_40GBASE_KR4)
+#define I40E_CAP_PHY_TYPE_XAUI BIT_ULL(I40E_PHY_TYPE_XAUI)
+#define I40E_CAP_PHY_TYPE_XFI BIT_ULL(I40E_PHY_TYPE_XFI)
+#define I40E_CAP_PHY_TYPE_SFI BIT_ULL(I40E_PHY_TYPE_SFI)
+#define I40E_CAP_PHY_TYPE_XLAUI BIT_ULL(I40E_PHY_TYPE_XLAUI)
+#define I40E_CAP_PHY_TYPE_XLPPI BIT_ULL(I40E_PHY_TYPE_XLPPI)
+#define I40E_CAP_PHY_TYPE_40GBASE_CR4_CU BIT_ULL(I40E_PHY_TYPE_40GBASE_CR4_CU)
+#define I40E_CAP_PHY_TYPE_10GBASE_CR1_CU BIT_ULL(I40E_PHY_TYPE_10GBASE_CR1_CU)
+#define I40E_CAP_PHY_TYPE_10GBASE_AOC BIT_ULL(I40E_PHY_TYPE_10GBASE_AOC)
+#define I40E_CAP_PHY_TYPE_40GBASE_AOC BIT_ULL(I40E_PHY_TYPE_40GBASE_AOC)
+#define I40E_CAP_PHY_TYPE_100BASE_TX BIT_ULL(I40E_PHY_TYPE_100BASE_TX)
+#define I40E_CAP_PHY_TYPE_1000BASE_T BIT_ULL(I40E_PHY_TYPE_1000BASE_T)
+#define I40E_CAP_PHY_TYPE_10GBASE_T BIT_ULL(I40E_PHY_TYPE_10GBASE_T)
+#define I40E_CAP_PHY_TYPE_10GBASE_SR BIT_ULL(I40E_PHY_TYPE_10GBASE_SR)
+#define I40E_CAP_PHY_TYPE_10GBASE_LR BIT_ULL(I40E_PHY_TYPE_10GBASE_LR)
+#define I40E_CAP_PHY_TYPE_10GBASE_SFPP_CU BIT_ULL(I40E_PHY_TYPE_10GBASE_SFPP_CU)
+#define I40E_CAP_PHY_TYPE_10GBASE_CR1 BIT_ULL(I40E_PHY_TYPE_10GBASE_CR1)
+#define I40E_CAP_PHY_TYPE_40GBASE_CR4 BIT_ULL(I40E_PHY_TYPE_40GBASE_CR4)
+#define I40E_CAP_PHY_TYPE_40GBASE_SR4 BIT_ULL(I40E_PHY_TYPE_40GBASE_SR4)
+#define I40E_CAP_PHY_TYPE_40GBASE_LR4 BIT_ULL(I40E_PHY_TYPE_40GBASE_LR4)
+#define I40E_CAP_PHY_TYPE_1000BASE_SX BIT_ULL(I40E_PHY_TYPE_1000BASE_SX)
+#define I40E_CAP_PHY_TYPE_1000BASE_LX BIT_ULL(I40E_PHY_TYPE_1000BASE_LX)
+#define I40E_CAP_PHY_TYPE_1000BASE_T_OPTICAL \
+				BIT_ULL(I40E_PHY_TYPE_1000BASE_T_OPTICAL)
+#define I40E_CAP_PHY_TYPE_20GBASE_KR2 BIT_ULL(I40E_PHY_TYPE_20GBASE_KR2)
+#define I40E_CAP_PHY_TYPE_25GBASE_KR BIT_ULL(I40E_AQ_PHY_TYPE_EXT_25G_KR + 32)
+#define I40E_CAP_PHY_TYPE_25GBASE_CR BIT_ULL(I40E_AQ_PHY_TYPE_EXT_25G_CR + 32)
+#define I40E_CAP_PHY_TYPE_25GBASE_SR BIT_ULL(I40E_AQ_PHY_TYPE_EXT_25G_SR + 32)
+#define I40E_CAP_PHY_TYPE_25GBASE_LR BIT_ULL(I40E_AQ_PHY_TYPE_EXT_25G_LR + 32)
 #define I40E_HW_CAP_MAX_GPIO			30
 /* Capabilities of a PF or a VF or the whole device */
 struct i40e_hw_capabilities {
-- 
2.4.11

