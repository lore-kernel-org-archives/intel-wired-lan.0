From: Stefan Assmann <sassmann@kpanic.de>
Date: Fri,  1 Sep 2017 16:02:34 +0200
Subject: [Intel-wired-lan] [PATCH 2/2] Revert "i40e: remove WQ_UNBOUND and
	the task limit of our workqueue"
In-Reply-To: <20170901140234.7840-1-sassmann@kpanic.de>
References: <20170901140234.7840-1-sassmann@kpanic.de>
Message-ID: <20170901140234.7840-3-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This reverts commit 4d5957cbdecdbb77d24c1465caadd801c07afa4a.

Due to this workqueue change the eeprom check right after flashing
firmware fails, although the flash itself completed successfully.
The error observed looks like this
i40e 0000:88:00.0: eeprom check failed (-62), Tx/Rx traffic disabled
The NIC is fully operational after the flash and even after a cold boot
any follow-up eeprom checks succeed.

This needs to be investigated, but for now it should be more important
to make sure the firmware update works as expected.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6498da8806cb..069b6683e1b0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12160,14 +12160,12 @@ static int __init i40e_init_module(void)
 		i40e_driver_string, i40e_driver_version_str);
 	pr_info("%s: %s\n", i40e_driver_name, i40e_copyright);
 
-	/* There is no need to throttle the number of active tasks because
-	 * each device limits its own task using a state bit for scheduling
-	 * the service task, and the device tasks do not interfere with each
-	 * other, so we don't set a max task limit. We must set WQ_MEM_RECLAIM
-	 * since we need to be able to guarantee forward progress even under
-	 * memory pressure.
+	/* we will see if single thread per module is enough for now,
+	 * it can't be any worse than using the system workqueue which
+	 * was already single threaded
 	 */
-	i40e_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0, i40e_driver_name);
+	i40e_wq = alloc_workqueue("%s", WQ_UNBOUND | WQ_MEM_RECLAIM, 1,
+				  i40e_driver_name);
 	if (!i40e_wq) {
 		pr_err("%s: Failed to create workqueue\n", i40e_driver_name);
 		return -ENOMEM;
-- 
2.13.5

