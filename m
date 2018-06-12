From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 12 Jun 2018 11:18:51 -0400
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 5/7] net: Add
 generic ndo_select_queue functions
In-Reply-To: <20180612151322.86792.97587.stgit@ahduyck-green-test.jf.intel.com>
References: <20180612151322.86792.97587.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180612151851.86792.50638.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds a generic version of the ndo_select_queue functions for
either returning 0 or selecting a queue based on the processor ID. This is
generally meant to just reduce the number of functions we have to change
in the future when we have to deal with ndo_select_queue changes.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/lantiq_etop.c   |   10 +---------
 drivers/net/ethernet/ti/netcp_core.c |    9 +--------
 drivers/staging/netlogic/xlr_net.c   |    9 +--------
 include/linux/netdevice.h            |    4 ++++
 net/core/dev.c                       |   14 ++++++++++++++
 net/packet/af_packet.c               |    2 +-
 6 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index afc8100..7a637b5 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -563,14 +563,6 @@ struct ltq_etop_priv {
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
-static u16
-ltq_etop_select_queue(struct net_device *dev, struct sk_buff *skb,
-		      void *accel_priv, select_queue_fallback_t fallback)
-{
-	/* we are currently only using the first queue */
-	return 0;
-}
-
 static int
 ltq_etop_init(struct net_device *dev)
 {
@@ -641,7 +633,7 @@ struct ltq_etop_priv {
 	.ndo_set_mac_address = ltq_etop_set_mac_address,
 	.ndo_validate_addr = eth_validate_addr,
 	.ndo_set_rx_mode = ltq_etop_set_multicast_list,
-	.ndo_select_queue = ltq_etop_select_queue,
+	.ndo_select_queue = dev_pick_tx_zero,
 	.ndo_init = ltq_etop_init,
 	.ndo_tx_timeout = ltq_etop_tx_timeout,
 };
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index e40aa3e..2c455bd 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -1889,13 +1889,6 @@ static int netcp_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vid)
 	return err;
 }
 
-static u16 netcp_select_queue(struct net_device *dev, struct sk_buff *skb,
-			      void *accel_priv,
-			      select_queue_fallback_t fallback)
-{
-	return 0;
-}
-
 static int netcp_setup_tc(struct net_device *dev, enum tc_setup_type type,
 			  void *type_data)
 {
@@ -1972,7 +1965,7 @@ static int netcp_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	.ndo_vlan_rx_add_vid	= netcp_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= netcp_rx_kill_vid,
 	.ndo_tx_timeout		= netcp_ndo_tx_timeout,
-	.ndo_select_queue	= netcp_select_queue,
+	.ndo_select_queue	= dev_pick_tx_zero,
 	.ndo_setup_tc		= netcp_setup_tc,
 };
 
diff --git a/drivers/staging/netlogic/xlr_net.c b/drivers/staging/netlogic/xlr_net.c
index e461168..4e6611e 100644
--- a/drivers/staging/netlogic/xlr_net.c
+++ b/drivers/staging/netlogic/xlr_net.c
@@ -290,13 +290,6 @@ static netdev_tx_t xlr_net_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static u16 xlr_net_select_queue(struct net_device *ndev, struct sk_buff *skb,
-				void *accel_priv,
-				select_queue_fallback_t fallback)
-{
-	return (u16)smp_processor_id();
-}
-
 static void xlr_hw_set_mac_addr(struct net_device *ndev)
 {
 	struct xlr_net_priv *priv = netdev_priv(ndev);
@@ -403,7 +396,7 @@ static void xlr_stats(struct net_device *ndev, struct rtnl_link_stats64 *stats)
 	.ndo_open = xlr_net_open,
 	.ndo_stop = xlr_net_stop,
 	.ndo_start_xmit = xlr_net_start_xmit,
-	.ndo_select_queue = xlr_net_select_queue,
+	.ndo_select_queue = dev_pick_tx_cpu_id,
 	.ndo_set_mac_address = xlr_net_set_mac_addr,
 	.ndo_set_rx_mode = xlr_set_rx_mode,
 	.ndo_get_stats64 = xlr_stats,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 91b3ca9..70f7ee3 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2551,6 +2551,10 @@ struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
 void dev_close_many(struct list_head *head, bool unlink);
 void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
+u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
+		     void *accel_priv, select_queue_fallback_t fallback);
+u16 dev_pick_tx_cpu_id(struct net_device *dev, struct sk_buff *skb,
+		       void *accel_priv, select_queue_fallback_t fallback);
 int dev_queue_xmit(struct sk_buff *skb);
 int dev_queue_xmit_accel(struct sk_buff *skb, struct net_device *sb_dev);
 int dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
diff --git a/net/core/dev.c b/net/core/dev.c
index 2249294..1a1cf2c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3505,6 +3505,20 @@ static inline int get_xps_queue(struct net_device *dev,
 #endif
 }
 
+u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
+		     void *accel_priv, select_queue_fallback_t fallback)
+{
+	return 0;
+}
+EXPORT_SYMBOL(dev_pick_tx_zero);
+
+u16 dev_pick_tx_cpu_id(struct net_device *dev, struct sk_buff *skb,
+		       void *accel_priv, select_queue_fallback_t fallback)
+{
+	return (u16)raw_smp_processor_id() % dev->real_num_tx_queues;
+}
+EXPORT_SYMBOL(dev_pick_tx_cpu_id);
+
 static u16 ___netdev_pick_tx(struct net_device *dev, struct sk_buff *skb,
 			     struct net_device *sb_dev)
 {
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ee01856..905f7cd 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -277,7 +277,7 @@ static bool packet_use_direct_xmit(const struct packet_sock *po)
 
 static u16 __packet_pick_tx_queue(struct net_device *dev, struct sk_buff *skb)
 {
-	return (u16) raw_smp_processor_id() % dev->real_num_tx_queues;
+	return dev_pick_tx_cpu_id(dev, skb, NULL, NULL);
 }
 
 static u16 packet_pick_tx_queue(struct sk_buff *skb)

