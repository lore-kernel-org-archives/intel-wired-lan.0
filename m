From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 12 Jan 2017 15:59:40 -0800
Subject: [Intel-wired-lan] [PATCH 3/5] fm10k: allow service task to
	reschedule itself
In-Reply-To: <20170112235942.5767-1-jacob.e.keller@intel.com>
References: <20170112235942.5767-1-jacob.e.keller@intel.com>
Message-ID: <20170112235942.5767-3-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If some code path executes fm10k_service_event_schedule(), it is
guaranteed that we only queue the service task once, since we use
__FM10K_SERVICE_SCHED flag. Unfortunately this has a side effect that if
a service request occurs while we are currently running the watchdog, it
is possible that we will fail to notice the request and ignore it until
the next time the request occurs.

This can cause problems with pf/vf mailbox communication and other
service event tasks. To avoid this, introduce a FM10K_SERVICE_REQUEST
bit. When we successfully schedule (and set the _SCHED bit) the service
task, we will clear this bit. However, if we are unable to currently
schedule the service event, we just set the new SERVICE_REQUEST bit.

Finally, after the service event completes, we will re-schedule if the
request bit has been set.

This should ensure that we do not miss any service event schedules,
since we will re-schedule it once the currently running task finishes.
This means that for each request, we will always schedule the service
task to run at least once in full after the request came in.

This will avoid timing issues that can occur with the service event
scheduling. We do pay a cost in re-running many tasks, but all the
service event tasks use either flags to avoid duplicate work, or are
tolerant of being run multiple times.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h     |  1 +
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index b496300d0268..689c413b7782 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -272,6 +272,7 @@ enum fm10k_state_t {
 	__FM10K_RESETTING,
 	__FM10K_DOWN,
 	__FM10K_SERVICE_SCHED,
+	__FM10K_SERVICE_REQUEST,
 	__FM10K_SERVICE_DISABLE,
 	__FM10K_MBX_LOCK,
 	__FM10K_LINK_DOWN,
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 68a265ac09f4..57ed2a98c6ab 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -93,8 +93,12 @@ static int fm10k_hw_ready(struct fm10k_intfc *interface)
 void fm10k_service_event_schedule(struct fm10k_intfc *interface)
 {
 	if (!test_bit(__FM10K_SERVICE_DISABLE, interface->state) &&
-	    !test_and_set_bit(__FM10K_SERVICE_SCHED, interface->state))
+	    !test_and_set_bit(__FM10K_SERVICE_SCHED, interface->state)) {
+		clear_bit(__FM10K_SERVICE_REQUEST, interface->state);
 		queue_work(fm10k_workqueue, &interface->service_task);
+	} else {
+		set_bit(__FM10K_SERVICE_REQUEST, interface->state);
+	}
 }
 
 static void fm10k_service_event_complete(struct fm10k_intfc *interface)
@@ -104,6 +108,13 @@ static void fm10k_service_event_complete(struct fm10k_intfc *interface)
 	/* flush memory to make sure state is correct before next watchog */
 	smp_mb__before_atomic();
 	clear_bit(__FM10K_SERVICE_SCHED, interface->state);
+
+	/* If a service event was requested since we started, immediately
+	 * re-schedule now. This ensures we don't drop a request until the
+	 * next timer event.
+	 */
+	if (test_bit(__FM10K_SERVICE_REQUEST, interface->state))
+		fm10k_service_event_schedule(interface);
 }
 
 /**
-- 
2.11.0.403.g196674b8396b

