From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 11:44:44 -0700
Subject: [Intel-wired-lan] [PATCH S9 12/15] ice: Cleanup ice_tx_timeout()
In-Reply-To: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026184447.13547-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Clean up number of formatting issues and a comment that could use
clarification.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_main.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 292d19e65af0..54ded5d9ab4f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3702,35 +3702,31 @@ static void ice_tx_timeout(struct net_device *netdev)
 
 	pf->tx_timeout_count++;
 
-	/* find the stopped queue the same way the stack does */
+	/* find the stopped queue the same way dev_watchdog() does */
 	for (i = 0; i < netdev->num_tx_queues; i++) {
-		struct netdev_queue *q;
 		unsigned long trans_start;
+		struct netdev_queue *q;
 
 		q = netdev_get_tx_queue(netdev, i);
 		trans_start = q->trans_start;
 		if (netif_xmit_stopped(q) &&
 		    time_after(jiffies,
-			       (trans_start + netdev->watchdog_timeo))) {
+			       trans_start + netdev->watchdog_timeo)) {
 			hung_queue = i;
 			break;
 		}
 	}
 
-	if (i == netdev->num_tx_queues) {
+	if (i == netdev->num_tx_queues)
 		netdev_info(netdev, "tx_timeout: no netdev hung queue found\n");
-	} else {
+	else
 		/* now that we have an index, find the tx_ring struct */
-		for (i = 0; i < vsi->num_txq; i++) {
-			if (vsi->tx_rings[i] && vsi->tx_rings[i]->desc) {
-				if (hung_queue ==
-				    vsi->tx_rings[i]->q_index) {
+		for (i = 0; i < vsi->num_txq; i++)
+			if (vsi->tx_rings[i] && vsi->tx_rings[i]->desc)
+				if (hung_queue == vsi->tx_rings[i]->q_index) {
 					tx_ring = vsi->tx_rings[i];
 					break;
 				}
-			}
-		}
-	}
 
 	/* Reset recovery level if enough time has elapsed after last timeout.
 	 * Also ensure no new reset action happens before next timeout period.
@@ -3751,7 +3747,7 @@ static void ice_tx_timeout(struct net_device *netdev)
 		if (test_bit(ICE_FLAG_MSIX_ENA, pf->flags))
 			val = rd32(hw,
 				   GLINT_DYN_CTL(tx_ring->q_vector->v_idx +
-					tx_ring->vsi->hw_base_vector));
+						 tx_ring->vsi->hw_base_vector));
 
 		netdev_info(netdev, "tx_timeout: VSI_num: %d, Q %d, NTC: 0x%x, HW_HEAD: 0x%x, NTU: 0x%x, INT: 0x%x\n",
 			    vsi->vsi_num, hung_queue, tx_ring->next_to_clean,
-- 
2.14.3

