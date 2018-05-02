From: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
Date: Wed,  2 May 2018 17:26:28 -0300
Subject: [Intel-wired-lan] [PATCH v3] ixgbe/ixgbevf: Free IRQ when PCI error
 recovery removes the device
Message-ID: <1525292788-22260-1-git-send-email-maurosr@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since commit f7f37e7ff2b9 ("ixgbe: handle close/suspend race with
netif_device_detach/present") ixgbe_close_suspend is called, from
ixgbe_close, only if the device is present, i.e. if it isn't detached.
That exposed a situation where IRQs weren't freed if a PCI error
recovery system opts to remove the device. For such case the pci channel
state is set to pci_channel_io_perm_failure and ixgbe_io_error_detected
was returning PCI_ERS_RESULT_DISCONNECT before calling
ixgbe_close_suspend consequentially not freeing IRQ and crashing when
the remove handler calls pci_disable_device, hitting a BUG_ON at
free_msi_irqs, which asserts that there is no non-free IRQ associated
with the device to be removed:

BUG_ON(irq_has_action(entry->irq + i));

The issue is fixed by calling the ixgbe_close_suspend before evaluate
the pci channel state.

Reported-by: Naresh Bannoth <nbannoth@in.ibm.com>
Reported-by: Abdul Haleem <abdhalee@in.ibm.com>
Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
---
v2: Extended the fix to ixgbevf driver.

v3: Improving the fix according to Alexander Duyck's review.
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 6 +++---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index afadba9..60eee07 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10909,14 +10909,14 @@ static pci_ers_result_t ixgbe_io_error_detected(struct pci_dev *pdev,
 	rtnl_lock();
 	netif_device_detach(netdev);
 
+	if (netif_running(netdev))
+		ixgbe_close_suspend(adapter);
+
 	if (state == pci_channel_io_perm_failure) {
 		rtnl_unlock();
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
-	if (netif_running(netdev))
-		ixgbe_close_suspend(adapter);
-
 	if (!test_and_set_bit(__IXGBE_DISABLED, &adapter->state))
 		pci_disable_device(pdev);
 	rtnl_unlock();
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index e3d04f2..6feb88f 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4770,14 +4770,14 @@ static pci_ers_result_t ixgbevf_io_error_detected(struct pci_dev *pdev,
 	rtnl_lock();
 	netif_device_detach(netdev);
 
+	if (netif_running(netdev))
+		ixgbevf_close_suspend(adapter);
+
 	if (state == pci_channel_io_perm_failure) {
 		rtnl_unlock();
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
-	if (netif_running(netdev))
-		ixgbevf_close_suspend(adapter);
-
 	if (!test_and_set_bit(__IXGBEVF_DISABLED, &adapter->state))
 		pci_disable_device(pdev);
 	rtnl_unlock();
-- 
2.7.4

