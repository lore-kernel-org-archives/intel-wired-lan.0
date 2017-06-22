From: Paul Greenwalt <paul.greenwalt@intel.com>
Date: Thu, 22 Jun 2017 11:35:34 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add DMA Coalescing support
Message-ID: <1498145734-7358-1-git-send-email-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add DMA Coalescing (DMAC) support for X550, X550em_a, and X550em_x devices.
DMAC can reduce total power consumption by allowing the chipset and/or CPU
to spend more time in low-power states. DMAC is disabled by default, and
can be enabled/disabled by the ethtool coalesce dmac parameter. The dmac
parameter configures the watchdog timer interval in usecs. Setting dmac
to 0 disables DMAC, and support values range is 41 - 100000 usecs.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  10 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  24 +++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  23 +++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |  37 +++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c    | 102 +++++++++++++++++++++++
 include/uapi/linux/ethtool.h                     |   2 +
 6 files changed, 196 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 2e9df66..05e3b28 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -507,6 +507,11 @@ struct hwmon_buff {
 #define IXGBE_20K_ITR		200
 #define IXGBE_12K_ITR		336
 
+/* DMA coalecing watchdog timer interval in usecs */
+#define IXGBE_DMACWT_DISABLE	0
+#define IXGBE_DMACWT_MIN	41
+#define IXGBE_DMACWT_MAX	10000
+
 /* ixgbe_test_staterr - tests bits in Rx descriptor status and error fields */
 static inline __le32 ixgbe_test_staterr(union ixgbe_adv_rx_desc *rx_desc,
 					const u32 stat_err_bits)
@@ -942,6 +947,11 @@ int ixgbe_fcoe_get_wwn(struct net_device *netdev, u64 *wwn, int type);
 int ixgbe_fcoe_get_hbainfo(struct net_device *netdev,
 			   struct netdev_fcoe_hbainfo *info);
 u8 ixgbe_fcoe_get_tc(struct ixgbe_adapter *adapter);
+#else
+static inline u8 ixgbe_fcoe_get_tc(struct ixgbe_adapter *adapter)
+{
+	return 0;
+}
 #endif /* IXGBE_FCOE */
 #ifdef CONFIG_DEBUG_FS
 void ixgbe_dbg_adapter_init(struct ixgbe_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index e10a4d6..18f5576 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2289,6 +2289,8 @@ static int ixgbe_get_coalesce(struct net_device *netdev,
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 
+	ec->dmac = adapter->hw.mac.dmac_config.watchdog_timer;
+
 	/* only valid if in constant ITR mode */
 	if (adapter->rx_itr_setting <= 1)
 		ec->rx_coalesce_usecs = adapter->rx_itr_setting;
@@ -2342,10 +2344,12 @@ static int ixgbe_set_coalesce(struct net_device *netdev,
 			      struct ethtool_coalesce *ec)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
+	struct ixgbe_hw *hw = &adapter->hw;
 	struct ixgbe_q_vector *q_vector;
-	int i;
 	u16 tx_itr_param, rx_itr_param, tx_itr_prev;
 	bool need_reset = false;
+	u16 dmac_prev;
+	int i;
 
 	if (adapter->q_vector[0]->tx.count && adapter->q_vector[0]->rx.count) {
 		/* reject Tx specific changes in case of mixed RxTx vectors */
@@ -2396,6 +2400,24 @@ static int ixgbe_set_coalesce(struct net_device *netdev,
 			need_reset = true;
 	}
 
+	if (ec->dmac != IXGBE_DMACWT_DISABLE &&
+	    (ec->dmac < IXGBE_DMACWT_MIN || ec->dmac > IXGBE_DMACWT_MAX))
+		return -EINVAL;
+
+	if (hw->mac.ops.dmac_config) {
+		dmac_prev = hw->mac.dmac_config.watchdog_timer;
+		hw->mac.dmac_config.watchdog_timer = ec->dmac;
+
+		/* Disable DMAC if interrupt throttling is disabled */
+		if (hw->mac.dmac_config.watchdog_timer &&
+		    (!adapter->rx_itr_setting && !adapter->tx_itr_setting)) {
+			hw->mac.dmac_config.watchdog_timer = 0;
+			hw->mac.ops.dmac_config(&adapter->hw);
+		} else if (hw->mac.dmac_config.watchdog_timer != dmac_prev) {
+			hw->mac.ops.dmac_config(&adapter->hw);
+		}
+	}
+
 	/* check the old value and enable RSC if necessary */
 	need_reset |= ixgbe_update_rsc(adapter);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 706995f..2df8000 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5656,6 +5656,12 @@ void ixgbe_reset(struct ixgbe_adapter *adapter)
 	if (hw->mac.san_mac_rar_index)
 		hw->mac.ops.set_vmdq_san_mac(hw, VMDQ_P(0));
 
+	/* Clear saved DMA coalescing values except for watchdog_timer */
+	hw->mac.dmac_config.fcoe_en = false;
+	hw->mac.dmac_config.link_speed = 0;
+	hw->mac.dmac_config.fcoe_tc = 0;
+	hw->mac.dmac_config.num_tcs = 0;
+
 	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
 		ixgbe_ptp_reset(adapter);
 
@@ -7107,6 +7113,23 @@ static void ixgbe_watchdog_update_link(struct ixgbe_adapter *adapter)
 
 	adapter->link_up = link_up;
 	adapter->link_speed = link_speed;
+
+	if (hw->mac.ops.dmac_config && hw->mac.dmac_config.watchdog_timer) {
+		u8 num_tcs = netdev_get_num_tc(adapter->netdev);
+		u8 fcoe_tc = ixgbe_fcoe_get_tc(adapter);
+		bool fcoe_en = !!(adapter->flags & IXGBE_FLAG_FCOE_ENABLED);
+
+		if (hw->mac.dmac_config.link_speed != link_speed ||
+		    hw->mac.dmac_config.fcoe_tc != fcoe_tc ||
+		    hw->mac.dmac_config.fcoe_en != fcoe_en ||
+		    hw->mac.dmac_config.num_tcs != num_tcs) {
+			hw->mac.dmac_config.link_speed = link_speed;
+			hw->mac.dmac_config.num_tcs = num_tcs;
+			hw->mac.dmac_config.fcoe_en = fcoe_en;
+			hw->mac.dmac_config.fcoe_tc = fcoe_tc;
+			hw->mac.ops.dmac_config(hw);
+		}
+	}
 }
 
 static void ixgbe_update_default_up(struct ixgbe_adapter *adapter)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 4808978..f094865 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -326,6 +326,7 @@ struct ixgbe_thermal_sensor_data {
 #define IXGBE_RXCTRL    0x03000
 #define IXGBE_DROPEN    0x03D04
 #define IXGBE_RXPBSIZE_SHIFT 10
+#define IXGBE_RXPBSIZE_MASK	0x000FFC00
 
 /* Receive Registers */
 #define IXGBE_RXCSUM    0x05000
@@ -573,6 +574,40 @@ struct ixgbe_thermal_sensor_data {
 #define IXGBE_TDPT2TCCR(_i)     (0x0CD20 + ((_i) * 4)) /* 8 of these (0-7) */
 #define IXGBE_TDPT2TCSR(_i)     (0x0CD40 + ((_i) * 4)) /* 8 of these (0-7) */
 
+/* DMA Coalescing configuration */
+struct ixgbe_dmac_config {
+	u16	watchdog_timer; /* usec units */
+	bool	fcoe_en;
+	u32	link_speed;
+	u8	fcoe_tc;
+	u8	num_tcs;
+};
+
+/* DMA Coalescing threshold Rx PB TC[n] value in Kilobyte by link speed.
+ * DMACRXT = 10Gbps = 10,000 bits / usec = 1250 bytes / usec 70 * 1250 ==
+ * 87500 bytes [85KB]
+ */
+#define IXGBE_DMACRXT_10G		0x55
+#define IXGBE_DMACRXT_1G		0x09
+#define IXGBE_DMACRXT_100M		0x01
+
+/* DMA Coalescing registers */
+#define IXGBE_DMCMNGTH			0x15F20 /* Management Threshold */
+#define IXGBE_DMACR			0x02400 /* Control register */
+#define IXGBE_DMCTH(_i)			(0x03300 + ((_i) * 4)) /* 8 of these */
+#define IXGBE_DMCTLX			0x02404 /* Time to Lx request */
+/* DMA Coalescing register fields */
+#define IXGBE_DMCMNGTH_DMCMNGTH_MASK	0x000FFFF0 /* Mng Threshold mask */
+#define IXGBE_DMCMNGTH_DMCMNGTH_SHIFT	4 /* Management Threshold shift */
+#define IXGBE_DMACR_DMACWT_MASK		0x0000FFFF /* Watchdog Timer mask */
+#define IXGBE_DMACR_HIGH_PRI_TC_MASK	0x00FF0000
+#define IXGBE_DMACR_HIGH_PRI_TC_SHIFT	16
+#define IXGBE_DMACR_EN_MNG_IND		0x10000000 /* Enable Mng Indications */
+#define IXGBE_DMACR_LX_COAL_IND		0x40000000 /* Lx Coalescing indicate */
+#define IXGBE_DMACR_DMAC_EN		0x80000000 /* DMA Coalescing Enable */
+#define IXGBE_DMCTH_DMACRXT_MASK	0x000001FF /* Receive Threshold mask */
+#define IXGBE_DMCTLX_TTLX_MASK		0x00000FFF /* Time to Lx request mask */
+
 /* Security Control Registers */
 #define IXGBE_SECTXCTRL         0x08800
 #define IXGBE_SECTXSTAT         0x08804
@@ -3460,7 +3495,6 @@ struct ixgbe_mac_operations {
 
 	/* DMA Coalescing */
 	s32 (*dmac_config)(struct ixgbe_hw *hw);
-	s32 (*dmac_update_tcs)(struct ixgbe_hw *hw);
 	s32 (*dmac_config_tcs)(struct ixgbe_hw *hw);
 	s32 (*read_iosf_sb_reg)(struct ixgbe_hw *, u32, u32, u32 *);
 	s32 (*write_iosf_sb_reg)(struct ixgbe_hw *, u32, u32, u32);
@@ -3553,6 +3587,7 @@ struct ixgbe_mac_info {
 	u8                              flags;
 	u8				san_mac_rar_index;
 	struct ixgbe_thermal_sensor_data  thermal_sensor_data;
+	struct ixgbe_dmac_config	dmac_config;
 	bool				set_lben;
 	u8				led_link_act;
 };
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index ea483f8..357805a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -639,6 +639,106 @@ static s32 ixgbe_fc_autoneg_fw(struct ixgbe_hw *hw)
 	return ixgbe_setup_fw_link(hw);
 }
 
+/**
+ *  ixgbe_dmac_config_tcs_X550
+ *  @hw: pointer to hardware structure
+ *
+ *  Configure DMA coalescing threshold per TC. The dmac enable bit must
+ *  be cleared before configuring.
+ **/
+static s32 ixgbe_dmac_config_tcs_X550(struct ixgbe_hw *hw)
+{
+	u32 tc, reg, pb_headroom, rx_pb_size, maxframe_size_kb;
+
+	/* Configure DMA coalescing enabled */
+	switch (hw->mac.dmac_config.link_speed) {
+	case IXGBE_LINK_SPEED_10_FULL:
+	case IXGBE_LINK_SPEED_100_FULL:
+		pb_headroom = IXGBE_DMACRXT_100M;
+		break;
+	case IXGBE_LINK_SPEED_1GB_FULL:
+		pb_headroom = IXGBE_DMACRXT_1G;
+		break;
+	default:
+		pb_headroom = IXGBE_DMACRXT_10G;
+		break;
+	}
+
+	maxframe_size_kb = ((IXGBE_READ_REG(hw, IXGBE_MAXFRS) >>
+			     IXGBE_MHADD_MFS_SHIFT) / 1024);
+
+	/* Set the per Rx packet buffer receive threshold */
+	for (tc = 0; tc < MAX_TRAFFIC_CLASS; tc++) {
+		reg = IXGBE_READ_REG(hw, IXGBE_DMCTH(tc));
+		reg &= ~IXGBE_DMCTH_DMACRXT_MASK;
+
+		if (tc < hw->mac.dmac_config.num_tcs) {
+			/* Get Rx PB size */
+			rx_pb_size = IXGBE_READ_REG(hw, IXGBE_RXPBSIZE(tc));
+			rx_pb_size = (rx_pb_size & IXGBE_RXPBSIZE_MASK) >>
+				IXGBE_RXPBSIZE_SHIFT;
+
+			/* Calculate receive buffer threshold in kilobytes */
+			if (rx_pb_size > pb_headroom)
+				rx_pb_size = rx_pb_size - pb_headroom;
+			else
+				rx_pb_size = 0;
+
+			/* Minimum of MFS shall be set for DMCTH */
+			reg |= (rx_pb_size > maxframe_size_kb) ?
+				rx_pb_size : maxframe_size_kb;
+		}
+		IXGBE_WRITE_REG(hw, IXGBE_DMCTH(tc), reg);
+	}
+	return 0;
+}
+
+/**
+ *  ixgbe_dmac_config_X550
+ *  @hw: pointer to hardware structure
+ *
+ *  Configure DMA coalescing. If enabling dmac, dmac is activated.
+ *  When disabling dmac, dmac enable dmac bit is cleared.
+ **/
+static s32 ixgbe_dmac_config_X550(struct ixgbe_hw *hw)
+{
+	u32 reg, high_pri_tc;
+
+	/* Disable DMA coalescing before configuring */
+	reg = IXGBE_READ_REG(hw, IXGBE_DMACR);
+	reg &= ~IXGBE_DMACR_DMAC_EN;
+	IXGBE_WRITE_REG(hw, IXGBE_DMACR, reg);
+
+	/* Disable DMA Coalescing if the watchdog timer is 0 */
+	if (!hw->mac.dmac_config.watchdog_timer)
+		goto out;
+
+	ixgbe_dmac_config_tcs_X550(hw);
+
+	/* Configure DMA Coalescing Control Register */
+	reg = IXGBE_READ_REG(hw, IXGBE_DMACR);
+
+	/* Set the watchdog timer in units of 40.96 usec */
+	reg &= ~IXGBE_DMACR_DMACWT_MASK;
+	reg |= (hw->mac.dmac_config.watchdog_timer * 100) / 4096;
+
+	reg &= ~IXGBE_DMACR_HIGH_PRI_TC_MASK;
+	/* If fcoe is enabled, set high priority traffic class */
+	if (hw->mac.dmac_config.fcoe_en) {
+		high_pri_tc = 1 << hw->mac.dmac_config.fcoe_tc;
+		reg |= ((high_pri_tc << IXGBE_DMACR_HIGH_PRI_TC_SHIFT) &
+			IXGBE_DMACR_HIGH_PRI_TC_MASK);
+	}
+	reg |= IXGBE_DMACR_EN_MNG_IND;
+
+	/* Enable DMA coalescing after configuration */
+	reg |= IXGBE_DMACR_DMAC_EN;
+	IXGBE_WRITE_REG(hw, IXGBE_DMACR, reg);
+
+out:
+	return 0;
+}
+
 /** ixgbe_init_eeprom_params_X550 - Initialize EEPROM params
  *  @hw: pointer to hardware structure
  *
@@ -3955,6 +4055,8 @@ static s32 ixgbe_write_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
 	.disable_mdd                    = &ixgbe_disable_mdd_X550, \
 	.mdd_event                      = &ixgbe_mdd_event_X550, \
 	.restore_mdd_vf                 = &ixgbe_restore_mdd_vf_X550, \
+	.dmac_config			= &ixgbe_dmac_config_X550, \
+	.dmac_config_tcs		= &ixgbe_dmac_config_tcs_X550, \
 
 static const struct ixgbe_mac_operations mac_ops_X550 = {
 	X550_COMMON_MAC
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 7d4a594..0083f4d 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -402,6 +402,7 @@ struct ethtool_modinfo {
  *	a TX interrupt, when the packet rate is above @pkt_rate_high.
  * @rate_sample_interval: How often to do adaptive coalescing packet rate
  *	sampling, measured in seconds.  Must not be zero.
+ * @dmac: How many usecs to store packets before moving to host memory.
  *
  * Each pair of (usecs, max_frames) fields specifies that interrupts
  * should be coalesced until
@@ -452,6 +453,7 @@ struct ethtool_coalesce {
 	__u32	tx_coalesce_usecs_high;
 	__u32	tx_max_coalesced_frames_high;
 	__u32	rate_sample_interval;
+	__u32	dmac;
 };
 
 /**
-- 
2.7.4

