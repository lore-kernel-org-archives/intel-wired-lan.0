From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 16 Nov 2016 11:25:34 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix AER error handling
Message-ID: <20161116192534.12765.65734.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Make sure that we free the IRQs in ixgbevf_io_error_detected() when
responding to an PCIe AER error and also restore them when the
interface recovers from it.

Previously it was possible to trigger BUG_ON() check in free_msix_irqs()
in the case where we call ixgbevf_remove() after a failed recovery from
AER error because the inerrupts were not freed.

Also moved the down and free functions into ixgbevf_close_suspend()
same as with ixgbe.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   43 ++++++++++++---------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 2cc3d90..8bc3e4d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3228,6 +3228,21 @@ int ixgbevf_open(struct net_device *netdev)
 }
 
 /**
+ * ixgbevf_close_suspend - actions necessary to both suspend and close flows
+ * @adapter: the private adapter struct
+ *
+ * This function should contain the necessary work common to both suspending
+ * and closing of the device.
+ */
+static void ixgbevf_close_suspend(struct ixgbevf_adapter *adapter)
+{
+		ixgbevf_down(adapter);
+		ixgbevf_free_irq(adapter);
+		ixgbevf_free_all_tx_resources(adapter);
+		ixgbevf_free_all_rx_resources(adapter);
+}
+
+/**
  * ixgbevf_close - Disables a network interface
  * @netdev: network interface device structure
  *
@@ -3242,14 +3257,8 @@ int ixgbevf_close(struct net_device *netdev)
 {
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
 
-	if (!netif_device_present(netdev))
-		return 0;
-
-	ixgbevf_down(adapter);
-	ixgbevf_free_irq(adapter);
-
-	ixgbevf_free_all_tx_resources(adapter);
-	ixgbevf_free_all_rx_resources(adapter);
+	if (netif_device_present(netdev))
+		ixgbevf_close_suspend(adapter);
 
 	return 0;
 }
@@ -3802,13 +3811,10 @@ static int ixgbevf_suspend(struct pci_dev *pdev, pm_message_t state)
 	rtnl_lock();
 	netif_device_detach(netdev);
 
-	if (netif_running(netdev)) {
-		ixgbevf_down(adapter);
-		ixgbevf_free_irq(adapter);
-		ixgbevf_free_all_tx_resources(adapter);
-		ixgbevf_free_all_rx_resources(adapter);
-		ixgbevf_clear_interrupt_scheme(adapter);
-	}
+	if (netif_running(netdev))
+		ixgbevf_close_suspend(adapter);
+
+	ixgbevf_clear_interrupt_scheme(adapter);
 	rtnl_unlock();
 
 #ifdef CONFIG_PM
@@ -4247,7 +4253,7 @@ static pci_ers_result_t ixgbevf_io_error_detected(struct pci_dev *pdev,
 	}
 
 	if (netif_running(netdev))
-		ixgbevf_down(adapter);
+		ixgbevf_close_suspend(adapter);
 
 	if (!test_and_set_bit(__IXGBEVF_DISABLED, &adapter->state))
 		pci_disable_device(pdev);
@@ -4295,12 +4301,13 @@ static pci_ers_result_t ixgbevf_io_slot_reset(struct pci_dev *pdev)
 static void ixgbevf_io_resume(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
-	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
 
+	rtnl_lock();
 	if (netif_running(netdev))
-		ixgbevf_up(adapter);
+		ixgbevf_open(netdev);
 
 	netif_device_attach(netdev);
+	rtnl_unlock();
 }
 
 /* PCI Error Recovery (ERS) */

