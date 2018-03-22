From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu, 22 Mar 2018 16:14:33 +0100
Subject: [Intel-wired-lan] [PATCH v3 1/2] i40e: tweak page counting for
 XDP_REDIRECT
Message-ID: <20180322151434.24338-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

This commit tweaks the page counting for XDP_REDIRECT to function
properly. XDP_REDIRECT support will be added in a future commit.

The current page counting scheme assumes that the reference count
cannot decrease until the received frame is sent to the upper layers
of the networking stack. This assumption does not hold for the
XDP_REDIRECT action, since a page (pointed out by xdp_buff) can have
its reference count decreased via the xdp_do_redirect call.

To work around that, we now start off by a large page count and then
don't allow a refcount less than two.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index e8eef9a56b6b..2f817d1466eb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1588,9 +1588,8 @@ static bool i40e_alloc_mapped_page(struct i40e_ring *rx_ring,
 	bi->dma = dma;
 	bi->page = page;
 	bi->page_offset = i40e_rx_offset(rx_ring);
-
-	/* initialize pagecnt_bias to 1 representing we fully own page */
-	bi->pagecnt_bias = 1;
+	page_ref_add(page, USHRT_MAX - 1);
+	bi->pagecnt_bias = USHRT_MAX;
 
 	return true;
 }
@@ -1956,8 +1955,8 @@ static bool i40e_can_reuse_rx_page(struct i40e_rx_buffer *rx_buffer)
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

