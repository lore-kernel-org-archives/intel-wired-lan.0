From: Joe Damato <jdamato@fastly.com>
Date: Wed,  5 Jan 2022 07:49:13 -0800
Subject: [Intel-wired-lan] [next-queue,
 v2] i40e: Remove unused RX realloc stat
Message-ID: <1641397753-121138-1-git-send-email-jdamato@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

After commit 1a557afc4dd5 ("i40e: Refactor receive routine"),
rx_stats.realloc_count is no longer being incremented, so remove it.

The debugfs string was left, but hardcoded to 0. This is intended to
prevent breaking any existing code / scripts that are parsing debugfs
for i40e.

Fixes: 1a557afc4dd5 ("i40e: Refactor receive routine")
Signed-off-by: Joe Damato <jdamato@fastly.com>

---
v1 -> v2: Fix commit message to include one-line SHA summary. Patch is now
          based on next-queue.
--- 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 3 +--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 1e57cc8..90fff05 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -275,9 +275,8 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 rx_ring->rx_stats.alloc_page_failed,
 			 rx_ring->rx_stats.alloc_buff_failed);
 		dev_info(&pf->pdev->dev,
-			 "    rx_rings[%i]: rx_stats: realloc_count = %lld, page_reuse_count = %lld\n",
+			 "    rx_rings[%i]: rx_stats: realloc_count = 0, page_reuse_count = %lld\n",
 			 i,
-			 rx_ring->rx_stats.realloc_count,
 			 rx_ring->rx_stats.page_reuse_count);
 		dev_info(&pf->pdev->dev,
 			 "    rx_rings[%i]: size = %i\n",
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index fd22e2f..324699e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -298,7 +298,6 @@ struct i40e_rx_queue_stats {
 	u64 alloc_page_failed;
 	u64 alloc_buff_failed;
 	u64 page_reuse_count;
-	u64 realloc_count;
 	u64 page_alloc_count;
 	u64 page_waive_count;
 	u64 page_busy_count;
-- 
2.7.4

