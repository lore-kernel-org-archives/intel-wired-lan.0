From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Fri, 11 Nov 2016 10:07:47 -0800
Subject: [Intel-wired-lan] [PATCH v3] ixgbe: handle close/suspend race with
 netif_device_detach/present
Message-ID: <20161111180747.17123.27924.stgit@localhost6.localdomain6>
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
to avoid clearing the interrupts second time in ixgbe_close();

Also extend the rtnl lock in ixgbe_resume() to netif_device_attach().

v2 - add rtnl locks and a check in ixgbe_remove()

v3 - remove the check in ixgbe_remove(), I will submit a separate
patch to address the case of failed PCIe error recovery

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 51cdac9..6d049d7 100644
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
 
-	if (err)
-		return err;
-
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

