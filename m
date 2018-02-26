From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 26 Feb 2018 13:37:44 -0800
Subject: [Intel-wired-lan] [RFC PATCH 4/5] ixgbevf: Add support for meta data
In-Reply-To: <20180226213745.14508-1-anthony.l.nguyen@intel.com>
References: <20180226213745.14508-1-anthony.l.nguyen@intel.com>
Message-ID: <20180226213745.14508-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add support for XDP meta data when using build skb.

Based on commit 366a88fe2f40 ("bpf, ixgbe: add meta data support")

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 29 +++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index ca6c11bae66c..448a1d59a09a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -889,6 +889,20 @@ struct sk_buff *ixgbevf_construct_skb(struct ixgbevf_ring *rx_ring,
 #if L1_CACHE_BYTES < 128
 	prefetch(xdp->data + L1_CACHE_BYTES);
 #endif
+	/* Note, we get here by enabling legacy-rx via:
+	 *
+	 *    ethtool --set-priv-flags <dev> legacy-rx on
+	 *
+	 * In this mode, we currently get 0 extra XDP headroom as
+	 * opposed to having legacy-rx off, where we process XDP
+	 * packets going to stack via ixgbevf_build_skb().
+	 *
+	 * For ixgbevf_construct_skb() mode it means that the
+	 * xdp->data_meta will always point to xdp->data, since
+	 * the helper cannot expand the head. Should this ever
+	 * changed in future for legacy-rx mode on, then lets also
+	 * add xdp->data_meta handling here.
+	 */
 
 	/* allocate a skb to store the frags */
 	skb = napi_alloc_skb(&rx_ring->q_vector->napi, IXGBEVF_RX_HDR_SIZE);
@@ -936,6 +950,7 @@ static struct sk_buff *ixgbevf_build_skb(struct ixgbevf_ring *rx_ring,
 					 struct xdp_buff *xdp,
 					 union ixgbe_adv_rx_desc *rx_desc)
 {
+	unsigned int metasize = xdp->data - xdp->data_meta;
 #if (PAGE_SIZE < 8192)
 	unsigned int truesize = ixgbevf_rx_pg_size(rx_ring) / 2;
 #else
@@ -945,10 +960,14 @@ static struct sk_buff *ixgbevf_build_skb(struct ixgbevf_ring *rx_ring,
 #endif
 	struct sk_buff *skb;
 
-	/* prefetch first cache line of first page */
-	prefetch(xdp->data);
+	/* Prefetch first cache line of first page. If xdp->data_meta
+	 * is unused, this points to xdp->data, otherwise, we likely
+	 * have a consumer accessing first few bytes of meta data,
+	 * and then actual data.
+	 */
+	prefetch(xdp->data_meta);
 #if L1_CACHE_BYTES < 128
-	prefetch(xdp->data + L1_CACHE_BYTES);
+	prefetch(xdp->data_meta + L1_CACHE_BYTES);
 #endif
 
 	/* build an skb around the page buffer */
@@ -959,6 +978,8 @@ static struct sk_buff *ixgbevf_build_skb(struct ixgbevf_ring *rx_ring,
 	/* update pointers within the skb to store the data */
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	__skb_put(skb, xdp->data_end - xdp->data);
+	if (metasize)
+		skb_metadata_set(skb, metasize);
 
 	/* update buffer offset */
 #if (PAGE_SIZE < 8192)
@@ -1126,7 +1147,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		if (!skb) {
 			xdp.data = page_address(rx_buffer->page) +
 				   rx_buffer->page_offset;
-			xdp_set_data_meta_invalid(&xdp);
+			xdp.data_meta = xdp.data;
 			xdp.data_hard_start = xdp.data -
 					      ixgbevf_rx_offset(rx_ring);
 			xdp.data_end = xdp.data + size;
-- 
2.13.6

