From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:41 -0800
Subject: [Intel-wired-lan] [PATCH S11 14/16] ice: use absolute vector ID for
 VFs
In-Reply-To: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205043.11975-15-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

When the PF driver sets up the VF MSI-X vector allocation, it needs to
use the hardware absolute vector ID, not the per-PF vector ID. Without
this change we see (apparent) TX hangs when using VFs on multiple PFs.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 458e179ea863..57155b4a59dc 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -173,7 +173,8 @@ static void ice_dis_vf_mappings(struct ice_vf *vf)
 	wr32(hw, VPINT_ALLOC(vf->vf_id), 0);
 	wr32(hw, VPINT_ALLOC_PCI(vf->vf_id), 0);
 
-	first = vf->first_vector_idx;
+	first = vf->first_vector_idx +
+		hw->func_caps.common_cap.msix_vector_first_id;
 	last = first + pf->num_vf_msix - 1;
 	for (v = first; v <= last; v++) {
 		u32 reg;
@@ -523,7 +524,8 @@ static void ice_ena_vf_mappings(struct ice_vf *vf)
 
 	hw = &pf->hw;
 	vsi = pf->vsi[vf->lan_vsi_idx];
-	first = vf->first_vector_idx;
+	first = vf->first_vector_idx +
+		hw->func_caps.common_cap.msix_vector_first_id;
 	last = (first + pf->num_vf_msix) - 1;
 	abs_vf_id = vf->vf_id + hw->func_caps.vf_base_id;
 
-- 
2.14.5

