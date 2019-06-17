From: Detlev Casanova <detlev.casanova@gmail.com>
Date: Mon, 17 Jun 2019 15:54:18 -0400
Subject: [Intel-wired-lan] [PATCH] e1000e: Make watchdog use delayed work
Message-ID: <20190617195418.3499-1-detlev.casanova@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use delayed work instead of timers to run the watchdog of the e1000e
driver.

Simplify the code with one less middle function.

Signed-off-by: Detlev Casanova <detlev.casanova@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h  |  3 +-
 drivers/net/ethernet/intel/e1000e/netdev.c | 52 +++++++++++-----------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index be13227f1697..942ab74030ca 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -186,12 +186,11 @@ struct e1000_phy_regs {
 
 /* board specific private data structure */
 struct e1000_adapter {
-	struct timer_list watchdog_timer;
 	struct timer_list phy_info_timer;
 	struct timer_list blink_timer;
 
 	struct work_struct reset_task;
-	struct work_struct watchdog_task;
+	struct delayed_work watchdog_task;
 
 	const struct e1000_info *ei;
 
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 0e09bede42a2..f62434aa24ad 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -39,6 +39,8 @@ static int debug = -1;
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
+static struct workqueue_struct *e1000_workqueue;
+
 static const struct e1000_info *e1000_info_tbl[] = {
 	[board_82571]		= &e1000_82571_info,
 	[board_82572]		= &e1000_82572_info,
@@ -1780,7 +1782,7 @@ static irqreturn_t e1000_intr_msi(int __always_unused irq, void *data)
 		}
 		/* guard against interrupt when we're going down */
 		if (!test_bit(__E1000_DOWN, &adapter->state))
-			mod_timer(&adapter->watchdog_timer, jiffies + 1);
+			queue_delayed_work(e1000_workqueue, &adapter->watchdog_task, 1);
 	}
 
 	/* Reset on uncorrectable ECC error */
@@ -1860,7 +1862,7 @@ static irqreturn_t e1000_intr(int __always_unused irq, void *data)
 		}
 		/* guard against interrupt when we're going down */
 		if (!test_bit(__E1000_DOWN, &adapter->state))
-			mod_timer(&adapter->watchdog_timer, jiffies + 1);
+			queue_delayed_work(e1000_workqueue, &adapter->watchdog_task, 1);
 	}
 
 	/* Reset on uncorrectable ECC error */
@@ -1905,7 +1907,7 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
 		hw->mac.get_link_status = true;
 		/* guard against interrupt when we're going down */
 		if (!test_bit(__E1000_DOWN, &adapter->state))
-			mod_timer(&adapter->watchdog_timer, jiffies + 1);
+			queue_delayed_work(e1000_workqueue, &adapter->watchdog_task, 0);
 	}
 
 	if (!test_bit(__E1000_DOWN, &adapter->state))
@@ -4278,7 +4280,6 @@ void e1000e_down(struct e1000_adapter *adapter, bool reset)
 
 	napi_synchronize(&adapter->napi);
 
-	del_timer_sync(&adapter->watchdog_timer);
 	del_timer_sync(&adapter->phy_info_timer);
 
 	spin_lock(&adapter->stats64_lock);
@@ -5150,25 +5151,11 @@ static void e1000e_check_82574_phy_workaround(struct e1000_adapter *adapter)
 	}
 }
 
-/**
- * e1000_watchdog - Timer Call-back
- * @data: pointer to adapter cast into an unsigned long
- **/
-static void e1000_watchdog(struct timer_list *t)
-{
-	struct e1000_adapter *adapter = from_timer(adapter, t, watchdog_timer);
-
-	/* Do the rest outside of interrupt context */
-	schedule_work(&adapter->watchdog_task);
-
-	/* TODO: make this use queue_delayed_work() */
-}
-
 static void e1000_watchdog_task(struct work_struct *work)
 {
 	struct e1000_adapter *adapter = container_of(work,
 						     struct e1000_adapter,
-						     watchdog_task);
+						     watchdog_task.work);
 	struct net_device *netdev = adapter->netdev;
 	struct e1000_mac_info *mac = &adapter->hw.mac;
 	struct e1000_phy_info *phy = &adapter->hw.phy;
@@ -5395,8 +5382,8 @@ static void e1000_watchdog_task(struct work_struct *work)
 
 	/* Reset the timer */
 	if (!test_bit(__E1000_DOWN, &adapter->state))
-		mod_timer(&adapter->watchdog_timer,
-			  round_jiffies(jiffies + 2 * HZ));
+		queue_delayed_work(e1000_workqueue, &adapter->watchdog_task,
+				   round_jiffies(2 * HZ));
 }
 
 #define E1000_TX_FLAGS_CSUM		0x00000001
@@ -7251,11 +7238,21 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_eeprom;
 	}
 
-	timer_setup(&adapter->watchdog_timer, e1000_watchdog, 0);
+	e1000_workqueue = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
+			                  e1000e_driver_name);
+
+	if (!e1000_workqueue)
+	{
+		err = -ENOMEM;
+		goto err_workqueue;
+	}
+
+	INIT_DELAYED_WORK(&adapter->watchdog_task, e1000_watchdog_task);
+	queue_delayed_work(e1000_workqueue, &adapter->watchdog_task, 0);
+
 	timer_setup(&adapter->phy_info_timer, e1000_update_phy_info, 0);
 
 	INIT_WORK(&adapter->reset_task, e1000_reset_task);
-	INIT_WORK(&adapter->watchdog_task, e1000_watchdog_task);
 	INIT_WORK(&adapter->downshift_task, e1000e_downshift_workaround);
 	INIT_WORK(&adapter->update_phy_task, e1000e_update_phy_task);
 	INIT_WORK(&adapter->print_hang_task, e1000_print_hw_hang);
@@ -7349,6 +7346,9 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 err_register:
+	flush_workqueue(e1000_workqueue);
+	destroy_workqueue(e1000_workqueue);
+err_workqueue:
 	if (!(adapter->flags & FLAG_HAS_AMT))
 		e1000e_release_hw_control(adapter);
 err_eeprom:
@@ -7395,15 +7395,17 @@ static void e1000_remove(struct pci_dev *pdev)
 	 */
 	if (!down)
 		set_bit(__E1000_DOWN, &adapter->state);
-	del_timer_sync(&adapter->watchdog_timer);
 	del_timer_sync(&adapter->phy_info_timer);
 
 	cancel_work_sync(&adapter->reset_task);
-	cancel_work_sync(&adapter->watchdog_task);
 	cancel_work_sync(&adapter->downshift_task);
 	cancel_work_sync(&adapter->update_phy_task);
 	cancel_work_sync(&adapter->print_hang_task);
 
+	cancel_delayed_work(&adapter->watchdog_task);
+	flush_workqueue(e1000_workqueue);
+	destroy_workqueue(e1000_workqueue);
+
 	if (adapter->flags & FLAG_HAS_HW_TIMESTAMP) {
 		cancel_work_sync(&adapter->tx_hwtstamp_work);
 		if (adapter->tx_hwtstamp_skb) {
-- 
2.22.0

