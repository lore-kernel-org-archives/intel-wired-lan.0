From: Jarod Wilson <jarod@redhat.com>
Date: Mon,  4 May 2020 10:59:41 -0400
Subject: [Intel-wired-lan] [RFC PATCH net-next 1/3] xfrm: bail early on
 slave pass over skb
In-Reply-To: <20200504145943.8841-1-jarod@redhat.com>
References: <20200504145943.8841-1-jarod@redhat.com>
Message-ID: <20200504145943.8841-2-jarod@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is prep work for initial support of bonding hardware encryption
pass-through support. The bonding driver will fill in the slave_dev
pointer, and we use that to know not to skb_push() again on a given
skb that was already processed on the bond device.

CC: Jay Vosburgh <j.vosburgh@gmail.com>
CC: Veaceslav Falico <vfalico@gmail.com>
CC: Andy Gospodarek <andy@greyhouse.net>
CC: "David S. Miller" <davem@davemloft.net>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: netdev at vger.kernel.org
CC: intel-wired-lan at lists.osuosl.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 include/net/xfrm.h     |  1 +
 net/xfrm/xfrm_device.c | 34 +++++++++++++++++-----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 8f71c111e65a..a6ec341cd9f0 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -127,6 +127,7 @@ struct xfrm_state_walk {
 
 struct xfrm_state_offload {
 	struct net_device	*dev;
+	struct net_device	*slave_dev;
 	unsigned long		offload_handle;
 	unsigned int		num_exthdrs;
 	u8			flags;
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 6cc7f7f1dd68..1cd31dcf59da 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -108,6 +108,7 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 	struct sk_buff *skb2, *nskb, *pskb = NULL;
 	netdev_features_t esp_features = features;
 	struct xfrm_offload *xo = xfrm_offload(skb);
+	struct net_device *dev = skb->dev;
 	struct sec_path *sp;
 
 	if (!xo)
@@ -121,6 +122,10 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 	if (xo->flags & XFRM_GRO || x->xso.flags & XFRM_OFFLOAD_INBOUND)
 		return skb;
 
+	/* This skb was already validated on the master dev */
+	if ((x->xso.dev != dev) && (x->xso.slave_dev == dev))
+		return skb;
+
 	local_irq_save(flags);
 	sd = this_cpu_ptr(&softnet_data);
 	err = !skb_queue_empty(&sd->xfrm_backlog);
@@ -131,25 +136,20 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		return skb;
 	}
 
-	if (skb_is_gso(skb)) {
-		struct net_device *dev = skb->dev;
-
-		if (unlikely(x->xso.dev != dev)) {
-			struct sk_buff *segs;
+	if (skb_is_gso(skb) && unlikely(x->xso.dev != dev)) {
+		struct sk_buff *segs;
 
-			/* Packet got rerouted, fixup features and segment it. */
-			esp_features = esp_features & ~(NETIF_F_HW_ESP
-							| NETIF_F_GSO_ESP);
+		/* Packet got rerouted, fixup features and segment it. */
+		esp_features = esp_features & ~(NETIF_F_HW_ESP | NETIF_F_GSO_ESP);
 
-			segs = skb_gso_segment(skb, esp_features);
-			if (IS_ERR(segs)) {
-				kfree_skb(skb);
-				atomic_long_inc(&dev->tx_dropped);
-				return NULL;
-			} else {
-				consume_skb(skb);
-				skb = segs;
-			}
+		segs = skb_gso_segment(skb, esp_features);
+		if (IS_ERR(segs)) {
+			kfree_skb(skb);
+			atomic_long_inc(&dev->tx_dropped);
+			return NULL;
+		} else {
+			consume_skb(skb);
+			skb = segs;
 		}
 	}
 
-- 
2.20.1

