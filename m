From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 18 Mar 2016 10:35:00 -0700
Subject: [Intel-wired-lan] [PATCH 2/7] ixgbe: Add support for phy token
	firmware command
In-Reply-To: <20160318173358.28259.83547.stgit@mdrustad-wks.jf.intel.com>
References: <20160318173358.28259.83547.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160318173500.28259.48022.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The new mac includes a new firmware command that need to be used
to control phy access, so add definitions and support for it.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   19 +++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   55 +++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index fae85d1c3bf9..818e0a10d1bd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2626,6 +2626,16 @@ enum ixgbe_fdir_pballoc_type {
 #define FW_MAX_READ_BUFFER_SIZE		1024
 #define FW_DISABLE_RXEN_CMD		0xDE
 #define FW_DISABLE_RXEN_LEN		0x1
+#define FW_PHY_MGMT_REQ_CMD		0x20
+#define FW_PHY_TOKEN_REQ_CMD		0x0A
+#define FW_PHY_TOKEN_REQ_LEN		2
+#define FW_PHY_TOKEN_REQ		0
+#define FW_PHY_TOKEN_REL		1
+#define FW_PHY_TOKEN_OK			1
+#define FW_PHY_TOKEN_RETRY		0x80
+#define FW_PHY_TOKEN_DELAY		5	/* milliseconds */
+#define FW_PHY_TOKEN_WAIT		5	/* seconds */
+#define FW_PHY_TOKEN_RETRIES ((FW_PHY_TOKEN_WAIT * 1000) / FW_PHY_TOKEN_DELAY)
 
 /* Host Interface Command Structures */
 struct ixgbe_hic_hdr {
@@ -2694,6 +2704,13 @@ struct ixgbe_hic_disable_rxen {
 	u16 pad3;
 };
 
+struct ixgbe_hic_phy_token_req {
+	struct ixgbe_hic_hdr hdr;
+	u8 port_number;
+	u8 command_type;
+	u16 pad;
+};
+
 /* Transmit Descriptor - Advanced */
 union ixgbe_adv_tx_desc {
 	struct {
@@ -3525,6 +3542,8 @@ struct ixgbe_info {
 #define IXGBE_ERR_INVALID_ARGUMENT              -32
 #define IXGBE_ERR_HOST_INTERFACE_COMMAND        -33
 #define IXGBE_ERR_FDIR_CMD_INCOMPLETE		-38
+#define IXGBE_ERR_FW_RESP_INVALID		-39
+#define IXGBE_ERR_TOKEN_RETRY			-40
 #define IXGBE_NOT_IMPLEMENTED                   0x7FFFFFFF
 
 #define IXGBE_FUSES0_GROUP(_i)		(0x11158 + ((_i) * 4))
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 65832fa30426..aaea94759d76 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -413,6 +413,61 @@ out:
 	return ret;
 }
 
+/**
+ * ixgbe_get_phy_token - Get the token for shared phy access
+ * @hw: Pointer to hardware structure
+ */
+static s32 ixgbe_get_phy_token(struct ixgbe_hw *hw)
+{
+	struct ixgbe_hic_phy_token_req token_cmd;
+	s32 status;
+
+	token_cmd.hdr.cmd = FW_PHY_TOKEN_REQ_CMD;
+	token_cmd.hdr.buf_len = FW_PHY_TOKEN_REQ_LEN;
+	token_cmd.hdr.cmd_or_resp.cmd_resv = 0;
+	token_cmd.hdr.checksum = FW_DEFAULT_CHECKSUM;
+	token_cmd.port_number = hw->bus.lan_id;
+	token_cmd.command_type = FW_PHY_TOKEN_REQ;
+	token_cmd.pad = 0;
+	status = ixgbe_host_interface_command(hw, &token_cmd, sizeof(token_cmd),
+					      IXGBE_HI_COMMAND_TIMEOUT,
+					      true);
+	if (status)
+		return status;
+	if (token_cmd.hdr.cmd_or_resp.ret_status == FW_PHY_TOKEN_OK)
+		return 0;
+	if (token_cmd.hdr.cmd_or_resp.ret_status != FW_PHY_TOKEN_RETRY)
+		return IXGBE_ERR_FW_RESP_INVALID;
+
+	return IXGBE_ERR_TOKEN_RETRY;
+}
+
+/**
+ * ixgbe_put_phy_token - Put the token for shared phy access
+ * @hw: Pointer to hardware structure
+ */
+static s32 ixgbe_put_phy_token(struct ixgbe_hw *hw)
+{
+	struct ixgbe_hic_phy_token_req token_cmd;
+	s32 status;
+
+	token_cmd.hdr.cmd = FW_PHY_TOKEN_REQ_CMD;
+	token_cmd.hdr.buf_len = FW_PHY_TOKEN_REQ_LEN;
+	token_cmd.hdr.cmd_or_resp.cmd_resv = 0;
+	token_cmd.hdr.checksum = FW_DEFAULT_CHECKSUM;
+	token_cmd.port_number = hw->bus.lan_id;
+	token_cmd.command_type = FW_PHY_TOKEN_REL;
+	token_cmd.pad = 0;
+	status = ixgbe_host_interface_command(hw, &token_cmd, sizeof(token_cmd),
+					      IXGBE_HI_COMMAND_TIMEOUT,
+					      true);
+	if (status)
+		return status;
+	if (token_cmd.hdr.cmd_or_resp.ret_status == FW_PHY_TOKEN_OK)
+		return 0;
+	return IXGBE_ERR_FW_RESP_INVALID;
+}
+
 /** ixgbe_read_ee_hostif_data_X550 - Read EEPROM word using a host interface
  *  command assuming that the semaphore is already obtained.
  *  @hw: pointer to hardware structure

