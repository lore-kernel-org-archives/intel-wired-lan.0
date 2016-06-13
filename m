From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 13 Jun 2016 10:49:49 -0700
Subject: [Intel-wired-lan] [net-next PATCH 13/15] qlcnic: Replace
 ndo_add/del_vxlan_port with ndo_add/del_udp_enc_port
In-Reply-To: <20160613173750.15186.24381.stgit@localhost.localdomain>
References: <20160613173750.15186.24381.stgit@localhost.localdomain>
Message-ID: <20160613174949.15186.82510.stgit@localhost.localdomain>
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
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index 1c29105b6c36..e2840f55f09f 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -476,11 +476,15 @@ static int qlcnic_get_phys_port_id(struct net_device *netdev,
 
 #ifdef CONFIG_QLCNIC_VXLAN
 static void qlcnic_add_vxlan_port(struct net_device *netdev,
-				  sa_family_t sa_family, __be16 port)
+				  sa_family_t sa_family, __be16 port,
+				  unsigned int type)
 {
 	struct qlcnic_adapter *adapter = netdev_priv(netdev);
 	struct qlcnic_hardware_context *ahw = adapter->ahw;
 
+	if (type != UDP_ENC_OFFLOAD_TYPE_VXLAN)
+		return;
+
 	/* Adapter supports only one VXLAN port. Use very first port
 	 * for enabling offload
 	 */
@@ -498,11 +502,15 @@ static void qlcnic_add_vxlan_port(struct net_device *netdev,
 }
 
 static void qlcnic_del_vxlan_port(struct net_device *netdev,
-				  sa_family_t sa_family, __be16 port)
+				  sa_family_t sa_family, __be16 port,
+				  unsigned int type)
 {
 	struct qlcnic_adapter *adapter = netdev_priv(netdev);
 	struct qlcnic_hardware_context *ahw = adapter->ahw;
 
+	if (type != UDP_ENC_OFFLOAD_TYPE_VXLAN)
+		return;
+
 	if (!qlcnic_encap_rx_offload(adapter) || !ahw->vxlan_port_count ||
 	    (ahw->vxlan_port != ntohs(port)))
 		return;
@@ -540,8 +548,8 @@ static const struct net_device_ops qlcnic_netdev_ops = {
 	.ndo_fdb_dump		= qlcnic_fdb_dump,
 	.ndo_get_phys_port_id	= qlcnic_get_phys_port_id,
 #ifdef CONFIG_QLCNIC_VXLAN
-	.ndo_add_vxlan_port	= qlcnic_add_vxlan_port,
-	.ndo_del_vxlan_port	= qlcnic_del_vxlan_port,
+	.ndo_add_udp_enc_port	= qlcnic_add_vxlan_port,
+	.ndo_del_udp_enc_port	= qlcnic_del_vxlan_port,
 	.ndo_features_check	= qlcnic_features_check,
 #endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -2017,7 +2025,7 @@ qlcnic_attach(struct qlcnic_adapter *adapter)
 
 #ifdef CONFIG_QLCNIC_VXLAN
 	if (qlcnic_encap_rx_offload(adapter))
-		vxlan_get_rx_port(netdev);
+		udp_tunnel_get_rx_port(netdev);
 #endif
 
 	adapter->is_up = QLCNIC_ADAPTER_UP_MAGIC;

