From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Wed, 21 Oct 2015 17:21:10 -0700
Subject: [Intel-wired-lan] [PATCH 1/3] ixgbe: Use private workqueue to avoid
 certain possible hangs
Message-ID: <20151022002110.51120.4643.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use a private workqueue to avoid hangs that were otherwise possible
when performing stress tests, such as creating and destroying many
vfs repeatedly.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 0 files changed

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 391f39b2776f..494ce197a620 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -172,6 +172,8 @@ MODULE_DESCRIPTION("Intel(R) 10 Gigabit PCI Express Network Driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
+static struct workqueue_struct *ixgbe_wq;
+
 static bool ixgbe_check_cfg_remove(struct ixgbe_hw *hw, struct pci_dev *pdev);
 
 static int ixgbe_read_pci_cfg_word_parent(struct ixgbe_adapter *adapter,
@@ -313,7 +315,7 @@ static void ixgbe_service_event_schedule(struct ixgbe_adapter *adapter)
 	if (!test_bit(__IXGBE_DOWN, &adapter->state) &&
 	    !test_bit(__IXGBE_REMOVING, &adapter->state) &&
 	    !test_and_set_bit(__IXGBE_SERVICE_SCHED, &adapter->state))
-		schedule_work(&adapter->service_task);
+		queue_work(ixgbe_wq, &adapter->service_task);
 }
 
 static void ixgbe_remove_adapter(struct ixgbe_hw *hw)
@@ -9320,6 +9322,12 @@ static int __init ixgbe_init_module(void)
 	pr_info("%s - version %s\n", ixgbe_driver_string, ixgbe_driver_version);
 	pr_info("%s\n", ixgbe_copyright);
 
+	ixgbe_wq = create_singlethread_workqueue(ixgbe_driver_name);
+	if (!ixgbe_wq) {
+		pr_err("%s: Failed to create workqueue\n", ixgbe_driver_name);
+		return -ENOMEM;
+	}
+
 	ixgbe_dbg_init();
 
 	ret = pci_register_driver(&ixgbe_driver);
@@ -9351,6 +9359,10 @@ static void __exit ixgbe_exit_module(void)
 	pci_unregister_driver(&ixgbe_driver);
 
 	ixgbe_dbg_exit();
+	if (ixgbe_wq) {
+		destroy_workqueue(ixgbe_wq);
+		ixgbe_wq = NULL;
+	}
 }
 
 #ifdef CONFIG_IXGBE_DCA

