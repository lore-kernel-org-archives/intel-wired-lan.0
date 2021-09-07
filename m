From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Tue,  7 Sep 2021 09:25:40 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix deadlock occurrence
 during resetting VF interface
Message-ID: <20210907092540.59568-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

System hangs if close the interface is called from the kernel during
the interface is in resetting state.
During resetting operation the link is closing but kernel didn't
know it and it tried to close this interface again what sometimes
led to deadlock.
Inform kernel about current state of interface
and turn off the flag IFF_UP when interface is closing until reset
is finished.
Previously it was most likely to hang the system when kernel
(network manager) tried to close the interface in the same time
when interface was in resetting state because of deadlock.

Fixes: 3c8e0b989aa1 ("i40vf: don't stop me now")
Signed-off-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 80437ef26391..a089c0cbc26c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2207,6 +2207,7 @@ continue_reset:
 		   (adapter->state == __IAVF_RESETTING));
 
 	if (running) {
+		netdev->flags &= ~IFF_UP;
 		netif_carrier_off(netdev);
 		netif_tx_stop_all_queues(netdev);
 		adapter->link_up = false;
@@ -2315,7 +2316,7 @@ continue_reset:
 		iavf_configure(adapter);
 
 		iavf_up_complete(adapter);
-
+		netdev->flags |= IFF_UP;
 		iavf_irq_enable(adapter, true);
 	} else {
 		adapter->state = __IAVF_DOWN;
@@ -2328,6 +2329,8 @@ continue_reset:
 reset_err:
 	mutex_unlock(&adapter->client_lock);
 	mutex_unlock(&adapter->crit_lock);
+	if (running)
+		netdev->flags |= IFF_UP;
 	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
 	iavf_close(netdev);
 }
-- 
2.27.0

