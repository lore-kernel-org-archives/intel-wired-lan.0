From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 13 Jun 2016 10:49:37 -0700
Subject: [Intel-wired-lan] [net-next PATCH 12/15] qede: Move all UDP port
 notifiers to single function
In-Reply-To: <20160613173750.15186.24381.stgit@localhost.localdomain>
References: <20160613173750.15186.24381.stgit@localhost.localdomain>
Message-ID: <20160613174937.15186.69027.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch goes through and combines the notifiers for VXLAN and GENEVE
into a single function for each action.  So there is now one combined
function for getting ports, one for adding the ports, and one for deleting
the ports.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/qlogic/qede/qede_main.c |  113 ++++++++++++++------------
 1 file changed, 59 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 423168ba7c98..c5d9e0f15ae9 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -2112,72 +2112,84 @@ int qede_set_features(struct net_device *dev, netdev_features_t features)
 	return 0;
 }
 
-#ifdef CONFIG_QEDE_VXLAN
-static void qede_add_vxlan_port(struct net_device *dev,
-				sa_family_t sa_family, __be16 port)
+#if defined(CONFIG_QEDE_VXLAN) || defined(CONFIG_QEDE_GENEVE)
+static void qede_add_udp_enc_port(struct net_device *dev,
+				  sa_family_t sa_family, __be16 port,
+				  unsigned int type)
 {
 	struct qede_dev *edev = netdev_priv(dev);
 	u16 t_port = ntohs(port);
 
-	if (edev->vxlan_dst_port)
-		return;
+	switch (type) {
+#ifdef CONFIG_QEDE_VXLAN
+	case UDP_ENC_OFFLOAD_TYPE_VXLAN:
+		if (edev->vxlan_dst_port)
+			return;
 
-	edev->vxlan_dst_port = t_port;
+		edev->vxlan_dst_port = t_port;
 
-	DP_VERBOSE(edev, QED_MSG_DEBUG, "Added vxlan port=%d", t_port);
+		DP_VERBOSE(edev, QED_MSG_DEBUG, "Added vxlan port=%d",
+			   t_port);
 
-	set_bit(QEDE_SP_VXLAN_PORT_CONFIG, &edev->sp_flags);
-	schedule_delayed_work(&edev->sp_task, 0);
-}
+		set_bit(QEDE_SP_VXLAN_PORT_CONFIG, &edev->sp_flags);
+		break;
+#endif
+#ifdef CONFIG_QEDE_GENEVE
+	case UDP_ENC_OFFLOAD_TYPE_GENEVE:
+		if (edev->geneve_dst_port)
+			return;
 
-static void qede_del_vxlan_port(struct net_device *dev,
-				sa_family_t sa_family, __be16 port)
-{
-	struct qede_dev *edev = netdev_priv(dev);
-	u16 t_port = ntohs(port);
+		edev->geneve_dst_port = t_port;
 
-	if (t_port != edev->vxlan_dst_port)
+		DP_VERBOSE(edev, QED_MSG_DEBUG, "Added geneve port=%d",
+			   t_port);
+		set_bit(QEDE_SP_GENEVE_PORT_CONFIG, &edev->sp_flags);
+		break;
+#endif
+	default:
 		return;
+	}
 
-	edev->vxlan_dst_port = 0;
-
-	DP_VERBOSE(edev, QED_MSG_DEBUG, "Deleted vxlan port=%d", t_port);
-
-	set_bit(QEDE_SP_VXLAN_PORT_CONFIG, &edev->sp_flags);
 	schedule_delayed_work(&edev->sp_task, 0);
 }
-#endif
 
-#ifdef CONFIG_QEDE_GENEVE
-static void qede_add_geneve_port(struct net_device *dev,
-				 sa_family_t sa_family, __be16 port)
+static void qede_del_udp_enc_port(struct net_device *dev,
+				  sa_family_t sa_family, __be16 port,
+				  unsigned int type)
 {
 	struct qede_dev *edev = netdev_priv(dev);
 	u16 t_port = ntohs(port);
 
-	if (edev->geneve_dst_port)
-		return;
+	switch (type) {
+#ifdef CONFIG_QEDE_VXLAN
+	case UDP_ENC_OFFLOAD_TYPE_VXLAN:
+		if (t_port != edev->vxlan_dst_port)
+			return;
 
-	edev->geneve_dst_port = t_port;
+		edev->vxlan_dst_port = 0;
 
-	DP_VERBOSE(edev, QED_MSG_DEBUG, "Added geneve port=%d", t_port);
-	set_bit(QEDE_SP_GENEVE_PORT_CONFIG, &edev->sp_flags);
-	schedule_delayed_work(&edev->sp_task, 0);
-}
+		DP_VERBOSE(edev, QED_MSG_DEBUG, "Deleted vxlan port=%d",
+			   t_port);
 
-static void qede_del_geneve_port(struct net_device *dev,
-				 sa_family_t sa_family, __be16 port)
-{
-	struct qede_dev *edev = netdev_priv(dev);
-	u16 t_port = ntohs(port);
+		set_bit(QEDE_SP_VXLAN_PORT_CONFIG, &edev->sp_flags);
+		break;
+#endif
+#ifdef CONFIG_QEDE_GENEVE
+	case UDP_ENC_OFFLOAD_TYPE_GENEVE:
+		if (t_port != edev->geneve_dst_port)
+			return;
 
-	if (t_port != edev->geneve_dst_port)
-		return;
+		edev->geneve_dst_port = 0;
 
-	edev->geneve_dst_port = 0;
+		DP_VERBOSE(edev, QED_MSG_DEBUG, "Deleted geneve port=%d",
+			   t_port);
+		set_bit(QEDE_SP_GENEVE_PORT_CONFIG, &edev->sp_flags);
+		break;
+#endif
+	default:
+		return;
+	}
 
-	DP_VERBOSE(edev, QED_MSG_DEBUG, "Deleted geneve port=%d", t_port);
-	set_bit(QEDE_SP_GENEVE_PORT_CONFIG, &edev->sp_flags);
 	schedule_delayed_work(&edev->sp_task, 0);
 }
 #endif
@@ -2204,13 +2216,9 @@ static const struct net_device_ops qede_netdev_ops = {
 	.ndo_get_vf_config = qede_get_vf_config,
 	.ndo_set_vf_rate = qede_set_vf_rate,
 #endif
-#ifdef CONFIG_QEDE_VXLAN
-	.ndo_add_vxlan_port = qede_add_vxlan_port,
-	.ndo_del_vxlan_port = qede_del_vxlan_port,
-#endif
-#ifdef CONFIG_QEDE_GENEVE
-	.ndo_add_geneve_port = qede_add_geneve_port,
-	.ndo_del_geneve_port = qede_del_geneve_port,
+#if defined(CONFIG_QEDE_VXLAN) || defined(CONFIG_QEDE_GENEVE)
+	.ndo_add_udp_enc_port = qede_add_udp_enc_port,
+	.ndo_del_udp_enc_port = qede_del_udp_enc_port,
 #endif
 };
 
@@ -3579,11 +3587,8 @@ static int qede_open(struct net_device *ndev)
 	if (rc)
 		return rc;
 
-#ifdef CONFIG_QEDE_VXLAN
-	vxlan_get_rx_port(ndev);
-#endif
-#ifdef CONFIG_QEDE_GENEVE
-	geneve_get_rx_port(ndev);
+#if defined(CONFIG_QEDE_VXLAN) || defined(CONFIG_QEDE_GENEVE)
+	udp_tunnel_get_rx_port(ndev);
 #endif
 	return 0;
 }

