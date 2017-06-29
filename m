From: Alice Michael <alice.michael@intel.com>
Date: Thu, 29 Jun 2017 04:36:32 -0400
Subject: [Intel-wired-lan] [next PATCH S75-V2 01/12] i40evf: use netdev
	variable in reset task
Message-ID: <20170629083643.82018-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

If we're going to bother initializing a variable to reference it we might
as well use it.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 77d2835..ef55f71 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1879,7 +1879,7 @@ static void i40evf_reset_task(struct work_struct *work)
 	}
 
 continue_reset:
-	if (netif_running(adapter->netdev)) {
+	if (netif_running(netdev)) {
 		netif_carrier_off(netdev);
 		netif_tx_stop_all_queues(netdev);
 		adapter->link_up = false;
@@ -1947,7 +1947,7 @@ static void i40evf_reset_task(struct work_struct *work)
 	return;
 reset_err:
 	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
-	i40evf_close(adapter->netdev);
+	i40evf_close(netdev);
 }
 
 /**
-- 
2.9.3

