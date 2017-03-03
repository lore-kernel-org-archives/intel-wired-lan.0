From: John Fastabend <john.fastabend@gmail.com>
Date: Fri, 03 Mar 2017 09:57:46 -0800
Subject: [Intel-wired-lan] [net-next PATCH v3 3/3] ixgbe: xdp support for
	adjust head
In-Reply-To: <20170303175526.25015.12183.stgit@john-Precision-Tower-5810>
References: <20170303175526.25015.12183.stgit@john-Precision-Tower-5810>
Message-ID: <20170303175746.25015.22531.stgit@john-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add adjust_head support for XDP however at the moment we are only
adding IXGBE_SKB_PAD bytes of headroom to align with driver paths.

The infrastructure is is such that a follow on patch can extend
headroom up to 196B without changing RX path.

Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   31 +++++++++++++++++--------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index fa37d48..1892c42 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2117,6 +2117,7 @@ static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
 static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
 					   struct ixgbe_rx_buffer *rx_buffer,
 					   union ixgbe_adv_rx_desc *rx_desc,
+					   unsigned int headroom,
 					   unsigned int size)
 {
 	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
@@ -2125,6 +2126,7 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
 #else
 	unsigned int truesize = SKB_DATA_ALIGN(size);
 #endif
+	unsigned int off_page;
 	struct sk_buff *skb;
 
 	/* prefetch first cache line of first page */
@@ -2138,12 +2140,14 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
 	if (unlikely(!skb))
 		return NULL;
 
+	off_page = IXGBE_SKB_PAD - headroom;
+
 	if (size > IXGBE_RX_HDR_SIZE) {
 		if (!ixgbe_test_staterr(rx_desc, IXGBE_RXD_STAT_EOP))
 			IXGBE_CB(skb)->dma = rx_buffer->dma;
 
 		skb_add_rx_frag(skb, 0, rx_buffer->page,
-				rx_buffer->page_offset,
+				rx_buffer->page_offset - off_page,
 				size, truesize);
 #if (PAGE_SIZE < 8192)
 		rx_buffer->page_offset ^= truesize;
@@ -2151,7 +2155,8 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
 		rx_buffer->page_offset += truesize;
 #endif
 	} else {
-		memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
+		memcpy(__skb_put(skb, size), va - off_page,
+		       ALIGN(size, sizeof(long)));
 		rx_buffer->pagecnt_bias++;
 	}
 
@@ -2161,6 +2166,7 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
 static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
 				       struct ixgbe_rx_buffer *rx_buffer,
 				       union ixgbe_adv_rx_desc *rx_desc,
+				       unsigned int headroom,
 				       unsigned int size)
 {
 	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
@@ -2184,7 +2190,7 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
 		return NULL;
 
 	/* update pointers within the skb to store the data */
-	skb_reserve(skb, IXGBE_SKB_PAD);
+	skb_reserve(skb, headroom);
 	__skb_put(skb, size);
 
 	/* record DMA address if this is the start of a chain of buffers */
@@ -2211,7 +2217,8 @@ static int ixgbe_xmit_xdp_ring(struct ixgbe_adapter *adapter,
 static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 				     struct ixgbe_ring  *rx_ring,
 				     struct ixgbe_rx_buffer *rx_buffer,
-				     unsigned int size)
+				     unsigned int *headroom,
+				     unsigned int *size)
 {
 	int result = IXGBE_XDP_PASS;
 	struct bpf_prog *xdp_prog;
@@ -2226,14 +2233,16 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 		goto xdp_out;
 
 	addr = page_address(rx_buffer->page) + rx_buffer->page_offset;
-	xdp.data_hard_start = addr;
+	xdp.data_hard_start = addr - *headroom;
 	xdp.data = addr;
-	xdp.data_end = addr + size;
+	xdp.data_end = addr + *size;
 
 	act = bpf_prog_run_xdp(xdp_prog, &xdp);
 	switch (act) {
 	case XDP_PASS:
-		break;
+		*headroom = xdp.data - xdp.data_hard_start;
+		*size = xdp.data_end - xdp.data;
+		return IXGBE_XDP_PASS;
 	case XDP_TX:
 		result = ixgbe_xmit_xdp_ring(adapter, &xdp);
 		if (result == IXGBE_XDP_TX) {
@@ -2289,6 +2298,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 	u16 cleaned_count = ixgbe_desc_unused(rx_ring);
 
 	while (likely(total_rx_packets < budget)) {
+		unsigned int headroom = ixgbe_rx_offset(rx_ring);
 		union ixgbe_adv_rx_desc *rx_desc;
 		struct ixgbe_rx_buffer *rx_buffer;
 		struct sk_buff *skb;
@@ -2313,7 +2323,8 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 
 		rx_buffer = ixgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size);
 
-		skb = ixgbe_run_xdp(adapter, rx_ring, rx_buffer, size);
+		skb = ixgbe_run_xdp(adapter, rx_ring, rx_buffer,
+				    &headroom, &size);
 		if (IS_ERR(skb)) { /* XDP consumed buffer */
 			total_rx_packets++;
 			total_rx_bytes += size;
@@ -2321,10 +2332,10 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 			ixgbe_add_rx_frag(rx_ring, rx_buffer, skb, size);
 		} else if (ring_uses_build_skb(rx_ring)) {
 			skb = ixgbe_build_skb(rx_ring, rx_buffer,
-					      rx_desc, size);
+					      rx_desc, headroom, size);
 		} else {
 			skb = ixgbe_construct_skb(rx_ring, rx_buffer,
-						  rx_desc, size);
+						  rx_desc, headroom, size);
 		}
 
 		/* exit if we failed to retrieve a buffer */

