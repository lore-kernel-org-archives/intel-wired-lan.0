From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 31 Jan 2019 13:57:18 -0800
Subject: [Intel-wired-lan] [STABLE 3/4] ice: Introduce ice_dev_onetime_setup
In-Reply-To: <20190131215719.8272-1-anirudh.venkataramanan@intel.com>
References: <20190131215719.8272-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190131215719.8272-4-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is a partial backport of the mainline commit f203dca363f8
("ice: Introduce ice_dev_onetime_setup").

ice_dev_onetime_setup() contains a workaround for a current firmware
limitation. Without this patch, the driver is not able to process Rx
packets. This workaround is expected to away when the underlying
firmware issue is fixed.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 15 +++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c   |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 50b7545adc68..fb5e77f263e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -42,6 +42,19 @@ static enum ice_status ice_set_mac_type(struct ice_hw *hw)
 	return 0;
 }
 
+/**
+ * ice_dev_onetime_setup - Temporary HW/FW workarounds
+ * @hw: pointer to the HW structure
+ *
+ * This function provides temporary workarounds for certain issues
+ * that are expected to be fixed in the HW/FW.
+ */
+void ice_dev_onetime_setup(struct ice_hw *hw)
+{
+	/* configure Rx - set non pxe mode */
+	wr32(hw, GLLAN_RCTL_0, 0x1);
+}
+
 /**
  * ice_clear_pf_cfg - Clear PF configuration
  * @hw: pointer to the hardware structure
@@ -483,6 +496,8 @@ enum ice_status ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_sched;
 
+	ice_dev_onetime_setup(hw);
+
 	/* Get MAC information */
 	/* A single port can report up to two (LAN and WoL) addresses */
 	mac_buf = devm_kcalloc(ice_hw_to_dev(hw), 2,
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 9a5519130af1..6ef1df0f5d99 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -32,6 +32,7 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 		struct ice_sq_cd *cd);
 void ice_clear_pxe_mode(struct ice_hw *hw);
 enum ice_status ice_get_caps(struct ice_hw *hw);
+void ice_dev_onetime_setup(struct ice_hw *hw);
 enum ice_status
 ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 		  u32 rxq_index);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3f047bb43348..a95c8fbc0475 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5179,6 +5179,8 @@ static void ice_rebuild(struct ice_pf *pf)
 
 	ice_clear_pxe_mode(hw);
 
+	ice_dev_onetime_setup(hw);
+
 	ret = ice_get_caps(hw);
 	if (ret) {
 		dev_err(dev, "ice_get_caps failed %d\n", ret);
-- 
2.17.2

