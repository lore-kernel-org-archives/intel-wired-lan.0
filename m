From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 13 Jul 2020 13:53:14 -0700
Subject: [Intel-wired-lan] [PATCH S50 11/15] ice: Allow all VLANs in safe
 mode
In-Reply-To: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
Message-ID: <20200713205318.32425-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently the PF VSI's context parameters are left in a bad state when
going into safe mode. This is causing VLAN traffic to not pass. Fix this
by configuring the PF VSI to allow all VLAN tagged traffic.

Also, remove redundant comment explaining the safe mode flow in
ice_probe().

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 59 ++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a7b6502f1b4e..e6d758aa9a2f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3438,6 +3438,60 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx)
 	return err;
 }
 
+/**
+ * ice_set_safe_mode_vlan_cfg - configure PF VSI to allow all VLANs in safe mode
+ * @pf: PF to configure
+ *
+ * No VLAN offloads/filtering are advertised in safe mode so make sure the PF
+ * VSI can still Tx/Rx VLAN tagged packets.
+ */
+static void ice_set_safe_mode_vlan_cfg(struct ice_pf *pf)
+{
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
+	struct ice_vsi_ctx *ctxt;
+	enum ice_status status;
+	struct ice_hw *hw;
+
+	if (!vsi)
+		return;
+
+	ctxt = kzalloc(sizeof(*ctxt), GFP_KERNEL);
+	if (!ctxt)
+		return;
+
+	hw = &pf->hw;
+	ctxt->info = vsi->info;
+
+	ctxt->info.valid_sections =
+		cpu_to_le16(ICE_AQ_VSI_PROP_VLAN_VALID |
+			    ICE_AQ_VSI_PROP_SECURITY_VALID |
+			    ICE_AQ_VSI_PROP_SW_VALID);
+
+	/* disable VLAN anti-spoof */
+	ctxt->info.sec_flags &= ~(ICE_AQ_VSI_SEC_TX_VLAN_PRUNE_ENA <<
+				  ICE_AQ_VSI_SEC_TX_PRUNE_ENA_S);
+
+	/* disable VLAN pruning and keep all other settings */
+	ctxt->info.sw_flags2 &= ~ICE_AQ_VSI_SW_FLAG_RX_VLAN_PRUNE_ENA;
+
+	/* allow all VLANs on Tx and don't strip on Rx */
+	ctxt->info.vlan_flags = ICE_AQ_VSI_VLAN_MODE_ALL |
+		ICE_AQ_VSI_VLAN_EMOD_NOTHING;
+
+	status = ice_update_vsi(hw, vsi->idx, ctxt, NULL);
+	if (status) {
+		dev_err(ice_pf_to_dev(vsi->back), "Failed to update VSI for safe mode VLANs, err %s aq_err %s\n",
+			ice_stat_str(status),
+			ice_aq_str(hw->adminq.sq_last_status));
+	} else {
+		vsi->info.sec_flags = ctxt->info.sec_flags;
+		vsi->info.sw_flags2 = ctxt->info.sw_flags2;
+		vsi->info.vlan_flags = ctxt->info.vlan_flags;
+	}
+
+	kfree(ctxt);
+}
+
 /**
  * ice_log_pkg_init - log result of DDP package load
  * @hw: pointer to hardware info
@@ -3996,9 +4050,10 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	/* Disable WoL at init, wait for user to enable */
 	device_set_wakeup_enable(dev, false);
 
-	/* If no DDP driven features have to be setup, we are done with probe */
-	if (ice_is_safe_mode(pf))
+	if (ice_is_safe_mode(pf)) {
+		ice_set_safe_mode_vlan_cfg(pf);
 		goto probe_done;
+	}
 
 	/* initialize DDP driven features */
 
-- 
2.20.1

