From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Wed, 04 Apr 2018 13:00:00 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue,
 RFC PATCH 2/3] net: Enable Tx queue selection based on Rx queues
In-Reply-To: <152287164664.5088.10567280431867626085.stgit@anamdev.jf.intel.com>
References: <152287164664.5088.10567280431867626085.stgit@anamdev.jf.intel.com>
Message-ID: <152287200031.5088.14468247226136351295.stgit@anamdev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds support to pick Tx queue based on the Rx queue map
configuration set by the admin through the sysfs attribute
for each Tx queue. If the user configuration for receive
queue map does not apply, then the Tx queue selection falls back
to CPU map based selection and finally to hashing.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 include/net/sock.h       |   18 ++++++++++++++++++
 net/core/dev.c           |   36 ++++++++++++++++++++++++++++++------
 net/core/sock.c          |    5 +++++
 net/ipv4/tcp_input.c     |    7 +++++++
 net/ipv4/tcp_ipv4.c      |    1 +
 net/ipv4/tcp_minisocks.c |    1 +
 6 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 49bd2c1..53d58bc 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -139,6 +139,8 @@ typedef __u64 __bitwise __addrpair;
  *	@skc_node: main hash linkage for various protocol lookup tables
  *	@skc_nulls_node: main hash linkage for TCP/UDP/UDP-Lite protocol
  *	@skc_tx_queue_mapping: tx queue number for this connection
+ *	@skc_rx_queue_mapping: rx queue number for this connection
+ *	@skc_rx_ifindex: rx ifindex for this connection
  *	@skc_flags: place holder for sk_flags
  *		%SO_LINGER (l_onoff), %SO_BROADCAST, %SO_KEEPALIVE,
  *		%SO_OOBINLINE settings, %SO_TIMESTAMPING settings
@@ -215,6 +217,10 @@ struct sock_common {
 		struct hlist_nulls_node skc_nulls_node;
 	};
 	int			skc_tx_queue_mapping;
+#ifdef CONFIG_XPS
+	int			skc_rx_queue_mapping;
+	int			skc_rx_ifindex;
+#endif
 	union {
 		int		skc_incoming_cpu;
 		u32		skc_rcv_wnd;
@@ -326,6 +332,10 @@ struct sock {
 #define sk_nulls_node		__sk_common.skc_nulls_node
 #define sk_refcnt		__sk_common.skc_refcnt
 #define sk_tx_queue_mapping	__sk_common.skc_tx_queue_mapping
+#ifdef CONFIG_XPS
+#define sk_rx_queue_mapping	__sk_common.skc_rx_queue_mapping
+#define sk_rx_ifindex		__sk_common.skc_rx_ifindex
+#endif
 
 #define sk_dontcopy_begin	__sk_common.skc_dontcopy_begin
 #define sk_dontcopy_end		__sk_common.skc_dontcopy_end
@@ -1691,6 +1701,14 @@ static inline int sk_tx_queue_get(const struct sock *sk)
 	return sk ? sk->sk_tx_queue_mapping : -1;
 }
 
+static inline void sk_mark_rx_queue(struct sock *sk, struct sk_buff *skb)
+{
+#ifdef CONFIG_XPS
+	sk->sk_rx_ifindex = skb->skb_iif;
+	sk->sk_rx_queue_mapping = skb_get_rx_queue(skb);
+#endif
+}
+
 static inline void sk_set_socket(struct sock *sk, struct socket *sock)
 {
 	sk_tx_queue_clear(sk);
diff --git a/net/core/dev.c b/net/core/dev.c
index 4cfc179..d43f1c2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3457,18 +3457,14 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 }
 #endif /* CONFIG_NET_EGRESS */
 
-static inline int get_xps_queue(struct net_device *dev, struct sk_buff *skb)
+static int __get_xps_queue_idx(struct net_device *dev, struct sk_buff *skb,
+			       struct xps_dev_maps *dev_maps, unsigned int tci)
 {
 #ifdef CONFIG_XPS
-	struct xps_dev_maps *dev_maps;
 	struct xps_map *map;
 	int queue_index = -1;
 
-	rcu_read_lock();
-	dev_maps = rcu_dereference(dev->xps_maps[XPS_MAP_CPUS]);
 	if (dev_maps) {
-		unsigned int tci = skb->sender_cpu - 1;
-
 		if (dev->num_tc) {
 			tci *= dev->num_tc;
 			tci += netdev_get_prio_tc_map(dev, skb->priority);
@@ -3485,6 +3481,34 @@ static inline int get_xps_queue(struct net_device *dev, struct sk_buff *skb)
 				queue_index = -1;
 		}
 	}
+	return queue_index;
+#else
+	return -1;
+#endif
+}
+
+static int get_xps_queue(struct net_device *dev, struct sk_buff *skb)
+{
+#ifdef CONFIG_XPS
+	enum xps_map_type i = XPS_MAP_RXQS;
+	struct xps_dev_maps *dev_maps;
+	struct sock *sk = skb->sk;
+	int queue_index = -1;
+	unsigned int tci = 0;
+
+	if (sk && sk->sk_rx_queue_mapping <= dev->real_num_rx_queues &&
+	    dev->ifindex == sk->sk_rx_ifindex)
+		tci = sk->sk_rx_queue_mapping;
+
+	rcu_read_lock();
+	while (queue_index < 0 && i < __XPS_MAP_MAX) {
+		if (i == XPS_MAP_CPUS)
+			tci = skb->sender_cpu - 1;
+		dev_maps = rcu_dereference(dev->xps_maps[i]);
+		queue_index = __get_xps_queue_idx(dev, skb, dev_maps, tci);
+		i++;
+	}
+
 	rcu_read_unlock();
 
 	return queue_index;
diff --git a/net/core/sock.c b/net/core/sock.c
index 6444525..bd053db 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2817,6 +2817,11 @@ void sock_init_data(struct socket *sock, struct sock *sk)
 	sk->sk_pacing_rate = ~0U;
 	sk->sk_pacing_shift = 10;
 	sk->sk_incoming_cpu = -1;
+
+#ifdef CONFIG_XPS
+	sk->sk_rx_ifindex = -1;
+	sk->sk_rx_queue_mapping = -1;
+#endif
 	/*
 	 * Before updating sk_refcnt, we must commit prior changes to memory
 	 * (Documentation/RCU/rculist_nulls.txt for details)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 367def6..521b85c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -78,6 +78,7 @@
 #include <linux/errqueue.h>
 #include <trace/events/tcp.h>
 #include <linux/static_key.h>
+#include <net/busy_poll.h>
 
 int sysctl_tcp_max_orphans __read_mostly = NR_FILE;
 
@@ -5502,6 +5503,11 @@ void tcp_finish_connect(struct sock *sk, struct sk_buff *skb)
 		__tcp_fast_path_on(tp, tp->snd_wnd);
 	else
 		tp->pred_flags = 0;
+
+	if (skb) {
+		sk_mark_napi_id(sk, skb);
+		sk_mark_rx_queue(sk, skb);
+	}
 }
 
 static bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
@@ -6310,6 +6316,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tcp_rsk(req)->snt_isn = isn;
 	tcp_rsk(req)->txhash = net_tx_rndhash();
 	tcp_openreq_init_rwin(req, sk, dst);
+	sk_mark_rx_queue(req_to_sk(req), skb);
 	if (!want_cookie) {
 		tcp_reqsk_record_syn(sk, req, skb);
 		fastopen_sk = tcp_try_fastopen(sk, skb, req, &foc, dst);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f70586b..132d9af 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1467,6 +1467,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 
 		sock_rps_save_rxhash(sk, skb);
 		sk_mark_napi_id(sk, skb);
+		sk_mark_rx_queue(sk, skb);
 		if (dst) {
 			if (inet_sk(sk)->rx_dst_ifindex != skb->skb_iif ||
 			    !dst->ops->check(dst, 0)) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 57b5468..c18d6f2 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -835,6 +835,7 @@ int tcp_child_process(struct sock *parent, struct sock *child,
 
 	/* record NAPI ID of child */
 	sk_mark_napi_id(child, skb);
+	sk_mark_rx_queue(child, skb);
 
 	tcp_segs_in(tcp_sk(child), skb);
 	if (!sock_owned_by_user(child)) {

