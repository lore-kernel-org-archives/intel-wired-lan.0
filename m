From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Thu, 30 Apr 2020 13:22:18 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2 23/33] ixgbe: add XDP frame
 size to driver
In-Reply-To: <158824557985.2172139.4173570969543904434.stgit@firesoul>
References: <158824557985.2172139.4173570969543904434.stgit@firesoul>
Message-ID: <158824573834.2172139.13293919612785981823.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This driver uses different memory models depending on PAGE_SIZE at
compile time. For PAGE_SIZE 4K it uses page splitting, meaning for
normal MTU frame size is 2048 bytes (and headroom 192 bytes). For
larger MTUs the driver still use page splitting, by allocating
order-1 pages (8192 bytes) for RX frames. For PAGE_SIZE larger than
4K, driver instead advance its rx_buffer->page_offset with the frame
size "truesize".

For XDP frame size calculations, this mean that in PAGE_SIZE larger
than 4K mode the frame_sz change on a per packet basis. For the page
split 4K PAGE_SIZE mode, xdp.frame_sz is more constant and can be
updated once outside the main NAPI loop.

The default setting in the driver uses build_skb(), which provides
the necessary headroom and tailroom for XDP-redirect in RX-frame
(in both modes).

There is one complication, which is legacy-rx mode (configurable via
ethtool priv-flags). There are zero headroom in this mode, which is a
requirement for XDP-redirect to work. The conversion to xdp_frame
(convert_to_xdp_frame) will detect this insufficient space, and
xdp_do_redirect() call will fail. This is deemed acceptable, as it
allows other XDP actions to still work in legacy-mode. In
legacy-mode + larger PAGE_SIZE due to lacking tailroom, we also
accept that xdp_adjust_tail shrink doesn't work.

Cc: intel-wired-lan at lists.osuosl.org
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   34 +++++++++++++++++++------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ea6834bae04c..eab5934b04f5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2244,20 +2244,30 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 	return ERR_PTR(-result);
 }
 
+static unsigned int ixgbe_rx_frame_truesize(struct ixgbe_ring *rx_ring,
+					    unsigned int size)
+{
+	unsigned int truesize;
+
+#if (PAGE_SIZE < 8192)
+	truesize = ixgbe_rx_pg_size(rx_ring) / 2; /* Must be power-of-2 */
+#else
+	truesize = ring_uses_build_skb(rx_ring) ?
+		SKB_DATA_ALIGN(IXGBE_SKB_PAD + size) +
+		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
+		SKB_DATA_ALIGN(size);
+#endif
+	return truesize;
+}
+
 static void ixgbe_rx_buffer_flip(struct ixgbe_ring *rx_ring,
 				 struct ixgbe_rx_buffer *rx_buffer,
 				 unsigned int size)
 {
+	unsigned int truesize = ixgbe_rx_frame_truesize(rx_ring, size);
 #if (PAGE_SIZE < 8192)
-	unsigned int truesize = ixgbe_rx_pg_size(rx_ring) / 2;
-
 	rx_buffer->page_offset ^= truesize;
 #else
-	unsigned int truesize = ring_uses_build_skb(rx_ring) ?
-				SKB_DATA_ALIGN(IXGBE_SKB_PAD + size) +
-				SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
-				SKB_DATA_ALIGN(size);
-
 	rx_buffer->page_offset += truesize;
 #endif
 }
@@ -2291,6 +2301,11 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 
 	xdp.rxq = &rx_ring->xdp_rxq;
 
+	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
+#if (PAGE_SIZE < 8192)
+	xdp.frame_sz = ixgbe_rx_frame_truesize(rx_ring, 0);
+#endif
+
 	while (likely(total_rx_packets < budget)) {
 		union ixgbe_adv_rx_desc *rx_desc;
 		struct ixgbe_rx_buffer *rx_buffer;
@@ -2324,7 +2339,10 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 			xdp.data_hard_start = xdp.data -
 					      ixgbe_rx_offset(rx_ring);
 			xdp.data_end = xdp.data + size;
-
+#if (PAGE_SIZE > 4096)
+			/* At larger PAGE_SIZE, frame_sz depend on len size */
+			xdp.frame_sz = ixgbe_rx_frame_truesize(rx_ring, size);
+#endif
 			skb = ixgbe_run_xdp(adapter, rx_ring, &xdp);
 		}
 


