From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  8 Nov 2019 06:23:23 -0800
Subject: [Intel-wired-lan] [PATCH S33 07/15] ice: Fix setting coalesce to
 handle DCB configuration
In-Reply-To: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
Message-ID: <20191108142331.10221-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently there can be a case where a DCB map is applied and there are
more interrupt vectors (vsi->num_q_vectors) than Rx queues (vsi->num_rxq)
and Tx queues (vsi->num_txq). If we try to set coalesce settings in this
case it will report a false failure. Fix this by checking if vector index
is valid with respect to the number of Tx and Rx queues configured.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 1f00091f7906..6c796c5c8edf 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3420,10 +3420,17 @@ __ice_set_coalesce(struct net_device *netdev, struct ethtool_coalesce *ec,
 	struct ice_vsi *vsi = np->vsi;
 
 	if (q_num < 0) {
-		int i;
+		int v_idx;
+
+		ice_for_each_q_vector(vsi, v_idx) {
+			/* In some cases if DCB is configured the num_[rx|tx]q
+			 * can be less than vsi->num_q_vectors. This check
+			 * accounts for that so we don't report a false failure
+			 */
+			if (v_idx >= vsi->num_rxq && v_idx >= vsi->num_txq)
+				goto set_complete;
 
-		ice_for_each_q_vector(vsi, i) {
-			if (ice_set_q_coalesce(vsi, ec, i))
+			if (ice_set_q_coalesce(vsi, ec, v_idx))
 				return -EINVAL;
 		}
 		goto set_complete;
-- 
2.20.1

