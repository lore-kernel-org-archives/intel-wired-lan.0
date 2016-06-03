From: Andrew Lunn <andrew@lunn.ch>
Date: Fri,  3 Jun 2016 19:45:32 +0200
Subject: [Intel-wired-lan] [PATCH] net: igb: Only dma sync frame length
Message-ID: <1464975932-13301-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On some platforms, syncing a buffer for DMA is expensive. Rather than
sync the whole 2K receive buffer, only synchronise the length of the
frame, which will typically be the MTU, or a much smaller TCP ACK.

For an IMX6Q, this gives around 6% increased TCP receive performance,
which is cache operations bound and reduces CPU load for TCP transmit.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 0a289dda604a..670e3d612283 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6915,6 +6915,7 @@ static struct sk_buff *igb_fetch_rx_buffer(struct igb_ring *rx_ring,
 {
 	struct igb_rx_buffer *rx_buffer;
 	struct page *page;
+	unsigned int size = le16_to_cpu(rx_desc->wb.upper.length);
 
 	rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
 	page = rx_buffer->page;
@@ -6948,7 +6949,7 @@ static struct sk_buff *igb_fetch_rx_buffer(struct igb_ring *rx_ring,
 	dma_sync_single_range_for_cpu(rx_ring->dev,
 				      rx_buffer->dma,
 				      rx_buffer->page_offset,
-				      IGB_RX_BUFSZ,
+				      size,
 				      DMA_FROM_DEVICE);
 
 	/* pull page into skb */
-- 
2.8.1

