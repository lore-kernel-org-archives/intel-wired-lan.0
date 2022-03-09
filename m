From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Wed,  9 Mar 2022 16:37:39 +0100
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Fix double free in
 iavf_reset_task
Message-ID: <20220309153739.22014-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>

Fix double free possibility in iavf_disable_vf, as crit_lock is
freed in caller, iavf_reset_task. Add kernel-doc for iavf_disable_vf.
Remove mutex_unlock in iavf_disable_vf.
Without this patch there is double free scenario, when calling
iavf_reset_task.

Fixes: e85ff9c631e1 ("iavf: Fix deadlock in iavf_reset_task")
Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 Note: This is targeted to net-next because it fixes a patch
 that is not present in net.
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7c4b75a..c11e2ab 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2705,6 +2705,13 @@ static void iavf_watchdog_task(struct work_struct *work)
 		queue_delayed_work(iavf_wq, &adapter->watchdog_task, HZ * 2);
 }
 
+/**
+ * iavf_disable_vf - disable VF
+ * @adapter: board private structure
+ *
+ * Set communication failed flag and free all resources.
+ * NOTE: This function is expected to be called with crit_lock being held.
+ **/
 static void iavf_disable_vf(struct iavf_adapter *adapter)
 {
 	struct iavf_mac_filter *f, *ftmp;
@@ -2759,7 +2766,6 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 	memset(adapter->vf_res, 0, IAVF_VIRTCHNL_VF_RESOURCE_SIZE);
 	iavf_shutdown_adminq(&adapter->hw);
 	adapter->netdev->flags &= ~IFF_UP;
-	mutex_unlock(&adapter->crit_lock);
 	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
 	iavf_change_state(adapter, __IAVF_DOWN);
 	wake_up(&adapter->down_waitqueue);
-- 
2.27.0

