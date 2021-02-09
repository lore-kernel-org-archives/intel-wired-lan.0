From: Vedang Patel <vedang.patel@intel.com>
Date: Mon,  8 Feb 2021 18:42:41 -0800
Subject: [Intel-wired-lan] [PATCH net-next v3 7/9] igc: Replace
 IGC_TX_FLAGS_XDP flag by an enum
In-Reply-To: <20210209024243.23406-1-vedang.patel@intel.com>
References: <20210209024243.23406-1-vedang.patel@intel.com>
Message-ID: <20210209024243.23406-8-vedang.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Andre Guedes <andre.guedes@intel.com>

Up to this point, tx buffers are associated with either a skb or a xdpf,
and the IGC_TX_FLAGS_XDP flag was enough to distinguish between these
two case. However, with upcoming patches that will add AF_XDP zero-copy
support, a third case will be introduced so this flag-based approach
won't fit well.

In preparation to land AF_XDP zero-copy support, replace the
IGC_TX_FLAGS_XDP flag by an enum which will be extended once zero-copy
support is introduced to the driver.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  8 +++++--
 drivers/net/ethernet/intel/igc/igc_main.c | 27 ++++++++++++++++++-----
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 3f0d8377d661..5b14cd4aafe6 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -377,8 +377,6 @@ enum igc_tx_flags {
 	/* olinfo flags */
 	IGC_TX_FLAGS_IPV4	= 0x10,
 	IGC_TX_FLAGS_CSUM	= 0x20,
-
-	IGC_TX_FLAGS_XDP	= 0x100,
 };
 
 enum igc_boards {
@@ -395,12 +393,18 @@ enum igc_boards {
 #define TXD_USE_COUNT(S)	DIV_ROUND_UP((S), IGC_MAX_DATA_PER_TXD)
 #define DESC_NEEDED	(MAX_SKB_FRAGS + 4)
 
+enum igc_tx_buffer_type {
+	IGC_TX_BUFFER_TYPE_SKB,
+	IGC_TX_BUFFER_TYPE_XDP,
+};
+
 /* wrapper around a pointer to a socket buffer,
  * so a DMA handle can be stored along with the buffer
  */
 struct igc_tx_buffer {
 	union igc_adv_tx_desc *next_to_watch;
 	unsigned long time_stamp;
+	enum igc_tx_buffer_type type;
 	union {
 		struct sk_buff *skb;
 		struct xdp_frame *xdpf;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 9049456d2410..5874936b7c59 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -191,10 +191,18 @@ static void igc_clean_tx_ring(struct igc_ring *tx_ring)
 	while (i != tx_ring->next_to_use) {
 		union igc_adv_tx_desc *eop_desc, *tx_desc;
 
-		if (tx_buffer->tx_flags & IGC_TX_FLAGS_XDP)
+		switch (tx_buffer->type) {
+		case IGC_TX_BUFFER_TYPE_XDP:
 			xdp_return_frame(tx_buffer->xdpf);
-		else
+			break;
+		case IGC_TX_BUFFER_TYPE_SKB:
 			dev_kfree_skb_any(tx_buffer->skb);
+			break;
+		default:
+			netdev_warn_once(tx_ring->netdev,
+					 "Unknown tx buffer type\n");
+			break;
+		}
 
 		igc_unmap_tx_buffer(tx_ring->dev, tx_buffer);
 
@@ -1360,6 +1368,7 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 
 	/* record the location of the first descriptor for this packet */
 	first = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
+	first->type = IGC_TX_BUFFER_TYPE_SKB;
 	first->skb = skb;
 	first->bytecount = skb->len;
 	first->gso_segs = 1;
@@ -1934,8 +1943,8 @@ static int igc_xdp_init_tx_buffer(struct igc_tx_buffer *buffer,
 		return -ENOMEM;
 	}
 
+	buffer->type = IGC_TX_BUFFER_TYPE_XDP;
 	buffer->xdpf = xdpf;
-	buffer->tx_flags = IGC_TX_FLAGS_XDP;
 	buffer->protocol = 0;
 	buffer->bytecount = xdpf->len;
 	buffer->gso_segs = 1;
@@ -2299,10 +2308,18 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
 		total_bytes += tx_buffer->bytecount;
 		total_packets += tx_buffer->gso_segs;
 
-		if (tx_buffer->tx_flags & IGC_TX_FLAGS_XDP)
+		switch (tx_buffer->type) {
+		case IGC_TX_BUFFER_TYPE_XDP:
 			xdp_return_frame(tx_buffer->xdpf);
-		else
+			break;
+		case IGC_TX_BUFFER_TYPE_SKB:
 			napi_consume_skb(tx_buffer->skb, napi_budget);
+			break;
+		default:
+			netdev_warn_once(tx_ring->netdev,
+					 "Unknown tx buffer type\n");
+			break;
+		}
 
 		igc_unmap_tx_buffer(tx_ring->dev, tx_buffer);
 
-- 
2.17.1

