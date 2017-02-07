From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 06 Feb 2017 18:26:40 -0800
Subject: [Intel-wired-lan] [next PATCH v5 07/12] igb: Use page_address
 offset from page instead of masking virtual address
In-Reply-To: <20170207022339.9864.87863.stgit@localhost.localdomain>
References: <20170207022339.9864.87863.stgit@localhost.localdomain>
Message-ID: <20170207022632.9864.8422.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Update the handling of page addresses so that we always refer to them using
a void pointer, and try to use the consistent name of va indicating we are
working with a virtual address.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
v4: Split this code out of patch 6 of the original series.

 drivers/net/ethernet/intel/igb/igb.h      |    2 +-
 drivers/net/ethernet/intel/igb/igb_main.c |   11 +++++------
 drivers/net/ethernet/intel/igb/igb_ptp.c  |    3 +--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index a74928cc0e58..6a88a08c021c 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -614,7 +614,7 @@ enum igb_boards {
 void igb_ptp_suspend(struct igb_adapter *adapter);
 void igb_ptp_rx_hang(struct igb_adapter *adapter);
 void igb_ptp_rx_rgtstamp(struct igb_q_vector *q_vector, struct sk_buff *skb);
-void igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, unsigned char *va,
+void igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
 			 struct sk_buff *skb);
 int igb_ptp_set_ts_config(struct net_device *netdev, struct ifreq *ifr);
 int igb_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 0820fded7331..c5cb93ebc633 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6929,7 +6929,7 @@ static bool igb_add_rx_frag(struct igb_ring *rx_ring,
 			    struct sk_buff *skb)
 {
 	struct page *page = rx_buffer->page;
-	unsigned char *va = page_address(page) + rx_buffer->page_offset;
+	void *va = page_address(page) + rx_buffer->page_offset;
 #if (PAGE_SIZE < 8192)
 	unsigned int truesize = IGB_RX_BUFSZ;
 #else
@@ -6971,7 +6971,7 @@ static bool igb_add_rx_frag(struct igb_ring *rx_ring,
 
 add_tail_frag:
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
-			(unsigned long)va & ~PAGE_MASK, size, truesize);
+			va - page_address(page), size, truesize);
 
 	return igb_can_reuse_rx_page(rx_buffer, page, truesize);
 }
@@ -6996,13 +6996,12 @@ static struct sk_buff *igb_fetch_rx_buffer(struct igb_ring *rx_ring,
 				      DMA_FROM_DEVICE);
 
 	if (likely(!skb)) {
-		void *page_addr = page_address(page) +
-				  rx_buffer->page_offset;
+		void *va = page_address(page) + rx_buffer->page_offset;
 
 		/* prefetch first cache line of first page */
-		prefetch(page_addr);
+		prefetch(va);
 #if L1_CACHE_BYTES < 128
-		prefetch(page_addr + L1_CACHE_BYTES);
+		prefetch(va + L1_CACHE_BYTES);
 #endif
 
 		/* allocate a skb to store the frags */
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index c4477552ce9e..7a3fd4d74592 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -764,8 +764,7 @@ static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
  * incoming frame.  The value is stored in little endian format starting on
  * byte 8.
  **/
-void igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector,
-			 unsigned char *va,
+void igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
 			 struct sk_buff *skb)
 {
 	__le64 *regval = (__le64 *)va;

