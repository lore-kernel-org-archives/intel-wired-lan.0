From: Alice Michael <alice.michael@intel.com>
Date: Mon,  5 Feb 2018 06:11:14 -0500
Subject: [Intel-wired-lan] [next PATCH S86 V3 1/8] i40e: don't leak memory
 addresses
Message-ID: <20180205111121.59468-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Could a Bad Person do Bad Things to a server if they found these
addresses printed in the log? Who knows? But let's not take that risk.

Remove pointers from a bunch of printks. In some cases, I was able to
adjust the mesasge to indicate whether or not the value was null. In
others, I just removed the entire message as there was really no hope of
saving it.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 40 ++++----------------------
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 13 ++++-----
 2 files changed, 12 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index e9fc51b..b829fd3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -155,8 +155,8 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 		dev_info(&pf->pdev->dev, "        vlan_features = 0x%08lx\n",
 			 (unsigned long int)nd->vlan_features);
 	}
-	dev_info(&pf->pdev->dev,
-		 "    vlgrp: & = %p\n", vsi->active_vlans);
+	dev_info(&pf->pdev->dev, "    active_vlans is %s\n",
+		 vsi->active_vlans ? "<valid>" : "<null>");
 	dev_info(&pf->pdev->dev,
 		 "    flags = 0x%08lx, netdev_registered = %i, current_netdev_flags = 0x%04x\n",
 		 vsi->flags, vsi->netdev_registered, vsi->current_netdev_flags);
@@ -270,14 +270,6 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			continue;
 
 		dev_info(&pf->pdev->dev,
-			 "    rx_rings[%i]: desc = %p\n",
-			 i, rx_ring->desc);
-		dev_info(&pf->pdev->dev,
-			 "    rx_rings[%i]: dev = %p, netdev = %p, rx_bi = %p\n",
-			 i, rx_ring->dev,
-			 rx_ring->netdev,
-			 rx_ring->rx_bi);
-		dev_info(&pf->pdev->dev,
 			 "    rx_rings[%i]: state = %lu, queue_index = %d, reg_idx = %d\n",
 			 i, *rx_ring->state,
 			 rx_ring->queue_index,
@@ -307,13 +299,8 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 rx_ring->rx_stats.realloc_count,
 			 rx_ring->rx_stats.page_reuse_count);
 		dev_info(&pf->pdev->dev,
-			 "    rx_rings[%i]: size = %i, dma = 0x%08lx\n",
-			 i, rx_ring->size,
-			 (unsigned long int)rx_ring->dma);
-		dev_info(&pf->pdev->dev,
-			 "    rx_rings[%i]: vsi = %p, q_vector = %p\n",
-			 i, rx_ring->vsi,
-			 rx_ring->q_vector);
+			 "    rx_rings[%i]: size = %i\n",
+			 i, rx_ring->size);
 		dev_info(&pf->pdev->dev,
 			 "    rx_rings[%i]: itr_setting = %d (%s)\n",
 			 i, rx_ring->itr_setting,
@@ -326,14 +313,6 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			continue;
 
 		dev_info(&pf->pdev->dev,
-			 "    tx_rings[%i]: desc = %p\n",
-			 i, tx_ring->desc);
-		dev_info(&pf->pdev->dev,
-			 "    tx_rings[%i]: dev = %p, netdev = %p, tx_bi = %p\n",
-			 i, tx_ring->dev,
-			 tx_ring->netdev,
-			 tx_ring->tx_bi);
-		dev_info(&pf->pdev->dev,
 			 "    tx_rings[%i]: state = %lu, queue_index = %d, reg_idx = %d\n",
 			 i, *tx_ring->state,
 			 tx_ring->queue_index,
@@ -355,13 +334,8 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 tx_ring->tx_stats.tx_busy,
 			 tx_ring->tx_stats.tx_done_old);
 		dev_info(&pf->pdev->dev,
-			 "    tx_rings[%i]: size = %i, dma = 0x%08lx\n",
-			 i, tx_ring->size,
-			 (unsigned long int)tx_ring->dma);
-		dev_info(&pf->pdev->dev,
-			 "    tx_rings[%i]: vsi = %p, q_vector = %p\n",
-			 i, tx_ring->vsi,
-			 tx_ring->q_vector);
+			 "    tx_rings[%i]: size = %i\n",
+			 i, tx_ring->size);
 		dev_info(&pf->pdev->dev,
 			 "    tx_rings[%i]: DCB tc = %d\n",
 			 i, tx_ring->dcb_tc);
@@ -466,8 +440,6 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 		 vsi->info.resp_reserved[6], vsi->info.resp_reserved[7],
 		 vsi->info.resp_reserved[8], vsi->info.resp_reserved[9],
 		 vsi->info.resp_reserved[10], vsi->info.resp_reserved[11]);
-	if (vsi->back)
-		dev_info(&pf->pdev->dev, "    PF = %p\n", vsi->back);
 	dev_info(&pf->pdev->dev, "    idx = %d\n", vsi->idx);
 	dev_info(&pf->pdev->dev,
 		 "    tc_config: numtc = %d, enabled_tc = 0x%x\n",
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7828402..fec1b94 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -215,8 +215,8 @@ static int i40e_get_lump(struct i40e_pf *pf, struct i40e_lump_tracking *pile,
 
 	if (!pile || needed == 0 || id >= I40E_PILE_VALID_BIT) {
 		dev_info(&pf->pdev->dev,
-			 "param err: pile=%p needed=%d id=0x%04x\n",
-			 pile, needed, id);
+			 "param err: pile=%s needed=%d id=0x%04x\n",
+			 pile ? "<valid>" : "<null>", needed, id);
 		return -EINVAL;
 	}
 
@@ -10024,18 +10024,17 @@ static int i40e_vsi_clear(struct i40e_vsi *vsi)
 
 	mutex_lock(&pf->switch_mutex);
 	if (!pf->vsi[vsi->idx]) {
-		dev_err(&pf->pdev->dev, "pf->vsi[%d] is NULL, just free vsi[%d](%p,type %d)\n",
-			vsi->idx, vsi->idx, vsi, vsi->type);
+		dev_err(&pf->pdev->dev, "pf->vsi[%d] is NULL, just free vsi[%d](type %d)\n",
+			vsi->idx, vsi->idx, vsi->type);
 		goto unlock_vsi;
 	}
 
 	if (pf->vsi[vsi->idx] != vsi) {
 		dev_err(&pf->pdev->dev,
-			"pf->vsi[%d](%p, type %d) != vsi[%d](%p,type %d): no free!\n",
+			"pf->vsi[%d](type %d) != vsi[%d](type %d): no free!\n",
 			pf->vsi[vsi->idx]->idx,
-			pf->vsi[vsi->idx],
 			pf->vsi[vsi->idx]->type,
-			vsi->idx, vsi, vsi->type);
+			vsi->idx, vsi->type);
 		goto unlock_vsi;
 	}
 
-- 
2.9.5

