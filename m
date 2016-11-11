From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Fri, 11 Nov 2016 10:12:51 -0800
Subject: [Intel-wired-lan] [PATCH v4] ixgbevf: handle race between close and
 suspend on shutdown
Message-ID: <20161111181251.17498.91161.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When an interface is part of a namespace it is possible that
ixgbevf_close() may be called while ixgbevf_suspend() is running
which ends up in a double free WARN and/or a BUG in free_msi_irqs()

To handle this situation we extend the rtnl_lock() to protect the
call to netif_device_detach() and check for !netif_device_present()
to avoid entering close while in suspend.

Also added rtnl locks to ixgbevf_queue_reset_subtask().

-v2 handle the race with netif_device_detach/present() and rtnl
locks as suggested by Alex Duyck

-v3 add rtnl locks and check in ixgbevf_remove()

-v4 revert the ixgbevf_remove() changes from v3, I will submit a
separate patch to deal with the PCIe AER issue on failed recovery

CC: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index d316f50..2cc3d90 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3242,6 +3242,9 @@ int ixgbevf_close(struct net_device *netdev)
 {
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
 
+	if (!netif_device_present(netdev))
+		return 0;
+
 	ixgbevf_down(adapter);
 	ixgbevf_free_irq(adapter);
 
@@ -3268,6 +3271,8 @@ static void ixgbevf_queue_reset_subtask(struct ixgbevf_adapter *adapter)
 	 * match packet buffer alignment. Unfortunately, the
 	 * hardware is not flexible enough to do this dynamically.
 	 */
+	rtnl_lock();
+
 	if (netif_running(dev))
 		ixgbevf_close(dev);
 
@@ -3276,6 +3281,8 @@ static void ixgbevf_queue_reset_subtask(struct ixgbevf_adapter *adapter)
 
 	if (netif_running(dev))
 		ixgbevf_open(dev);
+
+	rtnl_unlock();
 }
 
 static void ixgbevf_tx_ctxtdesc(struct ixgbevf_ring *tx_ring,
@@ -3792,17 +3799,17 @@ static int ixgbevf_suspend(struct pci_dev *pdev, pm_message_t state)
 	int retval = 0;
 #endif
 
+	rtnl_lock();
 	netif_device_detach(netdev);
 
 	if (netif_running(netdev)) {
-		rtnl_lock();
 		ixgbevf_down(adapter);
 		ixgbevf_free_irq(adapter);
 		ixgbevf_free_all_tx_resources(adapter);
 		ixgbevf_free_all_rx_resources(adapter);
 		ixgbevf_clear_interrupt_scheme(adapter);
-		rtnl_unlock();
 	}
+	rtnl_unlock();
 
 #ifdef CONFIG_PM
 	retval = pci_save_state(pdev);

