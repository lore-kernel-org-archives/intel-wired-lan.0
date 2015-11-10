From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Mon,  9 Nov 2015 22:25:36 -0800
Subject: [Intel-wired-lan] [PATCH v3 2/6] net: Generalize udp based tunnel
	offload
In-Reply-To: <1447136740-77107-1-git-send-email-anjali.singhai@intel.com>
References: <1447136740-77107-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <1447136740-77107-2-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Replace add/del ndo ops for vxlan_port with tunnel_port so that all UDP
based tunnels can use the same ndo op. Add a parameter to pass tunnel
type to the ndo_op.

Change all drivers to use the generalized udp tunnel offload

Patch was compile tested with x86_64_defconfig.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 15 ++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c        | 15 ++++++---
 drivers/net/ethernet/emulex/benet/be_main.c      | 15 ++++++---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c  | 27 ++++++++++++----
 drivers/net/ethernet/intel/i40e/i40e_main.c      | 41 +++++++++++++++++-------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 17 +++++++---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c   | 21 ++++++++----
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c | 17 +++++++---
 drivers/net/vxlan.c                              | 20 ++++++------
 include/linux/netdevice.h                        | 39 ++++++++++++----------
 include/net/udp_tunnel.h                         |  5 +++
 11 files changed, 161 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index f1d62d5..3a863dc 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -47,6 +47,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/tcp.h>
+#include <net/udp_tunnel.h>
 #include <net/vxlan.h>
 #include <net/checksum.h>
 #include <net/ip6_checksum.h>
@@ -10124,11 +10125,14 @@ static void __bnx2x_add_vxlan_port(struct bnx2x *bp, u16 port)
 }
 
 static void bnx2x_add_vxlan_port(struct net_device *netdev,
-				 sa_family_t sa_family, __be16 port)
+				 sa_family_t sa_family, __be16 port,
+				 u32 type)
 {
 	struct bnx2x *bp = netdev_priv(netdev);
 	u16 t_port = ntohs(port);
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
 	__bnx2x_add_vxlan_port(bp, t_port);
 }
 
@@ -10152,11 +10156,14 @@ static void __bnx2x_del_vxlan_port(struct bnx2x *bp, u16 port)
 }
 
 static void bnx2x_del_vxlan_port(struct net_device *netdev,
-				 sa_family_t sa_family, __be16 port)
+				 sa_family_t sa_family, __be16 port,
+				 u32 type)
 {
 	struct bnx2x *bp = netdev_priv(netdev);
 	u16 t_port = ntohs(port);
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
 	__bnx2x_del_vxlan_port(bp, t_port);
 }
 #endif
@@ -13011,8 +13018,8 @@ static const struct net_device_ops bnx2x_netdev_ops = {
 	.ndo_set_vf_link_state	= bnx2x_set_vf_link_state,
 	.ndo_features_check	= bnx2x_features_check,
 #ifdef CONFIG_BNX2X_VXLAN
-	.ndo_add_vxlan_port	= bnx2x_add_vxlan_port,
-	.ndo_del_vxlan_port	= bnx2x_del_vxlan_port,
+	.ndo_add_udp_tunnel_port	= bnx2x_add_vxlan_port,
+	.ndo_del_udp_tunnel_port	= bnx2x_del_vxlan_port,
 #endif
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6c2e0c6..af68428 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -39,6 +39,7 @@
 #include <net/ip6_checksum.h>
 #if defined(CONFIG_VXLAN) || defined(CONFIG_VXLAN_MODULE)
 #include <net/vxlan.h>
+#include <net/udp_tunnel.h>
 #endif
 #ifdef CONFIG_NET_RX_BUSY_POLL
 #include <net/busy_poll.h>
@@ -5409,7 +5410,7 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 #endif /* CONFIG_RFS_ACCEL */
 
 static void bnxt_add_vxlan_port(struct net_device *dev, sa_family_t sa_family,
-				__be16 port)
+				__be16 port, u32 type)
 {
 	struct bnxt *bp = netdev_priv(dev);
 
@@ -5419,6 +5420,9 @@ static void bnxt_add_vxlan_port(struct net_device *dev, sa_family_t sa_family,
 	if (sa_family != AF_INET6 && sa_family != AF_INET)
 		return;
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
+
 	if (bp->vxlan_port_cnt && bp->vxlan_port != port)
 		return;
 
@@ -5431,7 +5435,7 @@ static void bnxt_add_vxlan_port(struct net_device *dev, sa_family_t sa_family,
 }
 
 static void bnxt_del_vxlan_port(struct net_device *dev, sa_family_t sa_family,
-				__be16 port)
+				__be16 port, u32 type)
 {
 	struct bnxt *bp = netdev_priv(dev);
 
@@ -5441,6 +5445,9 @@ static void bnxt_del_vxlan_port(struct net_device *dev, sa_family_t sa_family,
 	if (sa_family != AF_INET6 && sa_family != AF_INET)
 		return;
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
+
 	if (bp->vxlan_port_cnt && bp->vxlan_port == port) {
 		bp->vxlan_port_cnt--;
 
@@ -5479,8 +5486,8 @@ static const struct net_device_ops bnxt_netdev_ops = {
 #ifdef CONFIG_RFS_ACCEL
 	.ndo_rx_flow_steer	= bnxt_rx_flow_steer,
 #endif
-	.ndo_add_vxlan_port	= bnxt_add_vxlan_port,
-	.ndo_del_vxlan_port	= bnxt_del_vxlan_port,
+	.ndo_add_udp_tunnel_port	= bnxt_add_vxlan_port,
+	.ndo_del_udp_tunnel_port	= bnxt_del_vxlan_port,
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	.ndo_busy_poll		= bnxt_busy_poll,
 #endif
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index eb48a97..6af9f27 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -23,6 +23,7 @@
 #include <linux/aer.h>
 #include <linux/if_bridge.h>
 #include <net/busy_poll.h>
+#include <net/udp_tunnel.h>
 #include <net/vxlan.h>
 
 MODULE_VERSION(DRV_VER);
@@ -5177,12 +5178,15 @@ static int be_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
  * until after all the tunnels are removed.
  */
 static void be_add_vxlan_port(struct net_device *netdev, sa_family_t sa_family,
-			      __be16 port)
+			      __be16 port, u32 type)
 {
 	struct be_adapter *adapter = netdev_priv(netdev);
 	struct device *dev = &adapter->pdev->dev;
 	int status;
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
+
 	if (lancer_chip(adapter) || BEx_chip(adapter) || be_is_mc(adapter))
 		return;
 
@@ -5231,10 +5235,13 @@ err:
 }
 
 static void be_del_vxlan_port(struct net_device *netdev, sa_family_t sa_family,
-			      __be16 port)
+			      __be16 port, u32 type)
 {
 	struct be_adapter *adapter = netdev_priv(netdev);
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
+
 	if (lancer_chip(adapter) || BEx_chip(adapter) || be_is_mc(adapter))
 		return;
 
@@ -5344,8 +5351,8 @@ static const struct net_device_ops be_netdev_ops = {
 	.ndo_busy_poll		= be_busy_poll,
 #endif
 #ifdef CONFIG_BE2NET_VXLAN
-	.ndo_add_vxlan_port	= be_add_vxlan_port,
-	.ndo_del_vxlan_port	= be_del_vxlan_port,
+	.ndo_add_udp_tunnel_port	= be_add_vxlan_port,
+	.ndo_del_udp_tunnel_port	= be_del_vxlan_port,
 	.ndo_features_check	= be_features_check,
 #endif
 	.ndo_get_phys_port_id   = be_get_phys_port_id,
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 722ac52..bf7af95 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -21,6 +21,7 @@
 #include "fm10k.h"
 #include <linux/vmalloc.h>
 #if IS_ENABLED(CONFIG_FM10K_VXLAN)
+#include <net/udp_tunnel.h>
 #include <net/vxlan.h>
 #endif /* CONFIG_FM10K_VXLAN */
 
@@ -439,18 +440,24 @@ static void fm10k_restore_vxlan_port(struct fm10k_intfc *interface)
  * @netdev: network interface device structure
  * @sa_family: Address family of new port
  * @port: port number used for VXLAN
+ * @type: Tunnel type
  *
- * This funciton is called when a new VXLAN interface has added a new port
+ * This function is called when a new VXLAN interface has added a new port
  * number to the range that is currently in use for VXLAN.  The new port
  * number is always added to the tail so that the port number list should
  * match the order in which the ports were allocated.  The head of the list
  * is always used as the VXLAN port number for offloads.
  **/
 static void fm10k_add_vxlan_port(struct net_device *dev,
-				 sa_family_t sa_family, __be16 port) {
+				 sa_family_t sa_family, __be16 port,
+				 u32 type) {
+#if IS_ENABLED(CONFIG_FM10K_VXLAN)
 	struct fm10k_intfc *interface = netdev_priv(dev);
 	struct fm10k_vxlan_port *vxlan_port;
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
+
 	/* only the PF supports configuring tunnels */
 	if (interface->hw.mac.type != fm10k_mac_pf)
 		return;
@@ -476,6 +483,7 @@ insert_tail:
 	list_add_tail(&vxlan_port->list, &interface->vxlan_port);
 
 	fm10k_restore_vxlan_port(interface);
+#endif
 }
 
 /**
@@ -483,17 +491,23 @@ insert_tail:
  * @netdev: network interface device structure
  * @sa_family: Address family of freed port
  * @port: port number used for VXLAN
+ * @type: Tunnel type
  *
- * This funciton is called when a new VXLAN interface has freed a port
+ * This function is called when a new VXLAN interface has freed a port
  * number from the range that is currently in use for VXLAN.  The freed
  * port is removed from the list and the new head is used to determine
  * the port number for offloads.
  **/
 static void fm10k_del_vxlan_port(struct net_device *dev,
-				 sa_family_t sa_family, __be16 port) {
+				 sa_family_t sa_family, __be16 port,
+				 u32 type) {
+#if IS_ENABLED(CONFIG_FM10K_VXLAN)
 	struct fm10k_intfc *interface = netdev_priv(dev);
 	struct fm10k_vxlan_port *vxlan_port;
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
+
 	if (interface->hw.mac.type != fm10k_mac_pf)
 		return;
 
@@ -508,6 +522,7 @@ static void fm10k_del_vxlan_port(struct net_device *dev,
 	}
 
 	fm10k_restore_vxlan_port(interface);
+#endif
 }
 
 /**
@@ -1389,8 +1404,8 @@ static const struct net_device_ops fm10k_netdev_ops = {
 	.ndo_set_vf_vlan	= fm10k_ndo_set_vf_vlan,
 	.ndo_set_vf_rate	= fm10k_ndo_set_vf_bw,
 	.ndo_get_vf_config	= fm10k_ndo_get_vf_config,
-	.ndo_add_vxlan_port	= fm10k_add_vxlan_port,
-	.ndo_del_vxlan_port	= fm10k_del_vxlan_port,
+	.ndo_add_udp_tunnel_port	= fm10k_add_vxlan_port,
+	.ndo_del_udp_tunnel_port	= fm10k_del_vxlan_port,
 	.ndo_do_ioctl		= fm10k_ioctl,
 	.ndo_dfwd_add_station	= fm10k_dfwd_add_station,
 	.ndo_dfwd_del_station	= fm10k_dfwd_del_station,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 900cc57..9d45e40 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -28,6 +28,7 @@
 #include "i40e.h"
 #include "i40e_diag.h"
 #if IS_ENABLED(CONFIG_VXLAN)
+#include <net/udp_tunnel.h>
 #include <net/vxlan.h>
 #endif
 
@@ -8470,6 +8471,7 @@ static int i40e_set_features(struct net_device *netdev,
 
 	return 0;
 }
+#if IS_ENABLED(CONFIG_VXLAN)
 
 /**
  * i40e_get_vxlan_port_idx - Lookup a possibly offloaded for Rx UDP port
@@ -8489,22 +8491,29 @@ static u8 i40e_get_vxlan_port_idx(struct i40e_pf *pf, __be16 port)
 
 	return i;
 }
+#endif
 
 /**
- * i40e_add_vxlan_port - Get notifications about VXLAN ports that come up
+ * i40e_add_tunnel_port - Get notifications about UDP tunnel ports that come up
  * @netdev: This physical port's netdev
- * @sa_family: Socket Family that VXLAN is notifying us about
- * @port: New UDP port number that VXLAN started listening to
+ * @sa_family: Socket Family that tunnel netdev is  associated with
+ * @port: New UDP port number that tunnel started listening to
+ * @type: Tunnel Type
  **/
-static void i40e_add_vxlan_port(struct net_device *netdev,
-				sa_family_t sa_family, __be16 port)
+static void i40e_add_tunnel_port(struct net_device *netdev,
+				 sa_family_t sa_family, __be16 port,
+				 u32 type)
 {
+#if IS_ENABLED(CONFIG_VXLAN)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	u8 next_idx;
 	u8 idx;
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
+
 	if (sa_family == AF_INET6)
 		return;
 
@@ -8530,22 +8539,29 @@ static void i40e_add_vxlan_port(struct net_device *netdev,
 	pf->vxlan_ports[next_idx] = port;
 	pf->pending_vxlan_bitmap |= BIT_ULL(next_idx);
 	pf->flags |= I40E_FLAG_VXLAN_FILTER_SYNC;
+#endif
 }
 
 /**
- * i40e_del_vxlan_port - Get notifications about VXLAN ports that go away
+ * i40e_del_tunnel_port - Get notifications about UDP tunnel ports that go away
  * @netdev: This physical port's netdev
- * @sa_family: Socket Family that VXLAN is notifying us about
- * @port: UDP port number that VXLAN stopped listening to
+ * @sa_family: Socket Family that tunnel netdev is associated with
+ * @port: UDP port number that tunnel stopped listening to
+ * @type: Tunnel Type
  **/
-static void i40e_del_vxlan_port(struct net_device *netdev,
-				sa_family_t sa_family, __be16 port)
+static void i40e_del_tunnel_port(struct net_device *netdev,
+				 sa_family_t sa_family, __be16 port,
+				 u32 type)
 {
+#if IS_ENABLED(CONFIG_VXLAN)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	u8 idx;
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
+
 	if (sa_family == AF_INET6)
 		return;
 
@@ -8563,6 +8579,7 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
 		netdev_warn(netdev, "vxlan port %d was not found, not deleting\n",
 			    ntohs(port));
 	}
+#endif
 }
 
 static int i40e_get_phys_port_id(struct net_device *netdev,
@@ -8789,8 +8806,8 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_get_vf_config	= i40e_ndo_get_vf_config,
 	.ndo_set_vf_link_state	= i40e_ndo_set_vf_link_state,
 	.ndo_set_vf_spoofchk	= i40e_ndo_set_vf_spoofchk,
-	.ndo_add_vxlan_port	= i40e_add_vxlan_port,
-	.ndo_del_vxlan_port	= i40e_del_vxlan_port,
+	.ndo_add_udp_tunnel_port	= i40e_add_tunnel_port,
+	.ndo_del_udp_tunnel_port	= i40e_del_tunnel_port,
 	.ndo_get_phys_port_id	= i40e_get_phys_port_id,
 	.ndo_fdb_add		= i40e_ndo_fdb_add,
 	.ndo_features_check	= i40e_features_check,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f5730dd..d7ad9d9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -50,6 +50,7 @@
 #include <linux/if_bridge.h>
 #include <linux/prefetch.h>
 #include <scsi/fc/fc_fcoe.h>
+#include <net/udp_tunnel.h>
 #include <net/vxlan.h>
 
 #ifdef CONFIG_OF
@@ -8312,14 +8313,18 @@ static int ixgbe_set_features(struct net_device *netdev,
  * @dev: The port's netdev
  * @sa_family: Socket Family that VXLAN is notifiying us about
  * @port: New UDP port number that VXLAN started listening to
+ * @type: Tunnel type
  **/
 static void ixgbe_add_vxlan_port(struct net_device *dev, sa_family_t sa_family,
-				 __be16 port)
+				 __be16 port, u32 type)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 	struct ixgbe_hw *hw = &adapter->hw;
 	u16 new_port = ntohs(port);
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
+
 	if (!(adapter->flags & IXGBE_FLAG_VXLAN_OFFLOAD_CAPABLE))
 		return;
 
@@ -8345,13 +8350,17 @@ static void ixgbe_add_vxlan_port(struct net_device *dev, sa_family_t sa_family,
  * @dev: The port's netdev
  * @sa_family: Socket Family that VXLAN is notifying us about
  * @port: UDP port number that VXLAN stopped listening to
+ * @type: Tunnel type
  **/
 static void ixgbe_del_vxlan_port(struct net_device *dev, sa_family_t sa_family,
-				 __be16 port)
+				 __be16 port, u32 type)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 	u16 new_port = ntohs(port);
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
+
 	if (!(adapter->flags & IXGBE_FLAG_VXLAN_OFFLOAD_CAPABLE))
 		return;
 
@@ -8663,8 +8672,8 @@ static const struct net_device_ops ixgbe_netdev_ops = {
 	.ndo_dfwd_add_station	= ixgbe_fwd_add,
 	.ndo_dfwd_del_station	= ixgbe_fwd_del,
 #ifdef CONFIG_IXGBE_VXLAN
-	.ndo_add_vxlan_port	= ixgbe_add_vxlan_port,
-	.ndo_del_vxlan_port	= ixgbe_del_vxlan_port,
+	.ndo_add_udp_tunnel_port	= ixgbe_add_vxlan_port,
+	.ndo_del_udp_tunnel_port	= ixgbe_del_vxlan_port,
 #endif /* CONFIG_IXGBE_VXLAN */
 	.ndo_features_check	= ixgbe_features_check,
 };
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 886e1bc..bd8f240 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -39,6 +39,7 @@
 #include <linux/hash.h>
 #include <net/ip.h>
 #include <net/busy_poll.h>
+#include <net/udp_tunnel.h>
 #include <net/vxlan.h>
 
 #include <linux/mlx4/driver.h>
@@ -2402,11 +2403,15 @@ static void mlx4_en_del_vxlan_offloads(struct work_struct *work)
 }
 
 static void mlx4_en_add_vxlan_port(struct  net_device *dev,
-				   sa_family_t sa_family, __be16 port)
+				   sa_family_t sa_family, __be16 port,
+				   u32 type)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	__be16 current_port;
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
+
 	if (priv->mdev->dev->caps.tunnel_offload_mode != MLX4_TUNNEL_OFFLOAD_MODE_VXLAN)
 		return;
 
@@ -2425,11 +2430,15 @@ static void mlx4_en_add_vxlan_port(struct  net_device *dev,
 }
 
 static void mlx4_en_del_vxlan_port(struct  net_device *dev,
-				   sa_family_t sa_family, __be16 port)
+				   sa_family_t sa_family, __be16 port,
+				   u32 type)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	__be16 current_port;
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
+
 	if (priv->mdev->dev->caps.tunnel_offload_mode != MLX4_TUNNEL_OFFLOAD_MODE_VXLAN)
 		return;
 
@@ -2509,8 +2518,8 @@ static const struct net_device_ops mlx4_netdev_ops = {
 #endif
 	.ndo_get_phys_port_id	= mlx4_en_get_phys_port_id,
 #ifdef CONFIG_MLX4_EN_VXLAN
-	.ndo_add_vxlan_port	= mlx4_en_add_vxlan_port,
-	.ndo_del_vxlan_port	= mlx4_en_del_vxlan_port,
+	.ndo_add_udp_tunnel_port	= mlx4_en_add_vxlan_port,
+	.ndo_del_udp_tunnel_port	= mlx4_en_del_vxlan_port,
 	.ndo_features_check	= mlx4_en_features_check,
 #endif
 	.ndo_set_tx_maxrate	= mlx4_en_set_tx_maxrate,
@@ -2547,8 +2556,8 @@ static const struct net_device_ops mlx4_netdev_ops_master = {
 #endif
 	.ndo_get_phys_port_id	= mlx4_en_get_phys_port_id,
 #ifdef CONFIG_MLX4_EN_VXLAN
-	.ndo_add_vxlan_port	= mlx4_en_add_vxlan_port,
-	.ndo_del_vxlan_port	= mlx4_en_del_vxlan_port,
+	.ndo_add_udp_tunnel_port	= mlx4_en_add_vxlan_port,
+	.ndo_del_udp_tunnel_port	= mlx4_en_del_vxlan_port,
 	.ndo_features_check	= mlx4_en_features_check,
 #endif
 	.ndo_set_tx_maxrate	= mlx4_en_set_tx_maxrate,
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index d448145..18d384f 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -17,6 +17,7 @@
 #include <linux/log2.h>
 #include <linux/pci.h>
 #ifdef CONFIG_QLCNIC_VXLAN
+#include <net/udp_tunnel.h>
 #include <net/vxlan.h>
 #endif
 
@@ -475,11 +476,15 @@ static int qlcnic_get_phys_port_id(struct net_device *netdev,
 
 #ifdef CONFIG_QLCNIC_VXLAN
 static void qlcnic_add_vxlan_port(struct net_device *netdev,
-				  sa_family_t sa_family, __be16 port)
+				  sa_family_t sa_family, __be16 port,
+				  u32 type)
 {
 	struct qlcnic_adapter *adapter = netdev_priv(netdev);
 	struct qlcnic_hardware_context *ahw = adapter->ahw;
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
+
 	/* Adapter supports only one VXLAN port. Use very first port
 	 * for enabling offload
 	 */
@@ -497,11 +502,15 @@ static void qlcnic_add_vxlan_port(struct net_device *netdev,
 }
 
 static void qlcnic_del_vxlan_port(struct net_device *netdev,
-				  sa_family_t sa_family, __be16 port)
+				  sa_family_t sa_family, __be16 port,
+				  u32 type)
 {
 	struct qlcnic_adapter *adapter = netdev_priv(netdev);
 	struct qlcnic_hardware_context *ahw = adapter->ahw;
 
+	if (type != UDP_TUNNEL_VXLAN)
+		return;
+
 	if (!qlcnic_encap_rx_offload(adapter) || !ahw->vxlan_port_count ||
 	    (ahw->vxlan_port != ntohs(port)))
 		return;
@@ -539,8 +548,8 @@ static const struct net_device_ops qlcnic_netdev_ops = {
 	.ndo_fdb_dump		= qlcnic_fdb_dump,
 	.ndo_get_phys_port_id	= qlcnic_get_phys_port_id,
 #ifdef CONFIG_QLCNIC_VXLAN
-	.ndo_add_vxlan_port	= qlcnic_add_vxlan_port,
-	.ndo_del_vxlan_port	= qlcnic_del_vxlan_port,
+	.ndo_add_udp_tunnel_port	= qlcnic_add_vxlan_port,
+	.ndo_del_udp_tunnel_port	= qlcnic_del_vxlan_port,
 	.ndo_features_check	= qlcnic_features_check,
 #endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 6369a57..463f41a 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -628,9 +628,9 @@ static void vxlan_notify_add_rx_port(struct vxlan_sock *vs)
 
 	rcu_read_lock();
 	for_each_netdev_rcu(net, dev) {
-		if (dev->netdev_ops->ndo_add_vxlan_port)
-			dev->netdev_ops->ndo_add_vxlan_port(dev, sa_family,
-							    port);
+		if (dev->netdev_ops->ndo_add_udp_tunnel_port)
+			dev->netdev_ops->ndo_add_udp_tunnel_port(dev, sa_family,
+							port, UDP_TUNNEL_VXLAN);
 	}
 	rcu_read_unlock();
 }
@@ -646,9 +646,9 @@ static void vxlan_notify_del_rx_port(struct vxlan_sock *vs)
 
 	rcu_read_lock();
 	for_each_netdev_rcu(net, dev) {
-		if (dev->netdev_ops->ndo_del_vxlan_port)
-			dev->netdev_ops->ndo_del_vxlan_port(dev, sa_family,
-							    port);
+		if (dev->netdev_ops->ndo_del_udp_tunnel_port)
+			dev->netdev_ops->ndo_del_udp_tunnel_port(dev, sa_family,
+							port, UDP_TUNNEL_VXLAN);
 	}
 	rcu_read_unlock();
 
@@ -2422,9 +2422,9 @@ static struct device_type vxlan_type = {
 	.name = "vxlan",
 };
 
-/* Calls the ndo_add_vxlan_port of the caller in order to
+/* Calls the ndo_add_udp_tunnel_port of the caller in order to
  * supply the listening VXLAN udp ports. Callers are expected
- * to implement the ndo_add_vxlan_port.
+ * to implement the ndo_add_udp_tunnel_port.
  */
 void vxlan_get_rx_port(struct net_device *dev)
 {
@@ -2440,8 +2440,8 @@ void vxlan_get_rx_port(struct net_device *dev)
 		hlist_for_each_entry_rcu(vs, &vn->sock_list[i], hlist) {
 			port = inet_sk(vs->sock->sk)->inet_sport;
 			sa_family = vxlan_get_sk_family(vs);
-			dev->netdev_ops->ndo_add_vxlan_port(dev, sa_family,
-							    port);
+			dev->netdev_ops->ndo_add_udp_tunnel_port(dev, sa_family,
+							port, UDP_TUNNEL_VXLAN);
 		}
 	}
 	spin_unlock(&vn->sock_lock);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4ac653b..dbbab3b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1004,18 +1004,24 @@ typedef u16 (*select_queue_fallback_t)(struct net_device *dev,
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
+ * void (*ndo_add_udp_tunnel_port)(struct  net_device *dev,
+ *			      sa_family_t sa_family, __be16 port, u32 type);
+ *	Called by UDP based tunnel modules to notify a driver about a UDP
+ *	port and socket address family that the tunnel is listening to. It is
+ *	called only when a new port starts listening. The operation is
+ *	protected by tunnel socket sock_lock which is per tunnel type.
+ *	If the driver implementation shares resources between different types
+ *	of tunnels, it should implement it's own locking to safeguard against
+ *	simultaneous access.
+ *
+ * void (*ndo_del_udp_tunnel_port)(struct  net_device *dev,
+ *			      sa_family_t sa_family, __be16 port, u32 type);
+ *	Called by UDP based tunnel modules to notify the driver about a UDP port
+ *	and socket address family that tunnel is not listening to anymore.
+ *	The operation is protected protected by tunnel socket sock_lock which
+ *	is per tunnel type. If the driver implementation shares resources
+ *	between different types of tunnels, it should implement it's own locking
+ *	to safeguard against simultaneous access.
  *
  * void* (*ndo_dfwd_add_station)(struct net_device *pdev,
  *				 struct net_device *dev)
@@ -1209,13 +1215,12 @@ struct net_device_ops {
 							struct netdev_phys_item_id *ppid);
 	int			(*ndo_get_phys_port_name)(struct net_device *dev,
 							  char *name, size_t len);
-	void			(*ndo_add_vxlan_port)(struct  net_device *dev,
+	void			(*ndo_add_udp_tunnel_port)(struct  net_device *dev,
 						      sa_family_t sa_family,
-						      __be16 port);
-	void			(*ndo_del_vxlan_port)(struct  net_device *dev,
+						      __be16 port, u32 type);
+	void			(*ndo_del_udp_tunnel_port)(struct  net_device *dev,
 						      sa_family_t sa_family,
-						      __be16 port);
-
+						      __be16 port, u32 type);
 	void*			(*ndo_dfwd_add_station)(struct net_device *pdev,
 							struct net_device *dev);
 	void			(*ndo_dfwd_del_station)(struct net_device *pdev,
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index cb2f89f..eb44d5f 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -9,6 +9,11 @@
 #include <net/addrconf.h>
 #endif
 
+enum udp_tunnel_type {
+	UDP_TUNNEL_VXLAN,
+	UDP_TUNNEL_GENEVE,
+};
+
 struct udp_port_cfg {
 	u8			family;
 
-- 
1.8.1.4

