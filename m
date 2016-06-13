From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 13 Jun 2016 10:48:30 -0700
Subject: [Intel-wired-lan] [net-next PATCH 05/15] benet: Replace
 ndo_add/del_vxlan_port with ndo_add/del_udp_enc_port
In-Reply-To: <20160613173750.15186.24381.stgit@localhost.localdomain>
References: <20160613173750.15186.24381.stgit@localhost.localdomain>
Message-ID: <20160613174830.15186.27109.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change replaces the network device operations for adding or removing a
VXLAN port with operations that are more generically defined to be used for
any UDP offload port but provide a type.  As such by just adding a line to
verify that the offload type if VXLAN we can maintain the same
functionality.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/emulex/benet/be_main.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 2451a47e88ab..f0ec15a7cd85 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -3627,7 +3627,7 @@ static int be_open(struct net_device *netdev)
 	netif_tx_start_all_queues(netdev);
 #ifdef CONFIG_BE2NET_VXLAN
 	if (skyhawk_chip(adapter))
-		vxlan_get_rx_port(netdev);
+		udp_tunnel_get_rx_port(netdev);
 #endif
 
 	return 0;
@@ -4721,12 +4721,15 @@ static int be_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
  * until after all the tunnels are removed.
  */
 static void be_add_vxlan_port(struct net_device *netdev, sa_family_t sa_family,
-			      __be16 port)
+			      __be16 port, unsigned int type)
 {
 	struct be_adapter *adapter = netdev_priv(netdev);
 	struct device *dev = &adapter->pdev->dev;
 	int status;
 
+	if (type != UDP_ENC_OFFLOAD_TYPE_VXLAN)
+		return;
+
 	if (lancer_chip(adapter) || BEx_chip(adapter) || be_is_mc(adapter))
 		return;
 
@@ -4775,10 +4778,13 @@ err:
 }
 
 static void be_del_vxlan_port(struct net_device *netdev, sa_family_t sa_family,
-			      __be16 port)
+			      __be16 port, unsigned int type)
 {
 	struct be_adapter *adapter = netdev_priv(netdev);
 
+	if (type != UDP_ENC_OFFLOAD_TYPE_VXLAN)
+		return;
+
 	if (lancer_chip(adapter) || BEx_chip(adapter) || be_is_mc(adapter))
 		return;
 
@@ -4888,8 +4894,8 @@ static const struct net_device_ops be_netdev_ops = {
 	.ndo_busy_poll		= be_busy_poll,
 #endif
 #ifdef CONFIG_BE2NET_VXLAN
-	.ndo_add_vxlan_port	= be_add_vxlan_port,
-	.ndo_del_vxlan_port	= be_del_vxlan_port,
+	.ndo_add_udp_enc_port	= be_add_vxlan_port,
+	.ndo_del_udp_enc_port	= be_del_vxlan_port,
 	.ndo_features_check	= be_features_check,
 #endif
 	.ndo_get_phys_port_id   = be_get_phys_port_id,

