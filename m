From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 31 Jul 2018 21:04:33 -0700
Subject: [Intel-wired-lan] [PATCH v2 13/13] ice: Introduce SERVICE_DIS flag
 and service routine functions
In-Reply-To: <20180801040433.5865-1-anirudh.venkataramanan@intel.com>
References: <20180801040433.5865-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180801040433.5865-14-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

This patch introduces SERVICE_DIS flag to use for stopping service task.
This flag will be checked before scheduling new tasks. Also add new
functions ice_service_task_stop to stop service task.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c | 34 ++++++++++++++++++-----
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 6f44a850c4b2..9cf233d085d8 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -138,6 +138,7 @@ enum ice_state {
 	__ICE_FLTR_OVERFLOW_PROMISC,
 	__ICE_CFG_BUSY,
 	__ICE_SERVICE_SCHED,
+	__ICE_SERVICE_DIS,
 	__ICE_STATE_NBITS		/* must be last */
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index bcc163bf3137..2276b4c49aad 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1107,7 +1107,7 @@ static void ice_clean_adminq_subtask(struct ice_pf *pf)
  */
 static void ice_service_task_schedule(struct ice_pf *pf)
 {
-	if (!test_bit(__ICE_DOWN, pf->state) &&
+	if (!test_bit(__ICE_SERVICE_DIS, pf->state) &&
 	    !test_and_set_bit(__ICE_SERVICE_SCHED, pf->state) &&
 	    !test_bit(__ICE_NEEDS_RESTART, pf->state))
 		queue_work(ice_wq, &pf->serv_task);
@@ -1126,6 +1126,22 @@ static void ice_service_task_complete(struct ice_pf *pf)
 	clear_bit(__ICE_SERVICE_SCHED, pf->state);
 }
 
+/**
+ * ice_service_task_stop - stop service task and cancel works
+ * @pf: board private structure
+ */
+static void ice_service_task_stop(struct ice_pf *pf)
+{
+	set_bit(__ICE_SERVICE_DIS, pf->state);
+
+	if (pf->serv_tmr.function)
+		del_timer_sync(&pf->serv_tmr);
+	if (pf->serv_task.func)
+		cancel_work_sync(&pf->serv_task);
+
+	clear_bit(__ICE_SERVICE_SCHED, pf->state);
+}
+
 /**
  * ice_service_timer - timer callback to schedule service task
  * @t: pointer to timer_list
@@ -3387,10 +3403,7 @@ static void ice_determine_q_usage(struct ice_pf *pf)
  */
 static void ice_deinit_pf(struct ice_pf *pf)
 {
-	if (pf->serv_tmr.function)
-		del_timer_sync(&pf->serv_tmr);
-	if (pf->serv_task.func)
-		cancel_work_sync(&pf->serv_task);
+	ice_service_task_stop(pf);
 	mutex_destroy(&pf->sw_mutex);
 	mutex_destroy(&pf->avail_q_mutex);
 }
@@ -3597,6 +3610,8 @@ static int ice_probe(struct pci_dev *pdev,
 	pf->pdev = pdev;
 	pci_set_drvdata(pdev, pf);
 	set_bit(__ICE_DOWN, pf->state);
+	/* Disable service task until DOWN bit is cleared */
+	set_bit(__ICE_SERVICE_DIS, pf->state);
 
 	hw = &pf->hw;
 	hw->hw_addr = pcim_iomap_table(pdev)[ICE_BAR0];
@@ -3654,6 +3669,9 @@ static int ice_probe(struct pci_dev *pdev,
 		goto err_init_interrupt_unroll;
 	}
 
+	/* Driver is mostly up */
+	clear_bit(__ICE_DOWN, pf->state);
+
 	/* In case of MSIX we are going to setup the misc vector right here
 	 * to handle admin queue events etc. In case of legacy and MSI
 	 * the misc functionality and queue processing is combined in
@@ -3693,8 +3711,7 @@ static int ice_probe(struct pci_dev *pdev,
 		goto err_alloc_sw_unroll;
 	}
 
-	/* Driver is mostly up */
-	clear_bit(__ICE_DOWN, pf->state);
+	clear_bit(__ICE_SERVICE_DIS, pf->state);
 
 	/* since everything is good, start the service timer */
 	mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
@@ -3708,6 +3725,7 @@ static int ice_probe(struct pci_dev *pdev,
 	return 0;
 
 err_alloc_sw_unroll:
+	set_bit(__ICE_SERVICE_DIS, pf->state);
 	set_bit(__ICE_DOWN, pf->state);
 	devm_kfree(&pf->pdev->dev, pf->first_sw);
 err_msix_misc_unroll:
@@ -3735,6 +3753,7 @@ static void ice_remove(struct pci_dev *pdev)
 		return;
 
 	set_bit(__ICE_DOWN, pf->state);
+	ice_service_task_stop(pf);
 
 	ice_vsi_release_all(pf);
 	ice_free_irq_msix_misc(pf);
@@ -5999,6 +6018,7 @@ static void ice_tx_timeout(struct net_device *netdev)
 		netdev_err(netdev, "tx_timeout recovery unsuccessful, device is in unrecoverable state.\n");
 		set_bit(__ICE_DOWN, pf->state);
 		set_bit(__ICE_NEEDS_RESTART, vsi->state);
+		set_bit(__ICE_SERVICE_DIS, pf->state);
 		break;
 	}
 
-- 
2.17.1

