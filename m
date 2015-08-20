From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Thu, 20 Aug 2015 11:46:23 -0700
Subject: [Intel-wired-lan] [PATCH 4/4] i40e: geneve tunnel offload support
In-Reply-To: <1440096383-8915-1-git-send-email-anjali.singhai@intel.com>
References: <1440096383-8915-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <1440096383-8915-4-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds driver hooks to implement ndo_ops to add/del udp
port in the HW to identify GENEVE tunnels.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Signed-off-by: Kiran Patil <kiran.patil@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 89 ++++++++++++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  2 +-
 3 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 71752c6..12c96da 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -330,6 +330,7 @@ struct i40e_pf {
 #define I40E_FLAG_VEB_STATS_ENABLED		BIT_ULL(37)
 #define I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE	BIT_ULL(38)
 #define I40E_FLAG_VEB_MODE_ENABLED		BIT_ULL(40)
+#define I40E_FLAG_GENEVE_OFFLOAD_CAPABLE	BIT_ULL(41)
 
 	/* tracks features that get auto disabled by errors */
 	u64 auto_disable_flags;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index bbc704b..7b41e1a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6665,7 +6665,7 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
  **/
 static void i40e_sync_udp_filters_subtask(struct i40e_pf *pf)
 {
-#if defined(CONFIG_VXLAN) || defined(CONFIG_VXLAN_MODULE)
+#if defined(CONFIG_VXLAN) || defined(CONFIG_VXLAN_MODULE) || defined(CONFIG_GENEVE_CORE)
 	struct i40e_hw *hw = &pf->hw;
 	i40e_status ret;
 	__be16 port;
@@ -7843,7 +7843,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
 			     I40E_FLAG_HW_ATR_EVICT_CAPABLE |
 			     I40E_FLAG_OUTER_UDP_CSUM_CAPABLE |
 			     I40E_FLAG_WB_ON_ITR_CAPABLE |
-			     I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE;
+			     I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE |
+			     I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
 	}
 	pf->eeprom_version = 0xDEAD;
 	pf->lan_veb = I40E_NO_VEB;
@@ -8036,6 +8037,88 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
 	}
 }
 
+/**
+ * i40e_add_geneve_port - Get notifications about GENEVE ports that come up
+ * @netdev: This physical port's netdev
+ * @sa_family: Socket Family that GENEVE is notifying us about
+ * @port: New UDP port number that GENEVE started listening to
+ **/
+static void i40e_add_geneve_port(struct net_device *netdev,
+				 sa_family_t sa_family, __be16 port)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_pf *pf = vsi->back;
+	u8 next_idx;
+	u8 idx;
+
+	if (!(pf->flags & I40E_FLAG_GENEVE_OFFLOAD_CAPABLE))
+		return;
+
+	if (sa_family == AF_INET6)
+		return;
+
+	idx = i40e_get_udp_port_idx(pf, port);
+
+	/* Check if port already exists */
+	if (idx < I40E_MAX_PF_UDP_OFFLOAD_PORTS) {
+		netdev_info(netdev, "udp port %d already offloaded\n",
+			    ntohs(port));
+		return;
+	}
+
+	/* Now check if there is space to add the new port */
+	next_idx = i40e_get_udp_port_idx(pf, 0);
+
+	if (next_idx == I40E_MAX_PF_UDP_OFFLOAD_PORTS) {
+		netdev_info(netdev, "maximum number of UDP ports reached, not adding port %d\n",
+			    ntohs(port));
+		return;
+	}
+
+	/* New port: add it and mark its index in the bitmap */
+	pf->udp_ports[next_idx].index = port;
+	pf->udp_ports[next_idx].type = I40E_AQC_TUNNEL_TYPE_NGE;
+	pf->pending_udp_bitmap |= BIT_ULL(next_idx);
+	pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
+}
+
+/**
+ * i40e_del_geneve_port - Get notifications about GENEVE ports that go away
+ * @netdev: This physical port's netdev
+ * @sa_family: Socket Family that GENEVE is notifying us about
+ * @port: UDP port number that GENEVE stopped listening to
+ **/
+static void i40e_del_geneve_port(struct net_device *netdev,
+				 sa_family_t sa_family, __be16 port)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_pf *pf = vsi->back;
+	u8 idx;
+
+	if (!(pf->flags & I40E_FLAG_GENEVE_OFFLOAD_CAPABLE))
+		return;
+
+	if (sa_family == AF_INET6)
+		return;
+
+	idx = i40e_get_udp_port_idx(pf, port);
+
+	/* Check if port already exists */
+	if (idx < I40E_MAX_PF_UDP_OFFLOAD_PORTS) {
+		/* if port exists, set it to 0 (mark for deletion)
+		 * and make it pending
+		 */
+		pf->udp_ports[idx].index = 0;
+		pf->pending_udp_bitmap |= BIT_ULL(idx);
+		pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
+	} else {
+		netdev_warn(netdev, "geneve port %d was not found, not deleting\n",
+			    ntohs(port));
+	}
+}
+
 static int i40e_get_phys_port_id(struct net_device *netdev,
 				 struct netdev_phys_item_id *ppid)
 {
@@ -8260,6 +8343,8 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_set_vf_spoofchk	= i40e_ndo_set_vf_spoofchk,
 	.ndo_add_vxlan_port	= i40e_add_vxlan_port,
 	.ndo_del_vxlan_port	= i40e_del_vxlan_port,
+	.ndo_add_geneve_port	= i40e_add_geneve_port,
+	.ndo_del_geneve_port	= i40e_del_geneve_port,
 	.ndo_get_phys_port_id	= i40e_get_phys_port_id,
 	.ndo_fdb_add		= i40e_ndo_fdb_add,
 	.ndo_features_check	= i40e_features_check,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 424c5cc..b93c2dc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1425,7 +1425,7 @@ static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
 	if (rx_error & BIT(I40E_RX_DESC_ERROR_PPRS_SHIFT))
 		return;
 
-	/* If VXLAN traffic has an outer UDPv4 checksum we need to check
+	/* If VXLAN/GENEVE traffic has an outer UDPv4 checksum we need to check
 	 * it in the driver, hardware does not do it for us.
 	 * Since L3L4P bit was set we assume a valid IHL value (>=5)
 	 * so the total length of IPv4 header is IHL*4 bytes
-- 
1.8.1.4

