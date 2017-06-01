From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  1 Jun 2017 15:40:46 -0700
Subject: [Intel-wired-lan] [PATCH 10/15] fm10k: prepare_for_reset() when we
	lose PCIe Link
In-Reply-To: <20170601224051.6106-1-jacob.e.keller@intel.com>
References: <20170601224051.6106-1-jacob.e.keller@intel.com>
Message-ID: <20170601224051.6106-11-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If we lose PCIe link, such as when an unannounced PFLR event occurs, or
when a device is surprise removed, we currently detach the device and
close the netdev. This unfortunately leaves a lot of things still
active, such as the msix_mbx_pf IRQ, and Tx/Rx resources.

This can cause problems because the register reads will return
potentially invalid values which may result in unknown driver behavior.

Begin the process of resetting using fm10k_prepare_for_reset(), much in
the same way as the suspend and resume cycle does. This will attempt to
shutdown as much as possible, in order to prevent possible issues.

Since the __FM10K_RESETTING state is long lived, we'll also stop waiting
for it when we check to the fm10k_reset_subtask. This is important since
otherwise it would deadlock with the fm10k_detach_subtask. Additionally,
stop attempting to manage the mailbox subtask if we're
detached/resetting, as there is nothing to do when we don't have a PCIe
address.

Overall this produces a much cleaner shutdown and recovery cycle for
a PCIe surprise remove event.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 39 +++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 6a7b4c5429ae..2d94a16f9613 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -141,8 +141,9 @@ static void fm10k_prepare_for_reset(struct fm10k_intfc *interface)
 	/* put off any impending NetWatchDogTimeout */
 	netif_trans_update(netdev);
 
-	while (test_and_set_bit(__FM10K_RESETTING, interface->state))
-		usleep_range(1000, 2000);
+	/* Nothing to do if a reset is already in progress */
+	if (test_and_set_bit(__FM10K_RESETTING, interface->state))
+		return;
 
 	rtnl_lock();
 
@@ -168,6 +169,8 @@ static int fm10k_handle_reset(struct fm10k_intfc *interface)
 	struct fm10k_hw *hw = &interface->hw;
 	int err;
 
+	WARN_ON(!test_bit(__FM10K_RESETTING, interface->state));
+
 	rtnl_lock();
 
 	pci_set_master(interface->pdev);
@@ -247,27 +250,33 @@ static void fm10k_detach_subtask(struct fm10k_intfc *interface)
 	u32 __iomem *hw_addr;
 	u32 value;
 
-	/* do nothing if device is still present or hw_addr is set */
+	/* do nothing if netdev is still present or hw_addr is set */
 	if (netif_device_present(netdev) || interface->hw.hw_addr)
 		return;
 
+	/* We've lost the PCIe register space, and can no longer access the
+	 * device. Shut everything except the detach subtask down and prepare
+	 * to reset the device in case we recover.
+	 */
+	fm10k_prepare_for_reset(interface);
+
 	/* check the real address space to see if we've recovered */
 	hw_addr = READ_ONCE(interface->uc_addr);
 	value = readl(hw_addr);
 	if (~value) {
+		/* Restore the hardware address */
 		interface->hw.hw_addr = interface->uc_addr;
+
+		/* PCIe link has been restored, and the device is active
+		 * again. Restore everything and reset the device.
+		 */
+		fm10k_handle_reset(interface);
+
+		/* Re-attach the netdev */
 		netif_device_attach(netdev);
-		set_bit(FM10K_FLAG_RESET_REQUESTED, interface->flags);
 		netdev_warn(netdev, "PCIe link restored, device now attached\n");
 		return;
 	}
-
-	rtnl_lock();
-
-	if (netif_running(netdev))
-		dev_close(netdev);
-
-	rtnl_unlock();
 }
 
 static void fm10k_reinit(struct fm10k_intfc *interface)
@@ -360,6 +369,10 @@ static void fm10k_watchdog_update_host_state(struct fm10k_intfc *interface)
  **/
 static void fm10k_mbx_subtask(struct fm10k_intfc *interface)
 {
+	/* If we're resetting, bail out */
+	if (test_bit(__FM10K_RESETTING, interface->state))
+		return;
+
 	/* process upstream mailbox and update device state */
 	fm10k_watchdog_update_host_state(interface);
 
@@ -609,9 +622,11 @@ static void fm10k_service_task(struct work_struct *work)
 
 	interface = container_of(work, struct fm10k_intfc, service_task);
 
+	/* Check whether we're detached first */
+	fm10k_detach_subtask(interface);
+
 	/* tasks run even when interface is down */
 	fm10k_mbx_subtask(interface);
-	fm10k_detach_subtask(interface);
 	fm10k_reset_subtask(interface);
 
 	/* tasks only run when interface is up */
-- 
2.13.0.598.gf927b9495246

