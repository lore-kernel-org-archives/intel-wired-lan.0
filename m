From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Wed, 23 Feb 2022 13:38:01 +0100
Subject: [Intel-wired-lan] [PATCH net v1 5/8] iavf: Fix race in init state
Message-ID: <20220223123801.30386-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: SlawomirX Laba <slawomirx.laba@intel.com>

When iavf_init_version_check sends VIRTCHNL_OP_GET_VF_RESOURCES
message, the driver will wait for the response after requeueing
the watchdog task in iavf_init_get_resources call stack. The
logic is implemented this way that iavf_init_get_resources has
to be called in order to allocate adapter->vf_res. It is polling
for the AQ response in iavf_get_vf_config function. Expect a
call trace from kernel when adminq_task worker handles this
message first. adapter->vf_res will be NULL in
iavf_virtchnl_completion.

Make the watchdog task not queue the adminq_task if the init
process is not finished yet.

Fixes: 898ef1cb1cb2 ("iavf: Combine init and watchdog state machines")
Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
Signed-off-by: Phani Burra <phani.r.burra@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 67349d2..36433d6 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2532,7 +2532,8 @@ static void iavf_watchdog_task(struct work_struct *work)
 	schedule_delayed_work(&adapter->client_task, msecs_to_jiffies(5));
 	mutex_unlock(&adapter->crit_lock);
 restart_watchdog:
-	queue_work(iavf_wq, &adapter->adminq_task);
+	if (adapter->state >= __IAVF_DOWN)
+		queue_work(iavf_wq, &adapter->adminq_task);
 	if (adapter->aq_required)
 		queue_delayed_work(iavf_wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(20));
-- 
2.27.0

