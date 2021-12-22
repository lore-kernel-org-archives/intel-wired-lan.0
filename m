From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Wed, 22 Dec 2021 11:39:52 -0500
Subject: [Intel-wired-lan] [PATCH v6 net-next 4/4] ice: add support for
 recovered clocks
In-Reply-To: <20211222163952.413183-1-arkadiusz.kubalewski@intel.com>
References: <20211222163952.413183-1-arkadiusz.kubalewski@intel.com>
Message-ID: <20211222163952.413183-4-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Implement ethtool netlink functions for handling recovered clocks
configuration on ice driver:
- ETHTOOL_MSG_RCLK_SET
- ETHTOOL_MSG_RCLK_GET

Co-developed-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 29 ++++++
 drivers/net/ethernet/intel/ice/ice_common.c   | 65 +++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |  6 ++
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 96 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  2 +
 5 files changed, 198 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 98d7a22185ce..4637f0d6b2ab 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1283,6 +1283,31 @@ struct ice_aqc_set_mac_lb {
 	u8 reserved[15];
 };
 
+/* Set PHY recovered clock output (direct 0x0630) */
+struct ice_aqc_set_phy_rec_clk_out {
+	u8 phy_output;
+	u8 port_num;
+	u8 flags;
+#define ICE_AQC_SET_PHY_REC_CLK_OUT_OUT_EN	BIT(0)
+#define ICE_AQC_SET_PHY_REC_CLK_OUT_CURR_PORT	0xFF
+	u8 rsvd;
+	__le32 freq;
+	u8 rsvd2[6];
+	__le16 node_handle;
+};
+
+/* Get PHY recovered clock output (direct 0x0631) */
+struct ice_aqc_get_phy_rec_clk_out {
+	u8 phy_output;
+	u8 port_num;
+	u8 flags;
+#define ICE_AQC_GET_PHY_REC_CLK_OUT_OUT_EN	BIT(0)
+	u8 rsvd;
+	__le32 freq;
+	u8 rsvd2[6];
+	__le16 node_handle;
+};
+
 struct ice_aqc_link_topo_params {
 	u8 lport_num;
 	u8 lport_num_valid;
@@ -2040,6 +2065,8 @@ struct ice_aq_desc {
 		struct ice_aqc_get_phy_caps get_phy;
 		struct ice_aqc_set_phy_cfg set_phy;
 		struct ice_aqc_restart_an restart_an;
+		struct ice_aqc_set_phy_rec_clk_out set_phy_rec_clk_out;
+		struct ice_aqc_get_phy_rec_clk_out get_phy_rec_clk_out;
 		struct ice_aqc_gpio read_write_gpio;
 		struct ice_aqc_sff_eeprom read_write_sff_param;
 		struct ice_aqc_set_port_id_led set_port_id_led;
@@ -2195,6 +2222,8 @@ enum ice_adminq_opc {
 	ice_aqc_opc_get_link_status			= 0x0607,
 	ice_aqc_opc_set_event_mask			= 0x0613,
 	ice_aqc_opc_set_mac_lb				= 0x0620,
+	ice_aqc_opc_set_phy_rec_clk_out			= 0x0630,
+	ice_aqc_opc_get_phy_rec_clk_out			= 0x0631,
 	ice_aqc_opc_get_link_topo			= 0x06E0,
 	ice_aqc_opc_set_port_id_led			= 0x06E9,
 	ice_aqc_opc_set_gpio				= 0x06EC,
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index cbc83928f3e1..1bbe4b8757db 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -5245,3 +5245,68 @@ bool ice_is_clock_mux_present_e810t(struct ice_hw *hw)
 	return true;
 }
 
+/**
+ * ice_aq_set_phy_rec_clk_out - set RCLK phy out
+ * @hw: pointer to the HW struct
+ * @phy_output: PHY reference clock output pin
+ * @enable: GPIO state to be applied
+ * @freq: PHY output frequency
+ *
+ * Set CGU reference priority (0x0630)
+ * Return 0 on success or negative value on failure.
+ */
+int
+ice_aq_set_phy_rec_clk_out(struct ice_hw *hw, u8 phy_output, bool enable,
+			   u32 *freq)
+{
+	struct ice_aqc_set_phy_rec_clk_out *cmd;
+	struct ice_aq_desc desc;
+	int status;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_set_phy_rec_clk_out);
+	cmd = &desc.params.set_phy_rec_clk_out;
+	cmd->phy_output = phy_output;
+	cmd->port_num = ICE_AQC_SET_PHY_REC_CLK_OUT_CURR_PORT;
+	cmd->flags = enable & ICE_AQC_SET_PHY_REC_CLK_OUT_OUT_EN;
+	cmd->freq = cpu_to_le32(*freq);
+
+	status = ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
+	if (!status)
+		*freq = le32_to_cpu(cmd->freq);
+
+	return status;
+}
+
+/**
+ * ice_aq_get_phy_rec_clk_out
+ * @hw: pointer to the HW struct
+ * @phy_output: PHY reference clock output pin
+ * @port_num: Port number
+ * @flags: PHY flags
+ * @freq: PHY output frequency
+ *
+ * Get PHY recovered clock output (0x0631)
+ */
+int
+ice_aq_get_phy_rec_clk_out(struct ice_hw *hw, u8 phy_output, u8 *port_num,
+			   u8 *flags, u32 *freq)
+{
+	struct ice_aqc_get_phy_rec_clk_out *cmd;
+	struct ice_aq_desc desc;
+	int status;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_phy_rec_clk_out);
+	cmd = &desc.params.get_phy_rec_clk_out;
+	cmd->phy_output = phy_output;
+	cmd->port_num = *port_num;
+
+	status = ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
+	if (!status) {
+		*port_num = cmd->port_num;
+		*flags = cmd->flags;
+		*freq = le32_to_cpu(cmd->freq);
+	}
+
+	return status;
+}
+
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index c253c0500512..314c53e31973 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -168,6 +168,12 @@ int
 ice_aq_get_cgu_dpll_status(struct ice_hw *hw, u8 dpll_num, u8 *ref_state,
 			   u16 *dpll_state, u64 *phase_offset, u8 *eec_mode);
 int
+ice_aq_set_phy_rec_clk_out(struct ice_hw *hw, u8 phy_output, bool enable,
+			   u32 *freq);
+int
+ice_aq_get_phy_rec_clk_out(struct ice_hw *hw, u8 phy_output, u8 *port_num,
+			   u8 *flags, u32 *freq);
+int
 ice_dis_vsi_rdma_qset(struct ice_port_info *pi, u16 count, u32 *qset_teid,
 		      u16 *q_id);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index e2e3ef7fba7f..e8a0f99e56a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4055,6 +4055,99 @@ ice_get_module_eeprom(struct net_device *netdev,
 	return 0;
 }
 
+/**
+ * ice_get_rclk_range - get range of recovered clock indices
+ * @netdev: network interface device structure
+ * @min_idx: min rclk index
+ * @max_idx: max rclk index
+ * @extack: netlink extended ack
+ */
+static int
+ice_get_rclk_range(struct net_device *netdev, u32 *min_idx, u32 *max_idx,
+		   struct netlink_ext_ack *extack)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_vsi *vsi = np->vsi;
+	struct ice_pf *pf = vsi->back;
+
+	if (!ice_is_feature_supported(pf, ICE_F_CGU))
+		return -EOPNOTSUPP;
+
+	*min_idx = 0;
+	*max_idx = ICE_RCLK_PIN_MAX;
+
+	return 0;
+}
+
+/**
+ * ice_get_rclk_state - get state of a recovered frequency output pin
+ * @netdev: network interface device structure
+ * @out_idx: index of a questioned pin
+ * @ena: returned state of a pin
+ * @extack: netlink extended ack
+ */
+static int
+ice_get_rclk_state(struct net_device *netdev, u32 out_idx,
+		   bool *ena, struct netlink_ext_ack *extack)
+{
+	u8 port_num = ICE_AQC_SET_PHY_REC_CLK_OUT_CURR_PORT, flags;
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_vsi *vsi = np->vsi;
+	struct ice_pf *pf = vsi->back;
+	u32 freq;
+	int ret;
+
+	if (!ice_is_feature_supported(pf, ICE_F_CGU))
+		return -EOPNOTSUPP;
+
+	if (out_idx > ICE_RCLK_PIN_MAX)
+		return -EINVAL;
+
+	ret = ice_aq_get_phy_rec_clk_out(&pf->hw, out_idx,
+					 &port_num, &flags, &freq);
+	if (ret)
+		return ret;
+
+	if (flags & ICE_AQC_GET_PHY_REC_CLK_OUT_OUT_EN)
+		*ena = true;
+	else
+		*ena = false;
+
+	return ret;
+}
+
+/**
+ * ice_set_rclk_out - enable/disable recovered clock redirection to the
+ * output pin
+ * @netdev: network interface device structure
+ * @out_idx: index of pin being configured
+ * @ena: requested state of a pin
+ * @extack: netlink extended ack
+ */
+static int
+ice_set_rclk_out(struct net_device *netdev, u32 out_idx, bool ena,
+		 struct netlink_ext_ack *extack)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_vsi *vsi = np->vsi;
+	struct ice_pf *pf = vsi->back;
+	u32 freq;
+	int ret;
+
+	if (!ice_is_feature_supported(pf, ICE_F_CGU))
+		return -EOPNOTSUPP;
+
+	if (out_idx > ICE_RCLK_PIN_MAX)
+		return -EINVAL;
+
+	ret = ice_aq_set_phy_rec_clk_out(&pf->hw, out_idx,
+					 ena, &freq);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
 static const struct ethtool_ops ice_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
@@ -4100,6 +4193,9 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.set_fecparam		= ice_set_fecparam,
 	.get_module_info	= ice_get_module_info,
 	.get_module_eeprom	= ice_get_module_eeprom,
+	.get_rclk_range		= ice_get_rclk_range,
+	.get_rclk_state		= ice_get_rclk_state,
+	.set_rclk_out		= ice_set_rclk_out,
 };
 
 static const struct ethtool_ops ice_ethtool_safe_mode_ops = {
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 28b04ec40bae..865ca680b62e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -132,4 +132,6 @@ enum ice_e810t_cgu_pins {
 	NUM_E810T_CGU_PINS
 };
 
+#define ICE_RCLK_PIN_MAX	(REF1N - REF1P)
+
 #endif /* _ICE_PTP_HW_H_ */
-- 
2.31.1

