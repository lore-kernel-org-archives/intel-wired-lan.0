From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu, 22 Mar 2018 10:02:36 +0100
Subject: [Intel-wired-lan] [PATCH] ixgbe: tweak page counting for
 XDP_REDIRECT
Message-ID: <20180322090236.14357-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

The current page counting scheme assumes that the reference count
cannot decrease until the received frame is sent to the upper layers
of the networking stack. This assumption does not hold for the
XDP_REDIRECT action, since a page (pointed out by xdp_buff) can have
its reference count decreased via the xdp_do_redirect call.

To work around that, we now start off by a large page count and then
don't allow a refcount less than two.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index fb80edbd2739..8dbb2ce06287 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1629,7 +1629,8 @@ static bool ixgbe_alloc_mapped_page(struct ixgbe_ring *rx_ring,
 	bi->dma = dma;
 	bi->page = page;
 	bi->page_offset = ixgbe_rx_offset(rx_ring);
-	bi->pagecnt_bias = 1;
+	page_ref_add(page, USHRT_MAX - 1);
+	bi->pagecnt_bias = USHRT_MAX;
 	rx_ring->rx_stats.alloc_rx_page++;
 
 	return true;
@@ -2039,8 +2040,8 @@ static bool ixgbe_can_reuse_rx_page(struct ixgbe_rx_buffer *rx_buffer)
 	 * the pagecnt_bias and page count so that we fully restock the
 	 * number of references the driver holds.
 	 */
-	if (unlikely(!pagecnt_bias)) {
-		page_ref_add(page, USHRT_MAX);
+	if (unlikely(pagecnt_bias == 1)) {
+		page_ref_add(page, USHRT_MAX - 1);
 		rx_buffer->pagecnt_bias = USHRT_MAX;
 	}
 
-- 
2.7.4

