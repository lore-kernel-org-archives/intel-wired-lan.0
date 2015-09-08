From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Tue,  8 Sep 2015 14:55:53 -0700
Subject: [Intel-wired-lan] [PATCH v2 2/5] vxlan: Generalize udp based tunnel
	offload
In-Reply-To: <1441749356-92927-1-git-send-email-anjali.singhai@intel.com>
References: <1441749356-92927-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <1441749356-92927-2-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Replace add/del ndo ops for vxlan_port with tunnel_port so that all UDP
based tunnels can use the same ndo op. Add a parameter to pass tunnel
type to the ndo_op.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/vxlan.c       | 20 ++++++++++----------
 include/linux/netdevice.h | 33 ++++++++++++++++-----------------
 include/net/udp_tunnel.h  |  6 ++++++
 3 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 61b457b..538e846 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -629,9 +629,9 @@ static void vxlan_notify_add_rx_port(struct vxlan_sock *vs)
 
 	rcu_read_lock();
 	for_each_netdev_rcu(net, dev) {
-		if (dev->netdev_ops->ndo_add_vxlan_port)
-			dev->netdev_ops->ndo_add_vxlan_port(dev, sa_family,
-							    port);
+		if (dev->netdev_ops->ndo_add_tunnel_port)
+			dev->netdev_ops->ndo_add_tunnel_port(dev, sa_family,
+							port, UDP_TUNNEL_VXLAN);
 	}
 	rcu_read_unlock();
 }
@@ -647,9 +647,9 @@ static void vxlan_notify_del_rx_port(struct vxlan_sock *vs)
 
 	rcu_read_lock();
 	for_each_netdev_rcu(net, dev) {
-		if (dev->netdev_ops->ndo_del_vxlan_port)
-			dev->netdev_ops->ndo_del_vxlan_port(dev, sa_family,
-							    port);
+		if (dev->netdev_ops->ndo_del_tunnel_port)
+			dev->netdev_ops->ndo_del_tunnel_port(dev, sa_family,
+							port, UDP_TUNNEL_VXLAN);
 	}
 	rcu_read_unlock();
 
@@ -2379,9 +2379,9 @@ static struct device_type vxlan_type = {
 	.name = "vxlan",
 };
 
-/* Calls the ndo_add_vxlan_port of the caller in order to
+/* Calls the ndo_add_tunnel_port of the caller in order to
  * supply the listening VXLAN udp ports. Callers are expected
- * to implement the ndo_add_vxlan_port.
+ * to implement the ndo_add_tunnel_port.
  */
 void vxlan_get_rx_port(struct net_device *dev)
 {
@@ -2397,8 +2397,8 @@ void vxlan_get_rx_port(struct net_device *dev)
 		hlist_for_each_entry_rcu(vs, &vn->sock_list[i], hlist) {
 			port = inet_sk(vs->sock->sk)->inet_sport;
 			sa_family = vxlan_get_sk_family(vs);
-			dev->netdev_ops->ndo_add_vxlan_port(dev, sa_family,
-							    port);
+			dev->netdev_ops->ndo_add_tunnel_port(dev, sa_family,
+							port, UDP_TUNNEL_VXLAN);
 		}
 	}
 	spin_unlock(&vn->sock_lock);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c69072b..b6f6beb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1003,18 +1003,18 @@ typedef u16 (*select_queue_fallback_t)(struct net_device *dev,
  *	not implement this, it is assumed that the hw is not able to have
  *	multiple net devices on single physical port.
  *
- * void (*ndo_add_vxlan_port)(struct  net_device *dev,
- *			      sa_family_t sa_family, __be16 port);
- *	Called by vxlan to notiy a driver about the UDP port and socket
- *	address family that vxlan is listnening to. It is called only when
- *	a new port starts listening. The operation is protected by the
- *	vxlan_net->sock_lock.
- *
- * void (*ndo_del_vxlan_port)(struct  net_device *dev,
- *			      sa_family_t sa_family, __be16 port);
- *	Called by vxlan to notify the driver about a UDP port and socket
- *	address family that vxlan is not listening to anymore. The operation
- *	is protected by the vxlan_net->sock_lock.
+ * void (*ndo_add_tunnel_port)(struct  net_device *dev,
+ *			      sa_family_t sa_family, __be16 port, u32 type);
+ *	Called by UDP based tunnel modules to notify a driver about a UDP
+ *	port and socket address family that the tunnel is listening to. It is
+ *	called only when a new port starts listening. The operation is
+ *	protected by tunnel socket sock_lock.
+ *
+ * void (*ndo_del_tunnel_port)(struct  net_device *dev,
+ *			      sa_family_t sa_family, __be16 port, u32 type);
+ *	Called by UDP based tunnel modules to notify the driver about a UDP port
+ *	and socket address family that tunnel is not listening to anymore.
+ *	The operation is protected by tunnel socket sock_lock.
  *
  * void* (*ndo_dfwd_add_station)(struct net_device *pdev,
  *				 struct net_device *dev)
@@ -1204,13 +1204,12 @@ struct net_device_ops {
 							struct netdev_phys_item_id *ppid);
 	int			(*ndo_get_phys_port_name)(struct net_device *dev,
 							  char *name, size_t len);
-	void			(*ndo_add_vxlan_port)(struct  net_device *dev,
+	void			(*ndo_add_tunnel_port)(struct  net_device *dev,
 						      sa_family_t sa_family,
-						      __be16 port);
-	void			(*ndo_del_vxlan_port)(struct  net_device *dev,
+						      __be16 port, u32 type);
+	void			(*ndo_del_tunnel_port)(struct  net_device *dev,
 						      sa_family_t sa_family,
-						      __be16 port);
-
+						      __be16 port, u32 type);
 	void*			(*ndo_dfwd_add_station)(struct net_device *pdev,
 							struct net_device *dev);
 	void			(*ndo_dfwd_del_station)(struct net_device *pdev,
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index c491c12..328f3ab 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -9,6 +9,12 @@
 #include <net/addrconf.h>
 #endif
 
+enum udp_tunnel_type {
+	UDP_TUNNEL_NONE,
+	UDP_TUNNEL_VXLAN,
+	UDP_TUNNEL_GENEVE,
+};
+
 struct udp_port_cfg {
 	u8			family;
 
-- 
1.8.1.4

