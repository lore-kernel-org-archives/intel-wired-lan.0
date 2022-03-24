From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Thu, 24 Mar 2022 14:19:15 +0100
Subject: [Intel-wired-lan] [PATCH net v1] Revert "iavf: Fix deadlock
 occurrence during resetting VF interface"
Message-ID: <20220324131915.13929-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change caused a regression with resetting while changing network
namespaces. By clearing the IFF_UP flag, the kernel now thinks it has
fully closed the device.

This reverts commit 0cc318d2e8408bc0ffb4662a0c3e5e57005ac6ff.

Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 0e178a0a..310fd57 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2706,7 +2706,6 @@ static void iavf_reset_task(struct work_struct *work)
 	running = adapter->state == __IAVF_RUNNING;
 
 	if (running) {
-		netdev->flags &= ~IFF_UP;
 		netif_carrier_off(netdev);
 		netif_tx_stop_all_queues(netdev);
 		adapter->link_up = false;
@@ -2821,7 +2820,7 @@ static void iavf_reset_task(struct work_struct *work)
 		 * to __IAVF_RUNNING
 		 */
 		iavf_up_complete(adapter);
-		netdev->flags |= IFF_UP;
+
 		iavf_irq_enable(adapter, true);
 	} else {
 		iavf_change_state(adapter, __IAVF_DOWN);
@@ -2837,10 +2836,8 @@ static void iavf_reset_task(struct work_struct *work)
 reset_err:
 	mutex_unlock(&adapter->client_lock);
 	mutex_unlock(&adapter->crit_lock);
-	if (running) {
+	if (running)
 		iavf_change_state(adapter, __IAVF_RUNNING);
-		netdev->flags |= IFF_UP;
-	}
 	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
 	iavf_close(netdev);
 }
-- 
2.27.0

