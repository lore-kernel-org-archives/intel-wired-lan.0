From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Apr 2017 13:38:04 -0700
Subject: [Intel-wired-lan] [PATCH] fixup! i40e: separate PF and VSI state
	flags
Message-ID: <20170421203805.11445-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This can be squashed into 1a9768597ef7 ("i40e: separate PF and VSI state
flags", 2017-04-21) and resolves some incorrect changes to the pf->state
flags in that commit.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
I provided this as a convenience to see the interdiff between the two
versions of the patch. For this to apply you will have one rebase
conflict due to the following patch where we use DECLARE_BITMAP which
you need to resolve, the solution is make sure that we still dont' use
__I40E_VSI_DOWN with pf->state.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 38 ++++++++++++++---------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 55bce4110773..c30f2bc65451 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -295,7 +295,7 @@ struct i40e_vsi *i40e_find_vsi_from_id(struct i40e_pf *pf, u16 id)
  **/
 void i40e_service_event_schedule(struct i40e_pf *pf)
 {
-	if (!test_bit(__I40E_VSI_DOWN, &pf->state) &&
+	if (!test_bit(__I40E_DOWN, &pf->state) &&
 	    !test_bit(__I40E_RESET_RECOVERY_PENDING, &pf->state))
 		queue_work(i40e_wq, &pf->service_task);
 }
@@ -3611,7 +3611,7 @@ static irqreturn_t i40e_intr(int irq, void *data)
 		 * this is not a performance path and napi_schedule()
 		 * can deal with rescheduling.
 		 */
-		if (!test_bit(__I40E_VSI_DOWN, &pf->state))
+		if (!test_bit(__I40E_DOWN, &pf->state))
 			napi_schedule_irqoff(&q_vector->napi);
 	}
 
@@ -3687,7 +3687,7 @@ static irqreturn_t i40e_intr(int irq, void *data)
 enable_intr:
 	/* re-enable interrupt causes */
 	wr32(hw, I40E_PFINT_ICR0_ENA, ena_mask);
-	if (!test_bit(__I40E_VSI_DOWN, &pf->state)) {
+	if (!test_bit(__I40E_DOWN, &pf->state)) {
 		i40e_service_event_schedule(pf);
 		i40e_irq_dynamic_enable_icr0(pf, false);
 	}
@@ -5790,7 +5790,7 @@ void i40e_do_reset(struct i40e_pf *pf, u32 reset_flags, bool lock_acquired)
 					       &vsi->state))
 				i40e_vsi_reinit_locked(pf->vsi[v]);
 		}
-	} else if (reset_flags & BIT_ULL(__I40E_VSI_DOWN_REQUESTED)) {
+	} else if (reset_flags & BIT_ULL(__I40E_DOWN_REQUESTED)) {
 		int v;
 
 		/* Find the VSI(s) that needs to be brought down */
@@ -6204,7 +6204,7 @@ static void i40e_fdir_reinit_subtask(struct i40e_pf *pf)
 {
 
 	/* if interface is down do nothing */
-	if (test_bit(__I40E_VSI_DOWN, &pf->state))
+	if (test_bit(__I40E_DOWN, &pf->state))
 		return;
 
 	if (test_bit(__I40E_FD_FLUSH_REQUESTED, &pf->state))
@@ -6345,7 +6345,7 @@ static void i40e_watchdog_subtask(struct i40e_pf *pf)
 	int i;
 
 	/* if interface is down do nothing */
-	if (test_bit(__I40E_VSI_DOWN, &pf->state) ||
+	if (test_bit(__I40E_DOWN, &pf->state) ||
 	    test_bit(__I40E_CONFIG_BUSY, &pf->state))
 		return;
 
@@ -6400,9 +6400,9 @@ static void i40e_reset_subtask(struct i40e_pf *pf)
 		reset_flags |= BIT(__I40E_GLOBAL_RESET_REQUESTED);
 		clear_bit(__I40E_GLOBAL_RESET_REQUESTED, &pf->state);
 	}
-	if (test_bit(__I40E_VSI_DOWN_REQUESTED, &pf->state)) {
-		reset_flags |= BIT(__I40E_VSI_DOWN_REQUESTED);
-		clear_bit(__I40E_VSI_DOWN_REQUESTED, &pf->state);
+	if (test_bit(__I40E_DOWN_REQUESTED, &pf->state)) {
+		reset_flags |= BIT(__I40E_DOWN_REQUESTED);
+		clear_bit(__I40E_DOWN_REQUESTED, &pf->state);
 	}
 
 	/* If there's a recovery already waiting, it takes
@@ -6416,7 +6416,7 @@ static void i40e_reset_subtask(struct i40e_pf *pf)
 
 	/* If we're already down or resetting, just bail */
 	if (reset_flags &&
-	    !test_bit(__I40E_VSI_DOWN, &pf->state) &&
+	    !test_bit(__I40E_DOWN, &pf->state) &&
 	    !test_bit(__I40E_CONFIG_BUSY, &pf->state)) {
 		rtnl_lock();
 		i40e_do_reset(pf, reset_flags, true);
@@ -7003,7 +7003,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	u32 val;
 	int v;
 
-	if (test_bit(__I40E_VSI_DOWN, &pf->state))
+	if (test_bit(__I40E_DOWN, &pf->state))
 		goto clear_recovery;
 	dev_dbg(&pf->pdev->dev, "Rebuilding internal switch\n");
 
@@ -9769,7 +9769,7 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
 		return -ENODEV;
 	}
 	if (vsi == pf->vsi[pf->lan_vsi] &&
-	    !test_bit(__I40E_VSI_DOWN, &pf->state)) {
+	    !test_bit(__I40E_DOWN, &pf->state)) {
 		dev_info(&pf->pdev->dev, "Can't remove PF VSI\n");
 		return -ENODEV;
 	}
@@ -11005,7 +11005,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	pf->next_vsi = 0;
 	pf->pdev = pdev;
-	set_bit(__I40E_VSI_DOWN, &pf->state);
+	set_bit(__I40E_DOWN, &pf->state);
 
 	hw = &pf->hw;
 	hw->back = pf;
@@ -11295,7 +11295,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * before setting up the misc vector or we get a race and the vector
 	 * ends up disabled forever.
 	 */
-	clear_bit(__I40E_VSI_DOWN, &pf->state);
+	clear_bit(__I40E_DOWN, &pf->state);
 
 	/* In case of MSIX we are going to setup the misc vector right here
 	 * to handle admin queue events etc. In case of legacy and MSI
@@ -11450,7 +11450,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Unwind what we've done if something failed in the setup */
 err_vsis:
-	set_bit(__I40E_VSI_DOWN, &pf->state);
+	set_bit(__I40E_DOWN, &pf->state);
 	i40e_clear_interrupt_scheme(pf);
 	kfree(pf->vsi);
 err_switch_setup:
@@ -11502,7 +11502,7 @@ static void i40e_remove(struct pci_dev *pdev)
 
 	/* no more scheduling of any task */
 	set_bit(__I40E_SUSPENDED, &pf->state);
-	set_bit(__I40E_VSI_DOWN, &pf->state);
+	set_bit(__I40E_DOWN, &pf->state);
 	if (pf->service_timer.data)
 		del_timer_sync(&pf->service_timer);
 	if (pf->service_task.func)
@@ -11742,7 +11742,7 @@ static void i40e_shutdown(struct pci_dev *pdev)
 	struct i40e_hw *hw = &pf->hw;
 
 	set_bit(__I40E_SUSPENDED, &pf->state);
-	set_bit(__I40E_VSI_DOWN, &pf->state);
+	set_bit(__I40E_DOWN, &pf->state);
 	rtnl_lock();
 	i40e_prep_for_reset(pf, true);
 	rtnl_unlock();
@@ -11791,7 +11791,7 @@ static int i40e_suspend(struct pci_dev *pdev, pm_message_t state)
 	int retval = 0;
 
 	set_bit(__I40E_SUSPENDED, &pf->state);
-	set_bit(__I40E_VSI_DOWN, &pf->state);
+	set_bit(__I40E_DOWN, &pf->state);
 
 	if (pf->wol_en && (pf->flags & I40E_FLAG_WOL_MC_MAGIC_PKT_WAKE))
 		i40e_enable_mc_magic_wake(pf);
@@ -11843,7 +11843,7 @@ static int i40e_resume(struct pci_dev *pdev)
 
 	/* handling the reset will rebuild the device state */
 	if (test_and_clear_bit(__I40E_SUSPENDED, &pf->state)) {
-		clear_bit(__I40E_VSI_DOWN, &pf->state);
+		clear_bit(__I40E_DOWN, &pf->state);
 		rtnl_lock();
 		i40e_reset_and_rebuild(pf, false, true);
 		rtnl_unlock();
-- 
2.12.2.882.g942b4cedeff1.dirty

