From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:26:51 -0700
Subject: [Intel-wired-lan] [net-next 01/25] fm10k: Corrected an error in Tx
	statistics
Message-ID: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The function collecting Tx statistics was actually using values from the RX
ring. Thus, Tx and Rx statistics values reported by "ifconfig" will
return identical values. This change corrects this error and the Tx
statistics is now reading from the Tx ring.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index d5b303d..a7db5e2 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1,5 +1,5 @@
 /* Intel Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2014 Intel Corporation.
+ * Copyright(c) 2013 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -1126,7 +1126,7 @@ static struct rtnl_link_stats64 *fm10k_get_stats64(struct net_device *netdev,
 	}
 
 	for (i = 0; i < interface->num_tx_queues; i++) {
-		ring = ACCESS_ONCE(interface->rx_ring[i]);
+		ring = ACCESS_ONCE(interface->tx_ring[i]);
 
 		if (!ring)
 			continue;
-- 
1.9.3

