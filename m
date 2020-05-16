From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:51:14 -0700
Subject: [Intel-wired-lan] [PATCH S45 08/15] ice: remove VM/VF disable
 command on CORER/GLOBR reset
In-Reply-To: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516005121.4963-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul Greenwalt <paul.greenwalt@intel.com>

Remove VM/VF disable AQC (opcode 0x0C31) when resetting all VFs.
This is not required for CORER/GLOBR reset.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 1212bf42c135..5a04589f76f2 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1196,17 +1196,6 @@ bool ice_reset_all_vfs(struct ice_pf *pf, bool is_vflr)
 	ice_for_each_vf(pf, v)
 		ice_trigger_vf_reset(&pf->vf[v], is_vflr, true);
 
-	ice_for_each_vf(pf, v) {
-		struct ice_vsi *vsi;
-
-		vf = &pf->vf[v];
-		vsi = pf->vsi[vf->lan_vsi_idx];
-		if (test_bit(ICE_VF_STATE_QS_ENA, vf->vf_states))
-			ice_dis_vf_qs(vf);
-		ice_dis_vsi_txq(vsi->port_info, vsi->idx, 0, 0, NULL, NULL,
-				NULL, ICE_VF_RESET, vf->vf_id, NULL);
-	}
-
 	/* HW requires some time to make sure it can flush the FIFO for a VF
 	 * when it resets it. Poll the VPGEN_VFRSTAT register for each VF in
 	 * sequence to make sure that it has completed. We'll keep track of
-- 
2.20.1

