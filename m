From: Dave Ertman <david.m.ertman@intel.com>
Date: Fri,  6 May 2022 11:04:10 -0700
Subject: [Intel-wired-lan] [PATCH net] ice: prevent low-core machines
 crashing on DCB config
Message-ID: <20220506180410.309280-1-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In the case where the driver is loaded on a low-core (< 8) core system,
and then a DCB config applied with the number of traffic classes
greater than the number of queues defined at probe time, there is a
chance to run into a NULL pointer dereference error in the queue
mapping code.

Put in a check and an error message that will stop the NULL pointer
dereference and notify the user that the VSI is in an indeterminate
state.

Fixes: 3a858ba392c3 ("ice: Add support for VSI allocation and deallocation")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c    | 22 ++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  2 ++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 136d7911adb4..d7b68ec4dde5 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -738,9 +738,14 @@ void ice_vsi_map_rings_to_vectors(struct ice_vsi *vsi)
 		for (q_id = q_base; q_id < (q_base + tx_rings_per_v); q_id++) {
 			struct ice_tx_ring *tx_ring = vsi->tx_rings[q_id];
 
-			tx_ring->q_vector = q_vector;
-			tx_ring->next = q_vector->tx.tx_ring;
-			q_vector->tx.tx_ring = tx_ring;
+			if (tx_ring) {
+				tx_ring->q_vector = q_vector;
+				tx_ring->next = q_vector->tx.tx_ring;
+				q_vector->tx.tx_ring = tx_ring;
+			} else {
+				dev_warn(ice_pf_to_dev(vsi->back), "NULL Tx ring found\n");
+				break;
+			}
 		}
 		tx_rings_rem -= tx_rings_per_v;
 
@@ -755,9 +760,14 @@ void ice_vsi_map_rings_to_vectors(struct ice_vsi *vsi)
 		for (q_id = q_base; q_id < (q_base + rx_rings_per_v); q_id++) {
 			struct ice_rx_ring *rx_ring = vsi->rx_rings[q_id];
 
-			rx_ring->q_vector = q_vector;
-			rx_ring->next = q_vector->rx.rx_ring;
-			q_vector->rx.rx_ring = rx_ring;
+			if (rx_ring) {
+				rx_ring->q_vector = q_vector;
+				rx_ring->next = q_vector->rx.rx_ring;
+				q_vector->rx.rx_ring = rx_ring;
+			} else {
+				dev_warn(ice_pf_to_dev(vsi->back), "NULL Rx ring found\n");
+				break;
+			}
 		}
 		rx_rings_rem -= rx_rings_per_v;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index add90e75f05c..fdae0b8ef525 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -744,6 +744,8 @@ void ice_pf_dcb_recfg(struct ice_pf *pf)
 			continue;
 
 		if (vsi->type == ICE_VSI_PF) {
+			if (ice_dcb_get_num_tc(dcbcfg) > vsi->alloc_txq)
+				dev_warn(ice_pf_to_dev(vsi->back), "More TCs defined than queues/rings allocated.\n");
 			tc_map = ice_dcb_get_ena_tc(dcbcfg);
 
 			/* If DCBX request non-contiguous TC, then configure
-- 
2.35.1

