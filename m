From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Wed, 23 Dec 2015 12:05:44 -0800
Subject: [Intel-wired-lan] [next PATCH S25 04/16] i40e: AQ thermal sensor
	control struct
In-Reply-To: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450901156-30904-5-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Add the new AQ command and struct for managing a thermal sensor.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Change-ID: I6f5631839a0f3dca352a6c222f1269a960e2310a
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 17 +++++++++++++++++
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 5effb91..9684572 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -230,6 +230,7 @@ enum i40e_admin_queue_opc {
 	i40e_aqc_opc_nvm_config_read		= 0x0704,
 	i40e_aqc_opc_nvm_config_write		= 0x0705,
 	i40e_aqc_opc_oem_post_update		= 0x0720,
+	i40e_aqc_opc_thermal_sensor		= 0x0721,
 
 	/* virtualization commands */
 	i40e_aqc_opc_send_msg_to_pf		= 0x0801,
@@ -1952,6 +1953,22 @@ struct i40e_aqc_nvm_oem_post_update_buffer {
 
 I40E_CHECK_STRUCT_LEN(0x28, i40e_aqc_nvm_oem_post_update_buffer);
 
+/* Thermal Sensor (indirect 0x0721)
+ *     read or set thermal sensor configs and values
+ *     takes a sensor and command specific data buffer, not detailed here
+ */
+struct i40e_aqc_thermal_sensor {
+	u8 sensor_action;
+#define I40E_AQ_THERMAL_SENSOR_READ_CONFIG	0
+#define I40E_AQ_THERMAL_SENSOR_SET_CONFIG	1
+#define I40E_AQ_THERMAL_SENSOR_READ_TEMP	2
+	u8 reserved[7];
+	__le32	addr_high;
+	__le32	addr_low;
+};
+
+I40E_CHECK_CMD_LENGTH(i40e_aqc_thermal_sensor);
+
 /* Send to PF command (indirect 0x0801) id is only used by PF
  * Send to VF command (indirect 0x0802) id is only used by PF
  * Send to Peer PF command (indirect 0x0803)
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index bdb18f6..6468537 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -230,6 +230,7 @@ enum i40e_admin_queue_opc {
 	i40e_aqc_opc_nvm_config_read		= 0x0704,
 	i40e_aqc_opc_nvm_config_write		= 0x0705,
 	i40e_aqc_opc_oem_post_update		= 0x0720,
+	i40e_aqc_opc_thermal_sensor		= 0x0721,
 
 	/* virtualization commands */
 	i40e_aqc_opc_send_msg_to_pf		= 0x0801,
@@ -1949,6 +1950,22 @@ struct i40e_aqc_nvm_oem_post_update_buffer {
 
 I40E_CHECK_STRUCT_LEN(0x28, i40e_aqc_nvm_oem_post_update_buffer);
 
+/* Thermal Sensor (indirect 0x0721)
+ *     read or set thermal sensor configs and values
+ *     takes a sensor and command specific data buffer, not detailed here
+ */
+struct i40e_aqc_thermal_sensor {
+	u8 sensor_action;
+#define I40E_AQ_THERMAL_SENSOR_READ_CONFIG	0
+#define I40E_AQ_THERMAL_SENSOR_SET_CONFIG	1
+#define I40E_AQ_THERMAL_SENSOR_READ_TEMP	2
+	u8 reserved[7];
+	__le32	addr_high;
+	__le32	addr_low;
+};
+
+I40E_CHECK_CMD_LENGTH(i40e_aqc_thermal_sensor);
+
 /* Send to PF command (indirect 0x0801) id is only used by PF
  * Send to VF command (indirect 0x0802) id is only used by PF
  * Send to Peer PF command (indirect 0x0803)
-- 
2.1.0

