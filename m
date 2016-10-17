From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 17 Oct 2016 13:24:42 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Report driver version to firmware
	for x550 devices
Message-ID: <1476735882-5310-1-git-send-email-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Some x550 devices require the driver version reported to its firmware; this
patch sends the driver version string to the firmware through the host
interface command for x550 devices.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |  7 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |  5 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   | 14 +++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   | 57 ++++++++++++++++++++++++-
 5 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index deac764..eb112f0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -3532,7 +3532,7 @@ void ixgbe_set_rxpba_generic(struct ixgbe_hw *hw,
  *  Calculates the checksum for some buffer on a specified length.  The
  *  checksum calculated is returned.
  **/
-static u8 ixgbe_calculate_checksum(u8 *buffer, u32 length)
+u8 ixgbe_calculate_checksum(u8 *buffer, u32 length)
 {
 	u32 i;
 	u8 sum = 0;
@@ -3676,6 +3676,8 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
  *  @min: driver version minor number
  *  @build: driver version build number
  *  @sub: driver version sub build number
+ *  @len: length of driver_ver string
+ *  @driver_ver: driver string
  *
  *  Sends driver version number to firmware through the manageability
  *  block.  On success return 0
@@ -3683,7 +3685,8 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
  *  semaphore or IXGBE_ERR_HOST_INTERFACE_COMMAND when command fails.
  **/
 s32 ixgbe_set_fw_drv_ver_generic(struct ixgbe_hw *hw, u8 maj, u8 min,
-				 u8 build, u8 sub)
+				 u8 build, u8 sub, __always_unused u16 len,
+				 __always_unused const char *driver_ver)
 {
 	struct ixgbe_hic_drv_info fw_cmd;
 	int i;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
index 6d4c260..a0a04ff 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
@@ -110,7 +110,8 @@ void ixgbe_set_mac_anti_spoofing(struct ixgbe_hw *hw, bool enable, int vf);
 void ixgbe_set_vlan_anti_spoofing(struct ixgbe_hw *hw, bool enable, int vf);
 s32 ixgbe_get_device_caps_generic(struct ixgbe_hw *hw, u16 *device_caps);
 s32 ixgbe_set_fw_drv_ver_generic(struct ixgbe_hw *hw, u8 maj, u8 min,
-				 u8 build, u8 ver);
+				 u8 build, u8 ver, u16 len, const char *str);
+u8 ixgbe_calculate_checksum(u8 *buffer, u32 length);
 s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *, u32 length,
 				 u32 timeout, bool return_data);
 void ixgbe_clear_tx_pending(struct ixgbe_hw *hw);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 569a3b0..143e4c0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9781,8 +9781,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * since os does not support feature
 	 */
 	if (hw->mac.ops.set_fw_drv_ver)
-		hw->mac.ops.set_fw_drv_ver(hw, 0xFF, 0xFF, 0xFF,
-					   0xFF);
+		hw->mac.ops.set_fw_drv_ver(hw, 0xFF, 0xFF, 0xFF, 0xFF,
+					   sizeof(ixgbe_driver_version) - 1,
+					   ixgbe_driver_version);
 
 	/* add san mac addr to netdev */
 	ixgbe_add_sanmac_netdev(netdev);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index dfd6143..af7d9a7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2618,6 +2618,7 @@ enum ixgbe_fdir_pballoc_type {
 #define FW_CEM_UNUSED_VER		0x0
 #define FW_CEM_MAX_RETRIES		3
 #define FW_CEM_RESP_STATUS_SUCCESS	0x1
+#define FW_CEM_DRIVER_VERSION_SIZE	39 /* +9 would send 48 bytes to fw */
 #define FW_READ_SHADOW_RAM_CMD		0x31
 #define FW_READ_SHADOW_RAM_LEN		0x6
 #define FW_WRITE_SHADOW_RAM_CMD		0x33
@@ -2685,6 +2686,16 @@ struct ixgbe_hic_drv_info {
 	u16 pad2; /* end spacing to ensure length is mult. of dword2 */
 };
 
+struct ixgbe_hic_drv_info2 {
+	struct ixgbe_hic_hdr hdr;
+	u8 port_num;
+	u8 ver_sub;
+	u8 ver_build;
+	u8 ver_min;
+	u8 ver_maj;
+	char driver_string[FW_CEM_DRIVER_VERSION_SIZE];
+};
+
 /* These need to be dword aligned */
 struct ixgbe_hic_read_shadow_ram {
 	union ixgbe_hic_hdr2 hdr;
@@ -3360,7 +3371,8 @@ struct ixgbe_mac_operations {
 	void (*fc_autoneg)(struct ixgbe_hw *);
 
 	/* Manageability interface */
-	s32 (*set_fw_drv_ver)(struct ixgbe_hw *, u8, u8, u8, u8);
+	s32 (*set_fw_drv_ver)(struct ixgbe_hw *, u8, u8, u8, u8, u16,
+			      const char *);
 	s32 (*get_thermal_sensor_data)(struct ixgbe_hw *);
 	s32 (*init_thermal_sensor_thresh)(struct ixgbe_hw *hw);
 	void (*disable_rx)(struct ixgbe_hw *hw);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index b6b35e4..36b820e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2354,6 +2354,61 @@ static s32 ixgbe_led_off_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
 	return 0;
 }
 
+/**
+ *  ixgbe_set_fw_drv_ver_x550 - Sends driver version to firmware
+ *  @hw: pointer to the HW structure
+ *  @maj: driver version major number
+ *  @min: driver version minor number
+ *  @build: driver version build number
+ *  @sub: driver version sub build number
+ *  @len: length of driver_ver string
+ *  @driver_ver: driver string
+ *
+ *  Sends driver version number to firmware through the manageability
+ *  block.  On success return 0
+ *  else returns IXGBE_ERR_SWFW_SYNC when encountering an error acquiring
+ *  semaphore or IXGBE_ERR_HOST_INTERFACE_COMMAND when command fails.
+ **/
+s32 ixgbe_set_fw_drv_ver_x550(struct ixgbe_hw *hw, u8 maj, u8 min,
+			      u8 build, u8 sub, u16 len, const char *driver_ver)
+{
+	struct ixgbe_hic_drv_info2 fw_cmd;
+	s32 ret_val;
+	int i;
+
+	if (!len || !driver_ver || (len > sizeof(fw_cmd.driver_string)))
+		return IXGBE_ERR_INVALID_ARGUMENT;
+
+	fw_cmd.hdr.cmd = FW_CEM_CMD_DRIVER_INFO;
+	fw_cmd.hdr.buf_len = FW_CEM_CMD_DRIVER_INFO_LEN + len;
+	fw_cmd.hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
+	fw_cmd.port_num = (u8)hw->bus.func;
+	fw_cmd.ver_maj = maj;
+	fw_cmd.ver_min = min;
+	fw_cmd.ver_build = build;
+	fw_cmd.ver_sub = sub;
+	fw_cmd.hdr.checksum = 0;
+	memcpy(fw_cmd.driver_string, driver_ver, len);
+	fw_cmd.hdr.checksum = ixgbe_calculate_checksum((u8 *)&fw_cmd,
+			      (FW_CEM_HDR_LEN + fw_cmd.hdr.buf_len));
+
+	for (i = 0; i <= FW_CEM_MAX_RETRIES; i++) {
+		ret_val = ixgbe_host_interface_command(hw, (u32 *)&fw_cmd,
+						       sizeof(fw_cmd),
+						       IXGBE_HI_COMMAND_TIMEOUT,
+						       true);
+		if (ret_val)
+			continue;
+
+		if (fw_cmd.hdr.cmd_or_resp.ret_status !=
+		    FW_CEM_RESP_STATUS_SUCCESS)
+			return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		return 0;
+	}
+
+	return ret_val;
+}
+
 /** ixgbe_get_lcd_x550em - Determine lowest common denominator
  *  @hw: pointer to hardware structure
  *  @lcd_speed: pointer to lowest common link speed
@@ -3273,7 +3328,7 @@ static s32 ixgbe_write_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
 	.clear_vfta			= &ixgbe_clear_vfta_generic, \
 	.set_vfta			= &ixgbe_set_vfta_generic, \
 	.fc_enable			= &ixgbe_fc_enable_generic, \
-	.set_fw_drv_ver			= &ixgbe_set_fw_drv_ver_generic, \
+	.set_fw_drv_ver			= &ixgbe_set_fw_drv_ver_x550, \
 	.init_uta_tables		= &ixgbe_init_uta_tables_generic, \
 	.set_mac_anti_spoofing		= &ixgbe_set_mac_anti_spoofing, \
 	.set_vlan_anti_spoofing		= &ixgbe_set_vlan_anti_spoofing, \
-- 
2.4.0

