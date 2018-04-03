From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 03 Apr 2018 17:16:14 -0400
Subject: [Intel-wired-lan] [iwl next-queue PATCH 04/10] ixgbe/fm10k: Drop
 tracking stats for macvlan broadcast/multicast
In-Reply-To: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180403211614.7880.55447.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Drop dead code now that we shouldn't be receiving broadcast or multicast
frames on the queues associated to the macvlan netdev.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c |    7 +++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index df86070..c51d61f 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -445,15 +445,14 @@ static void fm10k_type_trans(struct fm10k_ring *rx_ring,
 			l2_accel = NULL;
 	}
 
-	skb->protocol = eth_type_trans(skb, dev);
-
 	/* Record Rx queue, or update macvlan statistics */
 	if (!l2_accel)
 		skb_record_rx_queue(skb, rx_ring->queue_index);
 	else
 		macvlan_count_rx(netdev_priv(dev), skb->len + ETH_HLEN, true,
-				 (skb->pkt_type == PACKET_BROADCAST) ||
-				 (skb->pkt_type == PACKET_MULTICAST));
+				 false);
+
+	skb->protocol = eth_type_trans(skb, dev);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6172c1b..2c5100e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1768,15 +1768,14 @@ static void ixgbe_process_skb_fields(struct ixgbe_ring *rx_ring,
 	if (ixgbe_test_staterr(rx_desc, IXGBE_RXDADV_STAT_SECP))
 		ixgbe_ipsec_rx(rx_ring, rx_desc, skb);
 
-	skb->protocol = eth_type_trans(skb, dev);
-
 	/* record Rx queue, or update MACVLAN statistics */
 	if (netif_is_ixgbe(dev))
 		skb_record_rx_queue(skb, rx_ring->queue_index);
 	else
 		macvlan_count_rx(netdev_priv(dev), skb->len + ETH_HLEN, true,
-				 (skb->pkt_type == PACKET_BROADCAST) ||
-				 (skb->pkt_type == PACKET_MULTICAST));
+				 false);
+
+	skb->protocol = eth_type_trans(skb, dev);
 }
 
 static void ixgbe_rx_skb(struct ixgbe_q_vector *q_vector,

