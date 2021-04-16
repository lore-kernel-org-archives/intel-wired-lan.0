From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Fri, 16 Apr 2021 23:43:57 +0200
Subject: [Intel-wired-lan] [PATCH net] i40e: Remove lldp frame filters
Message-ID: <20210416214357.341975-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove filters from being setup in case of software DCB and allow the
lldp frames to be properly transmitted to the wire.

It is not possible to transmit the LLDP frame out of the port, if they
are filtered by control VSI. This prohibits software lldp agent
properly communicate it's DCB capabilities to the neighbors.

Fixes: 4b208eaa8078 ("i40e: Add init and default config of software based DCB")
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 -
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 42 -------------------
 3 files changed, 44 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 1116543..e3a4c7b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1222,7 +1222,6 @@ static inline bool i40e_is_sw_dcb(struct i40e_pf *pf)
 	return !!(pf->flags & I40E_FLAG_DISABLE_FW_LLDP);
 }
 
-void i40e_set_lldp_forwarding(struct i40e_pf *pf, bool enable);
 #ifdef CONFIG_I40E_DCB
 void i40e_dcbnl_flush_apps(struct i40e_pf *pf,
 			   struct i40e_dcbx_config *old_cfg,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index fbe4fe9..936908c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5280,7 +5280,6 @@ flags_complete:
 			i40e_aq_cfg_lldp_mib_change_event(&pf->hw, false, NULL);
 			i40e_aq_stop_lldp(&pf->hw, true, false, NULL);
 		} else {
-			i40e_set_lldp_forwarding(pf, false);
 			status = i40e_aq_start_lldp(&pf->hw, false, NULL);
 			if (status) {
 				adq_err = pf->hw.aq.asq_last_status;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3180b41..1a39e51 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6890,40 +6890,6 @@ out:
 }
 #endif /* CONFIG_I40E_DCB */
 
-/**
- * i40e_set_lldp_forwarding - set forwarding of lldp frames
- * @pf: PF being configured
- * @enable: if forwarding to OS shall be enabled
- *
- * Toggle forwarding of lldp frames behavior,
- * When passing DCB control from firmware to software
- * lldp frames must be forwarded to the software based
- * lldp agent.
- */
-void i40e_set_lldp_forwarding(struct i40e_pf *pf, bool enable)
-{
-	if (pf->lan_vsi == I40E_NO_VSI)
-		return;
-
-	if (!pf->vsi[pf->lan_vsi])
-		return;
-
-	/* No need to check the outcome, commands may fail
-	 * if desired value is already set
-	 */
-	i40e_aq_add_rem_control_packet_filter(&pf->hw, NULL, ETH_P_LLDP,
-					      I40E_AQC_ADD_CONTROL_PACKET_FLAGS_TX |
-					      I40E_AQC_ADD_CONTROL_PACKET_FLAGS_IGNORE_MAC,
-					      pf->vsi[pf->lan_vsi]->seid, 0,
-					      enable, NULL, NULL);
-
-	i40e_aq_add_rem_control_packet_filter(&pf->hw, NULL, ETH_P_LLDP,
-					      I40E_AQC_ADD_CONTROL_PACKET_FLAGS_RX |
-					      I40E_AQC_ADD_CONTROL_PACKET_FLAGS_IGNORE_MAC,
-					      pf->vsi[pf->lan_vsi]->seid, 0,
-					      enable, NULL, NULL);
-}
-
 /**
  * i40e_print_link_message - print link up or down
  * @vsi: the VSI for which link needs a message
@@ -10749,10 +10715,6 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	 */
 	i40e_add_filter_to_drop_tx_flow_control_frames(&pf->hw,
 						       pf->main_vsi_seid);
-#ifdef CONFIG_I40E_DCB
-	if (pf->flags & I40E_FLAG_DISABLE_FW_LLDP)
-		i40e_set_lldp_forwarding(pf, true);
-#endif /* CONFIG_I40E_DCB */
 
 	/* restart the VSIs that were rebuilt and running before the reset */
 	i40e_pf_unquiesce_all_vsi(pf);
@@ -15796,10 +15758,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	i40e_add_filter_to_drop_tx_flow_control_frames(&pf->hw,
 						       pf->main_vsi_seid);
-#ifdef CONFIG_I40E_DCB
-	if (pf->flags & I40E_FLAG_DISABLE_FW_LLDP)
-		i40e_set_lldp_forwarding(pf, true);
-#endif /* CONFIG_I40E_DCB */
 
 	if ((pf->hw.device_id == I40E_DEV_ID_10G_BASE_T) ||
 		(pf->hw.device_id == I40E_DEV_ID_10G_BASE_T4))

base-commit: ca4303103f33952646218db4e0869e6f6aa1c840
-- 
2.26.0

