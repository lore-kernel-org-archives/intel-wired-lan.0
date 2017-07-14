From: Alice Michael <alice.michael@intel.com>
Date: Fri, 14 Jul 2017 09:27:05 -0400
Subject: [Intel-wired-lan] [next PATCH S77-V3 06/10] i40e: prevent service
	task from running while we're suspended
In-Reply-To: <20170714132709.52657-1-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
Message-ID: <20170714132709.52657-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Although the service task does check the suspended status before
running, it might already be part way through running when we go to
suspend. Lets ensure that the service task is stopped and will not be
restarted again until we finish resuming. This ensures that service task
code does not cause strange interactions with the suspend/resume
handlers.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 11c9565..0d2e652 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12051,6 +12051,10 @@ static int i40e_suspend(struct device *dev)
 
 	set_bit(__I40E_DOWN, pf->state);
 
+	/* Ensure service task will not be running */
+	del_timer_sync(&pf->service_timer);
+	cancel_work_sync(&pf->service_task);
+
 	if (pf->wol_en && (pf->hw_features & I40E_HW_WOL_MC_MAGIC_PKT_WAKE))
 		i40e_enable_mc_magic_wake(pf);
 
@@ -12083,6 +12087,10 @@ static int i40e_resume(struct device *dev)
 	/* Clear suspended state last after everything is recovered */
 	clear_bit(__I40E_SUSPENDED, pf->state);
 
+	/* Restart the service task */
+	mod_timer(&pf->service_timer,
+		  round_jiffies(jiffies + pf->service_timer_period));
+
 	return 0;
 }
 
-- 
2.9.3

