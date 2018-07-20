From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 20 Jul 2018 13:53:43 -0700
Subject: [Intel-wired-lan] [RFC 03/13] ice: Prevent control queue operations
 during reset
In-Reply-To: <20180720205353.13296-1-anirudh.venkataramanan@intel.com>
References: <20180720205353.13296-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180720205353.13296-4-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Once reset is issued, the driver loses all control queue interfaces.
Exercising control queue operations during reset is incorrect and
may result in long timeouts.

This patch introduces a new field 'reset_ongoing' in the hw structure.
This is set to 1 by the core driver when it receives a reset interrupt.
ice_sq_send_cmd checks reset_ongoing before actually issuing the control
queue operation. If a reset is in progress, it returns a soft error code
(ICE_ERR_RESET_PENDING) to the caller. The caller may or may not have to
take any action based on this return. Once the driver knows that the
reset is done, it has to set reset_ongoing back to 0. This will allow
control queue operations to be posted to the hardware again.

This "bail out" logic was specifically added to ice_sq_send_cmd (which
is pretty low level function) so that we have one solution in one place
that applies to all types of control queues.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c |  3 +++
 drivers/net/ethernet/intel/ice/ice_main.c     | 34 +++++++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_status.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index 62be72fdc8f3..1fe026a65d75 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -806,6 +806,9 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	u16 retval = 0;
 	u32 val = 0;
 
+	/* if reset is in progress return a soft error */
+	if (hw->reset_ongoing)
+		return ICE_ERR_RESET_ONGOING;
 	mutex_lock(&cq->sq_lock);
 
 	cq->sq_last_status = ICE_AQ_RC_OK;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3782569b450a..23bffa3cbf7f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -535,10 +535,13 @@ static void ice_reset_subtask(struct ice_pf *pf)
 		ice_prepare_for_reset(pf);
 
 		/* make sure we are ready to rebuild */
-		if (ice_check_reset(&pf->hw))
+		if (ice_check_reset(&pf->hw)) {
 			set_bit(__ICE_RESET_FAILED, pf->state);
-		else
+		} else {
+			/* done with reset. start rebuild */
+			pf->hw.reset_ongoing = false;
 			ice_rebuild(pf);
+		}
 		clear_bit(__ICE_RESET_RECOVERY_PENDING, pf->state);
 		goto unlock;
 	}
@@ -1752,7 +1755,8 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 		 * We also make note of which reset happened so that peer
 		 * devices/drivers can be informed.
 		 */
-		if (!test_bit(__ICE_RESET_RECOVERY_PENDING, pf->state)) {
+		if (!test_and_set_bit(__ICE_RESET_RECOVERY_PENDING,
+				      pf->state)) {
 			if (reset == ICE_RESET_CORER)
 				set_bit(__ICE_CORER_RECV, pf->state);
 			else if (reset == ICE_RESET_GLOBR)
@@ -1760,7 +1764,20 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 			else
 				set_bit(__ICE_EMPR_RECV, pf->state);
 
-			set_bit(__ICE_RESET_RECOVERY_PENDING, pf->state);
+			/* There are couple of different bits at play here.
+			 * hw->reset_ongoing indicates whether the hardware is
+			 * in reset. This is set to true when a reset interrupt
+			 * is received and set back to false after the driver
+			 * has determined that the hardware is out of reset.
+			 *
+			 * __ICE_RESET_RECOVERY_PENDING in pf->state indicates
+			 * that a post reset rebuild is required before the
+			 * driver is operational again. This is set above.
+			 *
+			 * As this is the start of the reset/rebuild cycle, set
+			 * both to indicate that.
+			 */
+			hw->reset_ongoing = true;
 		}
 	}
 
@@ -4187,7 +4204,14 @@ static int ice_vsi_stop_tx_rings(struct ice_vsi *vsi)
 	}
 	status = ice_dis_vsi_txq(vsi->port_info, vsi->num_txq, q_ids, q_teids,
 				 NULL);
-	if (status) {
+	/* if the disable queue command was exercised during an active reset
+	 * flow, ICE_ERR_RESET_ONGOING is returned. This is not an error as
+	 * the reset operation disables queues at the hardware level anyway.
+	 */
+	if (status == ICE_ERR_RESET_ONGOING) {
+		dev_info(&pf->pdev->dev,
+			 "Reset in progress. LAN Tx queues already disabled\n");
+	} else if (status) {
 		dev_err(&pf->pdev->dev,
 			"Failed to disable LAN Tx queues, error: %d\n",
 			status);
diff --git a/drivers/net/ethernet/intel/ice/ice_status.h b/drivers/net/ethernet/intel/ice/ice_status.h
index 9a95c4ffd7d7..d2dae913d81e 100644
--- a/drivers/net/ethernet/intel/ice/ice_status.h
+++ b/drivers/net/ethernet/intel/ice/ice_status.h
@@ -20,6 +20,7 @@ enum ice_status {
 	ICE_ERR_ALREADY_EXISTS			= -14,
 	ICE_ERR_DOES_NOT_EXIST			= -15,
 	ICE_ERR_MAX_LIMIT			= -17,
+	ICE_ERR_RESET_ONGOING			= -18,
 	ICE_ERR_BUF_TOO_SHORT			= -52,
 	ICE_ERR_NVM_BLANK_MODE			= -53,
 	ICE_ERR_AQ_ERROR			= -100,
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index f5aff99bbb61..bc31d1069cab 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -289,6 +289,7 @@ struct ice_hw {
 	u8 sw_entry_point_layer;
 
 	u8 evb_veb;		/* true for VEB, false for VEPA */
+	u8 reset_ongoing;	/* true if hw is in reset, false otherwise */
 	struct ice_bus_info bus;
 	struct ice_nvm_info nvm;
 	struct ice_hw_dev_caps dev_caps;	/* device capabilities */
-- 
2.14.3

