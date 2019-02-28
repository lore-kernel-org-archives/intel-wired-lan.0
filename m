From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:24:26 -0800
Subject: [Intel-wired-lan] [PATCH S16 05/11] ice: Add code to process LLDP
 MIB change events
In-Reply-To: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
References: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190228232432.31659-6-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds support to process LLDP MIB change notifications sent
by the firmware.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb.c     |  5 ++--
 drivers/net/ethernet/intel/ice/ice_dcb.h     |  2 ++
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 36 ++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h |  4 ++++
 drivers/net/ethernet/intel/ice/ice_main.c    |  3 +++
 5 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
index 1ad36b40974a..ff8267f84c8c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -588,8 +588,7 @@ ice_parse_org_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
  *
  * Parse DCB configuration from the LLDPDU
  */
-static enum ice_status
-ice_lldp_to_dcb_cfg(u8 *lldpmib, struct ice_dcbx_cfg *dcbcfg)
+enum ice_status ice_lldp_to_dcb_cfg(u8 *lldpmib, struct ice_dcbx_cfg *dcbcfg)
 {
 	struct ice_lldp_org_tlv *tlv;
 	enum ice_status ret = 0;
@@ -871,7 +870,7 @@ ice_get_ieee_or_cee_dcb_cfg(struct ice_port_info *pi, u8 dcbx_mode)
  *
  * Get DCB configuration from the Firmware
  */
-static enum ice_status ice_get_dcb_cfg(struct ice_port_info *pi)
+enum ice_status ice_get_dcb_cfg(struct ice_port_info *pi)
 {
 	struct ice_aqc_get_cee_dcb_cfg_resp cee_cfg;
 	struct ice_dcbx_cfg *dcbx_cfg;
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.h b/drivers/net/ethernet/intel/ice/ice_dcb.h
index 03e310a679f0..5e2b67ee1131 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.h
@@ -121,6 +121,8 @@ struct ice_cee_app_prio {
 } __packed;
 
 u8 ice_get_dcbx_status(struct ice_hw *hw);
+enum ice_status ice_lldp_to_dcb_cfg(u8 *lldpmib, struct ice_dcbx_cfg *dcbcfg);
+enum ice_status ice_get_dcb_cfg(struct ice_port_info *pi);
 enum ice_status ice_set_dcb_cfg(struct ice_port_info *pi);
 enum ice_status ice_init_dcb(struct ice_hw *hw);
 enum ice_status
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 67b3fab74f7a..bb9c282ee35e 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -320,3 +320,39 @@ int ice_init_pf_dcb(struct ice_pf *pf)
 	dev_err(dev, "DCB init failed\n");
 	return err;
 }
+
+/**
+ * ice_dcb_process_lldp_set_mib_change - Process MIB change
+ * @pf: ptr to ice_pf
+ * @event: pointer to the admin queue receive event
+ */
+void
+ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
+				    struct ice_rq_event_info *event)
+{
+	if (pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) {
+		struct ice_dcbx_cfg *dcbcfg, *prev_cfg;
+		int err;
+
+		prev_cfg = &pf->hw.port_info->local_dcbx_cfg;
+		dcbcfg = devm_kmemdup(&pf->pdev->dev, prev_cfg,
+				      sizeof(*dcbcfg), GFP_KERNEL);
+		if (!dcbcfg)
+			return;
+
+		err = ice_lldp_to_dcb_cfg(event->msg_buf, dcbcfg);
+		if (!err)
+			ice_pf_dcb_cfg(pf, dcbcfg);
+
+		devm_kfree(&pf->pdev->dev, dcbcfg);
+
+		/* Get updated DCBx data from firmware */
+		err = ice_get_dcb_cfg(pf->hw.port_info);
+		if (err)
+			dev_err(&pf->pdev->dev,
+				"Failed to get DCB config\n");
+	} else {
+		dev_dbg(&pf->pdev->dev,
+			"MIB Change Event in HOST mode\n");
+	}
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
index 1c60bf4ca593..a2e42f85fa55 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
@@ -11,6 +11,9 @@
 u8 ice_dcb_get_ena_tc(struct ice_dcbx_cfg *dcbcfg);
 u8 ice_dcb_get_num_tc(struct ice_dcbx_cfg *dcbcfg);
 int ice_init_pf_dcb(struct ice_pf *pf);
+void
+ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
+				    struct ice_rq_event_info *event);
 #else
 static inline u8 ice_dcb_get_ena_tc(struct ice_dcbx_cfg __always_unused *dcbcfg)
 {
@@ -28,5 +31,6 @@ static inline int ice_init_pf_dcb(struct ice_pf *pf)
 	return -EOPNOTSUPP;
 }
 
+#define ice_dcb_process_lldp_set_mib_change(pf, event) do {} while (0)
 #endif /* CONFIG_DCB */
 #endif /* _ICE_DCB_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 158339769097..9b58f156ceee 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -936,6 +936,9 @@ static int __ice_clean_ctrlq(struct ice_pf *pf, enum ice_ctl_q q_type)
 		case ice_aqc_opc_fw_logging:
 			ice_output_fw_log(hw, &event.desc, event.msg_buf);
 			break;
+		case ice_aqc_opc_lldp_set_mib_change:
+			ice_dcb_process_lldp_set_mib_change(pf, &event);
+			break;
 		default:
 			dev_dbg(&pf->pdev->dev,
 				"%s Receive Queue unknown event 0x%04x ignored\n",
-- 
2.14.5

