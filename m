From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Tue, 10 Nov 2015 09:56:44 -0800
Subject: [Intel-wired-lan] [PATCH v4 5/6] i40e:Add geneve tunnel offload
	support
In-Reply-To: <1447178205-99510-1-git-send-email-anjali.singhai@intel.com>
References: <1447178205-99510-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <1447178205-99510-5-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds driver hooks to implement ndo_ops to add/del udp
port in the HW to identify GENEVE tunnels.

Also cleans up the features_check path now that we support
multiple udp based tunnels.

Add a spin_lock to guard the common data structure for the
udp based tunnels.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Signed-off-by: Kiran Patil <kiran.patil@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 61 ++++++++++++++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  2 +-
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index c24008f..08a0a00 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -338,6 +338,7 @@ struct i40e_pf {
 #define I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE	BIT_ULL(38)
 #define I40E_FLAG_LINK_POLLING_ENABLED		BIT_ULL(39)
 #define I40E_FLAG_VEB_MODE_ENABLED		BIT_ULL(40)
+#define I40E_FLAG_GENEVE_OFFLOAD_CAPABLE	BIT_ULL(41)
 #define I40E_FLAG_NO_PCI_LINK_CHECK		BIT_ULL(42)
 
 	/* tracks features that get auto disabled by errors */
@@ -422,6 +423,7 @@ struct i40e_pf {
 
 	u32 ioremap_len;
 	u32 fd_inv;
+	spinlock_t udp_tunnel_lock;
 };
 
 struct i40e_mac_filter {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ffc74bd..1ce65a1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -31,6 +31,9 @@
 #include <net/udp_tunnel.h>
 #include <net/vxlan.h>
 #endif
+#if IS_ENABLED(CONFIG_GENEVE)
+#include <net/geneve.h>
+#endif
 
 const char i40e_driver_name[] = "i40e";
 static const char i40e_driver_string[] =
@@ -6997,7 +7000,7 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
  **/
 static void i40e_sync_udp_filters_subtask(struct i40e_pf *pf)
 {
-#if IS_ENABLED(CONFIG_VXLAN)
+#if IS_ENABLED(CONFIG_VXLAN) || IS_ENABLED(CONFIG_GENEVE)
 	struct i40e_hw *hw = &pf->hw;
 	i40e_status ret;
 	__be16 port;
@@ -7006,6 +7009,8 @@ static void i40e_sync_udp_filters_subtask(struct i40e_pf *pf)
 	if (!(pf->flags & I40E_FLAG_UDP_FILTER_SYNC))
 		return;
 
+	spin_lock(&pf->udp_tunnel_lock);
+
 	pf->flags &= ~I40E_FLAG_UDP_FILTER_SYNC;
 
 	for (i = 0; i < I40E_MAX_PF_UDP_OFFLOAD_PORTS; i++) {
@@ -7031,6 +7036,7 @@ static void i40e_sync_udp_filters_subtask(struct i40e_pf *pf)
 			}
 		}
 	}
+	spin_unlock(&pf->udp_tunnel_lock);
 #endif
 }
 
@@ -8333,7 +8339,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
 			     I40E_FLAG_HW_ATR_EVICT_CAPABLE |
 			     I40E_FLAG_OUTER_UDP_CSUM_CAPABLE |
 			     I40E_FLAG_WB_ON_ITR_CAPABLE |
-			     I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE;
+			     I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE |
+			     I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
 	}
 	pf->eeprom_version = 0xDEAD;
 	pf->lan_veb = I40E_NO_VEB;
@@ -8431,8 +8438,8 @@ static int i40e_set_features(struct net_device *netdev,
 
 	return 0;
 }
-#if IS_ENABLED(CONFIG_VXLAN)
 
+#if IS_ENABLED(CONFIG_VXLAN) || IS_ENABLED(CONFIG_GENEVE)
 /**
  * i40e_get_udp_port_idx - Lookup a possibly offloaded for Rx UDP port
  * @pf: board private structure
@@ -8451,39 +8458,47 @@ static u8 i40e_get_udp_port_idx(struct i40e_pf *pf, __be16 port)
 
 	return i;
 }
-#endif
 
+#endif
 /**
  * i40e_add_tunnel_port - Get notifications about UDP tunnel ports that come up
  * @netdev: This physical port's netdev
  * @sa_family: Socket Family that tunnel netdev is  associated with
  * @port: New UDP port number that tunnel started listening to
  * @type: Tunnel Type
+ *
+ * This function modifies a common data structure for all udp_tunnels
+ * hence it is expected that it is called under a common lock.
  **/
 static void i40e_add_tunnel_port(struct net_device *netdev,
 				 sa_family_t sa_family, __be16 port,
 				 u32 type)
 {
-#if IS_ENABLED(CONFIG_VXLAN)
+#if IS_ENABLED(CONFIG_VXLAN) || IS_ENABLED(CONFIG_GENEVE)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	u8 next_idx;
 	u8 idx;
 
-	if (type != UDP_TUNNEL_VXLAN)
-		return;
+	if (!(type == UDP_TUNNEL_VXLAN || type == UDP_TUNNEL_GENEVE))
+		goto out;
+
+	if ((type == UDP_TUNNEL_GENEVE) &&
+	    (!(pf->flags & I40E_FLAG_GENEVE_OFFLOAD_CAPABLE)))
+		goto out;
 
 	if (sa_family == AF_INET6)
-		return;
+		goto out;
 
+	spin_lock(&pf->udp_tunnel_lock);
 	idx = i40e_get_udp_port_idx(pf, port);
 
 	/* Check if port already exists */
 	if (idx < I40E_MAX_PF_UDP_OFFLOAD_PORTS) {
 		netdev_info(netdev, "UDP port %d already offloaded\n",
 			    ntohs(port));
-		return;
+		goto err;
 	}
 
 	/* Now check if there is space to add the new port */
@@ -8492,16 +8507,24 @@ static void i40e_add_tunnel_port(struct net_device *netdev,
 	if (next_idx == I40E_MAX_PF_UDP_OFFLOAD_PORTS) {
 		netdev_info(netdev, "maximum number of UDP ports reached, not adding port %d\n",
 			    ntohs(port));
-		return;
+		goto err;
 	}
 
 	/* New port: add it and mark its index in the bitmap */
 	pf->udp_ports[next_idx].index = port;
 	if (type == UDP_TUNNEL_VXLAN)
 		pf->udp_ports[next_idx].type = I40E_AQC_TUNNEL_TYPE_VXLAN;
+	else if (type == UDP_TUNNEL_GENEVE)
+		pf->udp_ports[next_idx].type = I40E_AQC_TUNNEL_TYPE_NGE;
 
 	pf->pending_udp_bitmap |= BIT_ULL(next_idx);
 	pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
+
+err:
+	spin_unlock(&pf->udp_tunnel_lock);
+out:
+	return;
+
 #endif
 }
 
@@ -8511,23 +8534,28 @@ static void i40e_add_tunnel_port(struct net_device *netdev,
  * @sa_family: Socket Family that tunnel netdev is associated with
  * @port: UDP port number that tunnel stopped listening to
  * @type: Tunnel Type
+ *
+ * This function modifies a common data structure for all udp_tunnels
+ * hence it is expected that it is called under common lock.
  **/
 static void i40e_del_tunnel_port(struct net_device *netdev,
 				 sa_family_t sa_family, __be16 port,
 				 u32 type)
 {
-#if IS_ENABLED(CONFIG_VXLAN)
+#if IS_ENABLED(CONFIG_VXLAN) || IS_ENABLED(CONFIG_GENEVE)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	u8 idx;
 
-	if (type != UDP_TUNNEL_VXLAN)
+	if (!(type == UDP_TUNNEL_VXLAN || type == UDP_TUNNEL_GENEVE))
 		return;
 
 	if (sa_family == AF_INET6)
 		return;
 
+	spin_lock(&pf->udp_tunnel_lock);
+
 	idx = i40e_get_udp_port_idx(pf, port);
 
 	/* Check if port already exists */
@@ -8542,6 +8570,7 @@ static void i40e_del_tunnel_port(struct net_device *netdev,
 		netdev_warn(netdev, "udp tunnel port %d was not found, not deleting\n",
 			    ntohs(port));
 	}
+	spin_unlock(&pf->udp_tunnel_lock);
 #endif
 }
 
@@ -8722,7 +8751,10 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				       nlflags, 0, 0, filter_mask, NULL);
 }
 
-#define I40E_MAX_TUNNEL_HDR_LEN 80
+/* Hardware supports L4 tunnel length of 128B (=2^7) which includes
+ * inner mac plus all inner ethertypes.
+ */
+#define I40E_MAX_TUNNEL_HDR_LEN 128
 /**
  * i40e_features_check - Validate encapsulated packet conforms to limits
  * @skb: skb buff
@@ -8734,7 +8766,7 @@ static netdev_features_t i40e_features_check(struct sk_buff *skb,
 					     netdev_features_t features)
 {
 	if (skb->encapsulation &&
-	    (skb_inner_mac_header(skb) - skb_transport_header(skb) >
+	    ((skb_inner_network_header(skb) - skb_transport_header(skb)) >
 	     I40E_MAX_TUNNEL_HDR_LEN))
 		return features & ~(NETIF_F_ALL_CSUM | NETIF_F_GSO_MASK);
 
@@ -10741,6 +10773,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* tell the firmware that we're starting */
 	i40e_send_version(pf);
 
+	spin_lock_init(&pf->udp_tunnel_lock);
 	/* since everything's happy, start the service_task timer */
 	mod_timer(&pf->service_timer,
 		  round_jiffies(jiffies + pf->service_timer_period));
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 2729a48..5dfe15c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1383,7 +1383,7 @@ static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
 	if (rx_error & BIT(I40E_RX_DESC_ERROR_PPRS_SHIFT))
 		return;
 
-	/* If VXLAN traffic has an outer UDPv4 checksum we need to check
+	/* If VXLAN/GENEVE traffic has an outer UDPv4 checksum we need to check
 	 * it in the driver, hardware does not do it for us.
 	 * Since L3L4P bit was set we assume a valid IHL value (>=5)
 	 * so the total length of IPv4 header is IHL*4 bytes
-- 
1.8.1.4

