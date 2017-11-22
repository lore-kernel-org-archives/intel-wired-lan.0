From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Nov 2017 10:57:35 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 14/16] ixgbe: Fix
 handling of macvlan Tx offload
In-Reply-To: <20171122185256.29785.93548.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
Message-ID: <20171122185735.29785.22305.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This update makes it so that we report the actual number of Tx queues via
real_num_tx_queues but are still restricted to RSS on only the first pool
by setting num_tc equal to 1. Doing this locks us into only having the
ability to setup XPS on the queues in that pool, and only those queues
should be used for transmitting anything other than macvlan traffic.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    4 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   20 ++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index cfe5a6af04d0..b3c282d09b18 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -619,6 +619,10 @@ static bool ixgbe_set_sriov_queues(struct ixgbe_adapter *adapter)
 	}
 
 #endif
+	/* populate TC0 for use by pool 0 */
+	netdev_set_tc_queue(adapter->netdev, 0,
+			    adapter->num_rx_queues_per_pool, 0);
+
 	return true;
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index bcd05761b8e1..dba69c0bc644 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6563,20 +6563,12 @@ int ixgbe_open(struct net_device *netdev)
 		goto err_req_irq;
 
 	/* Notify the stack of the actual queue counts. */
-	if (adapter->num_rx_pools > 1)
-		queues = adapter->num_rx_queues_per_pool;
-	else
-		queues = adapter->num_tx_queues;
-
+	queues = adapter->num_tx_queues;
 	err = netif_set_real_num_tx_queues(netdev, queues);
 	if (err)
 		goto err_set_queues;
 
-	if (adapter->num_rx_pools > 1 &&
-	    adapter->num_rx_queues > IXGBE_MAX_L2A_QUEUES)
-		queues = IXGBE_MAX_L2A_QUEUES;
-	else
-		queues = adapter->num_rx_queues;
+	queues = adapter->num_rx_queues;
 	err = netif_set_real_num_rx_queues(netdev, queues);
 	if (err)
 		goto err_set_queues;
@@ -8806,6 +8798,14 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 	} else {
 		netdev_reset_tc(dev);
 
+		/* To support macvlan offload we have to use num_tc to
+		 * restrict the queues that can be used by the device.
+		 * By doing this we can avoid reporting a false number of
+		 * queues.
+		 */
+		if (!tc && adapter->num_rx_pools > 1)
+			netdev_set_num_tc(dev, 1);
+
 		if (adapter->hw.mac.type == ixgbe_mac_82598EB)
 			adapter->hw.fc.requested_mode = adapter->last_lfc_mode;
 

