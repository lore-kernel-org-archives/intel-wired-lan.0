From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 16 Nov 2016 09:48:02 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix AER error handling
Message-ID: <20161116174802.11222.68715.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Make sure that we free the IRQs in ixgbe_io_error_detected() when
responding to an PCIe AER error and also restore them when the
interface recovers from it.

Previously it was possible to trigger BUG_ON() check in free_msix_irqs()
in the case where we call ixgbe_remove() after a failed recovery from
AER error because the inerrupts were not freed.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6d049d7..e545155 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10078,7 +10078,7 @@ static pci_ers_result_t ixgbe_io_error_detected(struct pci_dev *pdev,
 	}
 
 	if (netif_running(netdev))
-		ixgbe_down(adapter);
+		ixgbe_close_suspend(adapter);
 
 	if (!test_and_set_bit(__IXGBE_DISABLED, &adapter->state))
 		pci_disable_device(pdev);
@@ -10148,10 +10148,12 @@ static void ixgbe_io_resume(struct pci_dev *pdev)
 	}
 
 #endif
+	rtnl_lock();
 	if (netif_running(netdev))
-		ixgbe_up(adapter);
+		ixgbe_open(netdev);
 
 	netif_device_attach(netdev);
+	rtnl_unlock();
 }
 
 static const struct pci_error_handlers ixgbe_err_handler = {

