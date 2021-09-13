From: Karol Kolacinski <karol.kolacinski@intel.com>
Date: Mon, 13 Sep 2021 12:11:07 +0200
Subject: [Intel-wired-lan] [PATCH intel-next 1/2] ice: add i2c read/write
 read commands
Message-ID: <20210913101108.17927-1-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add I2C read/write AQ commands. They are now required for controlling
the external physical connectors via external I2C port expander on
E810-T adapters.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 29 ++++++
 drivers/net/ethernet/intel/ice/ice_common.c   | 94 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |  8 ++
 3 files changed, 131 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 0f64fbc9d3e8..89448e61c3dd 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1341,6 +1341,31 @@ struct ice_aqc_get_link_topo {
 	u8 rsvd[9];
 };
 
+/* Read/Write I2C (direct, 0x06E2/0x06E3) */
+struct ice_aqc_i2c {
+	struct ice_aqc_link_topo_addr topo_addr;
+	__le16 i2c_addr;
+	u8 i2c_params;
+#define ICE_AQC_I2C_DATA_SIZE_S		0
+#define ICE_AQC_I2C_DATA_SIZE_M		(0xF << ICE_AQC_I2C_DATA_SIZE_S)
+#define ICE_AQC_I2C_ADDR_TYPE_M		BIT(4)
+#define ICE_AQC_I2C_ADDR_TYPE_7BIT	0
+#define ICE_AQC_I2C_ADDR_TYPE_10BIT	ICE_AQC_I2C_ADDR_TYPE_M
+#define ICE_AQC_I2C_DATA_OFFSET_S	5
+#define ICE_AQC_I2C_DATA_OFFSET_M	(0x3 << ICE_AQC_I2C_DATA_OFFSET_S)
+#define ICE_AQC_I2C_USE_REPEATED_START	BIT(7)
+	u8 rsvd;
+	__le16 i2c_bus_addr;
+#define ICE_AQC_I2C_ADDR_7BIT_MASK	0x7F
+#define ICE_AQC_I2C_ADDR_10BIT_MASK	0x3FF
+	u8 i2c_data[4]; /* Used only by write command, reserved in read. */
+};
+
+/* Read I2C Response (direct, 0x06E2) */
+struct ice_aqc_read_i2c_resp {
+	u8 i2c_data[16];
+};
+
 /* Set Port Identification LED (direct, 0x06E9) */
 struct ice_aqc_set_port_id_led {
 	u8 lport_num;
@@ -2051,6 +2076,8 @@ struct ice_aq_desc {
 		struct ice_aqc_get_link_status get_link_status;
 		struct ice_aqc_event_lan_overflow lan_overflow;
 		struct ice_aqc_get_link_topo get_link_topo;
+		struct ice_aqc_i2c read_write_i2c;
+		struct ice_aqc_read_i2c_resp read_i2c_resp;
 	} params;
 };
 
@@ -2162,6 +2189,8 @@ enum ice_adminq_opc {
 	ice_aqc_opc_set_event_mask			= 0x0613,
 	ice_aqc_opc_set_mac_lb				= 0x0620,
 	ice_aqc_opc_get_link_topo			= 0x06E0,
+	ice_aqc_opc_read_i2c				= 0x06E2,
+	ice_aqc_opc_write_i2c				= 0x06E3,
 	ice_aqc_opc_set_port_id_led			= 0x06E9,
 	ice_aqc_opc_set_gpio				= 0x06EC,
 	ice_aqc_opc_get_gpio				= 0x06ED,
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 93df36ccde51..c732e290921a 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4764,6 +4764,100 @@ ice_sched_query_elem(struct ice_hw *hw, u32 node_teid,
 	return status;
 }
 
+/**
+ * ice_aq_read_i2c
+ * @hw: pointer to the hw struct
+ * @topo_addr: topology address for a device to communicate with
+ * @bus_addr: 7-bit I2C bus address
+ * @addr: I2C memory address (I2C offset) with up to 16 bits
+ * @params: I2C parameters: bit [7] - Repeated start, bits [6:5] data offset size,
+ *			    bit [4] - I2C address type, bits [3:0] - data size to read (0-16 bytes)
+ * @data: pointer to data (0 to 16 bytes) to be read from the I2C device
+ * @cd: pointer to command details structure or NULL
+ *
+ * Read I2C (0x06E2)
+ */
+enum ice_status
+ice_aq_read_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
+		u16 bus_addr, __le16 addr, u8 params, u8 *data,
+		struct ice_sq_cd *cd)
+{
+	struct ice_aq_desc desc = { 0 };
+	struct ice_aqc_i2c *cmd;
+	enum ice_status status;
+	u8 data_size;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_read_i2c);
+	cmd = &desc.params.read_write_i2c;
+
+	if (!data)
+		return ICE_ERR_PARAM;
+
+	data_size = (params & ICE_AQC_I2C_DATA_SIZE_M) >> ICE_AQC_I2C_DATA_SIZE_S;
+
+	cmd->i2c_bus_addr = cpu_to_le16(bus_addr);
+	cmd->topo_addr = topo_addr;
+	cmd->i2c_params = params;
+	cmd->i2c_addr = addr;
+
+	status = ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
+	if (!status) {
+		struct ice_aqc_read_i2c_resp *resp;
+		u8 i;
+
+		resp = &desc.params.read_i2c_resp;
+		for (i = 0; i < data_size; i++) {
+			*data = resp->i2c_data[i];
+			data++;
+		}
+	}
+
+	return status;
+}
+
+/**
+ * ice_aq_write_i2c
+ * @hw: pointer to the hw struct
+ * @topo_addr: topology address for a device to communicate with
+ * @bus_addr: 7-bit I2C bus address
+ * @addr: I2C memory address (I2C offset) with up to 16 bits
+ * @params: I2C parameters: bit [4] - I2C address type, bits [3:0] - data size to write (0-7 bytes)
+ * @data: pointer to data (0 to 4 bytes) to be written to the I2C device
+ * @cd: pointer to command details structure or NULL
+ *
+ * Write I2C (0x06E3)
+ */
+enum ice_status
+ice_aq_write_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
+		 u16 bus_addr, __le16 addr, u8 params, u8 *data,
+		 struct ice_sq_cd *cd)
+{
+	struct ice_aq_desc desc = { 0 };
+	struct ice_aqc_i2c *cmd;
+	u8 i, data_size;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_write_i2c);
+	cmd = &desc.params.read_write_i2c;
+
+	data_size = (params & ICE_AQC_I2C_DATA_SIZE_M) >> ICE_AQC_I2C_DATA_SIZE_S;
+
+	/* data_size limited to 4 */
+	if (data_size > 4)
+		return ICE_ERR_PARAM;
+
+	cmd->i2c_bus_addr = cpu_to_le16(bus_addr);
+	cmd->topo_addr = topo_addr;
+	cmd->i2c_params = params;
+	cmd->i2c_addr = addr;
+
+	for (i = 0; i < data_size; i++) {
+		cmd->i2c_data[i] = *data;
+		data++;
+	}
+
+	return ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
+}
+
 /**
  * ice_aq_set_driver_param - Set driver parameter to share via firmware
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 3b3981f0a87b..f7be713dbb40 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -205,5 +205,13 @@ ice_aq_set_lldp_mib(struct ice_hw *hw, u8 mib_type, void *buf, u16 buf_size,
 bool ice_fw_supports_lldp_fltr_ctrl(struct ice_hw *hw);
 enum ice_status
 ice_lldp_fltr_add_remove(struct ice_hw *hw, u16 vsi_num, bool add);
+enum ice_status
+ice_aq_read_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
+		u16 bus_addr, __le16 addr, u8 params, u8 *data,
+		struct ice_sq_cd *cd);
+enum ice_status
+ice_aq_write_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
+		 u16 bus_addr, __le16 addr, u8 params, u8 *data,
+		 struct ice_sq_cd *cd);
 bool ice_fw_supports_report_dflt_cfg(struct ice_hw *hw);
 #endif /* _ICE_COMMON_H_ */
-- 
2.30.2

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

