From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  1 Jun 2017 15:40:47 -0700
Subject: [Intel-wired-lan] [PATCH 11/15] fm10k: prevent race condition of
	__FM10K_SERVICE_SCHED
In-Reply-To: <20170601224051.6106-1-jacob.e.keller@intel.com>
References: <20170601224051.6106-1-jacob.e.keller@intel.com>
Message-ID: <20170601224051.6106-12-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Although very unlikely, it is possible that cancel_work_sync() may stop
the service_task before it actually started. In this case, the
__FM10K_SERVICE_SCHED bit will never be cleared. This results in the
service task being unable to reschedule in the future. Add a helper
function which sets the service disable bit, waits for the service task
to stop and clears the schedule bit, thus avoiding the race condition.
We know the schedule bit is safe to clear because the cancel_work_sync()
guarantees the service task is not running.

Add a helper function also to restart the service task, for symmetry.
This is not strictly needed but helps the mental model of how to stop
and start the service task.

This race could only happen in fm10k_suspend/fm10k_resume as this is the
only place where the service task is actually restarted. Thus,
suspend/resume testing would be ideal. However, note that the chance of
this happening is very slim as the service event is scheduled for
immediate execution, and you would have to trigger a suspend at almost
the exact same time as the service task was scheduled.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 32 ++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 2d94a16f9613..206da6b7c46a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -118,6 +118,27 @@ static void fm10k_service_event_complete(struct fm10k_intfc *interface)
 		fm10k_service_event_schedule(interface);
 }
 
+static void fm10k_stop_service_event(struct fm10k_intfc *interface)
+{
+	set_bit(__FM10K_SERVICE_DISABLE, interface->state);
+	cancel_work_sync(&interface->service_task);
+
+	/* It's possible that cancel_work_sync stopped the service task from
+	 * running before it could actually start. In this case the
+	 * __FM10K_SERVICE_SCHED bit will never be cleared. Since we know that
+	 * the service task cannot be running at this point, we need to clear
+	 * the scheduled bit, as otherwise the service task may never be
+	 * restarted.
+	 */
+	clear_bit(__FM10K_SERVICE_SCHED, interface->state);
+}
+
+static void fm10k_start_service_event(struct fm10k_intfc *interface)
+{
+	clear_bit(__FM10K_SERVICE_DISABLE, interface->state);
+	fm10k_service_event_schedule(interface);
+}
+
 /**
  * fm10k_service_timer - Timer Call-back
  * @data: pointer to interface cast into an unsigned long
@@ -2131,8 +2152,7 @@ static void fm10k_remove(struct pci_dev *pdev)
 
 	del_timer_sync(&interface->service_timer);
 
-	set_bit(__FM10K_SERVICE_DISABLE, interface->state);
-	cancel_work_sync(&interface->service_task);
+	fm10k_stop_service_event(interface);
 
 	/* free netdev, this may bounce the interrupts due to setup_tc */
 	if (netdev->reg_state == NETREG_REGISTERED)
@@ -2170,8 +2190,7 @@ static void fm10k_prepare_suspend(struct fm10k_intfc *interface)
 	 * stopped. We stop the watchdog task until after we resume software
 	 * activity.
 	 */
-	set_bit(__FM10K_SERVICE_DISABLE, interface->state);
-	cancel_work_sync(&interface->service_task);
+	fm10k_stop_service_event(interface);
 
 	fm10k_prepare_for_reset(interface);
 }
@@ -2198,9 +2217,8 @@ static int fm10k_handle_resume(struct fm10k_intfc *interface)
 	interface->link_down_event = jiffies + (HZ);
 	set_bit(__FM10K_LINK_DOWN, interface->state);
 
-	/* clear the service task disable bit to allow service task to start */
-	clear_bit(__FM10K_SERVICE_DISABLE, interface->state);
-	fm10k_service_event_schedule(interface);
+	/* restart the service task */
+	fm10k_start_service_event(interface);
 
 	return err;
 }
-- 
2.13.0.598.gf927b9495246

