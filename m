From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Tue, 10 Nov 2015 09:56:43 -0800
Subject: [Intel-wired-lan] [PATCH v4 4/6] geneve: Add geneve udp port
	offload for ethernet
In-Reply-To: <1447178205-99510-1-git-send-email-anjali.singhai@intel.com>
References: <1447178205-99510-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <1447178205-99510-4-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Call ndo_ops to add/del UDP ports to a device that supports geneve
offload.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/geneve.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index de5c30c..f77db6ab 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -371,8 +371,11 @@ static struct socket *geneve_create_sock(struct net *net, bool ipv6,
 
 static void geneve_notify_add_rx_port(struct geneve_sock *gs)
 {
+	struct net_device *dev;
 	struct sock *sk = gs->sock->sk;
+	struct net *net = sock_net(sk);
 	sa_family_t sa_family = sk->sk_family;
+	__be16 port = inet_sk(sk)->inet_sport;
 	int err;
 
 	if (sa_family == AF_INET) {
@@ -381,6 +384,14 @@ static void geneve_notify_add_rx_port(struct geneve_sock *gs)
 			pr_warn("geneve: udp_add_offload failed with status %d\n",
 				err);
 	}
+	rcu_read_lock();
+	for_each_netdev_rcu(net, dev) {
+		if (dev->netdev_ops->ndo_add_udp_tunnel_port)
+			dev->netdev_ops->ndo_add_udp_tunnel_port(dev,
+					       sa_family,
+					       port, UDP_TUNNEL_GENEVE);
+	}
+	rcu_read_unlock();
 }
 
 static int geneve_hlen(struct genevehdr *gh)
@@ -521,8 +532,20 @@ static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
 
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
+		if (dev->netdev_ops->ndo_del_udp_tunnel_port)
+			dev->netdev_ops->ndo_del_udp_tunnel_port(dev,
+					       sa_family,
+					       port, UDP_TUNNEL_GENEVE);
+	}
+	rcu_read_unlock();
 
 	if (sa_family == AF_INET)
 		udp_del_offload(&gs->udp_offloads);
-- 
1.8.1.4

