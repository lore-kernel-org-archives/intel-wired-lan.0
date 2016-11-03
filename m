From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  3 Nov 2016 16:09:41 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: Limit dma sync of RX buffers to
	actual packet size
Message-ID: <20161103230941.27152-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Peterson, Scott D" <scott.d.peterson@intel.com>

On packet RX, we perform a dma sync for cpu before passing the
packet up.  Here we limit that sync to the actual length of the
incoming packet, rather than always syncing the entire buffer.

Testing Hints:
Verify traffic is still passed correctly with the same or better
performance as before this patch

Signed-off-by: Scott Peterson <scott.d.peterson@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 509514d3ce6c..8f90c6db53ff 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -251,6 +251,7 @@ static bool fm10k_can_reuse_rx_page(struct fm10k_rx_buffer *rx_buffer,
 /**
  * fm10k_add_rx_frag - Add contents of Rx buffer to sk_buff
  * @rx_buffer: buffer containing page to add
+ * @size: packet size from rx_desc
  * @rx_desc: descriptor containing length of buffer written by hardware
  * @skb: sk_buff to place the data into
  *
@@ -263,12 +264,12 @@ static bool fm10k_can_reuse_rx_page(struct fm10k_rx_buffer *rx_buffer,
  * true if the buffer can be reused by the interface.
  **/
 static bool fm10k_add_rx_frag(struct fm10k_rx_buffer *rx_buffer,
+			      unsigned int size,
 			      union fm10k_rx_desc *rx_desc,
 			      struct sk_buff *skb)
 {
 	struct page *page = rx_buffer->page;
 	unsigned char *va = page_address(page) + rx_buffer->page_offset;
-	unsigned int size = le16_to_cpu(rx_desc->w.length);
 #if (PAGE_SIZE < 8192)
 	unsigned int truesize = FM10K_RX_BUFSZ;
 #else
@@ -314,6 +315,7 @@ static struct sk_buff *fm10k_fetch_rx_buffer(struct fm10k_ring *rx_ring,
 					     union fm10k_rx_desc *rx_desc,
 					     struct sk_buff *skb)
 {
+	unsigned int size = le16_to_cpu(rx_desc->w.length);
 	struct fm10k_rx_buffer *rx_buffer;
 	struct page *page;
 
@@ -350,11 +352,11 @@ static struct sk_buff *fm10k_fetch_rx_buffer(struct fm10k_ring *rx_ring,
 	dma_sync_single_range_for_cpu(rx_ring->dev,
 				      rx_buffer->dma,
 				      rx_buffer->page_offset,
-				      FM10K_RX_BUFSZ,
+				      size,
 				      DMA_FROM_DEVICE);
 
 	/* pull page into skb */
-	if (fm10k_add_rx_frag(rx_buffer, rx_desc, skb)) {
+	if (fm10k_add_rx_frag(rx_buffer, size, rx_desc, skb)) {
 		/* hand second half of page back to the ring */
 		fm10k_reuse_rx_page(rx_ring, rx_buffer);
 	} else {
-- 
2.10.1.777.gd068e6b

