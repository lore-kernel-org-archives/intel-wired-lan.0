From: Sebastian Basierski <sebastianx.basierski@intel.com>
Date: Tue, 31 Jul 2018 18:04:10 +0200
Subject: [Intel-wired-lan] [PATCH] ixgbe: firmware recovery mode
Message-ID: <20180731160410.50028-1-sebastianx.basierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add check for FW NVM recovery mode during driver initialization and
service task. If in recovery mode, log message and unregister device

Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   | 12 ++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 41 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  4 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 15 +++++++
 4 files changed, 72 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 0bd1294ba517..78460fb365ba 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -3484,6 +3484,18 @@ void ixgbe_set_vlan_anti_spoofing(struct ixgbe_hw *hw, bool enable, int vf)
 	IXGBE_WRITE_REG(hw, IXGBE_PFVFSPOOF(vf_target_reg), pfvfspoof);
 }
 
+/**
+ *  ixgbe_fw_recovery_mode - Check if in FW NVM recovery mode
+ *  @hw: pointer to hardware structure
+ *
+ **/
+bool ixgbe_fw_recovery_mode(struct ixgbe_hw *hw)
+{
+	if (hw->mac.ops.fw_recovery_mode)
+		return hw->mac.ops.fw_recovery_mode(hw);
+	return false;
+}
+
 /**
  *  ixgbe_get_device_caps_generic - Get additional device capabilities
  *  @hw: pointer to hardware structure
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 447098005490..2c08bcef27ad 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7764,6 +7764,33 @@ static void ixgbe_reset_subtask(struct ixgbe_adapter *adapter)
 	rtnl_unlock();
 }
 
+/**
+ * ixgbe_check_fw_error - Check firmware for errors
+ * @adapter: the adapter private structure
+ *
+ * Check firmware errors in register FWSM
+ **/
+static bool ixgbe_check_fw_error(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 fwsm;
+
+	/* read fwsm.ext_err_ind register and log errors */
+	fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
+
+	if (fwsm & IXGBE_FWSM_EXT_ERR_IND_MASK ||
+	    !(fwsm & IXGBE_FWSM_FW_VAL_BIT))
+		e_dev_warn("Warning firmware error detected FWSM: 0x%08X\n",
+			   fwsm);
+
+	if (hw->mac.ops.fw_recovery_mode && hw->mac.ops.fw_recovery_mode(hw)) {
+		e_dev_err("Firmware recovery mode detected. Limiting functionality. Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode.\n");
+	return true;
+	}
+
+	return false;
+}
+
 /**
  * ixgbe_service_task - manages and runs subtasks
  * @work: pointer to work_struct containing our data
@@ -7782,6 +7809,15 @@ static void ixgbe_service_task(struct work_struct *work)
 		ixgbe_service_event_complete(adapter);
 		return;
 	}
+	if (ixgbe_check_fw_error(adapter)) {
+		if (!test_bit(__IXGBE_DOWN, &adapter->state)) {
+			rtnl_lock();
+			unregister_netdev(adapter->netdev);
+			rtnl_unlock();
+		}
+		ixgbe_service_event_complete(adapter);
+		return;
+	}
 	if (adapter->flags2 & IXGBE_FLAG2_UDP_TUN_REREG_NEEDED) {
 		rtnl_lock();
 		adapter->flags2 &= ~IXGBE_FLAG2_UDP_TUN_REREG_NEEDED;
@@ -10694,6 +10730,11 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (adapter->flags2 & IXGBE_FLAG2_RSC_ENABLED)
 		netdev->features |= NETIF_F_LRO;
 
+	if (ixgbe_check_fw_error(adapter)) {
+		err = -EIO;
+		goto err_sw_init;
+	}
+
 	/* make sure the EEPROM is good */
 	if (hw->eeprom.ops.validate_checksum(hw, NULL) < 0) {
 		e_dev_err("The EEPROM Checksum Is Not Valid\n");
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 44cfb2021145..7b7df5688b3a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -924,6 +924,9 @@ struct ixgbe_nvm_version {
 /* Firmware Semaphore Register */
 #define IXGBE_FWSM_MODE_MASK	0xE
 #define IXGBE_FWSM_FW_MODE_PT	0x4
+#define IXGBE_FWSM_FW_NVM_RECOVERY_MODE	BIT(5)
+#define IXGBE_FWSM_EXT_ERR_IND_MASK	0x01F80000
+#define IXGBE_FWSM_FW_VAL_BIT	BIT(15)
 
 /* ARC Subsystem registers */
 #define IXGBE_HICR      0x15F00
@@ -3460,6 +3463,7 @@ struct ixgbe_mac_operations {
 			      const char *);
 	s32 (*get_thermal_sensor_data)(struct ixgbe_hw *);
 	s32 (*init_thermal_sensor_thresh)(struct ixgbe_hw *hw);
+	bool (*fw_recovery_mode)(struct ixgbe_hw *hw);
 	void (*disable_rx)(struct ixgbe_hw *hw);
 	void (*enable_rx)(struct ixgbe_hw *hw);
 	void (*set_source_address_pruning)(struct ixgbe_hw *, bool,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index a8148c7126e5..dbe502a1ffcf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1247,6 +1247,20 @@ static s32 ixgbe_get_bus_info_X550em(struct ixgbe_hw *hw)
 	return 0;
 }
 
+/** ixgbe_fw_recovery_mode - Check FW NVM recovery mode
+ * @hw: pointer t hardware structure
+ *
+ * Returns true if in FW NVM recovery mode.
+ **/
+
+static bool ixgbe_fw_recovery_mode_X550(struct ixgbe_hw *hw)
+{
+	u32 fwsm;
+
+	fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
+	return !!(fwsm & IXGBE_FWSM_FW_NVM_RECOVERY_MODE);
+}
+
 /** ixgbe_disable_rx_x550 - Disable RX unit
  *
  *  Enables the Rx DMA unit for x550
@@ -3816,6 +3830,7 @@ static s32 ixgbe_write_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
 	.enable_rx_buff			= &ixgbe_enable_rx_buff_generic, \
 	.get_thermal_sensor_data	= NULL, \
 	.init_thermal_sensor_thresh	= NULL, \
+	.fw_recovery_mode		= &ixgbe_fw_recovery_mode_X550, \
 	.enable_rx			= &ixgbe_enable_rx_generic, \
 	.disable_rx			= &ixgbe_disable_rx_x550, \
 
-- 
2.17.1

