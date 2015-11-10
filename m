From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Tue, 10 Nov 2015 09:56:45 -0800
Subject: [Intel-wired-lan] [PATCH v4 6/6] net: Add a generic
	udp_offload_get_port function
In-Reply-To: <1447178205-99510-1-git-send-email-anjali.singhai@intel.com>
References: <1447178205-99510-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <1447178205-99510-6-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The new function udp_offload_get_port replaces vxlan_get_rx_port().
This is a generic function that will help replay all udp tunnel ports irrespective of tunnel type.
This way when new udp tunnels get added this function need not change.

Note: Drivers besides i40e are compile tested with this change.

v2: fix a compile issue with redefinition of the function.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Signed-off-by: Kiran Patil <kiran.patil@intel.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c |  5 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c        |  3 ++-
 drivers/net/ethernet/emulex/benet/be_main.c      |  3 ++-
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c  |  3 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c      |  5 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  5 +++--
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c   |  3 ++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c |  3 ++-
 drivers/net/vxlan.c                              | 28 ++----------------------
 include/linux/netdevice.h                        |  2 ++
 include/net/protocol.h                           |  2 ++
 include/net/vxlan.h                              |  8 -------
 net/ipv4/udp_offload.c                           | 25 +++++++++++++++++++++
 13 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 3a863dc..299dca7 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -60,6 +60,7 @@
 #include <linux/semaphore.h>
 #include <linux/stringify.h>
 #include <linux/vmalloc.h>
+#include <net/protocol.h>
 
 #include "bnx2x.h"
 #include "bnx2x_init.h"
@@ -10293,7 +10294,7 @@ sp_rtnl_not_reset:
 			netdev_info(bp->dev,
 				    "Deleted vxlan dest port %d", port);
 			bp->vxlan_dst_port = 0;
-			vxlan_get_rx_port(bp->dev);
+			udp_offload_get_port(bp->dev);
 		}
 	}
 #endif
@@ -12499,7 +12500,7 @@ static int bnx2x_open(struct net_device *dev)
 
 #ifdef CONFIG_BNX2X_VXLAN
 	if (IS_PF(bp))
-		vxlan_get_rx_port(dev);
+		udp_offload_get_port(dev);
 #endif
 
 	return 0;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index af68428..47184d0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -39,6 +39,7 @@
 #include <net/ip6_checksum.h>
 #if defined(CONFIG_VXLAN) || defined(CONFIG_VXLAN_MODULE)
 #include <net/vxlan.h>
+#include <net/protocol.h>
 #include <net/udp_tunnel.h>
 #endif
 #ifdef CONFIG_NET_RX_BUSY_POLL
@@ -4579,7 +4580,7 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 
 	if (irq_re_init) {
 #if defined(CONFIG_VXLAN) || defined(CONFIG_VXLAN_MODULE)
-		vxlan_get_rx_port(bp->dev);
+		udp_offload_get_port(bp->dev);
 #endif
 		if (!bnxt_hwrm_tunnel_dst_port_alloc(
 				bp, htons(0x17c1),
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 6af9f27..5d579eb 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -25,6 +25,7 @@
 #include <net/busy_poll.h>
 #include <net/udp_tunnel.h>
 #include <net/vxlan.h>
+#include <net/protocol.h>
 
 MODULE_VERSION(DRV_VER);
 MODULE_DESCRIPTION(DRV_DESC " " DRV_VER);
@@ -3606,7 +3607,7 @@ static int be_open(struct net_device *netdev)
 
 #ifdef CONFIG_BE2NET_VXLAN
 	if (skyhawk_chip(adapter))
-		vxlan_get_rx_port(netdev);
+		udp_offload_get_port(netdev);
 #endif
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index bf7af95..cefa5ab 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -23,6 +23,7 @@
 #if IS_ENABLED(CONFIG_FM10K_VXLAN)
 #include <net/udp_tunnel.h>
 #include <net/vxlan.h>
+#include <net/protocol.h>
 #endif /* CONFIG_FM10K_VXLAN */
 
 /**
@@ -573,7 +574,7 @@ int fm10k_open(struct net_device *netdev)
 
 #if IS_ENABLED(CONFIG_FM10K_VXLAN)
 	/* update VXLAN port configuration */
-	vxlan_get_rx_port(netdev);
+	udp_offload_get_port(netdev);
 
 #endif
 	fm10k_up(interface);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1ce65a1..73fc27a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -34,6 +34,7 @@
 #if IS_ENABLED(CONFIG_GENEVE)
 #include <net/geneve.h>
 #endif
+#include <net/protocol.h>
 
 const char i40e_driver_name[] = "i40e";
 static const char i40e_driver_string[] =
@@ -5298,9 +5299,7 @@ int i40e_open(struct net_device *netdev)
 						       TCP_FLAG_CWR) >> 16);
 	wr32(&pf->hw, I40E_GLLAN_TSOMSK_L, be32_to_cpu(TCP_FLAG_CWR) >> 16);
 
-#if IS_ENABLED(CONFIG_VXLAN)
-	vxlan_get_rx_port(netdev);
-#endif
+	udp_offload_get_port(netdev);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d7ad9d9..137a637 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -52,6 +52,7 @@
 #include <scsi/fc/fc_fcoe.h>
 #include <net/udp_tunnel.h>
 #include <net/vxlan.h>
+#include <net/protocol.h>
 
 #ifdef CONFIG_OF
 #include <linux/of_net.h>
@@ -6039,7 +6040,7 @@ static int ixgbe_open(struct net_device *netdev)
 
 	ixgbe_clear_vxlan_port(adapter);
 #ifdef CONFIG_IXGBE_VXLAN
-	vxlan_get_rx_port(netdev);
+	udp_offload_get_port(netdev);
 #endif
 
 	return 0;
@@ -7118,7 +7119,7 @@ static void ixgbe_service_task(struct work_struct *work)
 #ifdef CONFIG_IXGBE_VXLAN
 	if (adapter->flags2 & IXGBE_FLAG2_VXLAN_REREG_NEEDED) {
 		adapter->flags2 &= ~IXGBE_FLAG2_VXLAN_REREG_NEEDED;
-		vxlan_get_rx_port(adapter->netdev);
+		udp_offload_get_port(adapter->netdev);
 	}
 #endif /* CONFIG_IXGBE_VXLAN */
 	ixgbe_reset_subtask(adapter);
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index bd8f240..ffc43bb 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -41,6 +41,7 @@
 #include <net/busy_poll.h>
 #include <net/udp_tunnel.h>
 #include <net/vxlan.h>
+#include <net/protocol.h>
 
 #include <linux/mlx4/driver.h>
 #include <linux/mlx4/device.h>
@@ -1714,7 +1715,7 @@ int mlx4_en_start_port(struct net_device *dev)
 
 #ifdef CONFIG_MLX4_EN_VXLAN
 	if (priv->mdev->dev->caps.tunnel_offload_mode == MLX4_TUNNEL_OFFLOAD_MODE_VXLAN)
-		vxlan_get_rx_port(dev);
+		udp_offload_get_port(dev);
 #endif
 	priv->port_up = true;
 	netif_tx_start_all_queues(dev);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index 18d384f..203b328 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -19,6 +19,7 @@
 #ifdef CONFIG_QLCNIC_VXLAN
 #include <net/udp_tunnel.h>
 #include <net/vxlan.h>
+#include <net/protocol.h>
 #endif
 
 #include "qlcnic.h"
@@ -2025,7 +2026,7 @@ qlcnic_attach(struct qlcnic_adapter *adapter)
 
 #ifdef CONFIG_QLCNIC_VXLAN
 	if (qlcnic_encap_rx_offload(adapter))
-		vxlan_get_rx_port(netdev);
+		udp_offload_get_port(netdev);
 #endif
 
 	adapter->is_up = QLCNIC_ADAPTER_UP_MAGIC;
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 463f41a..2ccb15f 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2422,32 +2422,6 @@ static struct device_type vxlan_type = {
 	.name = "vxlan",
 };
 
-/* Calls the ndo_add_udp_tunnel_port of the caller in order to
- * supply the listening VXLAN udp ports. Callers are expected
- * to implement the ndo_add_udp_tunnel_port.
- */
-void vxlan_get_rx_port(struct net_device *dev)
-{
-	struct vxlan_sock *vs;
-	struct net *net = dev_net(dev);
-	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-	sa_family_t sa_family;
-	__be16 port;
-	unsigned int i;
-
-	spin_lock(&vn->sock_lock);
-	for (i = 0; i < PORT_HASH_SIZE; ++i) {
-		hlist_for_each_entry_rcu(vs, &vn->sock_list[i], hlist) {
-			port = inet_sk(vs->sock->sk)->inet_sport;
-			sa_family = vxlan_get_sk_family(vs);
-			dev->netdev_ops->ndo_add_udp_tunnel_port(dev, sa_family,
-							port, UDP_TUNNEL_VXLAN);
-		}
-	}
-	spin_unlock(&vn->sock_lock);
-}
-EXPORT_SYMBOL_GPL(vxlan_get_rx_port);
-
 /* Initialize the device structure. */
 static void vxlan_setup(struct net_device *dev)
 {
@@ -2636,6 +2610,8 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 
 	/* Initialize the vxlan udp offloads structure */
 	vs->udp_offloads.port = port;
+	vs->udp_offloads.tunnel_type = UDP_TUNNEL_VXLAN;
+	vs->udp_offloads.family = ipv6 ? AF_INET6 : AF_INET;
 	vs->udp_offloads.callbacks.gro_receive  = vxlan_gro_receive;
 	vs->udp_offloads.callbacks.gro_complete = vxlan_gro_complete;
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index dbbab3b..cfe6201 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2059,6 +2059,8 @@ struct udp_offload_callbacks {
 
 struct udp_offload {
 	__be16			 port;
+	u8			 tunnel_type;
+	u8			 family;
 	u8			 ipproto;
 	struct udp_offload_callbacks callbacks;
 };
diff --git a/include/net/protocol.h b/include/net/protocol.h
index d6fcc1f..738bfc6 100644
--- a/include/net/protocol.h
+++ b/include/net/protocol.h
@@ -110,6 +110,8 @@ void inet_unregister_protosw(struct inet_protosw *p);
 int  udp_add_offload(struct udp_offload *prot);
 void udp_del_offload(struct udp_offload *prot);
 
+void udp_offload_get_port(struct net_device *dev);
+
 #if IS_ENABLED(CONFIG_IPV6)
 int inet6_add_protocol(const struct inet6_protocol *prot, unsigned char num);
 int inet6_del_protocol(const struct inet6_protocol *prot, unsigned char num);
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index c1c899c..926455e 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -242,14 +242,6 @@ static inline netdev_features_t vxlan_features_check(struct sk_buff *skb,
 /* IPv6 header + UDP + VXLAN + Ethernet header */
 #define VXLAN6_HEADROOM (40 + 8 + 8 + 14)
 
-#if IS_ENABLED(CONFIG_VXLAN)
-void vxlan_get_rx_port(struct net_device *netdev);
-#else
-static inline void vxlan_get_rx_port(struct net_device *netdev)
-{
-}
-#endif
-
 static inline unsigned short vxlan_get_sk_family(struct vxlan_sock *vs)
 {
 	return vs->sock->sk->sk_family;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index f938616..30aa84c 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -290,6 +290,31 @@ unlock:
 }
 EXPORT_SYMBOL(udp_del_offload);
 
+void udp_offload_get_port(struct net_device *dev)
+{
+#if IS_ENABLED(CONFIG_VXLAN) || IS_ENABLED(CONFIG_GENEVE)
+	struct udp_offload_priv __rcu **head = &udp_offload_base;
+	struct udp_offload_priv *uo_priv;
+	struct udp_offload *uo;
+
+	rcu_read_lock();
+	uo_priv = rcu_dereference(udp_offload_base);
+	for (; uo_priv != NULL; uo_priv = rcu_dereference(uo_priv->next)) {
+		/* call the right add port */
+		uo = uo_priv->offload;
+		if (uo && dev->netdev_ops->ndo_add_udp_tunnel_port)
+			dev->netdev_ops->ndo_add_udp_tunnel_port(dev,
+							uo->family,
+							uo->port,
+							uo->tunnel_type);
+
+		head = &uo_priv->next;
+	}
+	rcu_read_unlock();
+#endif
+}
+EXPORT_SYMBOL(udp_offload_get_port);
+
 struct sk_buff **udp_gro_receive(struct sk_buff **head, struct sk_buff *skb,
 				 struct udphdr *uh)
 {
-- 
1.8.1.4

