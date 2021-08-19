From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Thu, 19 Aug 2021 08:47:58 +0000
Subject: [Intel-wired-lan] [PATCH net-next v6 3/3] iavf: Fix init and
 watchdog state machines
Message-ID: <20210819084758.2657-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use single state machine for driver initialization
and for service initialized driver. The init state machine implemented in
init_task() is merged into the watchdog_task(). The init_task() function is
removed.

Testing-Hints: Change is only for VF driver state machine,
               should be checked load/unload/reset and
               set/get driver parameters.

Fixes: bac8486116b0 ("iavf: Refactor the watchdog state machine")
Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
v6: Fixed that patch so that it applies on next-queue tree
v5: Fixed the patch so that it applies on net-next tree
v4: Removed unnecessary line
v3: Added new file to patch series
v2: Splitted the patch into 2 to make them smaller
---
 drivers/net/ethernet/intel/iavf/iavf.h      |   1 -
 drivers/net/ethernet/intel/iavf/iavf_main.c | 136 ++++++++------------
 2 files changed, 57 insertions(+), 80 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index d7f8026..b175f77 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -228,7 +228,6 @@ struct iavf_adapter {
 	struct work_struct reset_task;
 	struct work_struct adminq_task;
 	struct delayed_work client_task;
-	struct delayed_work init_task;
 	wait_queue_head_t down_waitqueue;
 	struct iavf_q_vector *q_vectors;
 	struct list_head vlan_filter_list;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index ce8b002..e3c5c9f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1965,7 +1965,48 @@ static void iavf_watchdog_task(struct work_struct *work)
 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
 		iavf_change_state(adapter, __IAVF_COMM_FAILED);
 
+	if (adapter->flags & IAVF_FLAG_RESET_NEEDED &&
+	    adapter->state != __IAVF_RESETTING) {
+		iavf_change_state(adapter, __IAVF_RESETTING);
+		adapter->aq_required = 0;
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+	}
+
 	switch (adapter->state) {
+	case __IAVF_STARTUP:
+		iavf_startup(adapter);
+		mutex_unlock(&adapter->crit_lock);
+		queue_delayed_work(iavf_wq, &adapter->watchdog_task,
+				   msecs_to_jiffies(30));
+		return;
+	case __IAVF_INIT_VERSION_CHECK:
+		iavf_init_version_check(adapter);
+		mutex_unlock(&adapter->crit_lock);
+		queue_delayed_work(iavf_wq, &adapter->watchdog_task,
+				   msecs_to_jiffies(30));
+		return;
+	case __IAVF_INIT_GET_RESOURCES:
+		iavf_init_get_resources(adapter);
+		mutex_unlock(&adapter->crit_lock);
+		queue_delayed_work(iavf_wq, &adapter->watchdog_task,
+				   msecs_to_jiffies(1));
+		return;
+	case __IAVF_INIT_FAILED:
+		if (++adapter->aq_wait_count > IAVF_AQ_MAX_ERR) {
+			dev_err(&adapter->pdev->dev,
+				"Failed to communicate with PF; waiting before retry\n");
+			adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
+			iavf_shutdown_adminq(hw);
+			mutex_unlock(&adapter->crit_lock);
+			queue_delayed_work(iavf_wq,
+					   &adapter->watchdog_task, (5 * HZ));
+			return;
+		}
+		/* Try again from failed step*/
+		iavf_change_state(adapter, adapter->last_state);
+		mutex_unlock(&adapter->crit_lock);
+		queue_delayed_work(iavf_wq, &adapter->watchdog_task, HZ);
+		return;
 	case __IAVF_COMM_FAILED:
 		reg_val = rd32(hw, IAVF_VFGEN_RSTAT) &
 			  IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
@@ -1974,16 +2015,12 @@ static void iavf_watchdog_task(struct work_struct *work)
 			/* A chance for redemption! */
 			dev_err(&adapter->pdev->dev,
 				"Hardware came out of reset. Attempting reinit.\n");
-			iavf_change_state(adapter, __IAVF_STARTUP);
-			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
-			queue_delayed_work(iavf_wq, &adapter->init_task, 10);
-			mutex_unlock(&adapter->crit_lock);
-			/* Don't reschedule the watchdog, since we've restarted
-			 * the init task. When init_task contacts the PF and
+			/* When init task contacts the PF and
 			 * gets everything set up again, it'll restart the
 			 * watchdog for us. Down, boy. Sit. Stay. Woof.
 			 */
-			return;
+			iavf_change_state(adapter, __IAVF_STARTUP);
+			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
 		}
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
@@ -1991,7 +2028,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 		queue_delayed_work(iavf_wq,
 				   &adapter->watchdog_task,
 				   msecs_to_jiffies(10));
-		goto watchdog_done;
+		return;
 	case __IAVF_RESETTING:
 		mutex_unlock(&adapter->crit_lock);
 		queue_delayed_work(iavf_wq, &adapter->watchdog_task, HZ * 2);
@@ -2014,12 +2051,14 @@ static void iavf_watchdog_task(struct work_struct *work)
 			    adapter->state == __IAVF_RUNNING)
 				iavf_request_stats(adapter);
 		}
+		if (adapter->state == __IAVF_RUNNING)
+			iavf_detect_recover_hung(&adapter->vsi);
 		break;
 	case __IAVF_REMOVE:
 		mutex_unlock(&adapter->crit_lock);
 		return;
 	default:
-		goto restart_watchdog;
+		return;
 	}
 
 	/* check for hw reset */
@@ -2031,22 +2070,21 @@ static void iavf_watchdog_task(struct work_struct *work)
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
 		queue_work(iavf_wq, &adapter->reset_task);
-		goto watchdog_done;
+		mutex_unlock(&adapter->crit_lock);
+		queue_delayed_work(iavf_wq,
+				   &adapter->watchdog_task, HZ * 2);
+		return;
 	}
 
 	schedule_delayed_work(&adapter->client_task, msecs_to_jiffies(5));
-watchdog_done:
-	if (adapter->state == __IAVF_RUNNING ||
-	    adapter->state == __IAVF_COMM_FAILED)
-		iavf_detect_recover_hung(&adapter->vsi);
 	mutex_unlock(&adapter->crit_lock);
 restart_watchdog:
+	queue_work(iavf_wq, &adapter->adminq_task);
 	if (adapter->aq_required)
 		queue_delayed_work(iavf_wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(20));
 	else
 		queue_delayed_work(iavf_wq, &adapter->watchdog_task, HZ * 2);
-	queue_work(iavf_wq, &adapter->adminq_task);
 }
 
 static void iavf_disable_vf(struct iavf_adapter *adapter)
@@ -2333,6 +2371,8 @@ static void iavf_reset_task(struct work_struct *work)
 reset_err:
 	mutex_unlock(&adapter->client_lock);
 	mutex_unlock(&adapter->crit_lock);
+	if (running)
+		iavf_change_state(adapter, __IAVF_RUNNING);
 	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
 	iavf_close(netdev);
 }
@@ -3666,67 +3706,6 @@ int iavf_process_config(struct iavf_adapter *adapter)
 	return 0;
 }
 
-/**
- * iavf_init_task - worker thread to perform delayed initialization
- * @work: pointer to work_struct containing our data
- *
- * This task completes the work that was begun in probe. Due to the nature
- * of VF-PF communications, we may need to wait tens of milliseconds to get
- * responses back from the PF. Rather than busy-wait in probe and bog down the
- * whole system, we'll do it in a task so we can sleep.
- * This task only runs during driver init. Once we've established
- * communications with the PF driver and set up our netdev, the watchdog
- * takes over.
- **/
-static void iavf_init_task(struct work_struct *work)
-{
-	struct iavf_adapter *adapter = container_of(work,
-						    struct iavf_adapter,
-						    init_task.work);
-	struct iavf_hw *hw = &adapter->hw;
-
-	if (iavf_lock_timeout(&adapter->crit_lock, 5000)) {
-		dev_warn(&adapter->pdev->dev, "failed to acquire crit_lock in %s\n", __FUNCTION__);
-		return;
-	}
-	switch (adapter->state) {
-	case __IAVF_STARTUP:
-		iavf_startup(adapter);
-		if (adapter->state == __IAVF_INIT_FAILED)
-			goto init_failed;
-		break;
-	case __IAVF_INIT_VERSION_CHECK:
-		iavf_init_version_check(adapter);
-		if (adapter->state == __IAVF_INIT_FAILED)
-			goto init_failed;
-		break;
-	case __IAVF_INIT_GET_RESOURCES:
-		iavf_init_get_resources(adapter);
-		if (adapter->state == __IAVF_INIT_FAILED)
-			goto init_failed;
-		goto out;
-	default:
-		goto init_failed;
-	}
-
-	queue_delayed_work(iavf_wq, &adapter->init_task,
-			   msecs_to_jiffies(30));
-	goto out;
-init_failed:
-	if (++adapter->aq_wait_count > IAVF_AQ_MAX_ERR) {
-		dev_err(&adapter->pdev->dev,
-			"Failed to communicate with PF; waiting before retry\n");
-		adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
-		iavf_shutdown_adminq(hw);
-		iavf_change_state(adapter, __IAVF_STARTUP);
-		queue_delayed_work(iavf_wq, &adapter->init_task, HZ * 5);
-		goto out;
-	}
-	queue_delayed_work(iavf_wq, &adapter->init_task, HZ);
-out:
-	mutex_unlock(&adapter->crit_lock);
-}
-
 /**
  * iavf_shutdown - Shutdown the device in preparation for a reboot
  * @pdev: pci device structure
@@ -3861,8 +3840,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&adapter->adminq_task, iavf_adminq_task);
 	INIT_DELAYED_WORK(&adapter->watchdog_task, iavf_watchdog_task);
 	INIT_DELAYED_WORK(&adapter->client_task, iavf_client_task);
-	INIT_DELAYED_WORK(&adapter->init_task, iavf_init_task);
-	queue_delayed_work(iavf_wq, &adapter->init_task,
+	queue_delayed_work(iavf_wq, &adapter->watchdog_task,
 			   msecs_to_jiffies(5 * (pdev->devfn & 0x07)));
 
 	/* Setup the wait queue for indicating transition to down status */
@@ -3968,8 +3946,8 @@ static void iavf_remove(struct pci_dev *pdev)
 	int err;
 	/* Indicate we are in remove and not to run reset_task */
 	mutex_lock(&adapter->remove_lock);
-	cancel_delayed_work_sync(&adapter->init_task);
 	cancel_work_sync(&adapter->reset_task);
+	cancel_delayed_work_sync(&adapter->watchdog_task);
 	cancel_delayed_work_sync(&adapter->client_task);
 	if (adapter->netdev_registered) {
 		unregister_netdev(netdev);
-- 
2.17.1

