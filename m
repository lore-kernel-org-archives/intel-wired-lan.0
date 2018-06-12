From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 12 Jun 2018 11:19:02 -0400
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 7/7] net: allow
 fallback function to pass netdev
In-Reply-To: <20180612151322.86792.97587.stgit@ahduyck-green-test.jf.intel.com>
References: <20180612151322.86792.97587.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180612151902.86792.50748.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

For most of these calls we can just pass NULL through to the fallback
function as the sb_dev. The only cases where we cannot are the cases where
we might be dealing with either an upper device or a driver that would
have configured things to support an sb_dev itself.

The only driver that has any signficant change in this patchset should be
ixgbe as we can drop the redundant functionality that existed in both the
ndo_select_queue function and the fallback function that was passed through
to us.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c    |    2 +-
 drivers/net/ethernet/broadcom/bcmsysport.c      |    4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c |    3 ++-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c   |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |    4 ++--
 drivers/net/ethernet/mellanox/mlx4/en_tx.c      |    4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c |    2 +-
 drivers/net/hyperv/netvsc_drv.c                 |    2 +-
 drivers/net/net_failover.c                      |    2 +-
 drivers/net/xen-netback/interface.c             |    2 +-
 include/linux/netdevice.h                       |    3 ++-
 net/core/dev.c                                  |   12 +++---------
 net/packet/af_packet.c                          |    7 ++++---
 14 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index e3befb1..c673ac2 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2224,7 +2224,7 @@ static u16 ena_select_queue(struct net_device *dev, struct sk_buff *skb,
 	if (skb_rx_queue_recorded(skb))
 		qid = skb_get_rx_queue(skb);
 	else
-		qid = fallback(dev, skb);
+		qid = fallback(dev, skb, NULL);
 
 	return qid;
 }
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 32f548e..eb890c4 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2116,7 +2116,7 @@ static u16 bcm_sysport_select_queue(struct net_device *dev, struct sk_buff *skb,
 	unsigned int q, port;
 
 	if (!netdev_uses_dsa(dev))
-		return fallback(dev, skb);
+		return fallback(dev, skb, NULL);
 
 	/* DSA tagging layer will have configured the correct queue */
 	q = BRCM_TAG_GET_QUEUE(queue);
@@ -2124,7 +2124,7 @@ static u16 bcm_sysport_select_queue(struct net_device *dev, struct sk_buff *skb,
 	tx_ring = priv->ring_map[q + port * priv->per_port_num_tx_queues];
 
 	if (unlikely(!tx_ring))
-		return fallback(dev, skb);
+		return fallback(dev, skb, NULL);
 
 	return tx_ring->index;
 }
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 969dcc9..7a1b99f 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -1928,7 +1928,8 @@ u16 bnx2x_select_queue(struct net_device *dev, struct sk_buff *skb,
 	}
 
 	/* select a non-FCoE queue */
-	return fallback(dev, skb) % (BNX2X_NUM_ETH_QUEUES(bp) * bp->max_cos);
+	return fallback(dev, skb, NULL) %
+	       (BNX2X_NUM_ETH_QUEUES(bp) * bp->max_cos);
 }
 
 void bnx2x_set_num_queues(struct bnx2x *bp)
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 8de3039..380931d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -972,7 +972,7 @@ static u16 cxgb_select_queue(struct net_device *dev, struct sk_buff *skb,
 		return txq;
 	}
 
-	return fallback(dev, skb) % dev->real_num_tx_queues;
+	return fallback(dev, skb, NULL) % dev->real_num_tx_queues;
 }
 
 static int closest_timer(const struct sge *s, int time)
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index c36a231..8327254 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -2033,7 +2033,7 @@ static void hns_nic_get_stats64(struct net_device *ndev,
 	    is_multicast_ether_addr(eth_hdr->h_dest))
 		return 0;
 	else
-		return fallback(ndev, skb);
+		return fallback(ndev, skb, NULL);
 }
 
 static const struct net_device_ops hns_nic_netdev_ops = {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 5d9867e..eef64d0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8248,11 +8248,11 @@ static u16 ixgbe_select_queue(struct net_device *dev, struct sk_buff *skb,
 	case htons(ETH_P_FIP):
 		adapter = netdev_priv(dev);
 
-		if (adapter->flags & IXGBE_FLAG_FCOE_ENABLED)
+		if (!sb_dev && (adapter->flags & IXGBE_FLAG_FCOE_ENABLED))
 			break;
 		/* fall through */
 	default:
-		return fallback(dev, skb);
+		return fallback(dev, skb, sb_dev);
 	}
 
 	f = &adapter->ring_feature[RING_F_FCOE];
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index df29966..1857ee0 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -695,9 +695,9 @@ u16 mlx4_en_select_queue(struct net_device *dev, struct sk_buff *skb,
 	u16 rings_p_up = priv->num_tx_rings_p_up;
 
 	if (netdev_get_num_tc(dev))
-		return fallback(dev, skb);
+		return fallback(dev, skb, NULL);
 
-	return fallback(dev, skb) % rings_p_up;
+	return fallback(dev, skb, NULL) % rings_p_up;
 }
 
 static void mlx4_bf_copy(void __iomem *dst, const void *src,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 0119e86..88c0c85 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -115,7 +115,7 @@ u16 mlx5e_select_queue(struct net_device *dev, struct sk_buff *skb,
 		       select_queue_fallback_t fallback)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
-	int channel_ix = fallback(dev, skb);
+	int channel_ix = fallback(dev, skb, NULL);
 	u16 num_channels;
 	int up = 0;
 
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 0a01572..5bc32e7 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -344,7 +344,7 @@ static u16 netvsc_select_queue(struct net_device *ndev, struct sk_buff *skb,
 			txq = vf_ops->ndo_select_queue(vf_netdev, skb,
 						       sb_dev, fallback);
 		else
-			txq = fallback(vf_netdev, skb);
+			txq = fallback(vf_netdev, skb, NULL);
 
 		/* Record the queue selected by VF so that it can be
 		 * used for common case where VF has more queues than
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index b2dc2e7..6f3d143 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -131,7 +131,7 @@ static u16 net_failover_select_queue(struct net_device *dev,
 			txq = ops->ndo_select_queue(primary_dev, skb,
 						    sb_dev, fallback);
 		else
-			txq = fallback(primary_dev, skb);
+			txq = fallback(primary_dev, skb, NULL);
 
 		qdisc_skb_cb(skb)->slave_dev_queue_mapping = skb->queue_mapping;
 
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index 19c4c58..92274c2 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -155,7 +155,7 @@ static u16 xenvif_select_queue(struct net_device *dev, struct sk_buff *skb,
 	unsigned int size = vif->hash.size;
 
 	if (vif->hash.alg == XEN_NETIF_CTRL_HASH_ALGORITHM_NONE)
-		return fallback(dev, skb) % dev->real_num_tx_queues;
+		return fallback(dev, skb, NULL) % dev->real_num_tx_queues;
 
 	xenvif_set_skb_hash(vif, skb);
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 94d8f9b..db02e5f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -782,7 +782,8 @@ static inline bool netdev_phys_item_id_same(struct netdev_phys_item_id *a,
 }
 
 typedef u16 (*select_queue_fallback_t)(struct net_device *dev,
-				       struct sk_buff *skb);
+				       struct sk_buff *skb,
+				       struct net_device *sb_dev);
 
 enum tc_setup_type {
 	TC_SETUP_QDISC_MQPRIO,
diff --git a/net/core/dev.c b/net/core/dev.c
index a78000a..5abf7ee 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3521,8 +3521,8 @@ u16 dev_pick_tx_cpu_id(struct net_device *dev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(dev_pick_tx_cpu_id);
 
-static u16 ___netdev_pick_tx(struct net_device *dev, struct sk_buff *skb,
-			     struct net_device *sb_dev)
+static u16 __netdev_pick_tx(struct net_device *dev, struct sk_buff *skb,
+			    struct net_device *sb_dev)
 {
 	struct sock *sk = skb->sk;
 	int queue_index = sk_tx_queue_get(sk);
@@ -3547,12 +3547,6 @@ static u16 ___netdev_pick_tx(struct net_device *dev, struct sk_buff *skb,
 	return queue_index;
 }
 
-static u16 __netdev_pick_tx(struct net_device *dev,
-			    struct sk_buff *skb)
-{
-	return ___netdev_pick_tx(dev, skb, NULL);
-}
-
 struct netdev_queue *netdev_pick_tx(struct net_device *dev,
 				    struct sk_buff *skb,
 				    struct net_device *sb_dev)
@@ -3573,7 +3567,7 @@ struct netdev_queue *netdev_pick_tx(struct net_device *dev,
 			queue_index = ops->ndo_select_queue(dev, skb, sb_dev,
 							    __netdev_pick_tx);
 		else
-			queue_index = ___netdev_pick_tx(dev, skb, sb_dev);
+			queue_index = __netdev_pick_tx(dev, skb, sb_dev);
 
 		queue_index = netdev_cap_txqueue(dev, queue_index);
 	}
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 905f7cd..e24d9b4 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -275,9 +275,10 @@ static bool packet_use_direct_xmit(const struct packet_sock *po)
 	return po->xmit == packet_direct_xmit;
 }
 
-static u16 __packet_pick_tx_queue(struct net_device *dev, struct sk_buff *skb)
+static u16 __packet_pick_tx_queue(struct net_device *dev, struct sk_buff *skb,
+				  struct net_device *sb_dev)
 {
-	return dev_pick_tx_cpu_id(dev, skb, NULL, NULL);
+	return dev_pick_tx_cpu_id(dev, skb, sb_dev, NULL);
 }
 
 static u16 packet_pick_tx_queue(struct sk_buff *skb)
@@ -291,7 +292,7 @@ static u16 packet_pick_tx_queue(struct sk_buff *skb)
 						    __packet_pick_tx_queue);
 		queue_index = netdev_cap_txqueue(dev, queue_index);
 	} else {
-		queue_index = __packet_pick_tx_queue(dev, skb);
+		queue_index = __packet_pick_tx_queue(dev, skb, NULL);
 	}
 
 	return queue_index;

