From: Zekun Shen <bruceshenzk@gmail.com>
Date: Fri,  3 Jul 2020 14:20:09 -0400
Subject: [Intel-wired-lan] [PATCH] net: fm10k: check size from dma region
Message-ID: <20200703182010.1867-1-bruceshenzk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Size is read from a dma region as input from device. Add sanity
check of size before calling dma_sync_single_range_for_cpu
with it.

This would prevent DMA-API warning: device driver tries to sync DMA
memory it has not allocated.

Signed-off-by: Zekun Shen <bruceshenzk@gmail.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 17738b0a9..e020b346b 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -304,6 +304,11 @@ static struct sk_buff *fm10k_fetch_rx_buffer(struct fm10k_ring *rx_ring,
 	struct fm10k_rx_buffer *rx_buffer;
 	struct page *page;
 
+	if (unlikely(size > PAGE_SIZE)) {
+		dev_err(rx_ring->dev, "size %d exceeds PAGE_SIZE\n", size);
+		return NULL;
+	}
+
 	rx_buffer = &rx_ring->rx_buffer[rx_ring->next_to_clean];
 	page = rx_buffer->page;
 	prefetchw(page);
-- 
2.17.1

