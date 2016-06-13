From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 13 Jun 2016 10:49:18 -0700
Subject: [Intel-wired-lan] [net-next PATCH 10/15] mlx5_en: Replace
 ndo_add/del_vxlan_port with ndo_add/del_udp_enc_port
In-Reply-To: <20160613173750.15186.24381.stgit@localhost.localdomain>
References: <20160613173750.15186.24381.stgit@localhost.localdomain>
Message-ID: <20160613174918.15186.83306.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change replaces the network device operations for adding or removing a
VXLAN port with operations that are more generically defined to be used for
any UDP offload port but provide a type.  As such by just adding a line to
verify that the offload type is VXLAN we can maintain the same
functionality.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f5c8d5db25a8..217ea4ba1a29 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2520,10 +2520,14 @@ static int mlx5e_get_vf_stats(struct net_device *dev,
 }
 
 static void mlx5e_add_vxlan_port(struct net_device *netdev,
-				 sa_family_t sa_family, __be16 port)
+				 sa_family_t sa_family, __be16 port,
+				 unsigned int type)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 
+	if (type != UDP_ENC_OFFLOAD_TYPE_VXLAN)
+		return;
+
 	if (!mlx5e_vxlan_allowed(priv->mdev))
 		return;
 
@@ -2531,10 +2535,14 @@ static void mlx5e_add_vxlan_port(struct net_device *netdev,
 }
 
 static void mlx5e_del_vxlan_port(struct net_device *netdev,
-				 sa_family_t sa_family, __be16 port)
+				 sa_family_t sa_family, __be16 port,
+				 unsigned int type)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 
+	if (type != UDP_ENC_OFFLOAD_TYPE_VXLAN)
+		return;
+
 	if (!mlx5e_vxlan_allowed(priv->mdev))
 		return;
 
@@ -2624,8 +2632,8 @@ static const struct net_device_ops mlx5e_netdev_ops_sriov = {
 	.ndo_set_features        = mlx5e_set_features,
 	.ndo_change_mtu          = mlx5e_change_mtu,
 	.ndo_do_ioctl            = mlx5e_ioctl,
-	.ndo_add_vxlan_port      = mlx5e_add_vxlan_port,
-	.ndo_del_vxlan_port      = mlx5e_del_vxlan_port,
+	.ndo_add_udp_enc_port	 = mlx5e_add_vxlan_port,
+	.ndo_del_udp_enc_port	 = mlx5e_del_vxlan_port,
 	.ndo_features_check      = mlx5e_features_check,
 #ifdef CONFIG_RFS_ACCEL
 	.ndo_rx_flow_steer	 = mlx5e_rx_flow_steer,
@@ -3128,7 +3136,7 @@ static void *mlx5e_create_netdev(struct mlx5_core_dev *mdev)
 
 	if (mlx5e_vxlan_allowed(mdev)) {
 		rtnl_lock();
-		vxlan_get_rx_port(netdev);
+		udp_tunnel_get_rx_port(netdev);
 		rtnl_unlock();
 	}
 

