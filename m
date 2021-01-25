From: Alexander Lobakin <alobakin@pm.me>
Date: Mon, 25 Jan 2021 16:47:08 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/3] net: constify
 page_is_pfmemalloc() argument at call sites
In-Reply-To: <20210125164612.243838-1-alobakin@pm.me>
References: <20210125164612.243838-1-alobakin@pm.me>
Message-ID: <20210125164612.243838-3-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Constify "page" argument for page_is_pfmemalloc() users where applicable.

Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c   | 2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c     | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c       | 2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c         | 2 +-
 drivers/net/ethernet/intel/igb/igb_main.c         | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c         | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   | 2 +-
 include/linux/skbuff.h                            | 4 ++--
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 512080640cbc..0f8e962b5010 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2800,7 +2800,7 @@ static void hns3_nic_alloc_rx_buffers(struct hns3_enet_ring *ring,
 	writel(i, ring->tqp->io_base + HNS3_RING_RX_RING_HEAD_REG);
 }
 
-static bool hns3_page_is_reusable(struct page *page)
+static bool hns3_page_is_reusable(const struct page *page)
 {
 	return page_to_nid(page) == numa_mem_id() &&
 		!page_is_pfmemalloc(page);
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 99b8252eb969..32fcb7a51b5d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -194,7 +194,7 @@ static void fm10k_reuse_rx_page(struct fm10k_ring *rx_ring,
 					 DMA_FROM_DEVICE);
 }
 
-static inline bool fm10k_page_is_reserved(struct page *page)
+static inline bool fm10k_page_is_reserved(const struct page *page)
 {
 	return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 2574e78f7597..3886cddfd856 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1850,7 +1850,7 @@ static bool i40e_cleanup_headers(struct i40e_ring *rx_ring, struct sk_buff *skb,
  * A page is not reusable if it was allocated under low memory
  * conditions, or it's not in the same NUMA node as this CPU.
  */
-static inline bool i40e_page_is_reusable(struct page *page)
+static inline bool i40e_page_is_reusable(const struct page *page)
 {
 	return (page_to_nid(page) == numa_mem_id()) &&
 		!page_is_pfmemalloc(page);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 256fa07d54d5..d9ba8433c911 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1148,7 +1148,7 @@ static void iavf_reuse_rx_page(struct iavf_ring *rx_ring,
  * A page is not reusable if it was allocated under low memory
  * conditions, or it's not in the same NUMA node as this CPU.
  */
-static inline bool iavf_page_is_reusable(struct page *page)
+static inline bool iavf_page_is_reusable(const struct page *page)
 {
 	return (page_to_nid(page) == numa_mem_id()) &&
 		!page_is_pfmemalloc(page);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 422f53997c02..ecbf94cb11ea 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -732,7 +732,7 @@ bool ice_alloc_rx_bufs(struct ice_ring *rx_ring, u16 cleaned_count)
  * ice_page_is_reserved - check if reuse is possible
  * @page: page struct to check
  */
-static bool ice_page_is_reserved(struct page *page)
+static bool ice_page_is_reserved(const struct page *page)
 {
 	return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
 }
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 84d4284b8b32..5e1aa7d04bf7 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8215,7 +8215,7 @@ static void igb_reuse_rx_page(struct igb_ring *rx_ring,
 	new_buff->pagecnt_bias	= old_buff->pagecnt_bias;
 }
 
-static inline bool igb_page_is_reserved(struct page *page)
+static inline bool igb_page_is_reserved(const struct page *page)
 {
 	return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
 }
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 43aec42e6d9d..2939a3a4fa00 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1648,7 +1648,7 @@ static void igc_reuse_rx_page(struct igc_ring *rx_ring,
 	new_buff->pagecnt_bias	= old_buff->pagecnt_bias;
 }
 
-static inline bool igc_page_is_reserved(struct page *page)
+static inline bool igc_page_is_reserved(const struct page *page)
 {
 	return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index e08c01525fd2..e2cd995512b1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1940,7 +1940,7 @@ static void ixgbe_reuse_rx_page(struct ixgbe_ring *rx_ring,
 	new_buff->pagecnt_bias	= old_buff->pagecnt_bias;
 }
 
-static inline bool ixgbe_page_is_reserved(struct page *page)
+static inline bool ixgbe_page_is_reserved(const struct page *page)
 {
 	return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
 }
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index a14e55e7fce8..b4fb6bee1bb0 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -781,7 +781,7 @@ static void ixgbevf_reuse_rx_page(struct ixgbevf_ring *rx_ring,
 	new_buff->pagecnt_bias = old_buff->pagecnt_bias;
 }
 
-static inline bool ixgbevf_page_is_reserved(struct page *page)
+static inline bool ixgbevf_page_is_reserved(const struct page *page)
 {
 	return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index dec93d57542f..9fff677026b7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -212,7 +212,7 @@ static inline u32 mlx5e_decompress_cqes_start(struct mlx5e_rq *rq,
 	return mlx5e_decompress_cqes_cont(rq, wq, 1, budget_rem) - 1;
 }
 
-static inline bool mlx5e_page_is_reserved(struct page *page)
+static inline bool mlx5e_page_is_reserved(const struct page *page)
 {
 	return page_is_pfmemalloc(page) || page_to_nid(page) != numa_mem_id();
 }
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9313b5aaf45b..b027526da4f9 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2943,8 +2943,8 @@ static inline struct page *dev_alloc_page(void)
  *	@page: The page that was allocated from skb_alloc_page
  *	@skb: The skb that may need pfmemalloc set
  */
-static inline void skb_propagate_pfmemalloc(struct page *page,
-					     struct sk_buff *skb)
+static inline void skb_propagate_pfmemalloc(const struct page *page,
+					    struct sk_buff *skb)
 {
 	if (page_is_pfmemalloc(page))
 		skb->pfmemalloc = true;
-- 
2.30.0


