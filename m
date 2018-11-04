From: Robert Eshleman <bobbyeshleman@gmail.com>
Date: Sat,  3 Nov 2018 17:17:19 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e: Change watchdog task to be
 delayed work
Message-ID: <1541290645-25033-1-git-send-email-bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This completes a pending TODO to use queue_delayed_work() instead of
schedule_work().

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 16a73bd..a387b21 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -39,6 +39,8 @@ static int debug = -1;
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
+struct workqueue_struct *e1000e_workqueue;
+
 static const struct e1000_info *e1000_info_tbl[] = {
 	[board_82571]		= &e1000_82571_info,
 	[board_82572]		= &e1000_82572_info,
@@ -5137,9 +5139,9 @@ static void e1000_watchdog(struct timer_list *t)
 	struct e1000_adapter *adapter = from_timer(adapter, t, watchdog_timer);
 
 	/* Do the rest outside of interrupt context */
-	schedule_work(&adapter->watchdog_task);
+	struct delayed_work *dwork = to_delayed_work(&adapter->watchdog_task);
 
-	/* TODO: make this use queue_delayed_work() */
+	queue_delayed_work(e1000e_workqueue, dwork, 1);
 }
 
 static void e1000_watchdog_task(struct work_struct *work)
@@ -7572,6 +7574,13 @@ static int __init e1000_init_module(void)
 		e1000e_driver_version);
 	pr_info("Copyright(c) 1999 - 2015 Intel Corporation.\n");
 
+	e1000e_workqueue = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
+					   e1000e_driver_name);
+	if (!e1000e_workqueue) {
+		pr_err("%s: Failed to create workqueue\n", e1000e_driver_name);
+		return -ENOMEM;
+	}
+
 	return pci_register_driver(&e1000_driver);
 }
 module_init(e1000_init_module);
@@ -7585,6 +7594,7 @@ module_init(e1000_init_module);
 static void __exit e1000_exit_module(void)
 {
 	pci_unregister_driver(&e1000_driver);
+	destroy_workqueue(e1000e_workqueue);
 }
 module_exit(e1000_exit_module);
 
-- 
2.7.4

