From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Wed, 03 Jun 2015 20:13:32 -0400
Subject: [Intel-wired-lan] [net-next PATCH 03/11] ixgbe: Add a PHY power
	state method
In-Reply-To: <20150604001322.18893.48953.stgit@dcs-desk.jf.intel.com>
References: <20150604001322.18893.48953.stgit@dcs-desk.jf.intel.com>
Message-ID: <20150604001332.18893.96556.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This new method will control the PHY power state.  You pass in the
state you wish to change to (ether on or off).  For cases where this
method is not used the current PHY power state behavior is maintained.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c |    2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   15 +++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c   |   34 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h   |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |    3 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c  |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c  |    1 +
 7 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
index 3f63065..65db69b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
@@ -1225,7 +1225,7 @@ static struct ixgbe_phy_operations phy_ops_82598 = {
 	.setup_link_speed	= &ixgbe_setup_phy_link_speed_generic,
 	.read_i2c_sff8472	= &ixgbe_read_i2c_sff8472_82598,
 	.read_i2c_eeprom	= &ixgbe_read_i2c_eeprom_82598,
-	.check_overtemp   = &ixgbe_tn_check_overtemp,
+	.check_overtemp		= &ixgbe_tn_check_overtemp,
 };
 
 struct ixgbe_info ixgbe_82598_info = {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 43cb17f..5aea3ef 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4898,6 +4898,9 @@ static void ixgbe_up_complete(struct ixgbe_adapter *adapter)
 	if (hw->mac.ops.enable_tx_laser)
 		hw->mac.ops.enable_tx_laser(hw);
 
+	if (hw->phy.ops.set_phy_power)
+		hw->phy.ops.set_phy_power(hw, true);
+
 	smp_mb__before_atomic();
 	clear_bit(__IXGBE_DOWN, &adapter->state);
 	ixgbe_napi_enable_all(adapter);
@@ -5017,6 +5020,13 @@ void ixgbe_reset(struct ixgbe_adapter *adapter)
 
 	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
 		ixgbe_ptp_reset(adapter);
+
+	if (hw->phy.ops.set_phy_power) {
+		if (!netif_running(adapter->netdev) && !adapter->wol)
+			hw->phy.ops.set_phy_power(hw, false);
+		else
+			hw->phy.ops.set_phy_power(hw, true);
+	}
 }
 
 /**
@@ -5697,6 +5707,7 @@ static int ixgbe_change_mtu(struct net_device *netdev, int new_mtu)
 static int ixgbe_open(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
+	struct ixgbe_hw *hw = &adapter->hw;
 	int err, queues;
 
 	/* disallow open during test */
@@ -5754,6 +5765,8 @@ err_set_queues:
 	ixgbe_free_irq(adapter);
 err_req_irq:
 	ixgbe_free_all_rx_resources(adapter);
+	if (hw->phy.ops.set_phy_power && !adapter->wol)
+		hw->phy.ops.set_phy_power(&adapter->hw, false);
 err_setup_rx:
 	ixgbe_free_all_tx_resources(adapter);
 err_setup_tx:
@@ -5914,6 +5927,8 @@ static int __ixgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	}
 
 	*enable_wake = !!wufc;
+	if (hw->phy.ops.set_phy_power && !*enable_wake)
+		hw->phy.ops.set_phy_power(hw, false);
 
 	ixgbe_release_hw_control(adapter);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 47ac0bc..5011e46 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -2140,3 +2140,37 @@ s32 ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
 
 	return IXGBE_ERR_OVERTEMP;
 }
+
+/** ixgbe_set_copper_phy_power - Control power for copper phy
+ *  @hw: pointer to hardware structure
+ *  @on: true for on, false for off
+ **/
+s32 ixgbe_set_copper_phy_power(struct ixgbe_hw *hw, bool on)
+{
+	u32 status;
+	u16 reg;
+
+	/* Bail if we don't have copper phy */
+	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
+		return 0;
+
+	status = hw->phy.ops.read_reg(hw, IXGBE_MDIO_VENDOR_SPECIFIC_1_CONTROL,
+				      IXGBE_MDIO_VENDOR_SPECIFIC_1_DEV_TYPE,
+				      &reg);
+	if (status)
+		return status;
+
+	if (on) {
+		reg &= ~IXGBE_MDIO_PHY_SET_LOW_POWER_MODE;
+	} else {
+		if (ixgbe_check_reset_blocked(hw))
+			return 0;
+		reg |= IXGBE_MDIO_PHY_SET_LOW_POWER_MODE;
+	}
+
+	status = hw->phy.ops.write_reg(hw, IXGBE_MDIO_VENDOR_SPECIFIC_1_CONTROL,
+				       IXGBE_MDIO_VENDOR_SPECIFIC_1_DEV_TYPE,
+				       reg);
+	return status;
+}
+
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index 4346438..e45988c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -145,6 +145,7 @@ s32 ixgbe_get_phy_firmware_version_generic(struct ixgbe_hw *hw,
 					   u16 *firmware_version);
 
 s32 ixgbe_reset_phy_nl(struct ixgbe_hw *hw);
+s32 ixgbe_set_copper_phy_power(struct ixgbe_hw *hw, bool on);
 s32 ixgbe_identify_module_generic(struct ixgbe_hw *hw);
 s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw);
 s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 560a2b4..77d1118 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -1309,6 +1309,8 @@ struct ixgbe_thermal_sensor_data {
 #define IXGBE_MDIO_AUTO_NEG_LP		0x13 /* AUTO_NEG LP Status Reg */
 #define IXGBE_MDIO_AUTO_NEG_EEE_ADVT	0x3C /* AUTO_NEG EEE Advt Reg */
 
+#define IXGBE_MDIO_PHY_SET_LOW_POWER_MODE	 0x0800 /* Set low power mode */
+
 #define IXGBE_MDIO_TX_VENDOR_ALARMS_3	0xCC02 /* Vendor Alarms 3 Reg */
 #define IXGBE_MDIO_TX_VENDOR_ALARMS_3_RST_MASK 0x3 /* PHY Reset Complete Mask */
 #define IXGBE_MDIO_GLOBAL_RES_PR_10 0xC479 /* Global Resv Provisioning 10 Reg */
@@ -3277,6 +3279,7 @@ struct ixgbe_phy_operations {
 	s32 (*read_i2c_combined)(struct ixgbe_hw *, u8 addr, u16 reg, u16 *val);
 	s32 (*write_i2c_combined)(struct ixgbe_hw *, u8 addr, u16 reg, u16 val);
 	s32 (*check_overtemp)(struct ixgbe_hw *);
+	s32 (*set_phy_power)(struct ixgbe_hw *, bool on);
 };
 
 struct ixgbe_eeprom_info {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index 12ce50d..032a587 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -850,6 +850,7 @@ static struct ixgbe_phy_operations phy_ops_X540 = {
 	.read_i2c_eeprom        = &ixgbe_read_i2c_eeprom_generic,
 	.write_i2c_eeprom       = &ixgbe_write_i2c_eeprom_generic,
 	.check_overtemp         = &ixgbe_tn_check_overtemp,
+	.set_phy_power          = &ixgbe_set_copper_phy_power,
 	.get_firmware_version   = &ixgbe_get_phy_firmware_version_generic,
 };
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index aaf5d1a..88f7862 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1530,6 +1530,7 @@ static struct ixgbe_phy_operations phy_ops_X550 = {
 	.setup_link		= &ixgbe_setup_phy_link_generic,
 	.read_i2c_combined	= &ixgbe_read_i2c_combined_generic,
 	.write_i2c_combined	= &ixgbe_write_i2c_combined_generic,
+	.set_phy_power          = &ixgbe_set_copper_phy_power,
 };
 
 static struct ixgbe_phy_operations phy_ops_X550EM_x = {

