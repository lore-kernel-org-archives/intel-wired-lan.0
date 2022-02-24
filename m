From: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
Date: Thu, 24 Feb 2022 13:36:14 +0000
Subject: [Intel-wired-lan] [PATCH net v1] ice: Fix re-enablement of FW
 logging after reset
Message-ID: <20220224133614.179091-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Device resets such as a CORER disable FW logging, and currently, it is
not re-enabled by the driver after the reset. This means that FW log
messages are not captured even though FW logging was enabled at driver
load time.

To fix the issue, call ice_cfg_fw_log() from ice_rebuild() to re-enable
the FW logging after a reset.

Fixes: 8b97ceb1dc0f ("ice: Enable firmware logging during device initialization.")
Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_common.h | 1 +
 drivers/net/ethernet/intel/ice/ice_main.c   | 5 +++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index e2af99a763ed..e0e20ad80199 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -737,7 +737,7 @@ static int ice_get_fw_log_cfg(struct ice_hw *hw)
  * messages from FW to SW. Interrupts are typically disabled during the device's
  * initialization phase.
  */
-static int ice_cfg_fw_log(struct ice_hw *hw, bool enable)
+int ice_cfg_fw_log(struct ice_hw *hw, bool enable)
 {
 	struct ice_aqc_fw_logging *cmd;
 	u16 i, chgs = 0, len = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 1c57097ddf0b..2d3743a3638e 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -174,6 +174,7 @@ ice_ena_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u16 q_handle,
 int ice_replay_vsi(struct ice_hw *hw, u16 vsi_handle);
 void ice_replay_post(struct ice_hw *hw);
 void ice_output_fw_log(struct ice_hw *hw, struct ice_aq_desc *desc, void *buf);
+int ice_cfg_fw_log(struct ice_hw *hw, bool enable);
 struct ice_q_ctx *
 ice_get_lan_q_ctx(struct ice_hw *hw, u16 vsi_handle, u8 tc, u16 q_handle);
 int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d72d5d147c75..9c36851d1401 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6646,6 +6646,11 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		goto err_init_ctrlq;
 	}
 
+	/* Re-enable FW logging. Not fatal if this fails. */
+	err = ice_cfg_fw_log(hw, true);
+	if (err)
+		dev_dbg(dev, "Failed to re-enable FW logging\n");
+
 	/* if DDP was previously loaded successfully */
 	if (!ice_is_safe_mode(pf)) {
 		/* reload the SW DB of filter tables */
-- 
2.27.0

