From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:49 -0800
Subject: [Intel-wired-lan] [PATCH S12 02/14] ice: Fix issue with VF reset
 and multiple VFs support on PFs
In-Reply-To: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205101.12078-3-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

This patch fixes issues with VF queues being disabled, and VF netdev
network carrier being lost after reset. Basically, we need to check if VF
is enabled, and queue configured in reset_all_vfs flow, and disable/enable
those queues appropriately whenever the function is called after
Global/CORER/PFR reset/rebuild/replay.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 089881b53677..a7e1594521ec 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -775,6 +775,7 @@ static void ice_cleanup_and_realloc_vf(struct ice_vf *vf)
 bool ice_reset_all_vfs(struct ice_pf *pf, bool is_vflr)
 {
 	struct ice_hw *hw = &pf->hw;
+	struct ice_vf *vf;
 	int v, i;
 
 	/* If we don't have any VFs, then there is nothing to reset */
@@ -789,12 +790,17 @@ bool ice_reset_all_vfs(struct ice_pf *pf, bool is_vflr)
 	for (v = 0; v < pf->num_alloc_vfs; v++)
 		ice_trigger_vf_reset(&pf->vf[v], is_vflr);
 
-	/* Call Disable LAN Tx queue AQ call with VFR bit set and 0
-	 * queues to inform Firmware about VF reset.
-	 */
-	for (v = 0; v < pf->num_alloc_vfs; v++)
-		ice_dis_vsi_txq(pf->vsi[0]->port_info, 0, NULL, NULL,
-				ICE_VF_RESET, v, NULL);
+	for (v = 0; v < pf->num_alloc_vfs; v++) {
+		struct ice_vsi *vsi;
+
+		vf = &pf->vf[v];
+		vsi = pf->vsi[vf->lan_vsi_idx];
+		if (test_bit(ICE_VF_STATE_ENA, vf->vf_states)) {
+			ice_vsi_stop_lan_tx_rings(vsi, ICE_VF_RESET, vf->vf_id);
+			ice_vsi_stop_rx_rings(vsi);
+			clear_bit(ICE_VF_STATE_ENA, vf->vf_states);
+		}
+	}
 
 	/* HW requires some time to make sure it can flush the FIFO for a VF
 	 * when it resets it. Poll the VPGEN_VFRSTAT register for each VF in
@@ -807,9 +813,9 @@ bool ice_reset_all_vfs(struct ice_pf *pf, bool is_vflr)
 
 		/* Check each VF in sequence */
 		while (v < pf->num_alloc_vfs) {
-			struct ice_vf *vf = &pf->vf[v];
 			u32 reg;
 
+			vf = &pf->vf[v];
 			reg = rd32(hw, VPGEN_VFRSTAT(vf->vf_id));
 			if (!(reg & VPGEN_VFRSTAT_VFRD_M))
 				break;
-- 
2.14.5

