From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:51:09 -0700
Subject: [Intel-wired-lan] [PATCH S45 03/15] ice: Add helper function for
 clearing VPGEN_VFRTRIG
In-Reply-To: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516005121.4963-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Create a helper function for clearing VPGEN_VFRTRIG as this needs to be
done on reset to notify the VF that we are done resetting it. Also, it
needs to be done on SR-IOV initialization/creation in case it was left
in a bad state after SR-IOV teardown.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 31 ++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 5d6f23cf0c1f..18fe4cfe4443 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -961,6 +961,21 @@ static int ice_set_per_vf_res(struct ice_pf *pf)
 	return 0;
 }
 
+/**
+ * ice_clear_vf_reset_trigger - enable VF to access hardware
+ * @vf: VF to enabled hardware access for
+ */
+static void ice_clear_vf_reset_trigger(struct ice_vf *vf)
+{
+	struct ice_hw *hw = &vf->pf->hw;
+	u32 reg;
+
+	reg = rd32(hw, VPGEN_VFRTRIG(vf->vf_id));
+	reg &= ~VPGEN_VFRTRIG_VFSWR_M;
+	wr32(hw, VPGEN_VFRTRIG(vf->vf_id), reg);
+	ice_flush(hw);
+}
+
 /**
  * ice_cleanup_and_realloc_vf - Clean up VF and reallocate resources after reset
  * @vf: pointer to the VF structure
@@ -974,26 +989,20 @@ static void ice_cleanup_and_realloc_vf(struct ice_vf *vf)
 {
 	struct ice_pf *pf = vf->pf;
 	struct ice_hw *hw;
-	u32 reg;
 
 	hw = &pf->hw;
 
-	/* PF software completes the flow by notifying VF that reset flow is
-	 * completed. This is done by enabling hardware by clearing the reset
-	 * bit in the VPGEN_VFRTRIG reg and setting VFR_STATE in the VFGEN_RSTAT
-	 * register to VFR completed (done at the end of this function)
-	 * By doing this we allow HW to access VF memory at any point. If we
-	 * did it any sooner, HW could access memory while it was being freed
-	 * in ice_free_vf_res(), causing an IOMMU fault.
+	/* Allow HW to access VF memory after calling
+	 * ice_clear_vf_reset_trigger(). If we did it any sooner, HW could
+	 * access memory while it was being freed in ice_free_vf_res(), causing
+	 * an IOMMU fault.
 	 *
 	 * On the other hand, this needs to be done ASAP, because the VF driver
 	 * is waiting for this to happen and may report a timeout. It's
 	 * harmless, but it gets logged into Guest OS kernel log, so best avoid
 	 * it.
 	 */
-	reg = rd32(hw, VPGEN_VFRTRIG(vf->vf_id));
-	reg &= ~VPGEN_VFRTRIG_VFSWR_M;
-	wr32(hw, VPGEN_VFRTRIG(vf->vf_id), reg);
+	ice_clear_vf_reset_trigger(vf);
 
 	/* reallocate VF resources to finish resetting the VSI state */
 	if (!ice_alloc_vf_res(vf)) {
-- 
2.20.1

