From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Mon, 14 Mar 2016 11:05:46 -0700
Subject: [Intel-wired-lan] [PATCH V2 2/5] ixgbe: Change the lan_id and func
 fields to a u8 to avoid casts
In-Reply-To: <20160314180316.8397.65394.stgit@mdrustad-wks.jf.intel.com>
References: <20160314180316.8397.65394.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160314180546.8397.53488.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since the lan_id and func fields only ever hold small values, make
them u8 to avoid casts used to silence warnings.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   |    4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 8c7e78b21c4e..dfdb1149b6fd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -3600,7 +3600,7 @@ s32 ixgbe_set_fw_drv_ver_generic(struct ixgbe_hw *hw, u8 maj, u8 min,
 	fw_cmd.hdr.cmd = FW_CEM_CMD_DRIVER_INFO;
 	fw_cmd.hdr.buf_len = FW_CEM_CMD_DRIVER_INFO_LEN;
 	fw_cmd.hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
-	fw_cmd.port_num = (u8)hw->bus.func;
+	fw_cmd.port_num = hw->bus.func;
 	fw_cmd.ver_maj = maj;
 	fw_cmd.ver_min = min;
 	fw_cmd.ver_build = build;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index d02a0a3fa1d8..7ae4bbd26ad8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3122,8 +3122,8 @@ struct ixgbe_bus_info {
 	enum ixgbe_bus_width width;
 	enum ixgbe_bus_type type;
 
-	u16 func;
-	u16 lan_id;
+	u8 func;
+	u8 lan_id;
 };
 
 /* Flow control parameters */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 9d3f765638cc..5affac123b75 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -862,7 +862,7 @@ static void ixgbe_disable_rx_x550(struct ixgbe_hw *hw)
 		fw_cmd.hdr.cmd = FW_DISABLE_RXEN_CMD;
 		fw_cmd.hdr.buf_len = FW_DISABLE_RXEN_LEN;
 		fw_cmd.hdr.checksum = FW_DEFAULT_CHECKSUM;
-		fw_cmd.port_number = (u8)hw->bus.lan_id;
+		fw_cmd.port_number = hw->bus.lan_id;
 
 		status = ixgbe_host_interface_command(hw, (u32 *)&fw_cmd,
 					sizeof(struct ixgbe_hic_disable_rxen),

