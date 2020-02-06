From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  6 Feb 2020 01:20:11 -0800
Subject: [Intel-wired-lan] [PATCH S37 v3 13/15] ice: Cleanup
 ice_vsi_alloc_q_vectors
In-Reply-To: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
Message-ID: <20200206092013.23388-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

1. Remove local variable num_q_vectors and use vsi->num_q_vectors instead
2. Remove local variable pf and pass vsi->back to ice_pf_to_dev

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 46f427a95056..81885efadc7a 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -503,20 +503,15 @@ int ice_vsi_ctrl_rx_ring(struct ice_vsi *vsi, bool ena, u16 rxq_idx)
  */
 int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi)
 {
-	struct ice_pf *pf = vsi->back;
-	int v_idx = 0, num_q_vectors;
-	struct device *dev;
-	int err;
+	struct device *dev = ice_pf_to_dev(vsi->back);
+	int v_idx, err;
 
-	dev = ice_pf_to_dev(pf);
 	if (vsi->q_vectors[0]) {
 		dev_dbg(dev, "VSI %d has existing q_vectors\n", vsi->vsi_num);
 		return -EEXIST;
 	}
 
-	num_q_vectors = vsi->num_q_vectors;
-
-	for (v_idx = 0; v_idx < num_q_vectors; v_idx++) {
+	for (v_idx = 0; v_idx < vsi->num_q_vectors; v_idx++) {
 		err = ice_vsi_alloc_q_vector(vsi, v_idx);
 		if (err)
 			goto err_out;
-- 
2.20.1

