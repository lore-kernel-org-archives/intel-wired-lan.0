From: Alice Michael <alice.michael@intel.com>
Date: Thu, 13 Apr 2017 04:45:52 -0400
Subject: [Intel-wired-lan] [next PATCH S70 09/12] i40e: reset all VFs in
	parallel when rebuilding PF
In-Reply-To: <20170413084555.6962-1-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
Message-ID: <20170413084555.6962-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

When there are a lot of active VFs, it can take multiple seconds to
finish resetting all of them during certain flows., which can cause some
VFs to fail to wait long enough for the reset to occur. The user might
see messages like "Never saw reset" or "Reset never finished" and the VF
driver will stop functioning properly.

The naive solution would be to simply increase the wait timer. We can
get much more clever. Notice that i40e_reset_vf is run in a serialized
fashion, and includes lots of delays.

There are two prominent delays which take most of the time. First, when
we begin resetting VFs, we have multiple 10ms delays which accrue
because we reset each VF in a serial fashion. These delays accumulate to
almost 4 seconds when handling the maximum number of VFs (128).

Secondly, there is a massive 50ms delay for each time we disable queues
on a VSI. This delay is necessary to allow HW to finish disabling queues
before we restore functionality. However, just like with the first case,
we are paying the cost for each VF, rather than disabling all VFs and
waiting once.

Both of these can be fixed, but required some previous refactoring to
handle the special case. First, we will need the
i40e_vsi_wait_queues_disabled function which was previously DCB
specific. Second, we will need to implement our own
i40e_vsi_stop_rings_no_wait function which will handle the stopping of
rings without the delays.

Finally, implement an i40e_reset_all_vfs function, which will first
start the reset of all VFs, and pay the wait cost all at once, rather
than serially waiting for each VF before we start processing then next
one. After the VF has been reset, we'll disable all the VF queues, and
then wait for them to disable. Again, we'll organize the flow such that
we pay the wait cost only once.

Finally, after we've disabled queues we'll go ahead and begin restoring
VF functionality. The result is reducing the wait time by a large factor
and ensuring that VFs do not timeout when waiting in the VF driver.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: Ia6e8cf8d98131b78aec89db78afb8d905c9b12be
---
Testing-hints:
  "time echo 1 > /sys/class/net/<enpX>/device/reset" will trigger
  a request for a reset in the driver. I used the "time" command to
  measure how long it took for the reset to finish.

 drivers/net/ethernet/intel/i40e/i40e.h             |   2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  32 +++++--
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 100 +++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   1 +
 4 files changed, 129 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index a33a733..d35fec3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -903,6 +903,8 @@ void i40e_notify_client_of_vf_msg(struct i40e_vsi *vsi, u32 vf_id,
 
 int i40e_vsi_start_rings(struct i40e_vsi *vsi);
 void i40e_vsi_stop_rings(struct i40e_vsi *vsi);
+void i40e_vsi_stop_rings_no_wait(struct  i40e_vsi *vsi);
+int i40e_vsi_wait_queues_disabled(struct i40e_vsi *vsi);
 int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count);
 struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags, u16 uplink_seid,
 				u16 downlink_seid, u8 enabled_tc);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ebf2ad4..7ceb256 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4159,6 +4159,29 @@ void i40e_vsi_stop_rings(struct i40e_vsi *vsi)
 }
 
 /**
+ * i40e_vsi_stop_rings_no_wait - Stop a VSI's rings and do not delay
+ * @vsi: the VSI being shutdown
+ *
+ * This function stops all the rings for a VSI but does not delay to verify
+ * that rings have been disabled. It is expected that the caller is shutting
+ * down multiple VSIs at once and will delay together for all the VSIs after
+ * initiating the shutdown. This is particularly useful for shutting down lots
+ * of VFs together. Otherwise, a large delay can be incurred while configuring
+ * each VSI in serial.
+ **/
+void i40e_vsi_stop_rings_no_wait(struct i40e_vsi *vsi)
+{
+	struct i40e_pf *pf = vsi->back;
+	int i, pf_q;
+
+	pf_q = vsi->base_queue;
+	for (i = 0; i < vsi->num_queue_pairs; i++, pf_q++) {
+		i40e_control_tx_q(pf, pf_q, false);
+		i40e_control_rx_q(pf, pf_q, false);
+	}
+}
+
+/**
  * i40e_vsi_free_irq - Free the irq association with the OS
  * @vsi: the VSI being configured
  **/
@@ -4488,14 +4511,13 @@ static void i40e_pf_unquiesce_all_vsi(struct i40e_pf *pf)
 	}
 }
 
-#ifdef CONFIG_I40E_DCB
 /**
  * i40e_vsi_wait_queues_disabled - Wait for VSI's queues to be disabled
  * @vsi: the VSI being configured
  *
  * Wait until all queues on a given VSI have been disabled.
  **/
-static int i40e_vsi_wait_queues_disabled(struct i40e_vsi *vsi)
+int i40e_vsi_wait_queues_disabled(struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = vsi->back;
 	int i, pf_q, ret;
@@ -4523,6 +4545,7 @@ static int i40e_vsi_wait_queues_disabled(struct i40e_vsi *vsi)
 	return 0;
 }
 
+#ifdef CONFIG_I40E_DCB
 /**
  * i40e_pf_wait_queues_disabled - Wait for all queues of PF VSIs to be disabled
  * @pf: the PF
@@ -7194,10 +7217,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	if (!lock_acquired)
 		rtnl_unlock();
 
-	if (pf->num_alloc_vfs) {
-		for (v = 0; v < pf->num_alloc_vfs; v++)
-			i40e_reset_vf(&pf->vf[v], true);
-	}
+	i40e_reset_all_vfs(pf, true);
 
 	/* tell the firmware that we're starting */
 	i40e_send_version(pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index a09c2b3..423068a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1076,6 +1076,106 @@ void i40e_reset_vf(struct i40e_vf *vf, bool flr)
 }
 
 /**
+ * i40e_reset_all_vfs
+ * @pf: pointer to the PF structure
+ * @flr: VFLR was issued or not
+ *
+ * Reset all allocated VFs in one go. First, tell the hardware to reset each
+ * VF, then do all the waiting in one chunk, and finally finish restoring each
+ * VF after the wait. This is useful during PF routines which need to reset
+ * all VFs, as otherwise it must perform these resets in a serialized fashion.
+ **/
+void i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
+{
+	struct i40e_hw *hw = &pf->hw;
+	struct i40e_vf *vf;
+	int i, v;
+	u32 reg;
+
+	/* If we don't have any VFs, then there is nothing to reset */
+	if (!pf->num_alloc_vfs)
+		return;
+
+	/* If VFs have been disabled, there is no need to reset */
+	if (test_and_set_bit(__I40E_VF_DISABLE, &pf->state))
+		return;
+
+	/* Begin reset on all VFs at once */
+	for (v = 0; v < pf->num_alloc_vfs; v++)
+		i40e_trigger_vf_reset(&pf->vf[v], flr);
+
+	/* HW requires some time to make sure it can flush the FIFO for a VF
+	 * when it resets it. Poll the VPGEN_VFRSTAT register for each VF in
+	 * sequence to make sure that it has completed. We'll keep track of
+	 * the VFs using a simple iterator that increments once that VF has
+	 * finished resetting.
+	 */
+	for (i = 0, v = 0; i < 10 && v < pf->num_alloc_vfs; i++) {
+		usleep_range(10000, 20000);
+
+		/* Check each VF in sequence, beginning with the VF to fail
+		 * the previous check.
+		 */
+		while (v < pf->num_alloc_vfs) {
+			vf = &pf->vf[v];
+			reg = rd32(hw, I40E_VPGEN_VFRSTAT(vf->vf_id));
+			if (!(reg & I40E_VPGEN_VFRSTAT_VFRD_MASK))
+				break;
+
+			/* If the current VF has finished resetting, move on
+			 * to the next VF in sequence.
+			 */
+			v++;
+		}
+	}
+
+	if (flr)
+		usleep_range(10000, 20000);
+
+	/* Display a warning if at least one VF didn't manage to reset in
+	 * time, but continue on with the operation.
+	 */
+	if (v < pf->num_alloc_vfs)
+		dev_err(&pf->pdev->dev, "VF reset check timeout on VF %d\n",
+			pf->vf[v].vf_id);
+	usleep_range(10000, 20000);
+
+	/* Begin disabling all the rings associated with VFs, but do not wait
+	 * between each VF.
+	 */
+	for (v = 0; v < pf->num_alloc_vfs; v++) {
+		/* On initial reset, we don't have any queues to disable */
+		if (pf->vf[v].lan_vsi_idx == 0)
+			continue;
+
+		i40e_vsi_stop_rings_no_wait(pf->vsi[pf->vf[v].lan_vsi_idx]);
+	}
+
+	/* Now that we've notified HW to disable all of the VF rings, wait
+	 * until they finish.
+	 */
+	for (v = 0; v < pf->num_alloc_vfs; v++) {
+		/* On initial reset, we don't have any queues to disable */
+		if (pf->vf[v].lan_vsi_idx == 0)
+			continue;
+
+		i40e_vsi_wait_queues_disabled(pf->vsi[pf->vf[v].lan_vsi_idx]);
+	}
+
+	/* Hw may need up to 50ms to finish disabling the RX queues. We
+	 * minimize the wait by delaying only once for all VFs.
+	 */
+	mdelay(50);
+
+	/* Finish the reset on each VF */
+	for (v = 0; v < pf->num_alloc_vfs; v++)
+		i40e_cleanup_reset_vf(&pf->vf[v]);
+
+	i40e_flush(hw);
+	clear_bit(__I40E_VF_DISABLE, &pf->state);
+}
+
+/**
  * i40e_free_vfs
  * @pf: pointer to the PF structure
  *
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 3e1f8f6..f76d234 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -130,6 +130,7 @@ int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
 			   u32 v_retval, u8 *msg, u16 msglen);
 int i40e_vc_process_vflr_event(struct i40e_pf *pf);
 void i40e_reset_vf(struct i40e_vf *vf, bool flr);
+void i40e_reset_all_vfs(struct i40e_pf *pf, bool flr);
 void i40e_vc_notify_vf_reset(struct i40e_vf *vf);
 
 /* VF configuration related iplink handlers */
-- 
2.9.3

