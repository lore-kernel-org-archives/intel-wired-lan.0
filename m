From: Sornek, Karen <karen.sornek@intel.com>
Date: Fri, 17 Dec 2021 08:32:16 +0100
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix reset path while
 removing the driver
Message-ID: <20211217073216.257633-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Karen Sornek <karen.sornek@intel.com>

Fix the crash in kernel while dereferencing the NULL pointer,
when the driver is unloaded and simultaneously the vsi rings
are being stopped.

The hardware requires 50msec in order to finish RX queues
disable. For this purpose the driver spins in mdelay function
for the operation to be completed.

For example changing number of queues which requires reset would
fail in the following call stack:

1) i40e_prep_for_reset
2) i40e_pf_quiesce_all_vsi
3) i40e_quiesce_vsi
4) i40e_vsi_close
5) i40e_down
6) i40e_vsi_stop_rings
7) i40e_vsi_control_rx -> disable requires the delay of 50msecs
8) continue back in i40e_down function where
   i40e_clean_tx_ring(vsi->tx_rings[i]) is going to crash

When the driver was spinning vsi_release called
i40e_vsi_free_arrays where the vsi->tx_rings resources
were freed and the pointer was set to NULL.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Karen Sornek <karen.sornek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 8b2edacb0a30..707805c339f6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -144,6 +144,7 @@ enum i40e_state_t {
 	__I40E_VIRTCHNL_OP_PENDING,
 	__I40E_RECOVERY_MODE,
 	__I40E_VF_RESETS_DISABLED,	/* disable resets during i40e_remove */
+	__I40E_IN_REMOVE,
 	__I40E_VFS_RELEASING,
 	/* This must be last as it determines the size of the BITMAP */
 	__I40E_STATE_SIZE__,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5e01875c7961..a850a75adc69 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10763,6 +10763,9 @@ static void i40e_reset_and_rebuild(struct i40e_pf *pf, bool reinit,
 				   bool lock_acquired)
 {
 	int ret;
+
+	if (test_bit(__I40E_IN_REMOVE, pf->state))
+		return;
 	/* Now we wait for GRST to settle out.
 	 * We don't have to delete the VEBs or VSIs from the hw switch
 	 * because the reset will make them disappear.
@@ -12122,6 +12125,8 @@ int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count)
 
 		vsi->req_queue_pairs = queue_count;
 		i40e_prep_for_reset(pf);
+		if (test_bit(__I40E_IN_REMOVE, pf->state))
+			return pf->alloc_rss_size;
 
 		pf->alloc_rss_size = new_rss_size;
 
@@ -12948,6 +12953,10 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
 	if (need_reset)
 		i40e_prep_for_reset(pf);
 
+	/* VSI shall be deleted in a moment, just return EINVAL */
+	if (test_bit(__I40E_IN_REMOVE, pf->state))
+		return -EINVAL;
+
 	old_prog = xchg(&vsi->xdp_prog, prog);
 
 	if (need_reset) {
@@ -16035,6 +16044,9 @@ static void i40e_pci_error_reset_done(struct pci_dev *pdev)
 {
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
 
+	if (test_bit(__I40E_IN_REMOVE, pf->state))
+		return;
+
 	i40e_reset_and_rebuild(pf, false, false);
 }
 
-- 
2.27.0

