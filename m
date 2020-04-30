From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Thu, 30 Apr 2020 13:22:33 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2 26/33] ice: add XDP frame size
 to driver
In-Reply-To: <158824557985.2172139.4173570969543904434.stgit@firesoul>
References: <158824557985.2172139.4173570969543904434.stgit@firesoul>
Message-ID: <158824575360.2172139.9184468386375447546.stgit@firesoul>
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
 drivers/net/ethernet/intel/ice/ice_txrx.c |   34 +++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index f67e8362958c..69b21b436f9a 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -423,6 +423,22 @@ static unsigned int ice_rx_offset(struct ice_ring *rx_ring)
 	return 0;
 }
 
+static unsigned int ice_rx_frame_truesize(struct ice_ring *rx_ring,
+					  unsigned int size)
+{
+	unsigned int truesize;
+
+#if (PAGE_SIZE < 8192)
+	truesize = ice_rx_pg_size(rx_ring) / 2; /* Must be power-of-2 */
+#else
+	truesize = ice_rx_offset(rx_ring) ?
+		SKB_DATA_ALIGN(ice_rx_offset(rx_ring) + size) +
+		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
+		SKB_DATA_ALIGN(size);
+#endif
+	return truesize;
+}
+
 /**
  * ice_run_xdp - Executes an XDP program on initialized xdp_buff
  * @rx_ring: Rx ring
@@ -991,6 +1007,10 @@ static int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 	bool failure;
 
 	xdp.rxq = &rx_ring->xdp_rxq;
+	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
+#if (PAGE_SIZE < 8192)
+	xdp.frame_sz = ice_rx_frame_truesize(rx_ring, 0);
+#endif
 
 	/* start the loop to process Rx packets bounded by 'budget' */
 	while (likely(total_rx_pkts < (unsigned int)budget)) {
@@ -1038,6 +1058,10 @@ static int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 		xdp.data_hard_start = xdp.data - ice_rx_offset(rx_ring);
 		xdp.data_meta = xdp.data;
 		xdp.data_end = xdp.data + size;
+#if (PAGE_SIZE > 4096)
+		/* At larger PAGE_SIZE, frame_sz depend on len size */
+		xdp.frame_sz = ice_rx_frame_truesize(rx_ring, size);
+#endif
 
 		rcu_read_lock();
 		xdp_prog = READ_ONCE(rx_ring->xdp_prog);
@@ -1051,16 +1075,8 @@ static int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 		if (!xdp_res)
 			goto construct_skb;
 		if (xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR)) {
-			unsigned int truesize;
-
-#if (PAGE_SIZE < 8192)
-			truesize = ice_rx_pg_size(rx_ring) / 2;
-#else
-			truesize = SKB_DATA_ALIGN(ice_rx_offset(rx_ring) +
-						  size);
-#endif
 			xdp_xmit |= xdp_res;
-			ice_rx_buf_adjust_pg_offset(rx_buf, truesize);
+			ice_rx_buf_adjust_pg_offset(rx_buf, xdp.frame_sz);
 		} else {
 			rx_buf->pagecnt_bias++;
 		}


