From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 22 Jan 2020 07:20:35 -0800
Subject: [Intel-wired-lan] [PATCH S37 09/15] ice: update Unit Load Status
 bitmask to check after reset
In-Reply-To: <20200122152041.41498-1-anthony.l.nguyen@intel.com>
References: <20200122152041.41498-1-anthony.l.nguyen@intel.com>
Message-ID: <20200122152041.41498-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

After a reset the Unit Load Status bits in the GLNVM_ULD register to check
for completion should be 0x7FF before continuing.  Update the mask to check
(minus the three reserved bits that are always set).

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c    | 18 +++++++++++++-----
 .../net/ethernet/intel/ice/ice_hw_autogen.h    |  6 ++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2d418c84d6a5..e89b549b943d 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -818,7 +818,7 @@ void ice_deinit_hw(struct ice_hw *hw)
  */
 enum ice_status ice_check_reset(struct ice_hw *hw)
 {
-	u32 cnt, reg = 0, grst_delay;
+	u32 cnt, reg = 0, grst_delay, uld_mask;
 
 	/* Poll for Device Active state in case a recent CORER, GLOBR,
 	 * or EMPR has occurred. The grst delay value is in 100ms units.
@@ -840,13 +840,21 @@ enum ice_status ice_check_reset(struct ice_hw *hw)
 		return ICE_ERR_RESET_FAILED;
 	}
 
-#define ICE_RESET_DONE_MASK	(GLNVM_ULD_CORER_DONE_M | \
-				 GLNVM_ULD_GLOBR_DONE_M)
+#define ICE_RESET_DONE_MASK	(GLNVM_ULD_PCIER_DONE_M |\
+				 GLNVM_ULD_PCIER_DONE_1_M |\
+				 GLNVM_ULD_CORER_DONE_M |\
+				 GLNVM_ULD_GLOBR_DONE_M |\
+				 GLNVM_ULD_POR_DONE_M |\
+				 GLNVM_ULD_POR_DONE_1_M |\
+				 GLNVM_ULD_PCIER_DONE_2_M)
+
+	uld_mask = ICE_RESET_DONE_MASK | (hw->func_caps.common_cap.iwarp ?
+					  GLNVM_ULD_PE_DONE_M : 0);
 
 	/* Device is Active; check Global Reset processes are done */
 	for (cnt = 0; cnt < ICE_PF_RESET_WAIT_COUNT; cnt++) {
-		reg = rd32(hw, GLNVM_ULD) & ICE_RESET_DONE_MASK;
-		if (reg == ICE_RESET_DONE_MASK) {
+		reg = rd32(hw, GLNVM_ULD) & uld_mask;
+		if (reg == uld_mask) {
 			ice_debug(hw, ICE_DBG_INIT,
 				  "Global reset processes done. %d\n", cnt);
 			break;
diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index 30f50b06173e..306b8943cfc0 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -268,8 +268,14 @@
 #define GLNVM_GENS_SR_SIZE_S			5
 #define GLNVM_GENS_SR_SIZE_M			ICE_M(0x7, 5)
 #define GLNVM_ULD				0x000B6008
+#define GLNVM_ULD_PCIER_DONE_M			BIT(0)
+#define GLNVM_ULD_PCIER_DONE_1_M		BIT(1)
 #define GLNVM_ULD_CORER_DONE_M			BIT(3)
 #define GLNVM_ULD_GLOBR_DONE_M			BIT(4)
+#define GLNVM_ULD_POR_DONE_M			BIT(5)
+#define GLNVM_ULD_POR_DONE_1_M			BIT(8)
+#define GLNVM_ULD_PCIER_DONE_2_M		BIT(9)
+#define GLNVM_ULD_PE_DONE_M			BIT(10)
 #define GLPCI_CNF2				0x000BE004
 #define GLPCI_CNF2_CACHELINE_SIZE_M		BIT(1)
 #define PF_FUNC_RID				0x0009E880
-- 
2.20.1

