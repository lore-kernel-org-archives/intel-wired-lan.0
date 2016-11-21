From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 21 Nov 2016 13:03:51 -0800
Subject: [Intel-wired-lan] [next PATCH S53-V3 5/5] i40e: lock service task
	correctly
In-Reply-To: <1479762231-27559-1-git-send-email-bimmy.pujari@intel.com>
References: <1479762231-27559-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1479762231-27559-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The service task lock was being set in the scheduling function, not the
actual service task. This would potentially leave the bit set for a long
time before the task actually ran. Furthermore, if the service task
takes too long, it calls the schedule function to reschedule itself -
which would fail to take the lock and do nothing.

Instead, set and clear the lock bit in the service task itself. In the
process, get rid of the i40e_service_event_complete() function, which is
really just two lines of code that can be put right in the service task
itself.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I83155e682b686121e2897f4429eb7d3f7c669168
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 849feaa..57850fd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -288,8 +288,7 @@ struct i40e_vsi *i40e_find_vsi_from_id(struct i40e_pf *pf, u16 id)
 void i40e_service_event_schedule(struct i40e_pf *pf)
 {
 	if (!test_bit(__I40E_DOWN, &pf->state) &&
-	    !test_bit(__I40E_RESET_RECOVERY_PENDING, &pf->state) &&
-	    !test_and_set_bit(__I40E_SERVICE_SCHED, &pf->state))
+	    !test_bit(__I40E_RESET_RECOVERY_PENDING, &pf->state))
 		queue_work(i40e_wq, &pf->service_task);
 }
 
@@ -5943,19 +5942,6 @@ static void i40e_handle_lan_overflow_event(struct i40e_pf *pf,
 }
 
 /**
- * i40e_service_event_complete - Finish up the service event
- * @pf: board private structure
- **/
-static void i40e_service_event_complete(struct i40e_pf *pf)
-{
-	WARN_ON(!test_bit(__I40E_SERVICE_SCHED, &pf->state));
-
-	/* flush memory to make sure state is correct before next watchog */
-	smp_mb__before_atomic();
-	clear_bit(__I40E_SERVICE_SCHED, &pf->state);
-}
-
-/**
  * i40e_get_cur_guaranteed_fd_count - Get the consumed guaranteed FD filters
  * @pf: board private structure
  **/
@@ -7264,10 +7250,12 @@ static void i40e_service_task(struct work_struct *work)
 
 	/* don't bother with service tasks if a reset is in progress */
 	if (test_bit(__I40E_RESET_RECOVERY_PENDING, &pf->state)) {
-		i40e_service_event_complete(pf);
 		return;
 	}
 
+	if (test_and_set_bit(__I40E_SERVICE_SCHED, &pf->state))
+		return;
+
 	i40e_detect_recover_hung(pf);
 	i40e_sync_filters_subtask(pf);
 	i40e_reset_subtask(pf);
@@ -7280,7 +7268,9 @@ static void i40e_service_task(struct work_struct *work)
 	i40e_sync_udp_filters_subtask(pf);
 	i40e_clean_adminq_subtask(pf);
 
-	i40e_service_event_complete(pf);
+	/* flush memory to make sure state is correct before next watchdog */
+	smp_mb__before_atomic();
+	clear_bit(__I40E_SERVICE_SCHED, &pf->state);
 
 	/* If the tasks have taken longer than one timer cycle or there
 	 * is more work to be done, reschedule the service task now
-- 
2.4.11

