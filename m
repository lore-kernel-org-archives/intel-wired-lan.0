From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 13 Jun 2016 10:49:29 -0700
Subject: [Intel-wired-lan] [net-next PATCH 11/15] nfp: Replace
 ndo_add/del_vxlan_port with ndo_add/del_udp_enc_port
In-Reply-To: <20160613173750.15186.24381.stgit@localhost.localdomain>
References: <20160613173750.15186.24381.stgit@localhost.localdomain>
Message-ID: <20160613174929.15186.41095.stgit@localhost.localdomain>
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
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index fa47c14c743a..5adddeda1e60 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1979,7 +1979,7 @@ static int __nfp_net_set_config_and_enable(struct nfp_net *nn)
 	if (nn->ctrl & NFP_NET_CFG_CTRL_VXLAN) {
 		memset(&nn->vxlan_ports, 0, sizeof(nn->vxlan_ports));
 		memset(&nn->vxlan_usecnt, 0, sizeof(nn->vxlan_usecnt));
-		vxlan_get_rx_port(nn->netdev);
+		udp_tunnel_get_rx_port(nn->netdev);
 	}
 
 	return err;
@@ -2551,11 +2551,15 @@ static int nfp_net_find_vxlan_idx(struct nfp_net *nn, __be16 port)
 }
 
 static void nfp_net_add_vxlan_port(struct net_device *netdev,
-				   sa_family_t sa_family, __be16 port)
+				   sa_family_t sa_family, __be16 port,
+				   unsigned int type)
 {
 	struct nfp_net *nn = netdev_priv(netdev);
 	int idx;
 
+	if (type != UDP_ENC_OFFLOAD_TYPE_VXLAN)
+		return;
+
 	idx = nfp_net_find_vxlan_idx(nn, port);
 	if (idx == -ENOSPC)
 		return;
@@ -2565,11 +2569,15 @@ static void nfp_net_add_vxlan_port(struct net_device *netdev,
 }
 
 static void nfp_net_del_vxlan_port(struct net_device *netdev,
-				   sa_family_t sa_family, __be16 port)
+				   sa_family_t sa_family, __be16 port,
+				   unsigned int type)
 {
 	struct nfp_net *nn = netdev_priv(netdev);
 	int idx;
 
+	if (type != UDP_ENC_OFFLOAD_TYPE_VXLAN)
+		return;
+
 	idx = nfp_net_find_vxlan_idx(nn, port);
 	if (!nn->vxlan_usecnt[idx] || idx == -ENOSPC)
 		return;
@@ -2589,8 +2597,8 @@ static const struct net_device_ops nfp_net_netdev_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_set_features	= nfp_net_set_features,
 	.ndo_features_check	= nfp_net_features_check,
-	.ndo_add_vxlan_port     = nfp_net_add_vxlan_port,
-	.ndo_del_vxlan_port     = nfp_net_del_vxlan_port,
+	.ndo_add_udp_enc_port	= nfp_net_add_vxlan_port,
+	.ndo_del_udp_enc_port	= nfp_net_del_vxlan_port,
 };
 
 /**

