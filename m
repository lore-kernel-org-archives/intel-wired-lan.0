From: Joe Damato <jdamato@fastly.com>
Date: Fri, 17 Dec 2021 11:35:17 -0800
Subject: [Intel-wired-lan] [net-queue, v2,
 3/5] i40e: Add a stat tracking new RX page allocations.
In-Reply-To: <1639769719-81285-1-git-send-email-jdamato@fastly.com>
References: <1639769719-81285-1-git-send-email-jdamato@fastly.com>
Message-ID: <1639769719-81285-4-git-send-email-jdamato@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a counter for new page allocations in the i40e RX path. This stat is
accessible with ethtool.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 5 ++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 2 ++
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 1 +
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index b61f17bf..ab73de2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -854,6 +854,7 @@ struct i40e_vsi {
 	u64 rx_buf_failed;
 	u64 rx_page_failed;
 	u64 rx_page_reuse;
+	u64 rx_page_alloc;
 
 	/* These are containers of ring pointers, allocated at run-time */
 	struct i40e_ring **rx_rings;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index ceb0d5f..22f746b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -296,6 +296,7 @@ static const struct i40e_stats i40e_gstrings_misc_stats[] = {
 	I40E_VSI_STAT("rx_alloc_fail", rx_buf_failed),
 	I40E_VSI_STAT("rx_pg_alloc_fail", rx_page_failed),
 	I40E_VSI_STAT("rx_cache_reuse", rx_page_reuse),
+	I40E_VSI_STAT("rx_cache_alloc", rx_page_alloc),
 };
 
 /* These PF_STATs might look like duplicates of some NETDEV_STATs,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6d3b0bc..6688598 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -812,7 +812,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	struct i40e_eth_stats *es;     /* device's eth stats */
 	u64 tx_restart, tx_busy;
 	struct i40e_ring *p;
-	u64 rx_page, rx_buf, rx_reuse;
+	u64 rx_page, rx_buf, rx_reuse, rx_alloc;
 	u64 bytes, packets;
 	unsigned int start;
 	u64 tx_linearize;
@@ -839,6 +839,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	rx_page = 0;
 	rx_buf = 0;
 	rx_reuse = 0;
+	rx_alloc = 0;
 	rcu_read_lock();
 	for (q = 0; q < vsi->num_queue_pairs; q++) {
 		/* locate Tx ring */
@@ -873,6 +874,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 		rx_buf += p->rx_stats.alloc_buff_failed;
 		rx_page += p->rx_stats.alloc_page_failed;
 		rx_reuse += p->rx_stats.page_reuse_count;
+		rx_alloc += p->rx_stats.page_alloc_count;
 
 		if (i40e_enabled_xdp_vsi(vsi)) {
 			/* locate XDP ring */
@@ -901,6 +903,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	vsi->rx_page_failed = rx_page;
 	vsi->rx_buf_failed = rx_buf;
 	vsi->rx_page_reuse = rx_reuse;
+	vsi->rx_page_alloc = rx_alloc;
 
 	ns->rx_packets = rx_p;
 	ns->rx_bytes = rx_b;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 8b3ffb7..322f85b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1673,6 +1673,8 @@ static bool i40e_alloc_mapped_page(struct i40e_ring *rx_ring,
 		return false;
 	}
 
+	rx_ring->rx_stats.page_alloc_count++;
+
 	/* map page for use */
 	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
 				 i40e_rx_pg_size(rx_ring),
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index bfc2845..7041e81 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -299,6 +299,7 @@ struct i40e_rx_queue_stats {
 	u64 alloc_buff_failed;
 	u64 page_reuse_count;
 	u64 realloc_count;
+	u64 page_alloc_count;
 };
 
 enum i40e_ring_state_t {
-- 
2.7.4

