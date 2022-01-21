From: Sokolowski, Jan <jan.sokolowski@intel.com>
Date: Fri, 21 Jan 2022 14:58:03 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] iavf: Add reset to watchdog
 task
Message-ID: <CO1PR11MB48811E81C70B27754A77D92F995B9@CO1PR11MB4881.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove the reset as separate task and implement
the reset procedure inside the watchdog state machine.
This allows to avoid additional overhead for processes
synchronization. The reset flags are still used to mark
reset progress for asynchonous invoked callback functions.

Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  1 -
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 12 ++--
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 67 +++++++------------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  4 +-
 4 files changed, 30 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 16cd06feed31..a746f446606f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -237,7 +237,6 @@ struct iavf_cloud_filter {
 
 /* board specific private data structure */
 struct iavf_adapter {
-	struct work_struct reset_task;
 	struct work_struct adminq_task;
 	struct delayed_work client_task;
 	wait_queue_head_t down_waitqueue;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 3bb56714beb0..e55c5321ab5c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -530,10 +530,8 @@ static int iavf_set_priv_flags(struct net_device *netdev, u32 flags)
 
 	/* issue a reset to force legacy-rx change to take effect */
 	if (changed_flags & IAVF_FLAG_LEGACY_RX) {
-		if (netif_running(netdev)) {
-			adapter->flags |= IAVF_FLAG_RESET_NEEDED;
-			queue_work(iavf_wq, &adapter->reset_task);
-		}
+		if (netif_running(netdev))
+			iavf_schedule_reset(adapter);
 	}
 
 	return 0;
@@ -670,10 +668,8 @@ static int iavf_set_ringparam(struct net_device *netdev,
 		adapter->rx_desc_count = new_rx_count;
 	}
 
-	if (netif_running(netdev)) {
-		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
-		queue_work(iavf_wq, &adapter->reset_task);
-	}
+	if (netif_running(netdev))
+		iavf_schedule_reset(adapter);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index ec4f85a95f26..5ca1e82799f8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -16,6 +16,7 @@ static int iavf_setup_all_rx_resources(struct iavf_adapter *adapter);
 static int iavf_close(struct net_device *netdev);
 static void iavf_init_get_resources(struct iavf_adapter *adapter);
 static int iavf_check_reset_complete(struct iavf_hw *hw);
+static void iavf_handle_hw_reset(struct iavf_adapter *adapter);
 
 char iavf_driver_name[] = "iavf";
 static const char iavf_driver_string[] =
@@ -167,11 +168,8 @@ int iavf_lock_timeout(struct mutex *lock, unsigned int msecs)
  **/
 void iavf_schedule_reset(struct iavf_adapter *adapter)
 {
-	if (!(adapter->flags &
-	      (IAVF_FLAG_RESET_PENDING | IAVF_FLAG_RESET_NEEDED))) {
-		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
-		queue_work(iavf_wq, &adapter->reset_task);
-	}
+	adapter->flags |= IAVF_FLAG_RESET_NEEDED;
+	mod_delayed_work(iavf_wq, &adapter->watchdog_task, 0);
 }
 
 /**
@@ -2504,8 +2502,11 @@ static void iavf_watchdog_task(struct work_struct *work)
 				   msecs_to_jiffies(10));
 		return;
 	case __IAVF_RESETTING:
+		iavf_handle_hw_reset(adapter);
 		mutex_unlock(&adapter->crit_lock);
-		queue_delayed_work(iavf_wq, &adapter->watchdog_task, HZ * 2);
+		queue_delayed_work(iavf_wq,
+				   &adapter->watchdog_task,
+				   msecs_to_jiffies(2));
 		return;
 	case __IAVF_DOWN:
 	case __IAVF_DOWN_PENDING:
@@ -2540,14 +2541,12 @@ static void iavf_watchdog_task(struct work_struct *work)
 	/* check for hw reset */
 	reg_val = rd32(hw, IAVF_VF_ARQLEN1) & IAVF_VF_ARQLEN1_ARQENABLE_MASK;
 	if (!reg_val) {
-		adapter->flags |= IAVF_FLAG_RESET_PENDING;
+		iavf_schedule_reset(adapter);
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
-		queue_work(iavf_wq, &adapter->reset_task);
 		mutex_unlock(&adapter->crit_lock);
-		queue_delayed_work(iavf_wq,
-				   &adapter->watchdog_task, HZ * 2);
+		queue_work(iavf_wq, &adapter->watchdog_task.work);
 		return;
 	}
 
@@ -2624,18 +2623,15 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 }
 
 /**
- * iavf_reset_task - Call-back task to handle hardware reset
- * @work: pointer to work_struct
+ * iavf_handle_hw_reset - Handle hardware reset
+ * @adapter: pointer to iavf_adapter
  *
  * During reset we need to shut down and reinitialize the admin queue
  * before we can use it to communicate with the PF again. We also clear
  * and reinit the rings because that context is lost as well.
  **/
-static void iavf_reset_task(struct work_struct *work)
+static void iavf_handle_hw_reset(struct iavf_adapter *adapter)
 {
-	struct iavf_adapter *adapter = container_of(work,
-						      struct iavf_adapter,
-						      reset_task);
 	struct virtchnl_vf_resource *vfres = adapter->vf_res;
 	struct net_device *netdev = adapter->netdev;
 	struct iavf_hw *hw = &adapter->hw;
@@ -2651,12 +2647,9 @@ static void iavf_reset_task(struct work_struct *work)
 	if (mutex_is_locked(&adapter->remove_lock))
 		return;
 
-	if (iavf_lock_timeout(&adapter->crit_lock, 200)) {
-		schedule_work(&adapter->reset_task);
-		return;
-	}
-	while (!mutex_trylock(&adapter->client_lock))
-		usleep_range(500, 1000);
+	adapter->flags |= IAVF_FLAG_RESET_PENDING;
+	adapter->flags &= ~IAVF_FLAG_RESET_NEEDED;
+
 	if (CLIENT_ENABLED(adapter)) {
 		adapter->flags &= ~(IAVF_FLAG_CLIENT_NEEDS_OPEN |
 				    IAVF_FLAG_CLIENT_NEEDS_CLOSE |
@@ -2665,17 +2658,14 @@ static void iavf_reset_task(struct work_struct *work)
 		cancel_delayed_work_sync(&adapter->client_task);
 		iavf_notify_client_close(&adapter->vsi, true);
 	}
+
+	/* Restart the AQ here. If we have been reset but didn't
+	 * detect it, or if the PF had to reinit, our AQ will be hosed.
+	 */
 	iavf_misc_irq_disable(adapter);
-	if (adapter->flags & IAVF_FLAG_RESET_NEEDED) {
-		adapter->flags &= ~IAVF_FLAG_RESET_NEEDED;
-		/* Restart the AQ here. If we have been reset but didn't
-		 * detect it, or if the PF had to reinit, our AQ will be hosed.
-		 */
-		iavf_shutdown_adminq(hw);
-		iavf_init_adminq(hw);
-		iavf_request_reset(adapter);
-	}
-	adapter->flags |= IAVF_FLAG_RESET_PENDING;
+	iavf_shutdown_adminq(hw);
+	iavf_init_adminq(hw);
+	iavf_request_reset(adapter);
 
 	/* poll until we see the reset actually happen */
 	for (i = 0; i < IAVF_RESET_WAIT_DETECTED_COUNT; i++) {
@@ -2804,8 +2794,6 @@ static void iavf_reset_task(struct work_struct *work)
 	adapter->aq_required |= IAVF_FLAG_AQ_ADD_CLOUD_FILTER;
 	iavf_misc_irq_enable(adapter);
 
-	mod_delayed_work(iavf_wq, &adapter->watchdog_task, 2);
-
 	/* We were running when the reset started, so we need to restore some
 	 * state here.
 	 */
@@ -2841,12 +2829,9 @@ static void iavf_reset_task(struct work_struct *work)
 		wake_up(&adapter->down_waitqueue);
 	}
 	mutex_unlock(&adapter->client_lock);
-	mutex_unlock(&adapter->crit_lock);
-
 	return;
 reset_err:
 	mutex_unlock(&adapter->client_lock);
-	mutex_unlock(&adapter->crit_lock);
 	if (running) {
 		iavf_change_state(adapter, __IAVF_RUNNING);
 		netdev->flags |= IFF_UP;
@@ -3900,8 +3885,7 @@ static int iavf_change_mtu(struct net_device *netdev, int new_mtu)
 		iavf_notify_client_l2_params(&adapter->vsi);
 		adapter->flags |= IAVF_FLAG_SERVICE_CLIENT_REQUESTED;
 	}
-	adapter->flags |= IAVF_FLAG_RESET_NEEDED;
-	queue_work(iavf_wq, &adapter->reset_task);
+	iavf_schedule_reset(adapter);
 
 	return 0;
 }
@@ -4490,7 +4474,6 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_LIST_HEAD(&adapter->fdir_list_head);
 	INIT_LIST_HEAD(&adapter->adv_rss_list_head);
 
-	INIT_WORK(&adapter->reset_task, iavf_reset_task);
 	INIT_WORK(&adapter->adminq_task, iavf_adminq_task);
 	INIT_DELAYED_WORK(&adapter->watchdog_task, iavf_watchdog_task);
 	INIT_DELAYED_WORK(&adapter->client_task, iavf_client_task);
@@ -4572,8 +4555,7 @@ static int __maybe_unused iavf_resume(struct device *dev_d)
 		return err;
 	}
 
-	queue_work(iavf_wq, &adapter->reset_task);
-
+	iavf_schedule_reset(adapter);
 	netif_device_attach(adapter->netdev);
 
 	return err;
@@ -4602,7 +4584,6 @@ static void iavf_remove(struct pci_dev *pdev)
 	int err;
 	/* Indicate we are in remove and not to run reset_task */
 	mutex_lock(&adapter->remove_lock);
-	cancel_work_sync(&adapter->reset_task);
 	cancel_delayed_work_sync(&adapter->watchdog_task);
 	cancel_delayed_work_sync(&adapter->client_task);
 	if (adapter->netdev_registered) {
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 5ee1d118fd30..115c1b15cb66 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1899,8 +1899,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			dev_info(&adapter->pdev->dev, "Reset indication received from the PF\n");
 			if (!(adapter->flags & IAVF_FLAG_RESET_PENDING)) {
 				adapter->flags |= IAVF_FLAG_RESET_PENDING;
-				dev_info(&adapter->pdev->dev, "Scheduling reset task\n");
-				queue_work(iavf_wq, &adapter->reset_task);
+				dev_info(&adapter->pdev->dev, "Scheduling reset\n");
+				iavf_schedule_reset(adapter);
 			}
 			break;
 		default:
-- 
2.27.0
