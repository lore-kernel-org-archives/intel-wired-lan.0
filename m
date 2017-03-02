From: John Fastabend <john.fastabend@gmail.com>
Date: Wed, 01 Mar 2017 16:55:00 -0800
Subject: [Intel-wired-lan] [net-next PATCH v2 3/3] ixgbe: xdp support for
	adjust head
In-Reply-To: <20170302005417.30505.14047.stgit@john-Precision-Tower-5810>
References: <20170302005417.30505.14047.stgit@john-Precision-Tower-5810>
Message-ID: <20170302005500.30505.88418.stgit@john-Precision-Tower-5810>
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   38 +++++++++++++++++--------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index e754fe0..c8bf64e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2026,6 +2026,7 @@ static bool ixgbe_can_reuse_rx_page(struct ixgbe_rx_buffer *rx_buffer)
 static void ixgbe_add_rx_frag(struct ixgbe_ring *rx_ring,
 			      struct ixgbe_rx_buffer *rx_buffer,
 			      struct sk_buff *skb,
+			      unsigned int headroom,
 			      unsigned int size)
 {
 #if (PAGE_SIZE < 8192)
@@ -2036,7 +2037,8 @@ static void ixgbe_add_rx_frag(struct ixgbe_ring *rx_ring,
 				SKB_DATA_ALIGN(size);
 #endif
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
-			rx_buffer->page_offset, size, truesize);
+			rx_buffer->page_offset - (IXGBE_SKB_PAD - headroom),
+			size, truesize);
 #if (PAGE_SIZE < 8192)
 	rx_buffer->page_offset ^= truesize;
 #else
@@ -2109,6 +2111,7 @@ static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
 static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
 					   struct ixgbe_rx_buffer *rx_buffer,
 					   union ixgbe_adv_rx_desc *rx_desc,
+					   unsigned int headroom,
 					   unsigned int size)
 {
 	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
@@ -2117,6 +2120,7 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
 #else
 	unsigned int truesize = SKB_DATA_ALIGN(size);
 #endif
+	unsigned int off_page;
 	struct sk_buff *skb;
 
 	/* prefetch first cache line of first page */
@@ -2130,12 +2134,14 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
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
@@ -2143,7 +2149,8 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
 		rx_buffer->page_offset += truesize;
 #endif
 	} else {
-		memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
+		memcpy(__skb_put(skb, size), va - off_page,
+		       ALIGN(size, sizeof(long)));
 		rx_buffer->pagecnt_bias++;
 	}
 
@@ -2153,6 +2160,7 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
 static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
 				       struct ixgbe_rx_buffer *rx_buffer,
 				       union ixgbe_adv_rx_desc *rx_desc,
+				       unsigned int headroom,
 				       unsigned int size)
 {
 	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
@@ -2176,7 +2184,7 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
 		return NULL;
 
 	/* update pointers within the skb to store the data */
-	skb_reserve(skb, IXGBE_SKB_PAD);
+	skb_reserve(skb, headroom);
 	__skb_put(skb, size);
 
 	/* record DMA address if this is the start of a chain of buffers */
@@ -2203,7 +2211,8 @@ static int ixgbe_xmit_xdp_ring(struct ixgbe_adapter *adapter,
 static int ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 			 struct ixgbe_ring  *rx_ring,
 			 struct ixgbe_rx_buffer *rx_buffer,
-			 unsigned int size)
+			 unsigned int *headroom,
+			 unsigned int *size)
 {
 	int result = IXGBE_XDP_PASS;
 	struct bpf_prog *xdp_prog;
@@ -2218,14 +2227,16 @@ static int ixgbe_run_xdp(struct ixgbe_adapter *adapter,
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
 		if (result == IXGBE_XDP_TX)
@@ -2274,6 +2285,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 	u16 cleaned_count = ixgbe_desc_unused(rx_ring);
 
 	while (likely(total_rx_packets < budget)) {
+		unsigned int headroom = ixgbe_rx_offset(rx_ring);
 		union ixgbe_adv_rx_desc *rx_desc;
 		struct ixgbe_rx_buffer *rx_buffer;
 		struct sk_buff *skb;
@@ -2299,7 +2311,8 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 
 		rx_buffer = ixgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size);
 
-		consumed = ixgbe_run_xdp(adapter, rx_ring, rx_buffer, size);
+		consumed = ixgbe_run_xdp(adapter, rx_ring, rx_buffer,
+					 &headroom, &size);
 
 		if (consumed) {
 			ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb);
@@ -2312,13 +2325,14 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 
 		/* retrieve a buffer from the ring */
 		if (skb)
-			ixgbe_add_rx_frag(rx_ring, rx_buffer, skb, size);
+			ixgbe_add_rx_frag(rx_ring, rx_buffer, skb,
+					  headroom, size);
 		else if (ring_uses_build_skb(rx_ring))
 			skb = ixgbe_build_skb(rx_ring, rx_buffer,
-					      rx_desc, size);
+					      rx_desc, headroom, size);
 		else
 			skb = ixgbe_construct_skb(rx_ring, rx_buffer,
-						  rx_desc, size);
+						  rx_desc, headroom, size);
 
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {

