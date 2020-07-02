From: Li RongQing <lirongqing@baidu.com>
Date: Thu,  2 Jul 2020 14:38:05 +0800
Subject: [Intel-wired-lan] [PATCH][net-next] i40e: prefetch struct page of
 rx buffer conditionally
Message-ID: <1593671885-30822-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

page_address() accesses struct page only when WANT_PAGE_VIRTUAL
or HASHED_PAGE_VIRTUAL is defined, otherwise it returns address
based on offset, so we prefetch it conditionally

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index f9555c847f73..b3836092c327 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1953,7 +1953,9 @@ static struct i40e_rx_buffer *i40e_get_rx_buffer(struct i40e_ring *rx_ring,
 	struct i40e_rx_buffer *rx_buffer;
 
 	rx_buffer = i40e_rx_bi(rx_ring, rx_ring->next_to_clean);
+#if defined(WANT_PAGE_VIRTUAL) || defined(HASHED_PAGE_VIRTUAL)
 	prefetchw(rx_buffer->page);
+#endif
 
 	/* we are reusing so sync this buffer for CPU use */
 	dma_sync_single_range_for_cpu(rx_ring->dev,
-- 
2.16.2

