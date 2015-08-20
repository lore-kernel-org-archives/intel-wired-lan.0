From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Thu, 20 Aug 2015 11:46:21 -0700
Subject: [Intel-wired-lan] [PATCH 2/4] geneve: Add geneve udp port offload
	for ethernet devices
In-Reply-To: <1440096383-8915-1-git-send-email-anjali.singhai@intel.com>
References: <1440096383-8915-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <1440096383-8915-2-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add ndo_ops to add/del UDP ports to a device that supports geneve
offload.

v2:Added comments for new ndo_ops and minor format fix.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 include/linux/netdevice.h | 20 +++++++++++++++++++-
 net/ipv4/geneve_core.c    | 22 ++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f3bb290..d6f00c7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1016,6 +1016,19 @@ typedef u16 (*select_queue_fallback_t)(struct net_device *dev,
  *	address family that vxlan is not listening to anymore. The operation
  *	is protected by the vxlan_net->sock_lock.
  *
+ * void (*ndo_add_geneve_port)(struct net_device *dev,
+ *			      sa_family_t sa_family, __be16 port);
+ *	Called by geneve to notiy a driver about the UDP port and socket
+ *	address family that geneve is listnening to. It is called only when
+ *	a new port starts listening. The operation is protected by the
+ *	geneve_net->sock_lock.
+ *
+ * void (*ndo_del_geneve_port)(struct net_device *dev,
+ *			      sa_family_t sa_family, __be16 port);
+ *	Called by geneve to notify the driver about a UDP port and socket
+ *	address family that geneve is not listening to anymore. The operation
+ *	is protected by the geneve_net->sock_lock.
+ *
  * void* (*ndo_dfwd_add_station)(struct net_device *pdev,
  *				 struct net_device *dev)
  *	Called by upper layer devices to accelerate switching or other
@@ -1210,7 +1223,12 @@ struct net_device_ops {
 	void			(*ndo_del_vxlan_port)(struct  net_device *dev,
 						      sa_family_t sa_family,
 						      __be16 port);
-
+	void			(*ndo_add_geneve_port)(struct net_device *dev,
+						      sa_family_t sa_family,
+						      __be16 port);
+	void			(*ndo_del_geneve_port)(struct net_device *dev,
+						      sa_family_t sa_family,
+						      __be16 port);
 	void*			(*ndo_dfwd_add_station)(struct net_device *pdev,
 							struct net_device *dev);
 	void			(*ndo_dfwd_del_station)(struct net_device *pdev,
diff --git a/net/ipv4/geneve_core.c b/net/ipv4/geneve_core.c
index 311a4ba..9ea9082 100644
--- a/net/ipv4/geneve_core.c
+++ b/net/ipv4/geneve_core.c
@@ -234,8 +234,11 @@ static int geneve_gro_complete(struct sk_buff *skb, int nhoff,
 
 static void geneve_notify_add_rx_port(struct geneve_sock *gs)
 {
+	struct net_device *dev;
 	struct sock *sk = gs->sock->sk;
+	struct net *net = sock_net(sk);
 	sa_family_t sa_family = sk->sk_family;
+	__be16 port = inet_sk(sk)->inet_sport;
 	int err;
 
 	if (sa_family == AF_INET) {
@@ -244,12 +247,31 @@ static void geneve_notify_add_rx_port(struct geneve_sock *gs)
 			pr_warn("geneve: udp_add_offload failed with status %d\n",
 				err);
 	}
+
+	rcu_read_lock();
+	for_each_netdev_rcu(net, dev) {
+		if (dev->netdev_ops->ndo_add_geneve_port)
+			dev->netdev_ops->ndo_add_geneve_port(dev, sa_family,
+							     port);
+	}
+	rcu_read_unlock();
 }
 
 static void geneve_notify_del_rx_port(struct geneve_sock *gs)
 {
+	struct net_device *dev;
 	struct sock *sk = gs->sock->sk;
+	struct net *net = sock_net(sk);
 	sa_family_t sa_family = sk->sk_family;
+	__be16 port = inet_sk(sk)->inet_sport;
+
+	rcu_read_lock();
+	for_each_netdev_rcu(net, dev) {
+		if (dev->netdev_ops->ndo_del_geneve_port)
+			dev->netdev_ops->ndo_del_geneve_port(dev, sa_family,
+							     port);
+	}
+	rcu_read_unlock();
 
 	if (sa_family == AF_INET)
 		udp_del_offload(&gs->udp_offloads);
-- 
1.8.1.4

