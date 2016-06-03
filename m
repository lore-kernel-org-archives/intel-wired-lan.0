From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  3 Jun 2016 15:42:22 -0700
Subject: [Intel-wired-lan] [PATCH v1 12/18] fm10k: use common reset flow
	when handling io errors from PCI stack
In-Reply-To: <20160603224228.10192-1-jacob.e.keller@intel.com>
References: <20160603224228.10192-1-jacob.e.keller@intel.com>
Message-ID: <20160603224228.10192-13-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Now that we have extracted the necessary steps for a split
suspend/resume flow, re-use these functions instead of using the current
open coded flow. This ensures that we don't miss any steps. It also
ensures that we have the correct driver states set.

Since we'll be handling all of the reset flow ourselves, we no longer
need to request a reset in the io_slot_reset() function.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 60 ++++------------------------
 1 file changed, 7 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index ab26bfa0a342..0ab20d2c4ea6 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2307,17 +2307,7 @@ static pci_ers_result_t fm10k_io_error_detected(struct pci_dev *pdev,
 	if (state == pci_channel_io_perm_failure)
 		return PCI_ERS_RESULT_DISCONNECT;
 
-	rtnl_lock();
-
-	if (netif_running(netdev))
-		fm10k_close(netdev);
-
-	fm10k_mbx_free_irq(interface);
-
-	/* free interrupts */
-	fm10k_clear_queueing_scheme(interface);
-
-	rtnl_unlock();
+	fm10k_prepare_suspend(interface);
 
 	/* Request a slot reset. */
 	return PCI_ERS_RESULT_NEED_RESET;
@@ -2331,7 +2321,6 @@ static pci_ers_result_t fm10k_io_error_detected(struct pci_dev *pdev,
  */
 static pci_ers_result_t fm10k_io_slot_reset(struct pci_dev *pdev)
 {
-	struct fm10k_intfc *interface = pci_get_drvdata(pdev);
 	pci_ers_result_t result;
 
 	if (pci_enable_device_mem(pdev)) {
@@ -2349,12 +2338,6 @@ static pci_ers_result_t fm10k_io_slot_reset(struct pci_dev *pdev)
 
 		pci_wake_from_d3(pdev, false);
 
-		/* refresh hw_addr in case it was dropped */
-		interface->hw.hw_addr = interface->uc_addr;
-
-		interface->flags |= FM10K_FLAG_RESET_REQUESTED;
-		fm10k_service_event_schedule(interface);
-
 		result = PCI_ERS_RESULT_RECOVERED;
 	}
 
@@ -2374,44 +2357,15 @@ static void fm10k_io_resume(struct pci_dev *pdev)
 {
 	struct fm10k_intfc *interface = pci_get_drvdata(pdev);
 	struct net_device *netdev = interface->netdev;
-	struct fm10k_hw *hw = &interface->hw;
-	int err = 0;
+	int err;
 
-	/* reset hardware to known state */
-	err = hw->mac.ops.init_hw(&interface->hw);
-	if (err) {
-		dev_err(&pdev->dev, "init_hw failed: %d\n", err);
-		return;
-	}
+	err = fm10k_handle_resume(interface);
 
-	/* reset statistics starting values */
-	hw->mac.ops.rebind_hw_stats(hw, &interface->stats);
-
-	rtnl_lock();
-
-	err = fm10k_init_queueing_scheme(interface);
-	if (err) {
-		dev_err(&interface->pdev->dev,
-			"init_queueing_scheme failed: %d\n", err);
-		goto unlock;
-	}
-
-	/* reassociate interrupts */
-	fm10k_mbx_request_irq(interface);
-
-	rtnl_lock();
-	if (netif_running(netdev))
-		err = fm10k_open(netdev);
-	rtnl_unlock();
-
-	/* final check of hardware state before registering the interface */
-	err = err ? : fm10k_hw_ready(interface);
-
-	if (!err)
+	if (err)
+		dev_warn(&pdev->dev,
+			 "fm10k_io_resume failed: %d\n", err);
+	else
 		netif_device_attach(netdev);
-
-unlock:
-	rtnl_unlock();
 }
 
 static const struct pci_error_handlers fm10k_err_handler = {
-- 
2.8.2.820.gd1c5f70

