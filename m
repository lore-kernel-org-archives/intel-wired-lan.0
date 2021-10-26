From: Maciej Machnikowski <maciej.machnikowski@intel.com>
Date: Tue, 26 Oct 2021 19:31:43 +0200
Subject: [Intel-wired-lan] [RFC v5 net-next 2/5] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20211026173146.1031412-1-maciej.machnikowski@intel.com>
References: <20211026173146.1031412-1-maciej.machnikowski@intel.com>
Message-ID: <20211026173146.1031412-3-maciej.machnikowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series introduces basic interface for reading the Ethernet
Equipment Clock (EEC) state on a SyncE capable device. This state gives
information about the state of EEC. This interface is required to
implement Synchronization Status Messaging on upper layers.

Initial implementation returns SyncE EEC state and flags attributes.
The only flag currently implemented is the EEC_SRC_PORT. When it's set
the EEC is synchronized to the recovered clock recovered from the
current port.

SyncE EEC state read needs to be implemented as a ndo_get_eec_state
function.

Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
---
 include/linux/netdevice.h      |  9 ++++
 include/uapi/linux/if_link.h   | 27 ++++++++++++
 include/uapi/linux/rtnetlink.h |  3 ++
 net/core/rtnetlink.c           | 77 ++++++++++++++++++++++++++++++++++
 security/selinux/nlmsgtab.c    |  3 +-
 5 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3ec42495a43a..fec54951347e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1344,6 +1344,9 @@ struct netdev_net_notifier {
  *	The caller must be under RCU read context.
  * int (*ndo_fill_forward_path)(struct net_device_path_ctx *ctx, struct net_device_path *path);
  *     Get the forwarding path to reach the real device from the HW destination address
+ * int (*ndo_get_eec_state)(struct net_device *dev, enum if_eec_state *state,
+ *			    u32 *src_idx, struct netlink_ext_ack *extack);
+ *	Get state of physical layer frequency synchronization (SyncE)
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1563,6 +1566,12 @@ struct net_device_ops {
 	struct net_device *	(*ndo_get_peer_dev)(struct net_device *dev);
 	int                     (*ndo_fill_forward_path)(struct net_device_path_ctx *ctx,
                                                          struct net_device_path *path);
+	int			(*ndo_get_eec_state)(struct net_device *dev,
+						     enum if_eec_state *state,
+						     struct netlink_ext_ack *extack);
+	int			(*ndo_get_eec_src)(struct net_device *dev,
+						   u32 *src,
+						   struct netlink_ext_ack *extack);
 };
 
 /**
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index eebd3894fe89..abab69b79e8a 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1273,4 +1273,31 @@ enum {
 
 #define IFLA_MCTP_MAX (__IFLA_MCTP_MAX - 1)
 
+/* SyncE section */
+
+enum if_eec_state {
+	IF_EEC_STATE_INVALID = 0,
+	IF_EEC_STATE_FREERUN,
+	IF_EEC_STATE_LOCKED,
+	IF_EEC_STATE_LOCKED_HO_ACQ,
+	IF_EEC_STATE_HOLDOVER,
+};
+
+#define EEC_SRC_PORT		(1 << 0) /* recovered clock from the port is
+					  * currently the source for the EEC
+					  */
+
+struct if_eec_state_msg {
+	__u32 ifindex;
+};
+
+enum {
+	IFLA_EEC_UNSPEC,
+	IFLA_EEC_STATE,
+	IFLA_EEC_SRC_IDX,
+	__IFLA_EEC_MAX,
+};
+
+#define IFLA_EEC_MAX (__IFLA_EEC_MAX - 1)
+
 #endif /* _UAPI_LINUX_IF_LINK_H */
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 5888492a5257..1d8662afd6bd 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -185,6 +185,9 @@ enum {
 	RTM_GETNEXTHOPBUCKET,
 #define RTM_GETNEXTHOPBUCKET	RTM_GETNEXTHOPBUCKET
 
+	RTM_GETEECSTATE = 124,
+#define RTM_GETEECSTATE	RTM_GETEECSTATE
+
 	__RTM_MAX,
 #define RTM_MAX		(((__RTM_MAX + 3) & ~3) - 1)
 };
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 2af8aeeadadf..bba13b377e73 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5467,6 +5467,81 @@ static int rtnl_stats_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+static int rtnl_fill_eec_state(struct sk_buff *skb, struct net_device *dev,
+			       u32 portid, u32 seq, struct netlink_callback *cb,
+			       int flags, struct netlink_ext_ack *extack)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+	struct if_eec_state_msg *state_msg;
+	enum if_eec_state state;
+	struct nlmsghdr *nlh;
+	u32 src_idx;
+	int err;
+
+	ASSERT_RTNL();
+
+	if (!ops->ndo_get_eec_state)
+		return -EOPNOTSUPP;
+
+	err = ops->ndo_get_eec_state(dev, &state, extack);
+	if (err)
+		return err;
+
+	nlh = nlmsg_put(skb, portid, seq, RTM_GETEECSTATE, sizeof(*state_msg),
+			flags);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	state_msg = nlmsg_data(nlh);
+	state_msg->ifindex = dev->ifindex;
+
+	if (nla_put_u32(skb, IFLA_EEC_STATE, state))
+		return -EMSGSIZE;
+
+	if (!ops->ndo_get_eec_src)
+		goto end_msg;
+
+	err = ops->ndo_get_eec_src(dev, &src_idx, extack);
+	if (err)
+		return err;
+
+	if (nla_put_u32(skb, IFLA_EEC_SRC_IDX, src_idx))
+		return -EMSGSIZE;
+
+end_msg:
+	nlmsg_end(skb, nlh);
+	return 0;
+}
+
+static int rtnl_eec_state_get(struct sk_buff *skb, struct nlmsghdr *nlh,
+			      struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	struct if_eec_state_msg *state;
+	struct net_device *dev;
+	struct sk_buff *nskb;
+	int err;
+
+	state = nlmsg_data(nlh);
+	dev = __dev_get_by_index(net, state->ifindex);
+	if (!dev)
+		return -ENODEV;
+
+	nskb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!nskb)
+		return -ENOBUFS;
+
+	err = rtnl_fill_eec_state(nskb, dev, NETLINK_CB(skb).portid,
+				  nlh->nlmsg_seq, NULL, nlh->nlmsg_flags,
+				  extack);
+	if (err < 0)
+		kfree_skb(nskb);
+	else
+		err = rtnl_unicast(nskb, net, NETLINK_CB(skb).portid);
+
+	return err;
+}
+
 /* Process one rtnetlink message. */
 
 static int rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -5692,4 +5767,6 @@ void __init rtnetlink_init(void)
 
 	rtnl_register(PF_UNSPEC, RTM_GETSTATS, rtnl_stats_get, rtnl_stats_dump,
 		      0);
+
+	rtnl_register(PF_UNSPEC, RTM_GETEECSTATE, rtnl_eec_state_get, NULL, 0);
 }
diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 94ea2a8b2bb7..2c66e722ea9c 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -91,6 +91,7 @@ static const struct nlmsg_perm nlmsg_route_perms[] =
 	{ RTM_NEWNEXTHOPBUCKET,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_DELNEXTHOPBUCKET,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_GETNEXTHOPBUCKET,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_GETEECSTATE,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
 };
 
 static const struct nlmsg_perm nlmsg_tcpdiag_perms[] =
@@ -176,7 +177,7 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 		 * structures@the top of this file with the new mappings
 		 * before updating the BUILD_BUG_ON() macro!
 		 */
-		BUILD_BUG_ON(RTM_MAX != (RTM_NEWNEXTHOPBUCKET + 3));
+		BUILD_BUG_ON(RTM_MAX != (RTM_GETEECSTATE + 3));
 		err = nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
 				 sizeof(nlmsg_route_perms));
 		break;
-- 
2.26.3

