From: Eryk Rybak <eryk.roch.rybak@intel.com>
Date: Thu, 21 Jan 2021 16:06:05 +0000
Subject: [Intel-wired-lan] [PATCH net-next] iavf: Fix asynchronous tasks
 during driver remove
Message-ID: <20210121160605.86278-1-eryk.roch.rybak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Although rare, is possible for unexpected driver watchdog or Admin
Queue tasks to run during the execution of iavf_remove function.
Then, is not possible to obtain the standard __IAVF_IN_CRITICAL_TASK
lock and difficult to ensure that the driver state stays consistent
during the full removal process.

Fully stops all asynchronous tasks in the beginning of iavf_remove,
and uses a single-threaded flow to shut down the driver.

Fixes: fdd4044ffdc8("iavf: Remove timer for work triggering, use delaying work instead")
Signed-off-by: Nick Nunley <nicholas.d.nunley@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Eryk Rybak <eryk.roch.rybak@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 29 ++++++++++++++++-----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 21a354e..84430a3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1903,6 +1903,12 @@ static void iavf_watchdog_task(struct work_struct *work)
 	struct iavf_hw *hw = &adapter->hw;
 	u32 reg_val;
 
+	/* If the driver is in the process of being removed then don't run or
+	 * reschedule the watchdog task.
+	 */
+	if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
+		return;
+
 	if (test_and_set_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section))
 		goto restart_watchdog;
 
@@ -2283,6 +2289,12 @@ static void iavf_adminq_task(struct work_struct *work)
 	u32 val, oldval;
 	u16 pending;
 
+	/* If the driver is in the process of being removed then return
+	 * immediately and don't re-enable the Admin Queue interrupt.
+	 */
+	if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
+		return;
+
 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
 		goto out;
 
@@ -3261,6 +3273,13 @@ static int iavf_close(struct net_device *netdev)
 
 	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
 
+	/* If the interface is closing as part of driver removal it doesn't
+	 * wait. The VF resources will be reinitialized when the hardware is
+	 * reset.
+	 */
+	if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
+		return 0;
+
 	/* We explicitly don't free resources here because the hardware is
 	 * still active and can DMA into memory. Resources are cleared in
 	 * iavf_virtchnl_completion() after we get confirmation from the PF
@@ -3869,11 +3888,14 @@ static void iavf_remove(struct pci_dev *pdev)
 	struct iavf_cloud_filter *cf, *cftmp;
 	struct iavf_hw *hw = &adapter->hw;
 	int err;
-	/* Indicate we are in remove and not to run reset_task */
+	/* Indicate that program driver is remove task and not
+	 * to run/schedule any driver tasks
+	 */
 	set_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section);
 	cancel_delayed_work_sync(&adapter->init_task);
 	cancel_work_sync(&adapter->reset_task);
 	cancel_delayed_work_sync(&adapter->client_task);
+	iavf_misc_irq_disable(adapter);
 	if (adapter->netdev_registered) {
 		unregister_netdev(netdev);
 		adapter->netdev_registered = false;
@@ -3898,15 +3920,10 @@ static void iavf_remove(struct pci_dev *pdev)
 	}
 	iavf_free_all_tx_resources(adapter);
 	iavf_free_all_rx_resources(adapter);
-	iavf_misc_irq_disable(adapter);
 	iavf_free_misc_irq(adapter);
 	iavf_reset_interrupt_capability(adapter);
 	iavf_free_q_vectors(adapter);
 
-	cancel_delayed_work_sync(&adapter->watchdog_task);
-
-	cancel_work_sync(&adapter->adminq_task);
-
 	iavf_free_rss(adapter);
 
 	if (hw->aq.asq.count)

base-commit: 53959a962308c53a02a89dab13e42c3b69f8c51c
-- 
2.20.1

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

