From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Sun, 15 Nov 2015 16:02:54 -0800
Subject: [Intel-wired-lan] [PATCH v5 6/7] net: Add geneve port offload
	support and refactor udp_offload
In-Reply-To: <1447632175-9477-1-git-send-email-anjali.singhai@intel.com>
References: <1447632175-9477-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <1447632175-9477-6-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch moves the calls to ndo_add/del ops for vxlan tunnel
into udp_add/del_offload call. This way the ndo_add/del ops get called
for not only vxlan tunnels but for any udp based tunnel.

Note: The patch needs an AF_INET check somewhere in the GRO ops to
make it complete.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/geneve.c   | 16 ++++++----------
 drivers/net/vxlan.c    | 33 ++++-----------------------------
 include/net/protocol.h |  4 ++--
 net/ipv4/fou.c         | 12 +++++-------
 net/ipv4/udp_offload.c | 16 ++++++++++++++--
 5 files changed, 31 insertions(+), 50 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index de5c30c..b584387 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -372,15 +372,12 @@ static struct socket *geneve_create_sock(struct net *net, bool ipv6,
 static void geneve_notify_add_rx_port(struct geneve_sock *gs)
 {
 	struct sock *sk = gs->sock->sk;
-	sa_family_t sa_family = sk->sk_family;
+	struct net *net = sock_net(sk);
 	int err;
 
-	if (sa_family == AF_INET) {
-		err = udp_add_offload(&gs->udp_offloads);
-		if (err)
-			pr_warn("geneve: udp_add_offload failed with status %d\n",
-				err);
-	}
+	err = udp_add_offload(&gs->udp_offloads, net);
+	if (err)
+		pr_warn("geneve: udp_add_offload failed with status %d\n", err);
 }
 
 static int geneve_hlen(struct genevehdr *gh)
@@ -522,10 +519,9 @@ static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
 static void geneve_notify_del_rx_port(struct geneve_sock *gs)
 {
 	struct sock *sk = gs->sock->sk;
-	sa_family_t sa_family = sk->sk_family;
+	struct net *net = sock_net(sk);
 
-	if (sa_family == AF_INET)
-		udp_del_offload(&gs->udp_offloads);
+	udp_del_offload(&gs->udp_offloads, net);
 }
 
 static void __geneve_sock_release(struct geneve_sock *gs)
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 2ccb15f..231c17e 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -613,47 +613,22 @@ static int vxlan_gro_complete(struct sk_buff *skb, int nhoff,
 /* Notify netdevs that UDP port started listening */
 static void vxlan_notify_add_rx_port(struct vxlan_sock *vs)
 {
-	struct net_device *dev;
 	struct sock *sk = vs->sock->sk;
 	struct net *net = sock_net(sk);
-	sa_family_t sa_family = vxlan_get_sk_family(vs);
-	__be16 port = inet_sk(sk)->inet_sport;
 	int err;
 
-	if (sa_family == AF_INET) {
-		err = udp_add_offload(&vs->udp_offloads);
-		if (err)
-			pr_warn("vxlan: udp_add_offload failed with status %d\n", err);
-	}
-
-	rcu_read_lock();
-	for_each_netdev_rcu(net, dev) {
-		if (dev->netdev_ops->ndo_add_udp_tunnel_port)
-			dev->netdev_ops->ndo_add_udp_tunnel_port(dev, sa_family,
-							port, UDP_TUNNEL_VXLAN);
-	}
-	rcu_read_unlock();
+	err = udp_add_offload(&vs->udp_offloads, net);
+	if (err)
+		pr_warn("vxlan: udp_add_offload failed with status %d\n", err);
 }
 
 /* Notify netdevs that UDP port is no more listening */
 static void vxlan_notify_del_rx_port(struct vxlan_sock *vs)
 {
-	struct net_device *dev;
 	struct sock *sk = vs->sock->sk;
 	struct net *net = sock_net(sk);
-	sa_family_t sa_family = vxlan_get_sk_family(vs);
-	__be16 port = inet_sk(sk)->inet_sport;
-
-	rcu_read_lock();
-	for_each_netdev_rcu(net, dev) {
-		if (dev->netdev_ops->ndo_del_udp_tunnel_port)
-			dev->netdev_ops->ndo_del_udp_tunnel_port(dev, sa_family,
-							port, UDP_TUNNEL_VXLAN);
-	}
-	rcu_read_unlock();
 
-	if (sa_family == AF_INET)
-		udp_del_offload(&vs->udp_offloads);
+	udp_del_offload(&vs->udp_offloads, net);
 }
 
 /* Add new entry to forwarding table -- assumes lock held */
diff --git a/include/net/protocol.h b/include/net/protocol.h
index 738bfc6..16ee9b5 100644
--- a/include/net/protocol.h
+++ b/include/net/protocol.h
@@ -107,8 +107,8 @@ int inet_del_offload(const struct net_offload *prot, unsigned char num);
 void inet_register_protosw(struct inet_protosw *p);
 void inet_unregister_protosw(struct inet_protosw *p);
 
-int  udp_add_offload(struct udp_offload *prot);
-void udp_del_offload(struct udp_offload *prot);
+int  udp_add_offload(struct udp_offload *prot, struct net *net);
+void udp_del_offload(struct udp_offload *prot, struct net *net);
 
 void udp_offload_get_port(struct net_device *dev);
 
diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
index e0fcbbb..f2ffd58 100644
--- a/net/ipv4/fou.c
+++ b/net/ipv4/fou.c
@@ -411,9 +411,9 @@ static void fou_release(struct fou *fou)
 {
 	struct socket *sock = fou->sock;
 	struct sock *sk = sock->sk;
+	struct net *net = sock_net(sk);
 
-	if (sk->sk_family == AF_INET)
-		udp_del_offload(&fou->udp_offloads);
+	udp_del_offload(&fou->udp_offloads, net);
 	list_del(&fou->list);
 	udp_tunnel_sock_release(sock);
 
@@ -496,11 +496,9 @@ static int fou_create(struct net *net, struct fou_cfg *cfg,
 
 	sk->sk_allocation = GFP_ATOMIC;
 
-	if (cfg->udp_config.family == AF_INET) {
-		err = udp_add_offload(&fou->udp_offloads);
-		if (err)
-			goto error;
-	}
+	err = udp_add_offload(&fou->udp_offloads, net);
+	if (err)
+		goto error;
 
 	err = fou_add_to_port_list(net, fou);
 	if (err)
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 8597020..a7b7a94 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -241,9 +241,10 @@ out:
 	return segs;
 }
 
-int udp_add_offload(struct udp_offload *uo)
+int udp_add_offload(struct udp_offload *uo, struct net *net)
 {
 	struct udp_offload_priv *new_offload = kzalloc(sizeof(*new_offload), GFP_ATOMIC);
+	struct net_device *dev;
 
 	if (!new_offload)
 		return -ENOMEM;
@@ -253,6 +254,11 @@ int udp_add_offload(struct udp_offload *uo)
 	spin_lock(&udp_offload_lock);
 	new_offload->next = udp_offload_base;
 	rcu_assign_pointer(udp_offload_base, new_offload);
+	for_each_netdev_rcu(net, dev) {
+		if (dev->netdev_ops->ndo_add_udp_tunnel_port)
+			dev->netdev_ops->ndo_add_udp_tunnel_port(dev,
+					 uo->family, uo->port, uo->tunnel_type);
+	}
 	spin_unlock(&udp_offload_lock);
 
 	return 0;
@@ -265,13 +271,19 @@ static void udp_offload_free_routine(struct rcu_head *head)
 	kfree(ou_priv);
 }
 
-void udp_del_offload(struct udp_offload *uo)
+void udp_del_offload(struct udp_offload *uo, struct net *net)
 {
 	struct udp_offload_priv __rcu **head = &udp_offload_base;
 	struct udp_offload_priv *uo_priv;
+	struct net_device *dev;
 
 	spin_lock(&udp_offload_lock);
 
+	for_each_netdev_rcu(net, dev) {
+		if (dev->netdev_ops->ndo_add_udp_tunnel_port)
+			dev->netdev_ops->ndo_del_udp_tunnel_port(dev,
+					 uo->family, uo->port, uo->tunnel_type);
+	}
 	uo_priv = udp_deref_protected(*head);
 	for (; uo_priv != NULL;
 	     uo_priv = udp_deref_protected(*head)) {
-- 
1.8.1.4

