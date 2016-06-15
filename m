From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 15 Jun 2016 15:08:39 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 13/17] nfp: Replace
 ndo_add/del_vxlan_port with ndo_add/del_udp_enc_port
In-Reply-To: <20160615220449.15575.17031.stgit@localhost.localdomain>
References: <20160615220449.15575.17031.stgit@localhost.localdomain>
Message-ID: <20160615220839.15575.8159.stgit@localhost.localdomain>
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
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |   22 +++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index fa47c14c743a..2195ed3053da 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1979,7 +1979,7 @@ static int __nfp_net_set_config_and_enable(struct nfp_net *nn)
 	if (nn->ctrl & NFP_NET_CFG_CTRL_VXLAN) {
 		memset(&nn->vxlan_ports, 0, sizeof(nn->vxlan_ports));
 		memset(&nn->vxlan_usecnt, 0, sizeof(nn->vxlan_usecnt));
-		vxlan_get_rx_port(nn->netdev);
+		udp_tunnel_get_rx_info(nn->netdev);
 	}
 
 	return err;
@@ -2551,26 +2551,32 @@ static int nfp_net_find_vxlan_idx(struct nfp_net *nn, __be16 port)
 }
 
 static void nfp_net_add_vxlan_port(struct net_device *netdev,
-				   sa_family_t sa_family, __be16 port)
+				   struct udp_tunnel_info *ti)
 {
 	struct nfp_net *nn = netdev_priv(netdev);
 	int idx;
 
-	idx = nfp_net_find_vxlan_idx(nn, port);
+	if (ti->type != UDP_TUNNEL_TYPE_VXLAN)
+		return;
+
+	idx = nfp_net_find_vxlan_idx(nn, ti->port);
 	if (idx == -ENOSPC)
 		return;
 
 	if (!nn->vxlan_usecnt[idx]++)
-		nfp_net_set_vxlan_port(nn, idx, port);
+		nfp_net_set_vxlan_port(nn, idx, ti->port);
 }
 
 static void nfp_net_del_vxlan_port(struct net_device *netdev,
-				   sa_family_t sa_family, __be16 port)
+				   struct udp_tunnel_info *ti)
 {
 	struct nfp_net *nn = netdev_priv(netdev);
 	int idx;
 
-	idx = nfp_net_find_vxlan_idx(nn, port);
+	if (ti->type != UDP_TUNNEL_TYPE_VXLAN)
+		return;
+
+	idx = nfp_net_find_vxlan_idx(nn, ti->port);
 	if (!nn->vxlan_usecnt[idx] || idx == -ENOSPC)
 		return;
 
@@ -2589,8 +2595,8 @@ static const struct net_device_ops nfp_net_netdev_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_set_features	= nfp_net_set_features,
 	.ndo_features_check	= nfp_net_features_check,
-	.ndo_add_vxlan_port     = nfp_net_add_vxlan_port,
-	.ndo_del_vxlan_port     = nfp_net_del_vxlan_port,
+	.ndo_udp_tunnel_add	= nfp_net_add_vxlan_port,
+	.ndo_udp_tunnel_del	= nfp_net_del_vxlan_port,
 };
 
 /**

