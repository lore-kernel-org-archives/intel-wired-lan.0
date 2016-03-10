From: ajdayana <avinash.dayanand@intel.com>
Date: Thu, 10 Mar 2016 14:59:45 -0800
Subject: [Intel-wired-lan] [next PATCH S30 v3 07/13] i40e: Remove timer and
	task only if created
In-Reply-To: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1457650791-100229-8-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

In some error scenarios, we may find ourselves trying to remove a
non-existent timer or worktask.  This causes the kernel some bit
of consternation, so don't do it.

Testing Hints: Inject an error into the i40e_probe before these are
created and see if you can get a clean remove.

Signed-off-by: Nelson, Shannon <shannon.nelson@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5d2dba2..298a73c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11212,8 +11212,10 @@ static void i40e_remove(struct pci_dev *pdev)
 	/* no more scheduling of any task */
 	set_bit(__I40E_SUSPENDED, &pf->state);
 	set_bit(__I40E_DOWN, &pf->state);
-	del_timer_sync(&pf->service_timer);
-	cancel_work_sync(&pf->service_task);
+	if (pf->service_timer.data)
+		del_timer_sync(&pf->service_timer);
+	if (pf->service_task.func)
+		cancel_work_sync(&pf->service_task);
 
 	if (pf->flags & I40E_FLAG_SRIOV_ENABLED) {
 		i40e_free_vfs(pf);
-- 
2.4.3

