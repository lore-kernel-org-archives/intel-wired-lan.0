From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 10 Jul 2015 15:31:34 -0600
Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove bimodal SR-IOV disabling
Message-ID: <20150710212710.9501.14320.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When unbinding an SR-IOV device with VFs configured from ixgbe, the
driver behaves in one of two ways.  If max_vfs was specified, the
SR-IOV state is disabled, removing the VFs.  The occurs regardless of
whether the VF count was later modified through sysfs.  If however
max_vfs is zero, such as by not specifying the module parameter, the
VFs persist after the PF is unbound from ixgbe.  If the PF is then
bound to vfio-pci to be assigned to a VM, the PF is non-functional.

From the comment, commit da36b64736cf ("ixgbe: Implement PCI SR-IOV
sysfs callback operation") clearly intended this alternate behavior,
but probably didn't realize the PF doesn't work in this mode.

This bimodal behavior is confusing to users and results in a state
where the PF is broken for other uses unless the user sets
sriov_numvfs to zero prior to unbinding the device.  Remove this
behavior so that VFs are removed and the PF is functional for other
uses after unbind, regardless of the way VFs are enabled.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Cc: Greg Rose <gregory.v.rose@intel.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---

I can only think that not disabling SR-IOV was meant to enable some
sort of persistence for VFs, but that's probably better accomplished
with either udev rules and/or modprobe.d install scripts.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 5be12a0..de04e3e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8810,12 +8810,7 @@ static void ixgbe_remove(struct pci_dev *pdev)
 		unregister_netdev(netdev);
 
 #ifdef CONFIG_PCI_IOV
-	/*
-	 * Only disable SR-IOV on unload if the user specified the now
-	 * deprecated max_vfs module parameter.
-	 */
-	if (max_vfs)
-		ixgbe_disable_sriov(adapter);
+	ixgbe_disable_sriov(adapter);
 #endif
 	ixgbe_clear_interrupt_scheme(adapter);
 

