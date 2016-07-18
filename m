From: kan.liang@intel.com <kan.liang@intel.com>
Date: Sun, 17 Jul 2016 23:56:16 -0700
Subject: [Intel-wired-lan] [RFC PATCH 22/30] net/netpolicy: set tx queues
	according to policy
In-Reply-To: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
Message-ID: <1468824984-65318-23-git-send-email-kan.liang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kan Liang <kan.liang@intel.com>

When the device tries to transmit a buffer, netdev_pick_tx is called to
find the available tx queues. This patch checks the per socket net
policy of the binding socket of the buffer. If net policy is set, it
picks up the assigned tx queue from net policy module, and redirect the
traffic to the assigned queue.

Signed-off-by: Kan Liang <kan.liang@intel.com>
---
 net/core/dev.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7894e40..6108e3b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3266,6 +3266,7 @@ struct netdev_queue *netdev_pick_tx(struct net_device *dev,
 				    void *accel_priv)
 {
 	int queue_index = 0;
+	struct sock *sk = skb->sk;
 
 #ifdef CONFIG_XPS
 	u32 sender_cpu = skb->sender_cpu - 1;
@@ -3279,8 +3280,21 @@ struct netdev_queue *netdev_pick_tx(struct net_device *dev,
 		if (ops->ndo_select_queue)
 			queue_index = ops->ndo_select_queue(dev, skb, accel_priv,
 							    __netdev_pick_tx);
-		else
-			queue_index = __netdev_pick_tx(dev, skb);
+		else {
+#ifdef CONFIG_NETPOLICY
+			queue_index = -1;
+			if (sk && (sk->sk_netpolicy.policy > NET_POLICY_NONE)) {
+				/* There is no device bind to socket when setting policy
+				 * Assign the dev now.
+				 */
+				if (!sk->sk_netpolicy.dev)
+					sk->sk_netpolicy.dev = dev;
+				queue_index = netpolicy_pick_queue(&sk->sk_netpolicy, false);
+			}
+			if (queue_index < 0)
+#endif
+				queue_index = __netdev_pick_tx(dev, skb);
+		}
 
 		if (!accel_priv)
 			queue_index = netdev_cap_txqueue(dev, queue_index);
-- 
2.5.5

