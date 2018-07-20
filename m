From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Fri, 20 Jul 2018 18:29:29 -0400
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 1/2] ixgbe: Reorder
 Tx/Rx shutdown to reduce time needed to stop device
In-Reply-To: <20180720222647.3568.34992.stgit@ahduyck-green-test.jf.intel.com>
References: <20180720222647.3568.34992.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180720222929.3568.39183.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change is meant to help reduce the time needed to shutdown the
transmit and receive paths for the device. Specifically what we now do
after this patch is disable the transmit path first at the netdev level,
and then work on disabling the Rx. This way while we are waiting on the Rx
queues to be disabled the Tx queues have an opportunity to drain out.

In addition I have droped the 10ms timeout that was left in the ixgbe_down
function that seems to have been carried through from back in e1000 as far
as I can tell. We shouldn't need it since we don't actually disable the Tx
until much later and we have additional logic in place for verifying the Tx
queues have been disabled.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 372174c..7eef089 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5814,6 +5814,13 @@ void ixgbe_down(struct ixgbe_adapter *adapter)
 	if (test_and_set_bit(__IXGBE_DOWN, &adapter->state))
 		return; /* do nothing if already down */
 
+	/* Shut off incoming Tx traffic */
+	netif_tx_stop_all_queues(netdev);
+
+	/* call carrier off first to avoid false dev_watchdog timeouts */
+	netif_carrier_off(netdev);
+	netif_tx_disable(netdev);
+
 	/* disable receives */
 	hw->mac.ops.disable_rx(hw);
 
@@ -5822,16 +5829,9 @@ void ixgbe_down(struct ixgbe_adapter *adapter)
 		/* this call also flushes the previous write */
 		ixgbe_disable_rx_queue(adapter, adapter->rx_ring[i]);
 
-	usleep_range(10000, 20000);
-
 	/* synchronize_sched() needed for pending XDP buffers to drain */
 	if (adapter->xdp_ring[0])
 		synchronize_sched();
-	netif_tx_stop_all_queues(netdev);
-
-	/* call carrier off first to avoid false dev_watchdog timeouts */
-	netif_carrier_off(netdev);
-	netif_tx_disable(netdev);
 
 	ixgbe_irq_disable(adapter);
 

