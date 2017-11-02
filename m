From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 02 Nov 2017 16:34:11 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 3/5] ixgbe: Fix
 handling of macvlan Tx offload
In-Reply-To: <20171102232857.15146.21583.stgit@localhost.localdomain>
References: <20171102232857.15146.21583.stgit@localhost.localdomain>
Message-ID: <20171102233351.15146.16006.stgit@localhost.localdomain>
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 69ef35d13c36..b22ec4b9d02c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6638,8 +6638,9 @@ int ixgbe_open(struct net_device *netdev)
 		goto err_req_irq;
 
 	/* Notify the stack of the actual queue counts. */
-	if (adapter->num_rx_pools > 1)
-		queues = adapter->num_rx_queues_per_pool;
+	if (adapter->num_rx_pools > 1 &&
+	    adapter->num_tx_queues > IXGBE_MAX_L2A_QUEUES)
+		queues = IXGBE_MAX_L2A_QUEUES;
 	else
 		queues = adapter->num_tx_queues;
 
@@ -8901,6 +8902,18 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 		if (adapter->hw.mac.type == ixgbe_mac_82598EB)
 			adapter->hw.fc.requested_mode = adapter->last_lfc_mode;
 
+		/* To support macvlan offload we have to use num_tc to
+		 * restrict the queues that can be used by the device.
+		 * By doing this we can avoid reporing a false number of
+		 * queues.
+		 */
+		if (adapter->num_rx_pools > 1) {
+			u16 qpp = adapter->num_rx_queues_per_pool;
+
+			netdev_set_num_tc(dev, 1);
+			netdev_set_tc_queue(dev, 0, qpp, 0);
+		}
+
 		adapter->flags &= ~IXGBE_FLAG_DCB_ENABLED;
 
 		adapter->temp_dcb_cfg.pfc_mode_enable = false;

