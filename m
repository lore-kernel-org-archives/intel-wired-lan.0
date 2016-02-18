From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Wed, 17 Feb 2016 16:12:15 -0800
Subject: [Intel-wired-lan] [next PATCH S29 05/14] i40e: Do not wait for Rx
	queue disable in DCB reconfig
In-Reply-To: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1455754344-6372-6-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Neerav Parikh <neerav.parikh@intel.com>

Just like Tx queues don't wait for Rx queues to be disabled before
DCB has been reconfigured.
Check the queues are disabled only after the DCB configuration has
been applied to the VSI(s) managed by the PF driver.

In case of any timeout issue a PF reset to recover.

Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
Change-ID: Ic51e94c25baf9a5480cee983f35d15575a88642c
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 33 +++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8919dc7..3c658a29 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3929,6 +3929,9 @@ static int i40e_vsi_control_rx(struct i40e_vsi *vsi, bool enable)
 		else
 			rx_reg &= ~I40E_QRX_ENA_QENA_REQ_MASK;
 		wr32(hw, I40E_QRX_ENA(pf_q), rx_reg);
+		/* No waiting for the Tx queue to disable */
+		if (!enable && test_bit(__I40E_PORT_TX_SUSPENDED, &pf->state))
+			continue;
 
 		/* wait for the change to finish */
 		ret = i40e_pf_rxq_wait(pf, pf_q, enable);
@@ -4287,12 +4290,12 @@ static void i40e_pf_unquiesce_all_vsi(struct i40e_pf *pf)
 
 #ifdef CONFIG_I40E_DCB
 /**
- * i40e_vsi_wait_txq_disabled - Wait for VSI's queues to be disabled
+ * i40e_vsi_wait_queues_disabled - Wait for VSI's queues to be disabled
  * @vsi: the VSI being configured
  *
- * This function waits for the given VSI's Tx queues to be disabled.
+ * This function waits for the given VSI's queues to be disabled.
  **/
-static int i40e_vsi_wait_txq_disabled(struct i40e_vsi *vsi)
+static int i40e_vsi_wait_queues_disabled(struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = vsi->back;
 	int i, pf_q, ret;
@@ -4309,24 +4312,36 @@ static int i40e_vsi_wait_txq_disabled(struct i40e_vsi *vsi)
 		}
 	}
 
+	pf_q = vsi->base_queue;
+	for (i = 0; i < vsi->num_queue_pairs; i++, pf_q++) {
+		/* Check and wait for the disable status of the queue */
+		ret = i40e_pf_rxq_wait(pf, pf_q, false);
+		if (ret) {
+			dev_info(&pf->pdev->dev,
+				 "VSI seid %d Rx ring %d disable timeout\n",
+				 vsi->seid, pf_q);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
 /**
- * i40e_pf_wait_txq_disabled - Wait for all queues of PF VSIs to be disabled
+ * i40e_pf_wait_queues_disabled - Wait for all queues of PF VSIs to be disabled
  * @pf: the PF
  *
- * This function waits for the Tx queues to be in disabled state for all the
+ * This function waits for the queues to be in disabled state for all the
  * VSIs that are managed by this PF.
  **/
-static int i40e_pf_wait_txq_disabled(struct i40e_pf *pf)
+static int i40e_pf_wait_queues_disabled(struct i40e_pf *pf)
 {
 	int v, ret = 0;
 
 	for (v = 0; v < pf->hw.func_caps.num_vsis; v++) {
 		/* No need to wait for FCoE VSI queues */
 		if (pf->vsi[v] && pf->vsi[v]->type != I40E_VSI_FCOE) {
-			ret = i40e_vsi_wait_txq_disabled(pf->vsi[v]);
+			ret = i40e_vsi_wait_queues_disabled(pf->vsi[v]);
 			if (ret)
 				break;
 		}
@@ -5722,8 +5737,8 @@ static int i40e_handle_lldp_event(struct i40e_pf *pf,
 	if (ret)
 		goto exit;
 
-	/* Wait for the PF's Tx queues to be disabled */
-	ret = i40e_pf_wait_txq_disabled(pf);
+	/* Wait for the PF's queues to be disabled */
+	ret = i40e_pf_wait_queues_disabled(pf);
 	if (ret) {
 		/* Schedule PF reset to recover */
 		set_bit(__I40E_PF_RESET_REQUESTED, &pf->state);
-- 
2.1.0

