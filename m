From: Ciara Loftus <ciara.loftus@intel.com>
Date: Tue, 23 Jun 2020 13:06:56 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 2/3] i40e: add xdp ring
 statistics to dump vsi debug output
In-Reply-To: <20200623130657.5668-1-ciara.loftus@intel.com>
References: <20200623130657.5668-1-ciara.loftus@intel.com>
Message-ID: <20200623130657.5668-2-ciara.loftus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Prior to this, only the rx and tx ring statistics were dumped. The xdp
ring statistics are now dumped as well.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 99ea543dd245..1c8285fce33f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -319,6 +319,47 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 i, tx_ring->itr_setting,
 			 ITR_IS_DYNAMIC(tx_ring->itr_setting) ? "dynamic" : "fixed");
 	}
+	if (i40e_enabled_xdp_vsi(vsi)) {
+		for (i = 0; i < vsi->num_queue_pairs; i++) {
+			struct i40e_ring *xdp_ring = READ_ONCE(vsi->xdp_rings[i]);
+
+			if (!xdp_ring)
+				continue;
+
+			dev_info(&pf->pdev->dev,
+				 "    xdp_rings[%i]: state = %lu, queue_index = %d, reg_idx = %d\n",
+				 i, *xdp_ring->state,
+				 xdp_ring->queue_index,
+				 xdp_ring->reg_idx);
+			dev_info(&pf->pdev->dev,
+				 "    xdp_rings[%i]: next_to_use = %d, next_to_clean = %d, ring_active = %i\n",
+				 i,
+				 xdp_ring->next_to_use,
+				 xdp_ring->next_to_clean,
+				 xdp_ring->ring_active);
+			dev_info(&pf->pdev->dev,
+				 "    xdp_rings[%i]: tx_stats: packets = %lld, bytes = %lld, restart_queue = %lld\n",
+				 i, xdp_ring->stats.packets,
+				 xdp_ring->stats.bytes,
+				 xdp_ring->tx_stats.restart_queue);
+			dev_info(&pf->pdev->dev,
+				 "    xdp_rings[%i]: tx_stats: tx_busy = %lld, tx_done_old = %lld\n",
+				 i,
+				 xdp_ring->tx_stats.tx_busy,
+				 xdp_ring->tx_stats.tx_done_old);
+			dev_info(&pf->pdev->dev,
+				 "    xdp_rings[%i]: size = %i\n",
+				 i, xdp_ring->size);
+			dev_info(&pf->pdev->dev,
+				 "    xdp_rings[%i]: DCB tc = %d\n",
+				 i, xdp_ring->dcb_tc);
+			dev_info(&pf->pdev->dev,
+				 "    xdp_rings[%i]: itr_setting = %d (%s)\n",
+				 i, xdp_ring->itr_setting,
+				 ITR_IS_DYNAMIC(xdp_ring->itr_setting) ?
+				 "dynamic" : "fixed");
+		}
+	}
 	rcu_read_unlock();
 	dev_info(&pf->pdev->dev,
 		 "    work_limit = %d\n",
-- 
2.17.1

