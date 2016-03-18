From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 18 Mar 2016 10:35:16 -0700
Subject: [Intel-wired-lan] [PATCH 5/7] ixgbe: Provide for use of firmware to
 access IOSF registers
In-Reply-To: <20160318173358.28259.83547.stgit@mdrustad-wks.jf.intel.com>
References: <20160318173358.28259.83547.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160318173516.28259.24270.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add functions to issue firmware requests to access IOSF registers
for systems that require firmware coordination.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   19 ++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   60 +++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index ae4b86fff9c3..de02702e44c6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2636,6 +2636,10 @@ enum ixgbe_fdir_pballoc_type {
 #define FW_PHY_TOKEN_DELAY		5	/* milliseconds */
 #define FW_PHY_TOKEN_WAIT		5	/* seconds */
 #define FW_PHY_TOKEN_RETRIES ((FW_PHY_TOKEN_WAIT * 1000) / FW_PHY_TOKEN_DELAY)
+#define FW_INT_PHY_REQ_CMD		0xB
+#define FW_INT_PHY_REQ_LEN		10
+#define FW_INT_PHY_REQ_READ		0
+#define FW_INT_PHY_REQ_WRITE		1
 
 /* Host Interface Command Structures */
 struct ixgbe_hic_hdr {
@@ -2711,6 +2715,21 @@ struct ixgbe_hic_phy_token_req {
 	u16 pad;
 };
 
+struct ixgbe_hic_internal_phy_req {
+	struct ixgbe_hic_hdr hdr;
+	u8 port_number;
+	u8 command_type;
+	__be16 address;
+	u16 rsv1;
+	__be32 write_data;
+	u16 pad;
+} __packed;
+
+struct ixgbe_hic_internal_phy_resp {
+	struct ixgbe_hic_hdr hdr;
+	__be32 read_data;
+};
+
 /* Transmit Descriptor - Advanced */
 union ixgbe_adv_tx_desc {
 	struct {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index b8c10e40bc9e..3f5d1802c61e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -468,6 +468,66 @@ static s32 ixgbe_put_phy_token(struct ixgbe_hw *hw)
 	return IXGBE_ERR_FW_RESP_INVALID;
 }
 
+/**
+ *  ixgbe_write_iosf_sb_reg_x550a - Write to IOSF phy register
+ *  @hw: pointer to hardware structure
+ *  @reg_addr: 32 bit PHY register to write
+ *  @device_type: 3 bit device type
+ *  @data: Data to write to the register
+ **/
+static s32 ixgbe_write_iosf_sb_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
+					 __always_unused u32 device_type,
+					 u32 data)
+{
+	struct ixgbe_hic_internal_phy_req write_cmd;
+
+	memset(&write_cmd, 0, sizeof(write_cmd));
+	write_cmd.hdr.cmd = FW_INT_PHY_REQ_CMD;
+	write_cmd.hdr.buf_len = FW_INT_PHY_REQ_LEN;
+	write_cmd.hdr.checksum = FW_DEFAULT_CHECKSUM;
+	write_cmd.port_number = hw->bus.lan_id;
+	write_cmd.command_type = FW_INT_PHY_REQ_WRITE;
+	write_cmd.address = cpu_to_be16(reg_addr);
+	write_cmd.write_data = cpu_to_be32(data);
+
+	return ixgbe_host_interface_command(hw, &write_cmd, sizeof(write_cmd),
+					    IXGBE_HI_COMMAND_TIMEOUT, false); 
+}
+
+/**
+ *  ixgbe_read_iosf_sb_reg_x550a - Read from IOSF phy register
+ *  @hw: pointer to hardware structure
+ *  @reg_addr: 32 bit PHY register to write
+ *  @device_type: 3 bit device type
+ *  @data: Pointer to read data from the register
+ **/
+static s32 ixgbe_read_iosf_sb_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
+					__always_unused u32 device_type,
+					u32 *data)
+{
+	union {
+		struct ixgbe_hic_internal_phy_req cmd;
+		struct ixgbe_hic_internal_phy_resp rsp;
+	} hic;
+	s32 status;
+
+	memset(&hic, 0, sizeof(hic));
+	hic.cmd.hdr.cmd = FW_INT_PHY_REQ_CMD;
+	hic.cmd.hdr.buf_len = FW_INT_PHY_REQ_LEN;
+	hic.cmd.hdr.checksum = FW_DEFAULT_CHECKSUM;
+	hic.cmd.port_number = hw->bus.lan_id;
+	hic.cmd.command_type = FW_INT_PHY_REQ_READ;
+	hic.cmd.address = cpu_to_be16(reg_addr);
+
+	status = ixgbe_host_interface_command(hw, &hic.cmd, sizeof(hic.cmd),
+					      IXGBE_HI_COMMAND_TIMEOUT, true);
+
+	/* Extract the register value from the response. */
+	*data = be32_to_cpu(hic.rsp.read_data);
+
+	return status;
+}
+
 /** ixgbe_read_ee_hostif_data_X550 - Read EEPROM word using a host interface
  *  command assuming that the semaphore is already obtained.
  *  @hw: pointer to hardware structure

