From: Tobias Klauser <tklauser@distanz.ch>
Date: Wed, 15 Feb 2017 12:08:20 +0100
Subject: [Intel-wired-lan] [PATCH net-next] ixgb: Omit private ndo_get_stats
	function
Message-ID: <20170215110820.30052-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ixgb_get_stats() just returns dev->stats so we can leave it
out altogether and let dev_get_stats() do the job.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/net/ethernet/intel/ixgb/ixgb_main.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_main.c b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
index fbd220d137b3..5a713199653c 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_main.c
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
@@ -86,7 +86,6 @@ static void ixgb_set_multi(struct net_device *netdev);
 static void ixgb_watchdog(unsigned long data);
 static netdev_tx_t ixgb_xmit_frame(struct sk_buff *skb,
 				   struct net_device *netdev);
-static struct net_device_stats *ixgb_get_stats(struct net_device *netdev);
 static int ixgb_change_mtu(struct net_device *netdev, int new_mtu);
 static int ixgb_set_mac(struct net_device *netdev, void *p);
 static irqreturn_t ixgb_intr(int irq, void *data);
@@ -367,7 +366,6 @@ static const struct net_device_ops ixgb_netdev_ops = {
 	.ndo_open 		= ixgb_open,
 	.ndo_stop		= ixgb_close,
 	.ndo_start_xmit		= ixgb_xmit_frame,
-	.ndo_get_stats		= ixgb_get_stats,
 	.ndo_set_rx_mode	= ixgb_set_multi,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= ixgb_set_mac,
@@ -1597,20 +1595,6 @@ ixgb_tx_timeout_task(struct work_struct *work)
 }
 
 /**
- * ixgb_get_stats - Get System Network Statistics
- * @netdev: network interface device structure
- *
- * Returns the address of the device statistics structure.
- * The statistics are actually updated from the timer callback.
- **/
-
-static struct net_device_stats *
-ixgb_get_stats(struct net_device *netdev)
-{
-	return &netdev->stats;
-}
-
-/**
  * ixgb_change_mtu - Change the Maximum Transfer Unit
  * @netdev: network interface device structure
  * @new_mtu: new value for maximum frame size
-- 
2.11.0


