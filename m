From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Tue,  8 Sep 2015 14:55:54 -0700
Subject: [Intel-wired-lan] [PATCH v2 3/5] ethernet: Change drivers to use
	the generalized udp tunnel offload
In-Reply-To: <1441749356-92927-1-git-send-email-anjali.singhai@intel.com>
References: <1441749356-92927-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <1441749356-92927-3-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Previous patch in the series replaces vxlan specific ndo_ops with
generalized udp_tunnel ndo_ops. This patch propagates the change to all
drivers implementing vxlan offload support.

Patch was compile tested with x86_64_defconfig.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 14 ++++++---
 drivers/net/ethernet/emulex/benet/be_main.c      | 14 ++++++---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c  | 26 ++++++++++++----
 drivers/net/ethernet/intel/i40e/i40e_main.c      | 38 ++++++++++++++++--------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 16 +++++++---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c   | 20 +++++++++----
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c | 16 +++++++---
 7 files changed, 104 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 26fbfcc..6c2d5f1 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -10117,11 +10117,14 @@ static void __bnx2x_add_vxlan_port(struct bnx2x *bp, u16 port)
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
 
@@ -10141,11 +10144,14 @@ static void __bnx2x_del_vxlan_port(struct bnx2x *bp, u16 port)
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
@@ -13000,8 +13006,8 @@ static const struct net_device_ops bnx2x_netdev_ops = {
 	.ndo_set_vf_link_state	= bnx2x_set_vf_link_state,
 	.ndo_features_check	= bnx2x_features_check,
 #ifdef CONFIG_BNX2X_VXLAN
-	.ndo_add_vxlan_port	= bnx2x_add_vxlan_port,
-	.ndo_del_vxlan_port	= bnx2x_del_vxlan_port,
+	.ndo_add_tunnel_port	= bnx2x_add_vxlan_port,
+	.ndo_del_tunnel_port	= bnx2x_del_vxlan_port,
 #endif
 };
 
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 12687bf..c24d352 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -5167,12 +5167,15 @@ static int be_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
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
 
@@ -5216,10 +5219,13 @@ err:
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
 
@@ -5324,8 +5330,8 @@ static const struct net_device_ops be_netdev_ops = {
 	.ndo_busy_poll		= be_busy_poll,
 #endif
 #ifdef CONFIG_BE2NET_VXLAN
-	.ndo_add_vxlan_port	= be_add_vxlan_port,
-	.ndo_del_vxlan_port	= be_del_vxlan_port,
+	.ndo_add_tunnel_port    = be_add_vxlan_port,
+	.ndo_del_tunnel_port	= be_del_vxlan_port,
 	.ndo_features_check	= be_features_check,
 #endif
 	.ndo_get_phys_port_id   = be_get_phys_port_id,
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 79c0fa2..133408a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -439,18 +439,24 @@ static void fm10k_restore_vxlan_port(struct fm10k_intfc *interface)
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
@@ -476,6 +482,7 @@ insert_tail:
 	list_add_tail(&vxlan_port->list, &interface->vxlan_port);
 
 	fm10k_restore_vxlan_port(interface);
+#endif
 }
 
 /**
@@ -483,17 +490,23 @@ insert_tail:
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
 
@@ -508,6 +521,7 @@ static void fm10k_del_vxlan_port(struct net_device *dev,
 	}
 
 	fm10k_restore_vxlan_port(interface);
+#endif
 }
 
 /**
@@ -1373,8 +1387,8 @@ static const struct net_device_ops fm10k_netdev_ops = {
 	.ndo_set_vf_vlan	= fm10k_ndo_set_vf_vlan,
 	.ndo_set_vf_rate	= fm10k_ndo_set_vf_bw,
 	.ndo_get_vf_config	= fm10k_ndo_get_vf_config,
-	.ndo_add_vxlan_port	= fm10k_add_vxlan_port,
-	.ndo_del_vxlan_port	= fm10k_del_vxlan_port,
+	.ndo_add_tunnel_port	= fm10k_add_vxlan_port,
+	.ndo_del_tunnel_port	= fm10k_del_vxlan_port,
 	.ndo_do_ioctl		= fm10k_ioctl,
 	.ndo_dfwd_add_station	= fm10k_dfwd_add_station,
 	.ndo_dfwd_del_station	= fm10k_dfwd_del_station,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d75dbf3..4ec16c0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7962,20 +7962,26 @@ static u8 i40e_get_vxlan_port_idx(struct i40e_pf *pf, __be16 port)
 }
 
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
 
@@ -8001,22 +8007,29 @@ static void i40e_add_vxlan_port(struct net_device *netdev,
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
 
@@ -8034,6 +8047,7 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
 		netdev_warn(netdev, "vxlan port %d was not found, not deleting\n",
 			    ntohs(port));
 	}
+#endif
 }
 
 static int i40e_get_phys_port_id(struct net_device *netdev,
@@ -8258,8 +8272,8 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_get_vf_config	= i40e_ndo_get_vf_config,
 	.ndo_set_vf_link_state	= i40e_ndo_set_vf_link_state,
 	.ndo_set_vf_spoofchk	= i40e_ndo_set_vf_spoofchk,
-	.ndo_add_vxlan_port	= i40e_add_vxlan_port,
-	.ndo_del_vxlan_port	= i40e_del_vxlan_port,
+	.ndo_add_tunnel_port	= i40e_add_tunnel_port,
+	.ndo_del_tunnel_port	= i40e_del_tunnel_port,
 	.ndo_get_phys_port_id	= i40e_get_phys_port_id,
 	.ndo_fdb_add		= i40e_ndo_fdb_add,
 	.ndo_features_check	= i40e_features_check,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 914c1b0..4c132dd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8080,14 +8080,18 @@ static int ixgbe_set_features(struct net_device *netdev,
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
 
@@ -8113,13 +8117,17 @@ static void ixgbe_add_vxlan_port(struct net_device *dev, sa_family_t sa_family,
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
 
@@ -8428,8 +8436,8 @@ static const struct net_device_ops ixgbe_netdev_ops = {
 	.ndo_dfwd_add_station	= ixgbe_fwd_add,
 	.ndo_dfwd_del_station	= ixgbe_fwd_del,
 #ifdef CONFIG_IXGBE_VXLAN
-	.ndo_add_vxlan_port	= ixgbe_add_vxlan_port,
-	.ndo_del_vxlan_port	= ixgbe_del_vxlan_port,
+	.ndo_add_tunnel_port	= ixgbe_add_vxlan_port,
+	.ndo_del_tunnel_port	= ixgbe_del_vxlan_port,
 #endif /* CONFIG_IXGBE_VXLAN */
 	.ndo_features_check	= ixgbe_features_check,
 };
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 4726122..8832cae 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -2386,11 +2386,15 @@ static void mlx4_en_del_vxlan_offloads(struct work_struct *work)
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
 
@@ -2409,11 +2413,15 @@ static void mlx4_en_add_vxlan_port(struct  net_device *dev,
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
 
@@ -2493,8 +2501,8 @@ static const struct net_device_ops mlx4_netdev_ops = {
 #endif
 	.ndo_get_phys_port_id	= mlx4_en_get_phys_port_id,
 #ifdef CONFIG_MLX4_EN_VXLAN
-	.ndo_add_vxlan_port	= mlx4_en_add_vxlan_port,
-	.ndo_del_vxlan_port	= mlx4_en_del_vxlan_port,
+	.ndo_add_tunnel_port	= mlx4_en_add_vxlan_port,
+	.ndo_del_tunnel_port	= mlx4_en_del_vxlan_port,
 	.ndo_features_check	= mlx4_en_features_check,
 #endif
 	.ndo_set_tx_maxrate	= mlx4_en_set_tx_maxrate,
@@ -2531,8 +2539,8 @@ static const struct net_device_ops mlx4_netdev_ops_master = {
 #endif
 	.ndo_get_phys_port_id	= mlx4_en_get_phys_port_id,
 #ifdef CONFIG_MLX4_EN_VXLAN
-	.ndo_add_vxlan_port	= mlx4_en_add_vxlan_port,
-	.ndo_del_vxlan_port	= mlx4_en_del_vxlan_port,
+	.ndo_add_tunnel_port	= mlx4_en_add_vxlan_port,
+	.ndo_del_tunnel_port	= mlx4_en_del_vxlan_port,
 	.ndo_features_check	= mlx4_en_features_check,
 #endif
 	.ndo_set_tx_maxrate	= mlx4_en_set_tx_maxrate,
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index 8b08b20..048108f 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -475,11 +475,15 @@ static int qlcnic_get_phys_port_id(struct net_device *netdev,
 
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
@@ -491,11 +495,15 @@ static void qlcnic_add_vxlan_port(struct net_device *netdev,
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
 	if (!qlcnic_encap_rx_offload(adapter) || !ahw->vxlan_port ||
 	    (ahw->vxlan_port != ntohs(port)))
 		return;
@@ -531,8 +539,8 @@ static const struct net_device_ops qlcnic_netdev_ops = {
 	.ndo_fdb_dump		= qlcnic_fdb_dump,
 	.ndo_get_phys_port_id	= qlcnic_get_phys_port_id,
 #ifdef CONFIG_QLCNIC_VXLAN
-	.ndo_add_vxlan_port	= qlcnic_add_vxlan_port,
-	.ndo_del_vxlan_port	= qlcnic_del_vxlan_port,
+	.ndo_add_tunnel_port	= qlcnic_add_vxlan_port,
+	.ndo_del_tunnel_port	= qlcnic_del_vxlan_port,
 	.ndo_features_check	= qlcnic_features_check,
 #endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
-- 
1.8.1.4

