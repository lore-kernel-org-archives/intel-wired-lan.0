From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Wed, 23 Feb 2022 13:38:55 +0100
Subject: [Intel-wired-lan] [PATCH net v1 8/8] iavf: Fix __IAVF_RESETTING
 state usage
Message-ID: <20220223123855.30862-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: SlawomirX Laba <slawomirx.laba@intel.com>

The setup of __IAVF_RESETTING state in watchdog task had no
effect and could lead to slow resets in the driver as
the task for __IAVF_RESETTING state only requeues watchdog.
Till now the __IAVF_RESETTING was interpreted by reset task
as running state which could lead to errors with allocating
and resources disposal.

Make watchdog_task queue the reset task when it's necessary.
Do not update the state to __IAVF_RESETTING so the reset task
knows exactly what is the current state of the adapter.

Fixes: 898ef1cb1cb2 ("iavf: Combine init and watchdog state machines")
Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
Signed-off-by: Phani Burra <phani.r.burra@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index be97ac2..dcf2426 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1137,8 +1137,7 @@ void iavf_down(struct iavf_adapter *adapter)
 		rss->state = IAVF_ADV_RSS_DEL_REQUEST;
 	spin_unlock_bh(&adapter->adv_rss_lock);
 
-	if (!(adapter->flags & IAVF_FLAG_PF_COMMS_FAILED) &&
-	    adapter->state != __IAVF_RESETTING) {
+	if (!(adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)) {
 		/* cancel any current operation */
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		/* Schedule operations to close down the HW. Don't wait
@@ -2385,11 +2384,12 @@ static void iavf_watchdog_task(struct work_struct *work)
 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
 		iavf_change_state(adapter, __IAVF_COMM_FAILED);
 
-	if (adapter->flags & IAVF_FLAG_RESET_NEEDED &&
-	    adapter->state != __IAVF_RESETTING) {
-		iavf_change_state(adapter, __IAVF_RESETTING);
+	if (adapter->flags & IAVF_FLAG_RESET_NEEDED) {
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+		mutex_unlock(&adapter->crit_lock);
+		queue_work(iavf_wq, &adapter->reset_task);
+		return;
 	}
 
 	switch (adapter->state) {
@@ -2697,8 +2697,7 @@ static void iavf_reset_task(struct work_struct *work)
 	 * ndo_open() returning, so we can't assume it means all our open
 	 * tasks have finished, since we're not holding the rtnl_lock here.
 	 */
-	running = ((adapter->state == __IAVF_RUNNING) ||
-		   (adapter->state == __IAVF_RESETTING));
+	running = adapter->state == __IAVF_RUNNING;
 
 	if (running) {
 		netdev->flags &= ~IFF_UP;
-- 
2.27.0

