From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  6 May 2021 08:40:07 -0700
Subject: [Intel-wired-lan] [PATCH S59 12/13] ice: reduce scope of variables
In-Reply-To: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
Message-ID: <20210506154008.12880-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

There are some places where the scope of a variable can
be reduced so do that.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 8 ++++----
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 3291fe194ba1..454432ed7a3f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1194,11 +1194,11 @@ static int ice_vsi_setup_vector_base(struct ice_vsi *vsi)
 	num_q_vectors = vsi->num_q_vectors;
 	/* reserve slots from OS requested IRQs */
 	if (vsi->type == ICE_VSI_CTRL && vsi->vf_id != ICE_INVAL_VFID) {
-		struct ice_vf *vf;
 		int i;
 
 		ice_for_each_vf(pf, i) {
-			vf = &pf->vf[i];
+			struct ice_vf *vf = &pf->vf[i];
+
 			if (i != vsi->vf_id && vf->ctrl_vsi_idx != ICE_NO_VSI) {
 				base = pf->vsi[vf->ctrl_vsi_idx]->base_vector;
 				break;
@@ -2852,11 +2852,11 @@ int ice_vsi_release(struct ice_vsi *vsi)
 	 * cleared in the same manner.
 	 */
 	if (vsi->type == ICE_VSI_CTRL && vsi->vf_id != ICE_INVAL_VFID) {
-		struct ice_vf *vf;
 		int i;
 
 		ice_for_each_vf(pf, i) {
-			vf = &pf->vf[i];
+			struct ice_vf *vf = &pf->vf[i];
+
 			if (i != vsi->vf_id && vf->ctrl_vsi_idx != ICE_NO_VSI)
 				break;
 		}
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index eaebffdb6257..0034bbe9c9b3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5498,7 +5498,6 @@ ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi, struct ice_ring **rings,
 static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 {
 	struct rtnl_link_stats64 *vsi_stats = &vsi->net_stats;
-	struct ice_ring *ring;
 	u64 pkts, bytes;
 	int i;
 
@@ -5522,7 +5521,8 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 
 	/* update Rx rings counters */
 	ice_for_each_rxq(vsi, i) {
-		ring = READ_ONCE(vsi->rx_rings[i]);
+		struct ice_ring *ring = READ_ONCE(vsi->rx_rings[i]);
+
 		ice_fetch_u64_stats_per_ring(ring, &pkts, &bytes);
 		vsi_stats->rx_packets += pkts;
 		vsi_stats->rx_bytes += bytes;
-- 
2.20.1

