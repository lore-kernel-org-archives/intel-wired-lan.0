From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Wed, 08 Apr 2020 13:52:41 +0200
Subject: [Intel-wired-lan] [PATCH RFC v2 25/33] ixgbevf: add XDP frame size
 to VF driver
In-Reply-To: <158634658714.707275.7903484085370879864.stgit@firesoul>
References: <158634658714.707275.7903484085370879864.stgit@firesoul>
Message-ID: <158634676136.707275.10117427327810984951.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch mirrors the changes to ixgbe in previous patch.

This VF driver doesn't support XDP_REDIRECT, but correct tailroom is
still necessary for BPF-helper xdp_adjust_tail.  In legacy-mode +
larger PAGE_SIZE, due to lacking tailroom, we accept that
xdp_adjust_tail shrink doesn't work.

Cc: intel-wired-lan at lists.osuosl.org
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   34 +++++++++++++++++----
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 4622c4ea2e46..62bc3e3b5b9c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1095,19 +1095,31 @@ static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
 	return ERR_PTR(-result);
 }
 
+static unsigned int ixgbevf_rx_frame_truesize(struct ixgbevf_ring *rx_ring,
+					      unsigned int size)
+{
+	unsigned int truesize;
+
+#if (PAGE_SIZE < 8192)
+	truesize = ixgbevf_rx_pg_size(rx_ring) / 2; /* Must be power-of-2 */
+#else
+	truesize = ring_uses_build_skb(rx_ring) ?
+		SKB_DATA_ALIGN(IXGBEVF_SKB_PAD + size) +
+		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
+		SKB_DATA_ALIGN(size);
+#endif
+       return truesize;
+}
+
 static void ixgbevf_rx_buffer_flip(struct ixgbevf_ring *rx_ring,
 				   struct ixgbevf_rx_buffer *rx_buffer,
 				   unsigned int size)
 {
-#if (PAGE_SIZE < 8192)
-	unsigned int truesize = ixgbevf_rx_pg_size(rx_ring) / 2;
+	unsigned int truesize = ixgbevf_rx_frame_truesize(rx_ring, size);
 
+#if (PAGE_SIZE < 8192)
 	rx_buffer->page_offset ^= truesize;
 #else
-	unsigned int truesize = ring_uses_build_skb(rx_ring) ?
-				SKB_DATA_ALIGN(IXGBEVF_SKB_PAD + size) :
-				SKB_DATA_ALIGN(size);
-
 	rx_buffer->page_offset += truesize;
 #endif
 }
@@ -1125,6 +1137,11 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 
 	xdp.rxq = &rx_ring->xdp_rxq;
 
+	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
+#if (PAGE_SIZE < 8192)
+	xdp.frame_sz = ixgbevf_rx_frame_truesize(rx_ring, 0);
+#endif
+
 	while (likely(total_rx_packets < budget)) {
 		struct ixgbevf_rx_buffer *rx_buffer;
 		union ixgbe_adv_rx_desc *rx_desc;
@@ -1157,7 +1174,10 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 			xdp.data_hard_start = xdp.data -
 					      ixgbevf_rx_offset(rx_ring);
 			xdp.data_end = xdp.data + size;
-
+#if (PAGE_SIZE > 4096)
+			/* At larger PAGE_SIZE, frame_sz depend on len size */
+			xdp.frame_sz = ixgbevf_rx_frame_truesize(rx_ring, size);
+#endif
 			skb = ixgbevf_run_xdp(adapter, rx_ring, &xdp);
 		}
 


