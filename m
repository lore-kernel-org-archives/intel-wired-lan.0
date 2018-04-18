From: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
Date: Wed, 18 Apr 2018 14:16:55 -0300
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix free irq process when removing
 device due to PCI Errors
Message-ID: <1524071815-32439-1-git-send-email-maurosr@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When a PCI error is detected ixgbe's pci error handler
ixgbe_io_error_detected detaches the network device. In general the PCI
error recovery mechanism may try to recover the device from the error or
eventually remove it completely from the system.

Since commit f7f37e7ff2b9 ("ixgbe: handle close/suspend race with
netif_device_detach/present")
we only follow to ixgbe_close_suspend if
the device is preset, i.e. if it wasn't detached, and then the irqs are
freed. That prevents to free irqs when the PCI error recovery system
decides to remove the device and hitting a BUG_ON free_msi_irqs when it
search for non freed irqs associated with the device being removed:

BUG_ON(irq_has_action(entry->irq + i));

This is fixed allowing the ixgbe_close_suspend, and thus ixgbe_free_irq,
to be called also when the PCI error recovery mechanism sets the device
channel to permanent failure state.

Reported-by: Naresh Bannoth <nbannoth@in.ibm.com>
Reported-by: Abdul Haleem <abdhalee@in.ibm.com>
Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index afadba9..d170de8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6679,7 +6679,8 @@ int ixgbe_close(struct net_device *netdev)
 
 	ixgbe_ptp_stop(adapter);
 
-	if (netif_device_present(netdev))
+	if (netif_device_present(netdev) ||
+	    adapter->pdev->error_state == pci_channel_io_perm_failure)
 		ixgbe_close_suspend(adapter);
 
 	ixgbe_fdir_filter_exit(adapter);
-- 
2.7.4

