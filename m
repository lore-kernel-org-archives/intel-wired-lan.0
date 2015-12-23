From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Wed, 23 Dec 2015 12:05:42 -0800
Subject: [Intel-wired-lan] [next PATCH S25 02/16] i40e: AQ Add
	set_switch_config
In-Reply-To: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450901156-30904-3-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Add the new Set Switch Config AdminQ command, and mark the L2 Filter
bit as deprecated in the Add VEB command.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Acked-by: Kevin Scott <kevin.c.scott@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Change-ID: I5b24790f14c56f0ddf3f70df1e486844146b039f
---
Testing-Hints:
Apply and compile cleanly.

 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 15 ++++++++++++++-
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 15 ++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 6e0834e..7e96615 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -145,6 +145,7 @@ enum i40e_admin_queue_opc {
 	i40e_aqc_opc_remove_statistics		= 0x0202,
 	i40e_aqc_opc_set_port_parameters	= 0x0203,
 	i40e_aqc_opc_get_switch_resource_alloc	= 0x0204,
+	i40e_aqc_opc_set_switch_config		= 0x0205,
 
 	i40e_aqc_opc_add_vsi			= 0x0210,
 	i40e_aqc_opc_update_vsi_parameters	= 0x0211,
@@ -683,6 +684,17 @@ struct i40e_aqc_switch_resource_alloc_element_resp {
 
 I40E_CHECK_STRUCT_LEN(0x10, i40e_aqc_switch_resource_alloc_element_resp);
 
+/* Set Switch Configuration (direct 0x0205) */
+struct i40e_aqc_set_switch_config {
+	__le16	flags;
+#define I40E_AQ_SET_SWITCH_CFG_PROMISC		0x0001
+#define I40E_AQ_SET_SWITCH_CFG_L2_FILTER	0x0002
+	__le16	valid_flags;
+	u8	reserved[12];
+};
+
+I40E_CHECK_CMD_LENGTH(i40e_aqc_set_switch_config);
+
 /* Add VSI (indirect 0x0210)
  *    this indirect command uses struct i40e_aqc_vsi_properties_data
  *    as the indirect buffer (128 bytes)
@@ -909,7 +921,8 @@ struct i40e_aqc_add_veb {
 					I40E_AQC_ADD_VEB_PORT_TYPE_SHIFT)
 #define I40E_AQC_ADD_VEB_PORT_TYPE_DEFAULT	0x2
 #define I40E_AQC_ADD_VEB_PORT_TYPE_DATA		0x4
-#define I40E_AQC_ADD_VEB_ENABLE_L2_FILTER	0x8
+#define I40E_AQC_ADD_VEB_ENABLE_L2_FILTER	0x8     /* deprecated */
+#define I40E_AQC_ADD_VEB_ENABLE_DISABLE_STATS	0x10
 	u8	enable_tcs;
 	u8	reserved[9];
 };
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index 220b972..2c8f3ed 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -145,6 +145,7 @@ enum i40e_admin_queue_opc {
 	i40e_aqc_opc_remove_statistics		= 0x0202,
 	i40e_aqc_opc_set_port_parameters	= 0x0203,
 	i40e_aqc_opc_get_switch_resource_alloc	= 0x0204,
+	i40e_aqc_opc_set_switch_config		= 0x0205,
 
 	i40e_aqc_opc_add_vsi			= 0x0210,
 	i40e_aqc_opc_update_vsi_parameters	= 0x0211,
@@ -680,6 +681,17 @@ struct i40e_aqc_switch_resource_alloc_element_resp {
 
 I40E_CHECK_STRUCT_LEN(0x10, i40e_aqc_switch_resource_alloc_element_resp);
 
+/* Set Switch Configuration (direct 0x0205) */
+struct i40e_aqc_set_switch_config {
+	__le16	flags;
+#define I40E_AQ_SET_SWITCH_CFG_PROMISC		0x0001
+#define I40E_AQ_SET_SWITCH_CFG_L2_FILTER	0x0002
+	__le16	valid_flags;
+	u8	reserved[12];
+};
+
+I40E_CHECK_CMD_LENGTH(i40e_aqc_set_switch_config);
+
 /* Add VSI (indirect 0x0210)
  *    this indirect command uses struct i40e_aqc_vsi_properties_data
  *    as the indirect buffer (128 bytes)
@@ -906,7 +918,8 @@ struct i40e_aqc_add_veb {
 					I40E_AQC_ADD_VEB_PORT_TYPE_SHIFT)
 #define I40E_AQC_ADD_VEB_PORT_TYPE_DEFAULT	0x2
 #define I40E_AQC_ADD_VEB_PORT_TYPE_DATA		0x4
-#define I40E_AQC_ADD_VEB_ENABLE_L2_FILTER	0x8
+#define I40E_AQC_ADD_VEB_ENABLE_L2_FILTER	0x8     /* deprecated */
+#define I40E_AQC_ADD_VEB_ENABLE_DISABLE_STATS	0x10
 	u8	enable_tcs;
 	u8	reserved[9];
 };
-- 
2.1.0

