From: Alice Michael <alice.michael@intel.com>
Date: Wed,  5 Apr 2017 07:51:03 -0400
Subject: [Intel-wired-lan] [next S66 v2 11/11] i40e/i40evf: Use build_skb to
	build frames
In-Reply-To: <20170405115103.67374-1-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
Message-ID: <20170405115103.67374-11-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch is meant to improve the performance of the Rx path.
Specifically by using build_skb we have several distinct advantages.

In the case of small frames we were previously using a copy-break approach.
This means that we were allocating a page fragment to use for skb->head,
and were having to copy the packet into that region.  Both of those calls
are now avoided since we just build the skb around the data.

In the case of large frames the gains are much more significant.
Specifically we were having to allocate skb->head, and copy the headers as
before.  However in addition we were having to parse the header using
eth_get_headlen which could be quite expensive.  All of this is avoided by
building the frame around the data.  I have seen gains as high as 30% when
using VXLAN for instance due to just header pulling overhead.

Finally with all this in place it also sets us up to start looking at
enabling XDP.  Specifically we now have a path in which the data is in the
page and the frame is built around it.  So if we parse it with XDP before
we call build_skb we can take care of any necessary processing there.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: Id4bdd618e94473d41f892417e5d8019639e421e3
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 47 +++++++++++++++++++++++++++
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 47 +++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 4b31aec..b4a7bfc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1816,6 +1816,51 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
 }
 
 /**
+ * i40e_build_skb - Build skb around an existing buffer
+ * @rx_ring: rx descriptor ring to transact packets on
+ * @rx_buffer: rx buffer to pull data from
+ * @size: size of buffer to add to skb
+ *
+ * This function builds an skb around an existing Rx buffer, taking care
+ * to set up the skb correctly and avoid any memcpy overhead.
+ */
+static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
+				      struct i40e_rx_buffer *rx_buffer,
+				      unsigned int size)
+{
+	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
+#if (PAGE_SIZE < 8192)
+	unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;
+#else
+	unsigned int truesize = SKB_DATA_ALIGN(size);
+#endif
+	struct sk_buff *skb;
+
+	/* prefetch first cache line of first page */
+	prefetch(va);
+#if L1_CACHE_BYTES < 128
+	prefetch(va + L1_CACHE_BYTES);
+#endif
+	/* build an skb around the page buffer */
+	skb = build_skb(va - I40E_SKB_PAD, truesize);
+	if (unlikely(!skb))
+		return NULL;
+
+	/* update pointers within the skb to store the data */
+	skb_reserve(skb, I40E_SKB_PAD);
+	__skb_put(skb, size);
+
+	/* buffer is used by skb, update page_offset */
+#if (PAGE_SIZE < 8192)
+	rx_buffer->page_offset ^= truesize;
+#else
+	rx_buffer->page_offset += truesize;
+#endif
+
+	return skb;
+}
+
+/**
  * i40e_put_rx_buffer - Clean up used buffer and either recycle or free
  * @rx_ring: rx descriptor ring to transact packets on
  * @rx_buffer: rx buffer to pull data from
@@ -1939,6 +1984,8 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		/* retrieve a buffer from the ring */
 		if (skb)
 			i40e_add_rx_frag(rx_ring, rx_buffer, skb, size);
+		else if (ring_uses_build_skb(rx_ring))
+			skb = i40e_build_skb(rx_ring, rx_buffer, size);
 		else
 			skb = i40e_construct_skb(rx_ring, rx_buffer, size);
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index d96f10a..7f1341c 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1177,6 +1177,51 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
 }
 
 /**
+ * i40e_build_skb - Build skb around an existing buffer
+ * @rx_ring: rx descriptor ring to transact packets on
+ * @rx_buffer: rx buffer to pull data from
+ * @size: size of buffer to add to skb
+ *
+ * This function builds an skb around an existing Rx buffer, taking care
+ * to set up the skb correctly and avoid any memcpy overhead.
+ */
+static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
+				      struct i40e_rx_buffer *rx_buffer,
+				      unsigned int size)
+{
+	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
+#if (PAGE_SIZE < 8192)
+	unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;
+#else
+	unsigned int truesize = SKB_DATA_ALIGN(size);
+#endif
+	struct sk_buff *skb;
+
+	/* prefetch first cache line of first page */
+	prefetch(va);
+#if L1_CACHE_BYTES < 128
+	prefetch(va + L1_CACHE_BYTES);
+#endif
+	/* build an skb around the page buffer */
+	skb = build_skb(va - I40E_SKB_PAD, truesize);
+	if (unlikely(!skb))
+		return NULL;
+
+	/* update pointers within the skb to store the data */
+	skb_reserve(skb, I40E_SKB_PAD);
+	__skb_put(skb, size);
+
+	/* buffer is used by skb, update page_offset */
+#if (PAGE_SIZE < 8192)
+	rx_buffer->page_offset ^= truesize;
+#else
+	rx_buffer->page_offset += truesize;
+#endif
+
+	return skb;
+}
+
+/**
  * i40e_put_rx_buffer - Clean up used buffer and either recycle or free
  * @rx_ring: rx descriptor ring to transact packets on
  * @rx_buffer: rx buffer to pull data from
@@ -1295,6 +1340,8 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		/* retrieve a buffer from the ring */
 		if (skb)
 			i40e_add_rx_frag(rx_ring, rx_buffer, skb, size);
+		else if (ring_uses_build_skb(rx_ring))
+			skb = i40e_build_skb(rx_ring, rx_buffer, size);
 		else
 			skb = i40e_construct_skb(rx_ring, rx_buffer, size);
 
-- 
2.9.3

