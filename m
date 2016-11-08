From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Tue, 08 Nov 2016 11:47:33 -0800
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: handle close/suspend race with
 netif_device_detach/present
Message-ID: <20161108194733.29155.16082.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When an interface is part of a namespace it is possible that
ixgbe_close() may be called while __ixgbe_shutdown() is running
which ends up in a double free WARN and/or a BUG in free_msi_irqs().

To handle this situation we extend the rtnl_lock() to protect the
call to netif_device_detach() and ixgbe_clear_interrupt_scheme()
in __ixgbe_shutdown() and check for netif_device_present()
to avoid clearing the interrupts second time in ixgbe_close() and
ixgbe_remove().

Also extend the rtnl lock in ixgbe_resume() to netif_device_attach().

v2 - add rtnl locks and a check in ixgbe_remove()

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 51cdac9..0b1fa5d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6200,7 +6200,8 @@ int ixgbe_close(struct net_device *netdev)
 
 	ixgbe_ptp_stop(adapter);
 
-	ixgbe_close_suspend(adapter);
+	if (netif_device_present(netdev))
+		ixgbe_close_suspend(adapter);
 
 	ixgbe_fdir_filter_exit(adapter);
 
@@ -6245,14 +6246,12 @@ static int ixgbe_resume(struct pci_dev *pdev)
 	if (!err && netif_running(netdev))
 		err = ixgbe_open(netdev);
 
-	rtnl_unlock();
-
-	if (err)
-		return err;
 
-	netif_device_attach(netdev);
+	if (!err)
+		netif_device_attach(netdev);
+	rtnl_unlock();
 
-	return 0;
+	return err;
 }
 #endif /* CONFIG_PM */
 
@@ -6267,14 +6266,14 @@ static int __ixgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	int retval = 0;
 #endif
 
+	rtnl_lock();
 	netif_device_detach(netdev);
 
-	rtnl_lock();
 	if (netif_running(netdev))
 		ixgbe_close_suspend(adapter);
-	rtnl_unlock();
 
 	ixgbe_clear_interrupt_scheme(adapter);
+	rtnl_unlock();
 
 #ifdef CONFIG_PM
 	retval = pci_save_state(pdev);
@@ -9923,7 +9922,10 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	if (netdev->reg_state == NETREG_REGISTERED)
 		unregister_netdev(netdev);
 
-	ixgbe_clear_interrupt_scheme(adapter);
+	rtnl_lock();
+	if (netif_device_present(netdev))
+		ixgbe_clear_interrupt_scheme(adapter);
+	rtnl_unlock();
 
 	ixgbe_release_hw_control(adapter);
 

