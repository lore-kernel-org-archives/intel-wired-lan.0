From: Alice Michael <alice.michael@intel.com>
Date: Mon, 18 Dec 2017 05:16:23 -0500
Subject: [Intel-wired-lan] [next PATCH S83-V5 3/9] i40evf: remove
 flush_scheduled_work call in i40evf_remove
Message-ID: <20171218101623.75729-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>

flush_schedule_work blocks until completion of all scheduled
work items in global work-queue. This can cause deadlock in some
cases. i40evf_remove() cleans up necessary work items with
cancel_delayed_work_sync and cancel_work_sync. This fix removes
flush_schedule_work call inside i40evf_remove().

Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index f92587a..6472116 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -3088,8 +3088,6 @@ static void i40evf_remove(struct pci_dev *pdev)
 	if (adapter->watchdog_timer.function)
 		del_timer_sync(&adapter->watchdog_timer);
 
-	flush_scheduled_work();
-
 	i40evf_free_rss(adapter);
 
 	if (hw->aq.asq.count)
-- 
2.9.5

