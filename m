From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 21 Feb 2017 15:55:48 -0800
Subject: [Intel-wired-lan] [next PATCH S61 10/10] i40e: Drop FCoE code that
	always evaluates to false or 0
In-Reply-To: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1487721348-25617-11-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Since FCoE isn't supported by the i40e products there isn't much point in
carrying around code that will always evaluate to false. This patch goes
through and strips out the code in several spots so that we don't go around
carrying variables and/or code that is always going to evaluate to false or
0.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: I39d1d779c66c638b75525839db2b6208fdc809d7
---
 drivers/net/ethernet/intel/i40e/i40e.h             |  3 ---
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 17 +++--------------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  1 -
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 504fd99..9d76645 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -405,9 +405,6 @@ struct i40e_pf {
 	 */
 	u16 dcbx_cap;
 
-	u32 fcoe_hmc_filt_num;
-	u32 fcoe_hmc_cntx_num;
-
 	struct i40e_filter_control_settings filter_settings;
 
 	struct ptp_clock *ptp_clock;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 909bdd6..384e0d3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4496,14 +4496,6 @@ static void i40e_quiesce_vsi(struct i40e_vsi *vsi)
 	if (test_bit(__I40E_DOWN, &vsi->state))
 		return;
 
-	/* No need to disable FCoE VSI when Tx suspended */
-	if ((test_bit(__I40E_PORT_TX_SUSPENDED, &vsi->back->state)) &&
-	    vsi->type == I40E_VSI_FCOE) {
-		dev_dbg(&vsi->back->pdev->dev,
-			 "VSI seid %d skipping FCoE VSI disable\n", vsi->seid);
-		return;
-	}
-
 	set_bit(__I40E_NEEDS_RESTART, &vsi->state);
 	if (vsi->netdev && netif_running(vsi->netdev))
 		vsi->netdev->netdev_ops->ndo_stop(vsi->netdev);
@@ -4621,8 +4613,7 @@ static int i40e_pf_wait_queues_disabled(struct i40e_pf *pf)
 	int v, ret = 0;
 
 	for (v = 0; v < pf->hw.func_caps.num_vsis; v++) {
-		/* No need to wait for FCoE VSI queues */
-		if (pf->vsi[v] && pf->vsi[v]->type != I40E_VSI_FCOE) {
+		if (pf->vsi[v]) {
 			ret = i40e_vsi_wait_queues_disabled(pf->vsi[v]);
 			if (ret)
 				break;
@@ -7077,8 +7068,7 @@ static void i40e_reset_and_rebuild(struct i40e_pf *pf, bool reinit)
 		goto end_core_reset;
 
 	ret = i40e_init_lan_hmc(hw, hw->func_caps.num_tx_qp,
-				hw->func_caps.num_rx_qp,
-				pf->fcoe_hmc_cntx_num, pf->fcoe_hmc_filt_num);
+				hw->func_caps.num_rx_qp, 0, 0);
 	if (ret) {
 		dev_info(&pf->pdev->dev, "init_lan_hmc failed: %d\n", ret);
 		goto end_core_reset;
@@ -11360,8 +11350,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	err = i40e_init_lan_hmc(hw, hw->func_caps.num_tx_qp,
-				hw->func_caps.num_rx_qp,
-				pf->fcoe_hmc_cntx_num, pf->fcoe_hmc_filt_num);
+				hw->func_caps.num_rx_qp, 0, 0);
 	if (err) {
 		dev_info(&pdev->dev, "init_lan_hmc failed: %d\n", err);
 		goto err_init_lan_hmc;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 52ba9d5..558ddf1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -109,7 +109,6 @@ struct i40e_vf {
 	u16 stag;
 
 	struct i40e_virtchnl_ether_addr default_lan_addr;
-	struct i40e_virtchnl_ether_addr default_fcoe_addr;
 	u16 port_vlan_id;
 	bool pf_set_mac;	/* The VMM admin set the VF MAC address */
 	bool trusted;
-- 
2.4.11

