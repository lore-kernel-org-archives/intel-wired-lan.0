From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 15 Apr 2019 10:38:00 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v5 5/6] net: pass net argument to
 the eth_get_headlen
In-Reply-To: <20190415173801.257254-1-sdf@google.com>
References: <20190415173801.257254-1-sdf@google.com>
Message-ID: <20190415173801.257254-6-sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Update all users eth_get_headlen to pass network namespace
and pass it down to the flow dissector. This commit is a noop
until administrator inserts BPF flow dissector program.

Cc: Maxim Krasnyansky <maxk@qti.qualcomm.com>
Cc: Saeed Mahameed <saeedm@mellanox.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: Salil Mehta <salil.mehta@huawei.com>
Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c  | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c     | 3 ++-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c   | 3 ++-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c     | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 3 ++-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c       | 3 ++-
 drivers/net/ethernet/intel/ice/ice_txrx.c         | 3 ++-
 drivers/net/ethernet/intel/igb/igb_main.c         | 3 ++-
 drivers/net/ethernet/intel/igc/igc_main.c         | 3 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c   | 3 ++-
 drivers/net/tun.c                                 | 3 ++-
 include/linux/etherdevice.h                       | 2 +-
 net/ethernet/eth.c                                | 5 +++--
 16 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index c64e2fb5a4f1..1b3181f757b7 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -354,7 +354,8 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 
 			hdr_len = buff->len;
 			if (hdr_len > AQ_CFG_RX_HDR_SIZE)
-				hdr_len = eth_get_headlen(aq_buf_vaddr(&buff->rxdata),
+				hdr_len = eth_get_headlen(dev_net(skb->dev),
+							  aq_buf_vaddr(&buff->rxdata),
 							  AQ_CFG_RX_HDR_SIZE);
 
 			memcpy(__skb_put(skb, hdr_len), aq_buf_vaddr(&buff->rxdata),
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6528a597367b..8bb5f708ccc6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -899,7 +899,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 			     DMA_ATTR_WEAK_ORDERING);
 
 	if (unlikely(!payload))
-		payload = eth_get_headlen(data_ptr, len);
+		payload = eth_get_headlen(dev_net(bp->dev), data_ptr, len);
 
 	skb = napi_alloc_skb(&rxr->bnapi->napi, payload);
 	if (!skb) {
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 297b95c1b3c1..f1ecc78d2323 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -598,7 +598,8 @@ static int hns_nic_poll_rx_skb(struct hns_nic_ring_data *ring_data,
 	} else {
 		ring->stats.seg_pkt_cnt++;
 
-		pull_len = eth_get_headlen(va, HNS_RX_HEAD_SIZE);
+		pull_len = eth_get_headlen(dev_net(ndev), va,
+					   HNS_RX_HEAD_SIZE);
 		memcpy(__skb_put(skb, pull_len), va,
 		       ALIGN(pull_len, sizeof(long)));
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index b53b0911ec24..423d9ce0f6f8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2457,7 +2457,8 @@ static int hns3_alloc_skb(struct hns3_enet_ring *ring, int length,
 	ring->stats.seg_pkt_cnt++;
 	u64_stats_update_end(&ring->syncp);
 
-	ring->pull_len = eth_get_headlen(va, HNS3_RX_HEAD_SIZE);
+	ring->pull_len = eth_get_headlen(dev_net(netdev), va,
+					 HNS3_RX_HEAD_SIZE);
 	__skb_put(skb, ring->pull_len);
 	hns3_nic_reuse_page(skb, ring->frag_num++, ring, ring->pull_len,
 			    desc_cb);
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 2325cee76211..e2bee187d652 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -280,7 +280,7 @@ static bool fm10k_add_rx_frag(struct fm10k_rx_buffer *rx_buffer,
 	/* we need the header to contain the greater of either ETH_HLEN or
 	 * 60 bytes if the skb->len is less than 60 for skb_pad.
 	 */
-	pull_len = eth_get_headlen(va, FM10K_RX_HDR_LEN);
+	pull_len = eth_get_headlen(dev_net(skb->dev), va, FM10K_RX_HDR_LEN);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, pull_len), va, ALIGN(pull_len, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 1a95223c9f99..85c5b503e0a0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2035,7 +2035,8 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > I40E_RX_HDR_SIZE)
-		headlen = eth_get_headlen(xdp->data, I40E_RX_HDR_SIZE);
+		headlen = eth_get_headlen(dev_net(skb->dev), xdp->data,
+					  I40E_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), xdp->data,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index b64187753ad6..23a62d7d0f9f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1315,7 +1315,8 @@ static struct sk_buff *iavf_construct_skb(struct iavf_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > IAVF_RX_HDR_SIZE)
-		headlen = eth_get_headlen(va, IAVF_RX_HDR_SIZE);
+		headlen = eth_get_headlen(dev_net(skb->dev), va,
+					  IAVF_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), va, ALIGN(headlen, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index a6f7b7feaf3c..2692b9333055 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -698,7 +698,8 @@ ice_construct_skb(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > ICE_RX_HDR_SIZE)
-		headlen = eth_get_headlen(va, ICE_RX_HDR_SIZE);
+		headlen = eth_get_headlen(dev_net(skb->dev), va,
+					  ICE_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), va, ALIGN(headlen, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index acbb5b4f333d..2023e1800c8d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8051,7 +8051,8 @@ static struct sk_buff *igb_construct_skb(struct igb_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > IGB_RX_HDR_LEN)
-		headlen = eth_get_headlen(va, IGB_RX_HDR_LEN);
+		headlen = eth_get_headlen(dev_net(skb->dev), va,
+					  IGB_RX_HDR_LEN);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), va, ALIGN(headlen, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index f79728381e8a..265a9d8a8421 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1199,7 +1199,8 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > IGC_RX_HDR_LEN)
-		headlen = eth_get_headlen(va, IGC_RX_HDR_LEN);
+		headlen = eth_get_headlen(dev_net(skb->dev), va,
+					  IGC_RX_HDR_LEN);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), va, ALIGN(headlen, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 60cec3540dd7..5e5294567ca1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1800,7 +1800,7 @@ static void ixgbe_pull_tail(struct ixgbe_ring *rx_ring,
 	 * we need the header to contain the greater of either ETH_HLEN or
 	 * 60 bytes if the skb->len is less than 60 for skb_pad.
 	 */
-	pull_len = eth_get_headlen(va, IXGBE_RX_HDR_SIZE);
+	pull_len = eth_get_headlen(dev_net(skb->dev), va, IXGBE_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	skb_copy_to_linear_data(skb, va, ALIGN(pull_len, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 49e23afa05a2..252fe0de6b56 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -895,7 +895,8 @@ struct sk_buff *ixgbevf_construct_skb(struct ixgbevf_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > IXGBEVF_RX_HDR_SIZE)
-		headlen = eth_get_headlen(xdp->data, IXGBEVF_RX_HDR_SIZE);
+		headlen = eth_get_headlen(dev_net(skb->dev), xdp->data,
+					  IXGBEVF_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), xdp->data,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 40f3f98aa279..efcc27756c7e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -163,7 +163,8 @@ static inline u16 mlx5e_calc_min_inline(enum mlx5_inline_modes mode,
 	case MLX5_INLINE_MODE_NONE:
 		return 0;
 	case MLX5_INLINE_MODE_TCP_UDP:
-		hlen = eth_get_headlen(skb->data, skb_headlen(skb));
+		hlen = eth_get_headlen(dev_net(skb->dev), skb->data,
+				       skb_headlen(skb));
 		if (hlen == ETH_HLEN && !skb_vlan_tag_present(skb))
 			hlen += VLAN_HLEN;
 		break;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 24d0220b9ba0..6d5c8ecfea1e 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1965,7 +1965,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (frags) {
 		/* Exercise flow dissector code path. */
-		u32 headlen = eth_get_headlen(skb->data, skb_headlen(skb));
+		u32 headlen = eth_get_headlen(dev_net(tun->dev), skb->data,
+					      skb_headlen(skb));
 
 		if (unlikely(headlen > skb_headlen(skb))) {
 			this_cpu_inc(tun->pcpu_stats->rx_dropped);
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index e2f3b21cd72a..71a441ffab3f 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -33,7 +33,7 @@ struct device;
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr);
 unsigned char *arch_get_platform_mac_address(void);
 int nvmem_get_mac_address(struct device *dev, void *addrbuf);
-u32 eth_get_headlen(void *data, unsigned int max_len);
+u32 eth_get_headlen(const struct net *net, void *data, unsigned int max_len);
 __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
 extern const struct header_ops eth_header_ops;
 
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 1e439549c419..0202e72e20a4 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -119,13 +119,14 @@ EXPORT_SYMBOL(eth_header);
 
 /**
  * eth_get_headlen - determine the length of header for an ethernet frame
+ * @net: pointer to device network namespace
  * @data: pointer to start of frame
  * @len: total length of frame
  *
  * Make a best effort attempt to pull the length for all of the headers for
  * a given frame in a linear buffer.
  */
-u32 eth_get_headlen(void *data, unsigned int len)
+u32 eth_get_headlen(const struct net *net, void *data, unsigned int len)
 {
 	const unsigned int flags = FLOW_DISSECTOR_F_PARSE_1ST_FRAG;
 	const struct ethhdr *eth = (const struct ethhdr *)data;
@@ -136,7 +137,7 @@ u32 eth_get_headlen(void *data, unsigned int len)
 		return len;
 
 	/* parse any remaining L2/L3 headers, check for L4 */
-	if (!skb_flow_dissect_flow_keys_basic(NULL, NULL, &keys, data,
+	if (!skb_flow_dissect_flow_keys_basic(net, NULL, &keys, data,
 					      eth->h_proto, sizeof(*eth),
 					      len, flags))
 		return max_t(u32, keys.control.thoff, sizeof(*eth));
-- 
2.21.0.392.gf8f6787159e-goog

