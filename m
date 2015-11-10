From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Mon,  9 Nov 2015 22:25:37 -0800
Subject: [Intel-wired-lan] [PATCH v3 3/6] i40e: Generalize the flow for udp
	based tunnels
In-Reply-To: <1447136740-77107-1-git-send-email-anjali.singhai@intel.com>
References: <1447136740-77107-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <1447136740-77107-3-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch generalizes the driver flow to make room for more than just
VXLAN tunnel by defining a common data structure with tunnel type.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 11 ++++--
 drivers/net/ethernet/intel/i40e/i40e_main.c | 54 ++++++++++++++++-------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  6 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  2 +-
 4 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index ae0cf17..10ffc17b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -245,6 +245,11 @@ struct i40e_tc_configuration {
 	struct i40e_tc_info tc_info[I40E_MAX_TRAFFIC_CLASS];
 };
 
+struct i40e_udp_port_config {
+	__be16 index;
+	u8 type;
+};
+
 /* struct that defines the Ethernet device */
 struct i40e_pf {
 	struct pci_dev *pdev;
@@ -281,8 +286,8 @@ struct i40e_pf {
 	u32 fd_atr_cnt;
 	u32 fd_tcp_rule;
 
-	__be16  vxlan_ports[I40E_MAX_PF_UDP_OFFLOAD_PORTS];
-	u16 pending_vxlan_bitmap;
+	struct i40e_udp_port_config udp_ports[I40E_MAX_PF_UDP_OFFLOAD_PORTS];
+	u16 pending_udp_bitmap;
 
 	enum i40e_interrupt_policy int_policy;
 	u16 rx_itr_default;
@@ -320,7 +325,7 @@ struct i40e_pf {
 #define I40E_FLAG_FD_ATR_ENABLED		BIT_ULL(22)
 #define I40E_FLAG_PTP				BIT_ULL(25)
 #define I40E_FLAG_MFP_ENABLED			BIT_ULL(26)
-#define I40E_FLAG_VXLAN_FILTER_SYNC		BIT_ULL(27)
+#define I40E_FLAG_UDP_FILTER_SYNC              BIT_ULL(27)
 #define I40E_FLAG_PORT_ID_VALID			BIT_ULL(28)
 #define I40E_FLAG_DCB_CAPABLE			BIT_ULL(29)
 #define I40E_FLAG_RSS_AQ_CAPABLE		BIT_ULL(31)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9d45e40..0dd308a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7032,10 +7032,10 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
 }
 
 /**
- * i40e_sync_vxlan_filters_subtask - Sync the VSI filter list with HW
+ * i40e_sync_udp_filters_subtask - Sync the VSI filter list with HW
  * @pf: board private structure
  **/
-static void i40e_sync_vxlan_filters_subtask(struct i40e_pf *pf)
+static void i40e_sync_udp_filters_subtask(struct i40e_pf *pf)
 {
 #if IS_ENABLED(CONFIG_VXLAN)
 	struct i40e_hw *hw = &pf->hw;
@@ -7043,18 +7043,18 @@ static void i40e_sync_vxlan_filters_subtask(struct i40e_pf *pf)
 	__be16 port;
 	int i;
 
-	if (!(pf->flags & I40E_FLAG_VXLAN_FILTER_SYNC))
+	if (!(pf->flags & I40E_FLAG_UDP_FILTER_SYNC))
 		return;
 
-	pf->flags &= ~I40E_FLAG_VXLAN_FILTER_SYNC;
+	pf->flags &= ~I40E_FLAG_UDP_FILTER_SYNC;
 
 	for (i = 0; i < I40E_MAX_PF_UDP_OFFLOAD_PORTS; i++) {
-		if (pf->pending_vxlan_bitmap & BIT_ULL(i)) {
-			pf->pending_vxlan_bitmap &= ~BIT_ULL(i);
-			port = pf->vxlan_ports[i];
+		if (pf->pending_udp_bitmap & BIT_ULL(i)) {
+			pf->pending_udp_bitmap &= ~BIT_ULL(i);
+			port = pf->udp_ports[i].index;
 			if (port)
 				ret = i40e_aq_add_udp_tunnel(hw, ntohs(port),
-						     I40E_AQC_TUNNEL_TYPE_VXLAN,
+						     pf->udp_ports[i].type,
 						     NULL, NULL);
 			else
 				ret = i40e_aq_del_udp_tunnel(hw, i, NULL);
@@ -7067,7 +7067,7 @@ static void i40e_sync_vxlan_filters_subtask(struct i40e_pf *pf)
 					 i40e_stat_str(&pf->hw, ret),
 					 i40e_aq_str(&pf->hw,
 						    pf->hw.aq.asq_last_status));
-				pf->vxlan_ports[i] = 0;
+				pf->udp_ports[i].index = 0;
 			}
 		}
 	}
@@ -7098,7 +7098,7 @@ static void i40e_service_task(struct work_struct *work)
 	i40e_watchdog_subtask(pf);
 	i40e_fdir_reinit_subtask(pf);
 	i40e_sync_filters_subtask(pf);
-	i40e_sync_vxlan_filters_subtask(pf);
+	i40e_sync_udp_filters_subtask(pf);
 	i40e_clean_adminq_subtask(pf);
 
 	i40e_service_event_complete(pf);
@@ -8474,18 +8474,18 @@ static int i40e_set_features(struct net_device *netdev,
 #if IS_ENABLED(CONFIG_VXLAN)
 
 /**
- * i40e_get_vxlan_port_idx - Lookup a possibly offloaded for Rx UDP port
+ * i40e_get_udp_port_idx - Lookup a possibly offloaded for Rx UDP port
  * @pf: board private structure
  * @port: The UDP port to look up
  *
  * Returns the index number or I40E_MAX_PF_UDP_OFFLOAD_PORTS if port not found
  **/
-static u8 i40e_get_vxlan_port_idx(struct i40e_pf *pf, __be16 port)
+static u8 i40e_get_udp_port_idx(struct i40e_pf *pf, __be16 port)
 {
 	u8 i;
 
 	for (i = 0; i < I40E_MAX_PF_UDP_OFFLOAD_PORTS; i++) {
-		if (pf->vxlan_ports[i] == port)
+		if (pf->udp_ports[i].index == port)
 			return i;
 	}
 
@@ -8517,28 +8517,31 @@ static void i40e_add_tunnel_port(struct net_device *netdev,
 	if (sa_family == AF_INET6)
 		return;
 
-	idx = i40e_get_vxlan_port_idx(pf, port);
+	idx = i40e_get_udp_port_idx(pf, port);
 
 	/* Check if port already exists */
 	if (idx < I40E_MAX_PF_UDP_OFFLOAD_PORTS) {
-		netdev_info(netdev, "vxlan port %d already offloaded\n",
+		netdev_info(netdev, "UDP port %d already offloaded\n",
 			    ntohs(port));
 		return;
 	}
 
 	/* Now check if there is space to add the new port */
-	next_idx = i40e_get_vxlan_port_idx(pf, 0);
+	next_idx = i40e_get_udp_port_idx(pf, 0);
 
 	if (next_idx == I40E_MAX_PF_UDP_OFFLOAD_PORTS) {
-		netdev_info(netdev, "maximum number of vxlan UDP ports reached, not adding port %d\n",
+		netdev_info(netdev, "maximum number of UDP ports reached, not adding port %d\n",
 			    ntohs(port));
 		return;
 	}
 
 	/* New port: add it and mark its index in the bitmap */
-	pf->vxlan_ports[next_idx] = port;
-	pf->pending_vxlan_bitmap |= BIT_ULL(next_idx);
-	pf->flags |= I40E_FLAG_VXLAN_FILTER_SYNC;
+	pf->udp_ports[next_idx].index = port;
+	if (type == UDP_TUNNEL_VXLAN)
+		pf->udp_ports[next_idx].type = I40E_AQC_TUNNEL_TYPE_VXLAN;
+
+	pf->pending_udp_bitmap |= BIT_ULL(next_idx);
+	pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
 #endif
 }
 
@@ -8565,18 +8568,18 @@ static void i40e_del_tunnel_port(struct net_device *netdev,
 	if (sa_family == AF_INET6)
 		return;
 
-	idx = i40e_get_vxlan_port_idx(pf, port);
+	idx = i40e_get_udp_port_idx(pf, port);
 
 	/* Check if port already exists */
 	if (idx < I40E_MAX_PF_UDP_OFFLOAD_PORTS) {
 		/* if port exists, set it to 0 (mark for deletion)
 		 * and make it pending
 		 */
-		pf->vxlan_ports[idx] = 0;
-		pf->pending_vxlan_bitmap |= BIT_ULL(idx);
-		pf->flags |= I40E_FLAG_VXLAN_FILTER_SYNC;
+		pf->udp_ports[idx].index = 0;
+		pf->pending_udp_bitmap |= BIT_ULL(idx);
+		pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
 	} else {
-		netdev_warn(netdev, "vxlan port %d was not found, not deleting\n",
+		netdev_warn(netdev, "udp tunnel port %d was not found, not deleting\n",
 			    ntohs(port));
 	}
 #endif
@@ -8841,6 +8844,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	np->vsi = vsi;
 
 	netdev->hw_enc_features |= NETIF_F_IP_CSUM	 |
+				  NETIF_F_RXCSUM	 |
 				  NETIF_F_GSO_UDP_TUNNEL |
 				  NETIF_F_GSO_GRE	 |
 				  NETIF_F_TSO;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index a22efca..e5fe04a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2006,7 +2006,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	if (!(tx_flags & (I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6)))
 		return;
 
-	if (!(tx_flags & I40E_TX_FLAGS_VXLAN_TUNNEL)) {
+	if (!(tx_flags & I40E_TX_FLAGS_UDP_TUNNEL)) {
 		/* snag network header to get L4 type and address */
 		hdr.network = skb_network_header(skb);
 
@@ -2091,7 +2091,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		     I40E_TXD_FLTR_QW1_FD_STATUS_SHIFT;
 
 	dtype_cmd |= I40E_TXD_FLTR_QW1_CNT_ENA_MASK;
-	if (!(tx_flags & I40E_TX_FLAGS_VXLAN_TUNNEL))
+	if (!(tx_flags & I40E_TX_FLAGS_UDP_TUNNEL))
 		dtype_cmd |=
 			((u32)I40E_FD_ATR_STAT_IDX(pf->hw.pf_id) <<
 			I40E_TXD_FLTR_QW1_CNTINDEX_SHIFT) &
@@ -2324,7 +2324,7 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			oudph = udp_hdr(skb);
 			oiph = ip_hdr(skb);
 			l4_tunnel = I40E_TXD_CTX_UDP_TUNNELING;
-			*tx_flags |= I40E_TX_FLAGS_VXLAN_TUNNEL;
+			*tx_flags |= I40E_TX_FLAGS_UDP_TUNNEL;
 			break;
 		case IPPROTO_GRE:
 			l4_tunnel = I40E_TXD_CTX_GRE_TUNNELING;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index dccc1eb..3f081e2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -163,7 +163,7 @@ enum i40e_dyn_idx_t {
 #define I40E_TX_FLAGS_FSO		BIT(7)
 #define I40E_TX_FLAGS_TSYN		BIT(8)
 #define I40E_TX_FLAGS_FD_SB		BIT(9)
-#define I40E_TX_FLAGS_VXLAN_TUNNEL	BIT(10)
+#define I40E_TX_FLAGS_UDP_TUNNEL	BIT(10)
 #define I40E_TX_FLAGS_VLAN_MASK		0xffff0000
 #define I40E_TX_FLAGS_VLAN_PRIO_MASK	0xe0000000
 #define I40E_TX_FLAGS_VLAN_PRIO_SHIFT	29
-- 
1.8.1.4

