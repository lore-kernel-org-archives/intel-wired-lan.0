From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Mon, 04 Jun 2018 11:17:59 -0400
Subject: [Intel-wired-lan] [RFC PATCH 4/4] net: Add support for subordinate
 traffic classes to netdev_pick_tx
In-Reply-To: <20180604150847.74754.8585.stgit@ahduyck-green-test.jf.intel.com>
References: <20180604150847.74754.8585.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180604151759.74754.90762.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change makes it so that we can support the concept of subordinate
device traffic classes to the core networking code. In doing this we can
start pulling out the driver specific bits needed to support selecting a
queue based on an upper device.

The solution at is currently stands is only partially implemented. I have
the start of some XPS bits in here, but I would still need to allow for
configuration of the XPS maps on the queues reserved for the subordinate
devices. For now I am using the reference to the sb_dev XPS map as just a
way to skip the lookup of the lower device XPS map for now as that would
result in the wrong queue being picked.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   15 ++-----
 drivers/net/macvlan.c                         |   10 +----
 include/linux/netdevice.h                     |    4 +-
 net/core/dev.c                                |   55 +++++++++++++++----------
 4 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 05d6d48..c42498d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8218,20 +8218,18 @@ static void ixgbe_atr(struct ixgbe_ring *ring,
 					      input, common, ring->queue_index);
 }
 
+#ifdef IXGBE_FCOE
 static u16 ixgbe_select_queue(struct net_device *dev, struct sk_buff *skb,
 			      void *accel_priv, select_queue_fallback_t fallback)
 {
-	struct ixgbe_fwd_adapter *fwd_adapter = accel_priv;
-#ifdef IXGBE_FCOE
 	struct ixgbe_adapter *adapter;
 	struct ixgbe_ring_feature *f;
-#endif
 	int txq;
 
-	if (fwd_adapter) {
+	if (accel_priv) {
 		u8 tc = netdev_get_num_tc(dev) ?
 			netdev_get_prio_tc_map(dev, skb->priority) : 0;
-		struct net_device *vdev = fwd_adapter->netdev;
+		struct net_device *vdev = accel_priv;
 
 		txq = vdev->tc_to_txq[tc].offset;
 		txq += reciprocal_scale(skb_get_hash(skb),
@@ -8240,7 +8238,6 @@ static u16 ixgbe_select_queue(struct net_device *dev, struct sk_buff *skb,
 		return txq;
 	}
 
-#ifdef IXGBE_FCOE
 
 	/*
 	 * only execute the code below if protocol is FCoE
@@ -8267,11 +8264,9 @@ static u16 ixgbe_select_queue(struct net_device *dev, struct sk_buff *skb,
 		txq -= f->indices;
 
 	return txq + f->offset;
-#else
-	return fallback(dev, skb);
-#endif
 }
 
+#endif
 static int ixgbe_xmit_xdp_ring(struct ixgbe_adapter *adapter,
 			       struct xdp_frame *xdpf)
 {
@@ -10071,7 +10066,6 @@ static void ixgbe_xdp_flush(struct net_device *dev)
 	.ndo_open		= ixgbe_open,
 	.ndo_stop		= ixgbe_close,
 	.ndo_start_xmit		= ixgbe_xmit_frame,
-	.ndo_select_queue	= ixgbe_select_queue,
 	.ndo_set_rx_mode	= ixgbe_set_rx_mode,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= ixgbe_set_mac,
@@ -10094,6 +10088,7 @@ static void ixgbe_xdp_flush(struct net_device *dev)
 	.ndo_poll_controller	= ixgbe_netpoll,
 #endif
 #ifdef IXGBE_FCOE
+	.ndo_select_queue	= ixgbe_select_queue,
 	.ndo_fcoe_ddp_setup = ixgbe_fcoe_ddp_get,
 	.ndo_fcoe_ddp_target = ixgbe_fcoe_ddp_target,
 	.ndo_fcoe_ddp_done = ixgbe_fcoe_ddp_put,
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index adde8fc..401e1d1 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -514,7 +514,6 @@ static int macvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 	const struct macvlan_dev *vlan = netdev_priv(dev);
 	const struct macvlan_port *port = vlan->port;
 	const struct macvlan_dev *dest;
-	void *accel_priv = NULL;
 
 	if (vlan->mode == MACVLAN_MODE_BRIDGE) {
 		const struct ethhdr *eth = (void *)skb->data;
@@ -533,15 +532,10 @@ static int macvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NET_XMIT_SUCCESS;
 		}
 	}
-
-	/* For packets that are non-multicast and not bridged we will pass
-	 * the necessary information so that the lowerdev can distinguish
-	 * the source of the packets via the accel_priv value.
-	 */
-	accel_priv = vlan->accel_priv;
 xmit_world:
 	skb->dev = vlan->lowerdev;
-	return dev_queue_xmit_accel(skb, accel_priv);
+	return dev_queue_xmit_accel(skb,
+				    netdev_get_sb_channel(dev) ? dev : NULL);
 }
 
 static inline netdev_tx_t macvlan_netpoll_send_skb(struct macvlan_dev *vlan, struct sk_buff *skb)
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index bbc8045..df5a582 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2072,7 +2072,7 @@ static inline void netdev_for_each_tx_queue(struct net_device *dev,
 
 struct netdev_queue *netdev_pick_tx(struct net_device *dev,
 				    struct sk_buff *skb,
-				    void *accel_priv);
+				    struct net_device *sb_dev);
 
 /* returns the headroom that the master device needs to take in account
  * when forwarding to this dev
@@ -2523,7 +2523,7 @@ struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
 void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 int dev_queue_xmit(struct sk_buff *skb);
-int dev_queue_xmit_accel(struct sk_buff *skb, void *accel_priv);
+int dev_queue_xmit_accel(struct sk_buff *skb, struct net_device *sb_dev);
 int dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
 int register_netdevice(struct net_device *dev);
 void unregister_netdevice_queue(struct net_device *dev, struct list_head *head);
diff --git a/net/core/dev.c b/net/core/dev.c
index eba255d..507e606 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2704,24 +2704,26 @@ void netif_device_attach(struct net_device *dev)
  * Returns a Tx hash based on the given packet descriptor a Tx queues' number
  * to be used as a distribution range.
  */
-static u16 skb_tx_hash(const struct net_device *dev, struct sk_buff *skb)
+static u16 skb_tx_hash(const struct net_device *dev,
+		       const struct net_device *sb_dev,
+		       struct sk_buff *skb)
 {
 	u32 hash;
 	u16 qoffset = 0;
 	u16 qcount = dev->real_num_tx_queues;
 
+	if (dev->num_tc) {
+		u8 tc = netdev_get_prio_tc_map(dev, skb->priority);
+
+		qoffset = sb_dev->tc_to_txq[tc].offset;
+		qcount = sb_dev->tc_to_txq[tc].count;
+	}
+
 	if (skb_rx_queue_recorded(skb)) {
 		hash = skb_get_rx_queue(skb);
 		while (unlikely(hash >= qcount))
 			hash -= qcount;
-		return hash;
-	}
-
-	if (dev->num_tc) {
-		u8 tc = netdev_get_prio_tc_map(dev, skb->priority);
-
-		qoffset = dev->tc_to_txq[tc].offset;
-		qcount = dev->tc_to_txq[tc].count;
+		return hash + qoffset;
 	}
 
 	return (u16) reciprocal_scale(skb_get_hash(skb), qcount) + qoffset;
@@ -3483,7 +3485,9 @@ int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
 }
 #endif /* CONFIG_NET_EGRESS */
 
-static inline int get_xps_queue(struct net_device *dev, struct sk_buff *skb)
+static inline int get_xps_queue(struct net_device *dev,
+				struct net_device *sb_dev,
+				struct sk_buff *skb)
 {
 #ifdef CONFIG_XPS
 	struct xps_dev_maps *dev_maps;
@@ -3491,7 +3495,7 @@ static inline int get_xps_queue(struct net_device *dev, struct sk_buff *skb)
 	int queue_index = -1;
 
 	rcu_read_lock();
-	dev_maps = rcu_dereference(dev->xps_maps);
+	dev_maps = rcu_dereference(sb_dev->xps_maps);
 	if (dev_maps) {
 		unsigned int tci = skb->sender_cpu - 1;
 
@@ -3519,17 +3523,18 @@ static inline int get_xps_queue(struct net_device *dev, struct sk_buff *skb)
 #endif
 }
 
-static u16 __netdev_pick_tx(struct net_device *dev, struct sk_buff *skb)
+static u16 ___netdev_pick_tx(struct net_device *dev, struct sk_buff *skb,
+			     struct net_device *sb_dev)
 {
 	struct sock *sk = skb->sk;
 	int queue_index = sk_tx_queue_get(sk);
 
 	if (queue_index < 0 || skb->ooo_okay ||
 	    queue_index >= dev->real_num_tx_queues) {
-		int new_index = get_xps_queue(dev, skb);
+		int new_index = get_xps_queue(dev, sb_dev, skb);
 
 		if (new_index < 0)
-			new_index = skb_tx_hash(dev, skb);
+			new_index = skb_tx_hash(dev, sb_dev, skb);
 
 		if (queue_index != new_index && sk &&
 		    sk_fullsock(sk) &&
@@ -3542,9 +3547,14 @@ static u16 __netdev_pick_tx(struct net_device *dev, struct sk_buff *skb)
 	return queue_index;
 }
 
+static u16 __netdev_pick_tx(struct net_device *dev,
+			    struct sk_buff *skb)
+{
+	return ___netdev_pick_tx(dev, skb, NULL);
+}
 struct netdev_queue *netdev_pick_tx(struct net_device *dev,
 				    struct sk_buff *skb,
-				    void *accel_priv)
+				    struct net_device *sb_dev)
 {
 	int queue_index = 0;
 
@@ -3559,10 +3569,11 @@ struct netdev_queue *netdev_pick_tx(struct net_device *dev,
 		const struct net_device_ops *ops = dev->netdev_ops;
 
 		if (ops->ndo_select_queue)
-			queue_index = ops->ndo_select_queue(dev, skb, accel_priv,
+			queue_index = ops->ndo_select_queue(dev, skb, sb_dev,
 							    __netdev_pick_tx);
 		else
-			queue_index = __netdev_pick_tx(dev, skb);
+			queue_index = ___netdev_pick_tx(dev, skb,
+							sb_dev ? : dev);
 
 		queue_index = netdev_cap_txqueue(dev, queue_index);
 	}
@@ -3574,7 +3585,7 @@ struct netdev_queue *netdev_pick_tx(struct net_device *dev,
 /**
  *	__dev_queue_xmit - transmit a buffer
  *	@skb: buffer to transmit
- *	@accel_priv: private data used for L2 forwarding offload
+ *	@sb_dev: suboordinate device used for L2 forwarding offload
  *
  *	Queue a buffer for transmission to a network device. The caller must
  *	have set the device and priority and built the buffer before calling
@@ -3597,7 +3608,7 @@ struct netdev_queue *netdev_pick_tx(struct net_device *dev,
  *      the BH enable code must have IRQs enabled so that it will not deadlock.
  *          --BLG
  */
-static int __dev_queue_xmit(struct sk_buff *skb, void *accel_priv)
+static int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 {
 	struct net_device *dev = skb->dev;
 	struct netdev_queue *txq;
@@ -3636,7 +3647,7 @@ static int __dev_queue_xmit(struct sk_buff *skb, void *accel_priv)
 	else
 		skb_dst_force(skb);
 
-	txq = netdev_pick_tx(dev, skb, accel_priv);
+	txq = netdev_pick_tx(dev, skb, sb_dev);
 	q = rcu_dereference_bh(txq->qdisc);
 
 	trace_net_dev_queue(skb);
@@ -3710,9 +3721,9 @@ int dev_queue_xmit(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(dev_queue_xmit);
 
-int dev_queue_xmit_accel(struct sk_buff *skb, void *accel_priv)
+int dev_queue_xmit_accel(struct sk_buff *skb, struct net_device *sb_dev)
 {
-	return __dev_queue_xmit(skb, accel_priv);
+	return __dev_queue_xmit(skb, sb_dev);
 }
 EXPORT_SYMBOL(dev_queue_xmit_accel);
 

