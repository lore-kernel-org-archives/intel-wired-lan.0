From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 06 Jan 2017 08:11:31 -0800
Subject: [Intel-wired-lan] [next PATCH 9/9] igb: Revert "igb: Revert support
 for build_skb in igb"
In-Reply-To: <20170106160850.2030.39073.stgit@localhost.localdomain>
References: <20170106160850.2030.39073.stgit@localhost.localdomain>
Message-ID: <20170106161131.2030.4342.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This reverts commit f9d40f6a9921 ("igb: Revert support for build_skb in
igb") and adds a few changes to update it to work with the latest version
of igb. We are now able to revert the removal of this due to the fact
that with the recent changes to the page count and the use of
DMA_ATTR_SKIP_CPU_SYNC we can make the pages writable so we should not be
invalidating the additional data added when we call build_skb.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |   47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index dfb04d7ba502..bed155207d52 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7019,6 +7019,51 @@ static struct sk_buff *igb_construct_skb(struct igb_ring *rx_ring,
 	return skb;
 }
 
+static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
+				     struct igb_rx_buffer *rx_buffer,
+				     union e1000_adv_rx_desc *rx_desc,
+				     unsigned int size)
+{
+	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
+#if (PAGE_SIZE < 8192)
+	unsigned int truesize = igb_rx_pg_size(rx_ring) / 2;
+#else
+	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
+				SKB_DATA_ALIGN(IGB_SKB_PAD + size);
+#endif
+	struct sk_buff *skb;
+
+	/* prefetch first cache line of first page */
+	prefetch(va);
+#if L1_CACHE_BYTES < 128
+	prefetch(va + L1_CACHE_BYTES);
+#endif
+
+	/* build an skb to around the page buffer */
+	skb = build_skb(va - IGB_SKB_PAD, truesize);
+	if (unlikely(!skb))
+		return NULL;
+
+	/* update pointers within the skb to store the data */
+	skb_reserve(skb, IGB_SKB_PAD);
+	__skb_put(skb, size);
+
+	/* pull timestamp out of packet data */
+	if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
+		igb_ptp_rx_pktstamp(rx_ring->q_vector, skb->data, skb);
+		__skb_pull(skb, IGB_TS_HDR_LEN);
+	}
+
+	/* update buffer offset */
+#if (PAGE_SIZE < 8192)
+	rx_buffer->page_offset ^= truesize;
+#else
+	rx_buffer->page_offset += truesize;
+#endif
+
+	return skb;
+}
+
 static inline void igb_rx_checksum(struct igb_ring *ring,
 				   union e1000_adv_rx_desc *rx_desc,
 				   struct sk_buff *skb)
@@ -7248,6 +7293,8 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 		/* retrieve a buffer from the ring */
 		if (skb)
 			igb_add_rx_frag(rx_ring, rx_buffer, skb, size);
+		else if (ring_uses_build_skb(rx_ring))
+			skb = igb_build_skb(rx_ring, rx_buffer, rx_desc, size);
 		else
 			skb = igb_construct_skb(rx_ring, rx_buffer,
 						rx_desc, size);

