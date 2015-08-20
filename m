From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Thu, 20 Aug 2015 11:46:22 -0700
Subject: [Intel-wired-lan] [PATCH 3/4] i40e: Generalize the UDP tunnel
	offload flow
In-Reply-To: <1440096383-8915-1-git-send-email-anjali.singhai@intel.com>
References: <1440096383-8915-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <1440096383-8915-3-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch generalizes the implementation for UDP based tunnel offloads
so that VXLAN and any other UDP based tunnel protocols such
as Geneve can utilize it.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Signed-off-by: Kiran Patil <kiran.patil@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 11 +++++--
 drivers/net/ethernet/intel/i40e/i40e_main.c | 50 ++++++++++++++---------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  6 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  2 +-
 4 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 257f7d8..71752c6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -237,6 +237,11 @@ struct i40e_tc_configuration {
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
@@ -274,8 +279,8 @@ struct i40e_pf {
 	u32 fd_atr_cnt;
 	u32 fd_tcp_rule;
 
-	__be16  vxlan_ports[I40E_MAX_PF_UDP_OFFLOAD_PORTS];
-	u16 pending_vxlan_bitmap;
+	struct i40e_udp_port_config udp_ports[I40E_MAX_PF_UDP_OFFLOAD_PORTS];
+	u16 pending_udp_bitmap;
 
 	enum i40e_interrupt_policy int_policy;
 	u16 rx_itr_default;
@@ -314,7 +319,7 @@ struct i40e_pf {
 #define I40E_FLAG_FD_ATR_ENABLED		BIT_ULL(22)
 #define I40E_FLAG_PTP				BIT_ULL(25)
 #define I40E_FLAG_MFP_ENABLED			BIT_ULL(26)
-#define I40E_FLAG_VXLAN_FILTER_SYNC		BIT_ULL(27)
+#define I40E_FLAG_UDP_FILTER_SYNC              BIT_ULL(27)
 #define I40E_FLAG_PORT_ID_VALID			BIT_ULL(28)
 #define I40E_FLAG_DCB_CAPABLE			BIT_ULL(29)
 #define I40E_FLAG_RSS_AQ_CAPABLE		BIT_ULL(31)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 05081d1..bbc704b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6660,10 +6660,10 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
 }
 
 /**
- * i40e_sync_vxlan_filters_subtask - Sync the VSI filter list with HW
+ * i40e_sync_udp_filters_subtask - Sync the VSI filter list with HW
  * @pf: board private structure
  **/
-static void i40e_sync_vxlan_filters_subtask(struct i40e_pf *pf)
+static void i40e_sync_udp_filters_subtask(struct i40e_pf *pf)
 {
 #if defined(CONFIG_VXLAN) || defined(CONFIG_VXLAN_MODULE)
 	struct i40e_hw *hw = &pf->hw;
@@ -6671,18 +6671,18 @@ static void i40e_sync_vxlan_filters_subtask(struct i40e_pf *pf)
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
@@ -6695,7 +6695,7 @@ static void i40e_sync_vxlan_filters_subtask(struct i40e_pf *pf)
 					 i40e_stat_str(&pf->hw, ret),
 					 i40e_aq_str(&pf->hw,
 						    pf->hw.aq.asq_last_status));
-				pf->vxlan_ports[i] = 0;
+				pf->udp_ports[i].index = 0;
 			}
 		}
 	}
@@ -6725,7 +6725,7 @@ static void i40e_service_task(struct work_struct *work)
 	i40e_watchdog_subtask(pf);
 	i40e_fdir_reinit_subtask(pf);
 	i40e_sync_filters_subtask(pf);
-	i40e_sync_vxlan_filters_subtask(pf);
+	i40e_sync_udp_filters_subtask(pf);
 	i40e_clean_adminq_subtask(pf);
 
 	i40e_service_event_complete(pf);
@@ -7943,18 +7943,18 @@ static int i40e_set_features(struct net_device *netdev,
 }
 
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
 
@@ -7979,28 +7979,28 @@ static void i40e_add_vxlan_port(struct net_device *netdev,
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
-
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
+	pf->udp_ports[next_idx].type = I40E_AQC_TUNNEL_TYPE_VXLAN;
+	pf->pending_udp_bitmap |= BIT_ULL(next_idx);
+	pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
 }
 
 /**
@@ -8020,16 +8020,16 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
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
 		netdev_warn(netdev, "vxlan port %d was not found, not deleting\n",
 			    ntohs(port));
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 0fbcd05..424c5cc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2007,7 +2007,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	if (!(tx_flags & (I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6)))
 		return;
 
-	if (!(tx_flags & I40E_TX_FLAGS_VXLAN_TUNNEL)) {
+	if (!(tx_flags & I40E_TX_FLAGS_UDP_TUNNEL)) {
 		/* snag network header to get L4 type and address */
 		hdr.network = skb_network_header(skb);
 
@@ -2092,7 +2092,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		     I40E_TXD_FLTR_QW1_FD_STATUS_SHIFT;
 
 	dtype_cmd |= I40E_TXD_FLTR_QW1_CNT_ENA_MASK;
-	if (!(tx_flags & I40E_TX_FLAGS_VXLAN_TUNNEL))
+	if (!(tx_flags & I40E_TX_FLAGS_UDP_TUNNEL))
 		dtype_cmd |=
 			((u32)I40E_FD_ATR_STAT_IDX(pf->hw.pf_id) <<
 			I40E_TXD_FLTR_QW1_CNTINDEX_SHIFT) &
@@ -2323,7 +2323,7 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			oudph = udp_hdr(skb);
 			oiph = ip_hdr(skb);
 			l4_tunnel = I40E_TXD_CTX_UDP_TUNNELING;
-			*tx_flags |= I40E_TX_FLAGS_VXLAN_TUNNEL;
+			*tx_flags |= I40E_TX_FLAGS_UDP_TUNNEL;
 			break;
 		default:
 			return;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index a992cb8f..db2130f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -151,7 +151,7 @@ enum i40e_dyn_idx_t {
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

