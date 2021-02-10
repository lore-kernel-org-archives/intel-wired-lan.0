From: Vedang Patel <vedang.patel@intel.com>
Date: Wed, 10 Feb 2021 13:58:43 -0800
Subject: [Intel-wired-lan] [PATCH net-next v6 4/9] igc: Introduce
 igc_get_rx_frame_truesize() helper
In-Reply-To: <20210210215848.24514-1-vedang.patel@intel.com>
References: <20210210215848.24514-1-vedang.patel@intel.com>
Message-ID: <20210210215848.24514-5-vedang.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Andre Guedes <andre.guedes@intel.com>

The RX frame truesize calculation is scattered throughout the RX code.
This patch creates the helper function igc_get_rx_frame_truesize() and
uses it where applicable.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 29 ++++++++++++++---------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1157a24f6d26..d1fc5baadf9b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1510,6 +1510,22 @@ static void igc_rx_buffer_flip(struct igc_rx_buffer *buffer,
 #endif
 }
 
+static unsigned int igc_get_rx_frame_truesize(struct igc_ring *ring,
+					      unsigned int size)
+{
+	unsigned int truesize;
+
+#if (PAGE_SIZE < 8192)
+	truesize = igc_rx_pg_size(ring) / 2;
+#else
+	truesize = ring_uses_build_skb(ring) ?
+		   SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
+		   SKB_DATA_ALIGN(IGC_SKB_PAD + size) :
+		   SKB_DATA_ALIGN(size);
+#endif
+	return truesize;
+}
+
 /**
  * igc_add_rx_frag - Add contents of Rx buffer to sk_buff
  * @rx_ring: rx descriptor ring to transact packets on
@@ -1545,12 +1561,7 @@ static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
 				     unsigned int size)
 {
 	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
-#if (PAGE_SIZE < 8192)
-	unsigned int truesize = igc_rx_pg_size(rx_ring) / 2;
-#else
-	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
-				SKB_DATA_ALIGN(IGC_SKB_PAD + size);
-#endif
+	unsigned int truesize = igc_get_rx_frame_truesize(rx_ring, size);
 	struct sk_buff *skb;
 
 	/* prefetch first cache line of first page */
@@ -1575,11 +1586,7 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
 					 unsigned int size)
 {
 	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
-#if (PAGE_SIZE < 8192)
-	unsigned int truesize = igc_rx_pg_size(rx_ring) / 2;
-#else
-	unsigned int truesize = SKB_DATA_ALIGN(size);
-#endif
+	unsigned int truesize = igc_get_rx_frame_truesize(rx_ring, size);
 	unsigned int headlen;
 	struct sk_buff *skb;
 
-- 
2.17.1

