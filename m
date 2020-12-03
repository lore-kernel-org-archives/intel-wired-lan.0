From: Jakub Kicinski <kuba@kernel.org>
Date: Wed,  2 Dec 2020 18:18:06 -0800
Subject: [Intel-wired-lan] [PATCH net] iavf: fix double-release of rtnl_lock
Message-ID: <20201203021806.692194-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This code does not jump to exit on an error in iavf_lan_add_device(),
so the rtnl_unlock() from the normal path will follow.

Fixes: b66c7bc1cd4d ("iavf: Refactor init state machine")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 95543dfd4fe7..0a867d64d467 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1829,21 +1829,19 @@ static int iavf_init_get_resources(struct iavf_adapter *adapter)
 		}
 	}
 
 	adapter->netdev_registered = true;
 
 	netif_tx_stop_all_queues(netdev);
 	if (CLIENT_ALLOWED(adapter)) {
 		err = iavf_lan_add_device(adapter);
-		if (err) {
-			rtnl_unlock();
+		if (err)
 			dev_info(&pdev->dev, "Failed to add VF to client API service list: %d\n",
 				 err);
-		}
 	}
 	dev_info(&pdev->dev, "MAC address: %pM\n", adapter->hw.mac.addr);
 	if (netdev->features & NETIF_F_GRO)
 		dev_info(&pdev->dev, "GRO is enabled\n");
 
 	adapter->state = __IAVF_DOWN;
 	set_bit(__IAVF_VSI_DOWN, adapter->vsi.state);
 	rtnl_unlock();
-- 
2.26.2

