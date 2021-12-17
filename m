From: Joe Damato <jdamato@fastly.com>
Date: Fri, 17 Dec 2021 11:35:19 -0800
Subject: [Intel-wired-lan] [net-queue, v2,
 5/5] i40e: Add a stat for tracking busy rx pages.
In-Reply-To: <1639769719-81285-1-git-send-email-jdamato@fastly.com>
References: <1639769719-81285-1-git-send-email-jdamato@fastly.com>
Message-ID: <1639769719-81285-6-git-send-email-jdamato@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In some cases, pages cannot be reused by i40e because the page is busy. Add
a counter for this event.

Busy page count is accessible via ethtool.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  5 ++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 12 ++++++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    |  1 +
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 3774e7b..b50530e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -856,6 +856,7 @@ struct i40e_vsi {
 	u64 rx_page_reuse;
 	u64 rx_page_alloc;
 	u64 rx_page_waive;
+	u64 rx_page_busy;
 
 	/* These are containers of ring pointers, allocated at run-time */
 	struct i40e_ring **rx_rings;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 224fe6d..64fd869 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -298,6 +298,7 @@ static const struct i40e_stats i40e_gstrings_misc_stats[] = {
 	I40E_VSI_STAT("rx_cache_reuse", rx_page_reuse),
 	I40E_VSI_STAT("rx_cache_alloc", rx_page_alloc),
 	I40E_VSI_STAT("rx_cache_waive", rx_page_waive),
+	I40E_VSI_STAT("rx_cache_busy", rx_page_busy),
 };
 
 /* These PF_STATs might look like duplicates of some NETDEV_STATs,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7a25488..180650f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -812,7 +812,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	struct i40e_eth_stats *es;     /* device's eth stats */
 	u64 tx_restart, tx_busy;
 	struct i40e_ring *p;
-	u64 rx_page, rx_buf, rx_reuse, rx_alloc, rx_waive;
+	u64 rx_page, rx_buf, rx_reuse, rx_alloc, rx_waive, rx_busy;
 	u64 bytes, packets;
 	unsigned int start;
 	u64 tx_linearize;
@@ -841,6 +841,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	rx_reuse = 0;
 	rx_alloc = 0;
 	rx_waive = 0;
+	rx_busy = 0;
 	rcu_read_lock();
 	for (q = 0; q < vsi->num_queue_pairs; q++) {
 		/* locate Tx ring */
@@ -877,6 +878,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 		rx_reuse += p->rx_stats.page_reuse_count;
 		rx_alloc += p->rx_stats.page_alloc_count;
 		rx_waive += p->rx_stats.page_waive_count;
+		rx_busy += p->rx_stats.page_busy_count;
 
 		if (i40e_enabled_xdp_vsi(vsi)) {
 			/* locate XDP ring */
@@ -907,6 +909,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	vsi->rx_page_reuse = rx_reuse;
 	vsi->rx_page_alloc = rx_alloc;
 	vsi->rx_page_waive = rx_waive;
+	vsi->rx_page_busy = rx_busy;
 
 	ns->rx_packets = rx_p;
 	ns->rx_bytes = rx_b;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 1e2ad48..692a727 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1990,8 +1990,8 @@ static bool i40e_cleanup_headers(struct i40e_ring *rx_ring, struct sk_buff *skb,
  * pointing to; otherwise, the DMA mapping needs to be destroyed and
  * page freed.
  *
- * rx_stats will be updated to indicate if the page was waived because it was
- * not reusable.
+ * rx_stats will be updated to indicate whether the page was waived
+ * or busy if it could not be reused.
  */
 static bool i40e_can_reuse_rx_page(struct i40e_rx_buffer *rx_buffer,
 				   struct i40e_rx_queue_stats *rx_stats,
@@ -2008,13 +2008,17 @@ static bool i40e_can_reuse_rx_page(struct i40e_rx_buffer *rx_buffer,
 
 #if (PAGE_SIZE < 8192)
 	/* if we are only owner of page we can reuse it */
-	if (unlikely((rx_buffer_pgcnt - pagecnt_bias) > 1))
+	if (unlikely((rx_buffer_pgcnt - pagecnt_bias) > 1)) {
+		rx_stats->page_busy_count++;
 		return false;
+	}
 #else
 #define I40E_LAST_OFFSET \
 	(SKB_WITH_OVERHEAD(PAGE_SIZE) - I40E_RXBUFFER_2048)
-	if (rx_buffer->page_offset > I40E_LAST_OFFSET)
+	if (rx_buffer->page_offset > I40E_LAST_OFFSET) {
+		rx_stats->page_busy_count++;
 		return false;
+	}
 #endif
 
 	/* If we have drained the page fragment pool we need to update
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index e049cf48..fd22e2f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -301,6 +301,7 @@ struct i40e_rx_queue_stats {
 	u64 realloc_count;
 	u64 page_alloc_count;
 	u64 page_waive_count;
+	u64 page_busy_count;
 };
 
 enum i40e_ring_state_t {
-- 
2.7.4

