From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 26 Jun 2019 02:20:14 -0700
Subject: [Intel-wired-lan] [PATCH S22 03/16] ice: Move vector base setup to
 PF VSI
In-Reply-To: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
Message-ID: <20190626092027.52845-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When interrupt tracking was refactored, during rebuild, the call to
ice_vsi_setup_vector_base() was inadvertently removed from the PF VSI
instead of being removed from the VF VSI. During reset, the failure to
properly setup the vector base generates a call trace. Correct this so
that resets/rebuilds properly complete.

Fixes: cbe66bfee6a0 ("ice: Refactor interrupt tracking")
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7311ce9c2f16..9aa1f285b17f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3082,6 +3082,10 @@ int ice_vsi_rebuild(struct ice_vsi *vsi)
 		if (ret)
 			goto err_rings;
 
+		ret = ice_vsi_setup_vector_base(vsi);
+		if (ret)
+			goto err_vectors;
+
 		ret = ice_vsi_set_q_vectors_reg_idx(vsi);
 		if (ret)
 			goto err_vectors;
@@ -3110,10 +3114,6 @@ int ice_vsi_rebuild(struct ice_vsi *vsi)
 		if (ret)
 			goto err_rings;
 
-		ret = ice_vsi_setup_vector_base(vsi);
-		if (ret)
-			goto err_vectors;
-
 		ret = ice_vsi_set_q_vectors_reg_idx(vsi);
 		if (ret)
 			goto err_vectors;
-- 
2.20.1

