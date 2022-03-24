From: Joe Damato <jdamato@fastly.com>
Date: Thu, 24 Mar 2022 12:46:58 -0700
Subject: [Intel-wired-lan] [intel-next v2] i40e: Add tx_stopped stat
Message-ID: <1648151218-113215-1-git-send-email-jdamato@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Track TX queue stop events and export the new stat with ethtool.

v2:
  - also export tx_stopped via debugfs

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 5 +++--
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 4 ++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 2 ++
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 1 +
 6 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 55c6bce..18558a0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -852,6 +852,7 @@ struct i40e_vsi {
 	u64 tx_busy;
 	u64 tx_linearize;
 	u64 tx_force_wb;
+	u64 tx_stopped;
 	u64 rx_buf_failed;
 	u64 rx_page_failed;
 	u64 rx_page_reuse;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index be7c6f3..c9dcd6d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -309,10 +309,11 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 tx_ring->stats.bytes,
 			 tx_ring->tx_stats.restart_queue);
 		dev_info(&pf->pdev->dev,
-			 "    tx_rings[%i]: tx_stats: tx_busy = %lld, tx_done_old = %lld\n",
+			 "    tx_rings[%i]: tx_stats: tx_busy = %lld, tx_done_old = %lld, tx_stopped = %lld\n",
 			 i,
 			 tx_ring->tx_stats.tx_busy,
-			 tx_ring->tx_stats.tx_done_old);
+			 tx_ring->tx_stats.tx_done_old,
+			 tx_ring->tx_stats.tx_stopped);
 		dev_info(&pf->pdev->dev,
 			 "    tx_rings[%i]: size = %i\n",
 			 i, tx_ring->size);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index e484996..162bae1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -293,6 +293,7 @@ static const struct i40e_stats i40e_gstrings_misc_stats[] = {
 	I40E_VSI_STAT("tx_linearize", tx_linearize),
 	I40E_VSI_STAT("tx_force_wb", tx_force_wb),
 	I40E_VSI_STAT("tx_busy", tx_busy),
+	I40E_VSI_STAT("tx_stopped", tx_stopped),
 	I40E_VSI_STAT("rx_alloc_fail", rx_buf_failed),
 	I40E_VSI_STAT("rx_pg_alloc_fail", rx_page_failed),
 	I40E_VSI_STAT("rx_cache_reuse", rx_page_reuse),
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b7f11fd..fea40ef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -785,6 +785,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	unsigned int start;
 	u64 tx_linearize;
 	u64 tx_force_wb;
+	u64 tx_stopped;
 	u64 rx_p, rx_b;
 	u64 tx_p, tx_b;
 	u16 q;
@@ -804,6 +805,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	rx_b = rx_p = 0;
 	tx_b = tx_p = 0;
 	tx_restart = tx_busy = tx_linearize = tx_force_wb = 0;
+	tx_stopped = 0;
 	rx_page = 0;
 	rx_buf = 0;
 	rx_reuse = 0;
@@ -828,6 +830,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 		tx_busy += p->tx_stats.tx_busy;
 		tx_linearize += p->tx_stats.tx_linearize;
 		tx_force_wb += p->tx_stats.tx_force_wb;
+		tx_stopped += p->tx_stats.tx_stopped;
 
 		/* locate Rx ring */
 		p = READ_ONCE(vsi->rx_rings[q]);
@@ -872,6 +875,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	vsi->tx_busy = tx_busy;
 	vsi->tx_linearize = tx_linearize;
 	vsi->tx_force_wb = tx_force_wb;
+	vsi->tx_stopped = tx_stopped;
 	vsi->rx_page_failed = rx_page;
 	vsi->rx_buf_failed = rx_buf;
 	vsi->rx_page_reuse = rx_reuse;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 8b844ad..7bc1174 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3396,6 +3396,8 @@ int __i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
 	/* Memory barrier before checking head and tail */
 	smp_mb();
 
+	++tx_ring->tx_stats.tx_stopped;
+
 	/* Check again in a case another CPU has just made room available. */
 	if (likely(I40E_DESC_UNUSED(tx_ring) < size))
 		return -EBUSY;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index c471c2d..41f86e9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -290,6 +290,7 @@ struct i40e_tx_queue_stats {
 	u64 tx_done_old;
 	u64 tx_linearize;
 	u64 tx_force_wb;
+	u64 tx_stopped;
 	int prev_pkt_ctr;
 };
 
-- 
2.7.4

