From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:27:09 -0700
Subject: [Intel-wired-lan] [net-next 19/25] fm10k: start service timer on
	probe
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-19-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since the service task handles varying work that doesn't all require the
interface to be up, launch the service timer immediately. This ensures
that we continually check the mailbox, as well as handle other tasks
while the device is down.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 25458ca..cc527dd 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1489,7 +1489,7 @@ void fm10k_up(struct fm10k_intfc *interface)
 	/* enable transmits */
 	netif_tx_start_all_queues(interface->netdev);
 
-	/* kick off the service timer */
+	/* kick off the service timer now */
 	hw->mac.get_host_state = 1;
 	mod_timer(&interface->service_timer, jiffies);
 }
@@ -1529,8 +1529,6 @@ void fm10k_down(struct fm10k_intfc *interface)
 	/* disable polling routines */
 	fm10k_napi_disable_all(interface);
 
-	del_timer_sync(&interface->service_timer);
-
 	/* capture stats one last time before stopping interface */
 	fm10k_update_stats(interface);
 
@@ -1656,6 +1654,9 @@ static int fm10k_sw_init(struct fm10k_intfc *interface,
 		    (unsigned long)interface);
 	INIT_WORK(&interface->service_task, fm10k_service_task);
 
+	/* kick off service timer now, even when interface is down */
+	mod_timer(&interface->service_timer, (HZ * 2) + jiffies);
+
 	/* Intitialize timestamp data */
 	fm10k_ts_init(interface);
 
@@ -1872,6 +1873,8 @@ static void fm10k_remove(struct pci_dev *pdev)
 	struct fm10k_intfc *interface = pci_get_drvdata(pdev);
 	struct net_device *netdev = interface->netdev;
 
+	del_timer_sync(&interface->service_timer);
+
 	set_bit(__FM10K_SERVICE_DISABLE, &interface->state);
 	cancel_work_sync(&interface->service_task);
 
-- 
1.9.3

