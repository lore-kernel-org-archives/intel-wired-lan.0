From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Fri, 27 May 2022 10:09:18 +0200
Subject: [Intel-wired-lan] [PATCH net v1 1/2] iavf: Add helper to check if
 iavf_remove() is in progress
Message-ID: <20220527080919.2370640-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently the driver checks if the __IAVF_IN_REMOVE_TASK bit is set in
the adapter's crit_section bitmap. This is fine, but if the
implementation were to ever change, i.e. a mutex was introduced all of
the callers of test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)
would have to change. Fix this by introducing the
iavf_is_remove_in_progress() helper function.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h      |  1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c | 17 ++++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 49aed3e506a6..c787c152f5b3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -502,6 +502,7 @@ int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter);
 void iavf_schedule_reset(struct iavf_adapter *adapter);
 void iavf_schedule_request_stats(struct iavf_adapter *adapter);
 void iavf_reset(struct iavf_adapter *adapter);
+bool iavf_is_remove_in_progress(struct iavf_adapter *adapter);
 void iavf_set_ethtool_ops(struct net_device *netdev);
 void iavf_update_stats(struct iavf_adapter *adapter);
 void iavf_reset_interrupt_capability(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index f3ecb3bca33d..eec74ee5fc19 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -268,6 +268,15 @@ int iavf_lock_timeout(struct mutex *lock, unsigned int msecs)
 	return -1;
 }
 
+/**
+ * iavf_is_remove_in_progress - Check if a iavf_remove() is in progress
+ * @adapter: board private structure
+ */
+bool iavf_is_remove_in_progress(struct iavf_adapter *adapter)
+{
+	return test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section);
+}
+
 /**
  * iavf_schedule_reset - Set the flags and schedule a reset event
  * @adapter: board private structure
@@ -2588,8 +2597,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 				   msecs_to_jiffies(1));
 		return;
 	case __IAVF_INIT_FAILED:
-		if (test_bit(__IAVF_IN_REMOVE_TASK,
-			     &adapter->crit_section)) {
+		if (iavf_is_remove_in_progress(adapter)) {
 			/* Do not update the state and do not reschedule
 			 * watchdog task, iavf_remove should handle this state
 			 * as it can loop forever
@@ -2613,8 +2621,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 		queue_delayed_work(iavf_wq, &adapter->watchdog_task, HZ);
 		return;
 	case __IAVF_COMM_FAILED:
-		if (test_bit(__IAVF_IN_REMOVE_TASK,
-			     &adapter->crit_section)) {
+		if (iavf_is_remove_in_progress(adapter)) {
 			/* Set state to __IAVF_INIT_FAILED and perform remove
 			 * steps. Remove IAVF_FLAG_PF_COMMS_FAILED so the task
 			 * doesn't bring the state back to __IAVF_COMM_FAILED.
@@ -3057,7 +3064,7 @@ static void iavf_adminq_task(struct work_struct *work)
 
 	if ((adapter->flags & IAVF_FLAG_SETUP_NETDEV_FEATURES)) {
 		if (adapter->netdev_registered ||
-		    !test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)) {
+		    !(iavf_is_remove_in_progress(adapter))) {
 			struct net_device *netdev = adapter->netdev;
 
 			rtnl_lock();
-- 
2.27.0

