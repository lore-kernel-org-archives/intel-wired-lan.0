From: Ken Cox <jkc@redhat.com>
Date: Wed,  8 Dec 2021 04:21:53 -0600
Subject: [Intel-wired-lan] [Patch 2/2] iavf: Prevent reset from being
 scheduled while adapter is being removed
In-Reply-To: <20211208102153.669338-1-jkc@redhat.com>
References: <20211208102153.669338-1-jkc@redhat.com>
Message-ID: <20211208102153.669338-3-jkc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If a reset gets scheduled while the adapter is being removed it can
cause a panic.

The work_struct for the reset_task is contained in the iavf_adapter
structure.  iavf_remove() eventually frees the iavf_adapter structure
so if there is active work scheduled it can cause a panic.

Signed-off-by: Ken Cox <jkc@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c  |  7 +++++--
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 15 ++++++++++-----
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c |  4 +++-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index af43fbd8cb75e..3cf1679153604 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -519,7 +519,9 @@ static int iavf_set_priv_flags(struct net_device *netdev, u32 flags)
 
 	/* issue a reset to force legacy-rx change to take effect */
 	if (changed_flags & IAVF_FLAG_LEGACY_RX) {
-		if (netif_running(netdev)) {
+
+		if (netif_running(netdev) &&
+		    !test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)) {
 			adapter->flags |= IAVF_FLAG_RESET_NEEDED;
 			queue_work(iavf_wq, &adapter->reset_task);
 		}
@@ -630,7 +632,8 @@ static int iavf_set_ringparam(struct net_device *netdev,
 	adapter->tx_desc_count = new_tx_count;
 	adapter->rx_desc_count = new_rx_count;
 
-	if (netif_running(netdev)) {
+	if (netif_running(netdev) &&
+	    !test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)) {
 		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
 		queue_work(iavf_wq, &adapter->reset_task);
 	}
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 63eec7edbf60a..af2788c997ca2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -164,7 +164,8 @@ static int iavf_lock_timeout(struct iavf_adapter *adapter,
 void iavf_schedule_reset(struct iavf_adapter *adapter)
 {
 	if (!(adapter->flags &
-	      (IAVF_FLAG_RESET_PENDING | IAVF_FLAG_RESET_NEEDED))) {
+	      (IAVF_FLAG_RESET_PENDING | IAVF_FLAG_RESET_NEEDED)) &&
+	    !test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)) {
 		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
 		queue_work(iavf_wq, &adapter->reset_task);
 	}
@@ -2013,7 +2014,8 @@ static void iavf_watchdog_task(struct work_struct *work)
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
-		queue_work(iavf_wq, &adapter->reset_task);
+		if (!test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
+			queue_work(iavf_wq, &adapter->reset_task);
 		goto watchdog_done;
 	}
 
@@ -3348,8 +3350,10 @@ static int iavf_change_mtu(struct net_device *netdev, int new_mtu)
 		iavf_notify_client_l2_params(&adapter->vsi);
 		adapter->flags |= IAVF_FLAG_SERVICE_CLIENT_REQUESTED;
 	}
-	adapter->flags |= IAVF_FLAG_RESET_NEEDED;
-	queue_work(iavf_wq, &adapter->reset_task);
+	if (!test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)) {
+		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
+		queue_work(iavf_wq, &adapter->reset_task);
+	}
 
 	return 0;
 }
@@ -3909,7 +3913,8 @@ static int __maybe_unused iavf_resume(struct device *dev_d)
 		return err;
 	}
 
-	queue_work(iavf_wq, &adapter->reset_task);
+	if (!test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
+		queue_work(iavf_wq, &adapter->reset_task);
 
 	netif_device_attach(netdev);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 0eab3c43bdc59..ba973b2ab0547 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1470,7 +1470,9 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			break;
 		case VIRTCHNL_EVENT_RESET_IMPENDING:
 			dev_info(&adapter->pdev->dev, "Reset warning received from the PF\n");
-			if (!(adapter->flags & IAVF_FLAG_RESET_PENDING)) {
+			if (!(adapter->flags & IAVF_FLAG_RESET_PENDING) &&
+			    !test_bit(__IAVF_IN_REMOVE_TASK,
+				      &adapter->crit_section)) {
 				adapter->flags |= IAVF_FLAG_RESET_PENDING;
 				dev_info(&adapter->pdev->dev, "Scheduling reset task\n");
 				queue_work(iavf_wq, &adapter->reset_task);
-- 
2.31.1

