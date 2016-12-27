From: Pujari, Bimmy <bimmy.pujari@intel.com>
Date: Tue, 27 Dec 2016 18:37:21 +0000
Subject: [Intel-wired-lan] [next PATCH S58 1/5] i40e-shared: fix up
 recent	proxy and wol bits for X722_SUPPORT
In-Reply-To: <1482861359-2352-1-git-send-email-bimmy.pujari@intel.com>
References: <1482861359-2352-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <B759292EEECB5C46AEDF3EC46470BC94AF1992@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi

I requested Jeff to remove this series from Intel-wired-lan.
Please ignore this one. I will be uploading correct series soon.

Thanks
Bimmy

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Bimmy Pujari
Sent: Tuesday, December 27, 2016 9:56 AM
To: intel-wired-lan@lists.osuosl.org
Cc: Shannon Nelson <shannon.nelson@intel.com>
Subject: [Intel-wired-lan] [next PATCH S58 1/5] i40e-shared: fix up recent proxy and wol bits for X722_SUPPORT

From: Shannon Nelson <shannon.nelson@intel.com>

Some opcodes added & reordered to be in numerical order with the
rest of the opcodes.  Several structs that were added are unnecessary,
so they are removed here. This patch adds admin queue structs to
support Wake on LAN feature for X722.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
---
Testing Hints :
        Apply and compile cleanly

 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 71 +++++++++++++++++++++-
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 71 +++++++++++++++++++++-
 2 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 451f48b..95171c2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -132,6 +132,12 @@ enum i40e_admin_queue_opc {
 	i40e_aqc_opc_list_func_capabilities	= 0x000A,
 	i40e_aqc_opc_list_dev_capabilities	= 0x000B,
 
+#ifdef X722_SUPPORT
+	/* Proxy commands */
+	i40e_aqc_opc_set_proxy_config		= 0x0104,
+	i40e_aqc_opc_set_ns_proxy_table_entry	= 0x0105,
+
+#endif
 	/* LAA */
 	i40e_aqc_opc_mac_address_read	= 0x0107,
 	i40e_aqc_opc_mac_address_write	= 0x0108,
@@ -139,6 +145,12 @@ enum i40e_admin_queue_opc {
 	/* PXE */
 	i40e_aqc_opc_clear_pxe_mode	= 0x0110,
 
+#ifdef X722_SUPPORT
+	/* WoL commands */
+	i40e_aqc_opc_set_wol_filter	= 0x0120,
+	i40e_aqc_opc_get_wake_reason	= 0x0121,
+
+#endif
 	/* internal switch commands */
 	i40e_aqc_opc_get_switch_config		= 0x0200,
 	i40e_aqc_opc_add_statistics		= 0x0201,
@@ -177,6 +189,7 @@ enum i40e_admin_queue_opc {
 	i40e_aqc_opc_remove_control_packet_filter	= 0x025B,
 	i40e_aqc_opc_add_cloud_filters		= 0x025C,
 	i40e_aqc_opc_remove_cloud_filters	= 0x025D,
+	i40e_aqc_opc_clear_wol_switch_filters	= 0x025E,
 
 	i40e_aqc_opc_add_mirror_rule	= 0x0260,
 	i40e_aqc_opc_delete_mirror_rule	= 0x0261,
@@ -563,6 +576,58 @@ struct i40e_aqc_clear_pxe {
 
 I40E_CHECK_CMD_LENGTH(i40e_aqc_clear_pxe);
 
+#ifdef X722_SUPPORT
+/* Set WoL Filter (0x0120) */
+
+struct i40e_aqc_set_wol_filter {
+	__le16 filter_index;
+#define I40E_AQC_MAX_NUM_WOL_FILTERS	8
+#define I40E_AQC_SET_WOL_FILTER_TYPE_MAGIC_SHIFT	15
+#define I40E_AQC_SET_WOL_FILTER_TYPE_MAGIC_MASK	(0x1 << \
+		I40E_AQC_SET_WOL_FILTER_TYPE_MAGIC_SHIFT)
+
+#define I40E_AQC_SET_WOL_FILTER_INDEX_SHIFT		0
+#define I40E_AQC_SET_WOL_FILTER_INDEX_MASK	(0x7 << \
+		I40E_AQC_SET_WOL_FILTER_INDEX_SHIFT)
+	__le16 cmd_flags;
+#define I40E_AQC_SET_WOL_FILTER				0x8000
+#define I40E_AQC_SET_WOL_FILTER_NO_TCO_WOL		0x4000
+#define I40E_AQC_SET_WOL_FILTER_ACTION_CLEAR		0
+#define I40E_AQC_SET_WOL_FILTER_ACTION_SET		1
+	__le16 valid_flags;
+#define I40E_AQC_SET_WOL_FILTER_ACTION_VALID		0x8000
+#define I40E_AQC_SET_WOL_FILTER_NO_TCO_ACTION_VALID	0x4000
+	u8 reserved[2];
+	__le32	address_high;
+	__le32	address_low;
+};
+
+I40E_CHECK_CMD_LENGTH(i40e_aqc_set_wol_filter);
+
+struct i40e_aqc_set_wol_filter_data {
+	u8 filter[128];
+	u8 mask[16];
+};
+
+I40E_CHECK_STRUCT_LEN(0x90, i40e_aqc_set_wol_filter_data);
+
+/* Get Wake Reason (0x0121) */
+
+struct i40e_aqc_get_wake_reason_completion {
+	u8 reserved_1[2];
+	__le16 wake_reason;
+#define I40E_AQC_GET_WAKE_UP_REASON_WOL_REASON_MATCHED_INDEX_SHIFT	0
+#define I40E_AQC_GET_WAKE_UP_REASON_WOL_REASON_MATCHED_INDEX_MASK (0xFF << \
+		I40E_AQC_GET_WAKE_UP_REASON_WOL_REASON_MATCHED_INDEX_SHIFT)
+#define I40E_AQC_GET_WAKE_UP_REASON_WOL_REASON_RESERVED_SHIFT	8
+#define I40E_AQC_GET_WAKE_UP_REASON_WOL_REASON_RESERVED_MASK	(0xFF << \
+		I40E_AQC_GET_WAKE_UP_REASON_WOL_REASON_RESERVED_SHIFT)
+	u8 reserved_2[12];
+};
+
+I40E_CHECK_CMD_LENGTH(i40e_aqc_get_wake_reason_completion);
+
+#endif /* X722_SUPPORT */
 /* Switch configuration commands (0x02xx) */
 
 /* Used by many indirect commands that only pass an seid and a buffer in the
@@ -645,6 +710,8 @@ struct i40e_aqc_set_port_parameters {
 #define I40E_AQ_SET_P_PARAMS_PAD_SHORT_PACKETS	2 /* must set! */
 #define I40E_AQ_SET_P_PARAMS_DOUBLE_VLAN_ENA	4
 	__le16	bad_frame_vsi;
+#define I40E_AQ_SET_P_PARAMS_BFRAME_SEID_SHIFT	0x0
+#define I40E_AQ_SET_P_PARAMS_BFRAME_SEID_MASK	0x3FF
 	__le16	default_seid;        /* reserved for command */
 	u8	reserved[10];
 };
@@ -696,6 +763,7 @@ I40E_CHECK_STRUCT_LEN(0x10, i40e_aqc_switch_resource_alloc_element_resp);
 /* Set Switch Configuration (direct 0x0205) */
 struct i40e_aqc_set_switch_config {
 	__le16	flags;
+/* flags used for both fields below */
 #define I40E_AQ_SET_SWITCH_CFG_PROMISC		0x0001
 #define I40E_AQ_SET_SWITCH_CFG_L2_FILTER	0x0002
 	__le16	valid_flags;
@@ -1844,11 +1912,12 @@ struct i40e_aqc_get_link_status {
 #define I40E_AQ_CONFIG_FEC_RS_ENA	0x02
 #define I40E_AQ_CONFIG_CRC_ENA		0x04
 #define I40E_AQ_CONFIG_PACING_MASK	0x78
-	u8	external_power_ability;
+	u8	power_desc;
 #define I40E_AQ_LINK_POWER_CLASS_1	0x00
 #define I40E_AQ_LINK_POWER_CLASS_2	0x01
 #define I40E_AQ_LINK_POWER_CLASS_3	0x02
 #define I40E_AQ_LINK_POWER_CLASS_4	0x03
+#define I40E_AQ_PWR_CLASS_MASK		0x03
 	u8	reserved[4];
 };
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index eeb9864..b763e3c 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -132,6 +132,12 @@ enum i40e_admin_queue_opc {
 	i40e_aqc_opc_list_func_capabilities	= 0x000A,
 	i40e_aqc_opc_list_dev_capabilities	= 0x000B,
 
+#ifdef X722_SUPPORT
+	/* Proxy commands */
+	i40e_aqc_opc_set_proxy_config		= 0x0104,
+	i40e_aqc_opc_set_ns_proxy_table_entry	= 0x0105,
+
+#endif
 	/* LAA */
 	i40e_aqc_opc_mac_address_read	= 0x0107,
 	i40e_aqc_opc_mac_address_write	= 0x0108,
@@ -139,6 +145,12 @@ enum i40e_admin_queue_opc {
 	/* PXE */
 	i40e_aqc_opc_clear_pxe_mode	= 0x0110,
 
+#ifdef X722_SUPPORT
+	/* WoL commands */
+	i40e_aqc_opc_set_wol_filter	= 0x0120,
+	i40e_aqc_opc_get_wake_reason	= 0x0121,
+
+#endif
 	/* internal switch commands */
 	i40e_aqc_opc_get_switch_config		= 0x0200,
 	i40e_aqc_opc_add_statistics		= 0x0201,
@@ -177,6 +189,7 @@ enum i40e_admin_queue_opc {
 	i40e_aqc_opc_remove_control_packet_filter	= 0x025B,
 	i40e_aqc_opc_add_cloud_filters		= 0x025C,
 	i40e_aqc_opc_remove_cloud_filters	= 0x025D,
+	i40e_aqc_opc_clear_wol_switch_filters	= 0x025E,
 
 	i40e_aqc_opc_add_mirror_rule	= 0x0260,
 	i40e_aqc_opc_delete_mirror_rule	= 0x0261,
@@ -558,6 +571,58 @@ struct i40e_aqc_clear_pxe {
 
 I40E_CHECK_CMD_LENGTH(i40e_aqc_clear_pxe);
 
+#ifdef X722_SUPPORT
+/* Set WoL Filter (0x0120) */
+
+struct i40e_aqc_set_wol_filter {
+	__le16 filter_index;
+#define I40E_AQC_MAX_NUM_WOL_FILTERS	8
+#define I40E_AQC_SET_WOL_FILTER_TYPE_MAGIC_SHIFT	15
+#define I40E_AQC_SET_WOL_FILTER_TYPE_MAGIC_MASK	(0x1 << \
+		I40E_AQC_SET_WOL_FILTER_TYPE_MAGIC_SHIFT)
+
+#define I40E_AQC_SET_WOL_FILTER_INDEX_SHIFT		0
+#define I40E_AQC_SET_WOL_FILTER_INDEX_MASK	(0x7 << \
+		I40E_AQC_SET_WOL_FILTER_INDEX_SHIFT)
+	__le16 cmd_flags;
+#define I40E_AQC_SET_WOL_FILTER				0x8000
+#define I40E_AQC_SET_WOL_FILTER_NO_TCO_WOL		0x4000
+#define I40E_AQC_SET_WOL_FILTER_ACTION_CLEAR		0
+#define I40E_AQC_SET_WOL_FILTER_ACTION_SET		1
+	__le16 valid_flags;
+#define I40E_AQC_SET_WOL_FILTER_ACTION_VALID		0x8000
+#define I40E_AQC_SET_WOL_FILTER_NO_TCO_ACTION_VALID	0x4000
+	u8 reserved[2];
+	__le32	address_high;
+	__le32	address_low;
+};
+
+I40E_CHECK_CMD_LENGTH(i40e_aqc_set_wol_filter);
+
+struct i40e_aqc_set_wol_filter_data {
+	u8 filter[128];
+	u8 mask[16];
+};
+
+I40E_CHECK_STRUCT_LEN(0x90, i40e_aqc_set_wol_filter_data);
+
+/* Get Wake Reason (0x0121) */
+
+struct i40e_aqc_get_wake_reason_completion {
+	u8 reserved_1[2];
+	__le16 wake_reason;
+#define I40E_AQC_GET_WAKE_UP_REASON_WOL_REASON_MATCHED_INDEX_SHIFT	0
+#define I40E_AQC_GET_WAKE_UP_REASON_WOL_REASON_MATCHED_INDEX_MASK (0xFF << \
+		I40E_AQC_GET_WAKE_UP_REASON_WOL_REASON_MATCHED_INDEX_SHIFT)
+#define I40E_AQC_GET_WAKE_UP_REASON_WOL_REASON_RESERVED_SHIFT	8
+#define I40E_AQC_GET_WAKE_UP_REASON_WOL_REASON_RESERVED_MASK	(0xFF << \
+		I40E_AQC_GET_WAKE_UP_REASON_WOL_REASON_RESERVED_SHIFT)
+	u8 reserved_2[12];
+};
+
+I40E_CHECK_CMD_LENGTH(i40e_aqc_get_wake_reason_completion);
+
+#endif /* X722_SUPPORT */
 /* Switch configuration commands (0x02xx) */
 
 /* Used by many indirect commands that only pass an seid and a buffer in the
@@ -640,6 +705,8 @@ struct i40e_aqc_set_port_parameters {
 #define I40E_AQ_SET_P_PARAMS_PAD_SHORT_PACKETS	2 /* must set! */
 #define I40E_AQ_SET_P_PARAMS_DOUBLE_VLAN_ENA	4
 	__le16	bad_frame_vsi;
+#define I40E_AQ_SET_P_PARAMS_BFRAME_SEID_SHIFT	0x0
+#define I40E_AQ_SET_P_PARAMS_BFRAME_SEID_MASK	0x3FF
 	__le16	default_seid;        /* reserved for command */
 	u8	reserved[10];
 };
@@ -691,6 +758,7 @@ I40E_CHECK_STRUCT_LEN(0x10, i40e_aqc_switch_resource_alloc_element_resp);
 /* Set Switch Configuration (direct 0x0205) */
 struct i40e_aqc_set_switch_config {
 	__le16	flags;
+/* flags used for both fields below */
 #define I40E_AQ_SET_SWITCH_CFG_PROMISC		0x0001
 #define I40E_AQ_SET_SWITCH_CFG_L2_FILTER	0x0002
 	__le16	valid_flags;
@@ -1839,11 +1907,12 @@ struct i40e_aqc_get_link_status {
 #define I40E_AQ_CONFIG_FEC_RS_ENA	0x02
 #define I40E_AQ_CONFIG_CRC_ENA		0x04
 #define I40E_AQ_CONFIG_PACING_MASK	0x78
-	u8	external_power_ability;
+	u8	power_desc;
 #define I40E_AQ_LINK_POWER_CLASS_1	0x00
 #define I40E_AQ_LINK_POWER_CLASS_2	0x01
 #define I40E_AQ_LINK_POWER_CLASS_3	0x02
 #define I40E_AQ_LINK_POWER_CLASS_4	0x03
+#define I40E_AQ_PWR_CLASS_MASK		0x03
 	u8	reserved[4];
 };
 
-- 
2.4.11

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
