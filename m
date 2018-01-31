From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Tue, 30 Jan 2018 16:51:27 -0800
Subject: [Intel-wired-lan] [PATCH 4/9] ixgbevf: setup queue counts
In-Reply-To: <20180131005015.19264.44085.stgit@localhost6.localdomain6>
References: <20180131005015.19264.44085.stgit@localhost6.localdomain6>
Message-ID: <20180131005127.19264.83738.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add calls for netif_set_real_num_t/rx_queues() in ixgbevf_open().
Make sure that calls to ixgbevf_open() are rtnl protected and improve
the error handling when setting up multiple queues.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   44 ++++++++++++++-------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index f8e1b1c..cb9d00a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3119,9 +3119,14 @@ static int ixgbevf_setup_all_tx_resources(struct ixgbevf_adapter *adapter)
 		if (!err)
 			continue;
 		hw_dbg(&adapter->hw, "Allocation for Tx Queue %u failed\n", i);
-		break;
+		goto err_setup_tx;
 	}
 
+	return 0;
+err_setup_tx:
+	/* rewind the index freeing the rings as we go */
+	while (i--)
+		ixgbevf_free_tx_resources(adapter->tx_ring[i]);
 	return err;
 }
 
@@ -3179,8 +3184,14 @@ static int ixgbevf_setup_all_rx_resources(struct ixgbevf_adapter *adapter)
 		if (!err)
 			continue;
 		hw_dbg(&adapter->hw, "Allocation for Rx Queue %u failed\n", i);
-		break;
+		goto err_setup_rx;
 	}
+
+	return 0;
+err_setup_rx:
+	/* rewind the index freeing the rings as we go */
+	while (i--)
+		ixgbevf_free_rx_resources(adapter->rx_ring[i]);
 	return err;
 }
 
@@ -3285,18 +3296,27 @@ int ixgbevf_open(struct net_device *netdev)
 	if (err)
 		goto err_req_irq;
 
+	/* Notify the stack of the actual queue counts. */
+	err = netif_set_real_num_tx_queues(netdev, adapter->num_tx_queues);
+	if (err)
+		goto err_set_queues;
+
+	err = netif_set_real_num_rx_queues(netdev, adapter->num_rx_queues);
+	if (err)
+		goto err_set_queues;
+
 	ixgbevf_up_complete(adapter);
 
 	return 0;
 
+err_set_queues:
+	ixgbevf_free_irq(adapter);
 err_req_irq:
-	ixgbevf_down(adapter);
-err_setup_rx:
 	ixgbevf_free_all_rx_resources(adapter);
-err_setup_tx:
+err_setup_rx:
 	ixgbevf_free_all_tx_resources(adapter);
+err_setup_tx:
 	ixgbevf_reset(adapter);
-
 err_setup_reset:
 
 	return err;
@@ -3948,17 +3968,11 @@ static int ixgbevf_resume(struct pci_dev *pdev)
 
 	rtnl_lock();
 	err = ixgbevf_init_interrupt_scheme(adapter);
+	if (!err && netif_running(netdev))
+		err = ixgbevf_open(netdev);
 	rtnl_unlock();
-	if (err) {
-		dev_err(&pdev->dev, "Cannot initialize interrupts\n");
+	if (err)
 		return err;
-	}
-
-	if (netif_running(netdev)) {
-		err = ixgbevf_open(netdev);
-		if (err)
-			return err;
-	}
 
 	netif_device_attach(netdev);
 

