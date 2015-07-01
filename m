From: Nicholas Krause <xerofoify@gmail.com>
Date: Wed,  1 Jul 2015 10:45:58 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe:Make the function
	ixgbe_fwd_ring_down have a return type of void
Message-ID: <1435761958-21472-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This makes the function ixgbe_fwd_ring_down have a return type of
void now due to this particular function always running successfully
and never signalling it's caller with a error code when this function
fails internally and for what reason.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 9aa6104..4efaeac 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4583,8 +4583,8 @@ static void ixgbe_disable_fwd_ring(struct ixgbe_fwd_adapter *vadapter,
 	rx_ring->l2_accel_priv = NULL;
 }
 
-static int ixgbe_fwd_ring_down(struct net_device *vdev,
-			       struct ixgbe_fwd_adapter *accel)
+static void ixgbe_fwd_ring_down(struct net_device *vdev,
+				struct ixgbe_fwd_adapter *accel)
 {
 	struct ixgbe_adapter *adapter = accel->real_adapter;
 	unsigned int rxbase = accel->rx_base_queue;
@@ -4602,9 +4602,6 @@ static int ixgbe_fwd_ring_down(struct net_device *vdev,
 		adapter->tx_ring[txbase + i]->l2_accel_priv = NULL;
 		adapter->tx_ring[txbase + i]->netdev = adapter->netdev;
 	}
-
-
-	return 0;
 }
 
 static int ixgbe_fwd_ring_up(struct net_device *vdev,
-- 
2.1.4

