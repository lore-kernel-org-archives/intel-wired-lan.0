From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 11 Dec 2017 10:37:15 -0800
Subject: [Intel-wired-lan] [PATCH 6/9] ixgbevf: add counters for Rx page
 allocations
In-Reply-To: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
Message-ID: <20171211183715.21524.56950.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We already had placehloders for failed page and buffer allocations.
Added alloc_rx_page and made sure the stats are properly updated and
exposed in ethtool.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ethtool.c      |    3 +++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |    6 ++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   23 ++++++++++++++++-----
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index ff9d05f..4400e49 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -75,6 +75,9 @@ struct ixgbe_stats {
 	IXGBEVF_STAT("tx_timeout_count", tx_timeout_count),
 	IXGBEVF_NETDEV_STAT(multicast),
 	IXGBEVF_STAT("rx_csum_offload_errors", hw_csum_rx_error),
+	IXGBEVF_STAT("alloc_rx_page", alloc_rx_page),
+	IXGBEVF_STAT("alloc_rx_page_failed", alloc_rx_page_failed),
+	IXGBEVF_STAT("alloc_rx_buff_failed", alloc_rx_buff_failed),
 };
 
 #define IXGBEVF_QUEUE_STATS_LEN ( \
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index c70a789..f695242 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -84,6 +84,7 @@ struct ixgbevf_tx_queue_stats {
 struct ixgbevf_rx_queue_stats {
 	u64 alloc_rx_page_failed;
 	u64 alloc_rx_buff_failed;
+	u64 alloc_rx_page;
 	u64 csum_err;
 };
 
@@ -295,8 +296,9 @@ struct ixgbevf_adapter {
 	u64 hw_csum_rx_error;
 	u64 hw_rx_no_dma_resources;
 	int num_msix_vectors;
-	u32 alloc_rx_page_failed;
-	u32 alloc_rx_buff_failed;
+	u64 alloc_rx_page_failed;
+	u64 alloc_rx_buff_failed;
+	u64 alloc_rx_page;
 
 	struct msix_entry *msix_entries;
 
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index ae2402d..350afec 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -604,7 +604,7 @@ static bool ixgbevf_alloc_mapped_page(struct ixgbevf_ring *rx_ring,
 	if (dma_mapping_error(rx_ring->dev, dma)) {
 		__free_page(page);
 
-		rx_ring->rx_stats.alloc_rx_buff_failed++;
+		rx_ring->rx_stats.alloc_rx_page_failed++;
 		return false;
 	}
 
@@ -612,6 +612,7 @@ static bool ixgbevf_alloc_mapped_page(struct ixgbevf_ring *rx_ring,
 	bi->page = page;
 	bi->page_offset = 0;
 	bi->pagecnt_bias = 1;
+	rx_ring->rx_stats.alloc_rx_page++;
 
 	return true;
 }
@@ -963,8 +964,10 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		skb = ixgbevf_fetch_rx_buffer(rx_ring, rx_desc, skb);
 
 		/* exit if we failed to retrieve a buffer */
-		if (!skb)
+		if (!skb) {
+			rx_ring->rx_stats.alloc_rx_buff_failed++;
 			break;
+		}
 
 		cleaned_count++;
 
@@ -2749,6 +2752,8 @@ static int ixgbevf_sw_init(struct ixgbevf_adapter *adapter)
 void ixgbevf_update_stats(struct ixgbevf_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
+	u64 alloc_rx_page_failed = 0, alloc_rx_buff_failed = 0;
+	u64 alloc_rx_page = 0, hw_csum_rx_error = 0;
 	int i;
 
 	if (test_bit(__IXGBEVF_DOWN, &adapter->state) ||
@@ -2769,10 +2774,18 @@ void ixgbevf_update_stats(struct ixgbevf_adapter *adapter)
 				adapter->stats.vfmprc);
 
 	for (i = 0;  i  < adapter->num_rx_queues;  i++) {
-		adapter->hw_csum_rx_error +=
-			adapter->rx_ring[i]->hw_csum_rx_error;
-		adapter->rx_ring[i]->hw_csum_rx_error = 0;
+		struct ixgbevf_ring *rx_ring = adapter->rx_ring[i];
+
+		hw_csum_rx_error += rx_ring->rx_stats.csum_err;
+		alloc_rx_page_failed += rx_ring->rx_stats.alloc_rx_page_failed;
+		alloc_rx_buff_failed += rx_ring->rx_stats.alloc_rx_buff_failed;
+		alloc_rx_page += rx_ring->rx_stats.alloc_rx_page;
 	}
+
+	adapter->hw_csum_rx_error = hw_csum_rx_error;
+	adapter->alloc_rx_page_failed = alloc_rx_page_failed;
+	adapter->alloc_rx_buff_failed = alloc_rx_buff_failed;
+	adapter->alloc_rx_page = alloc_rx_page;
 }
 
 /**

