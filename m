From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:57 -0800
Subject: [Intel-wired-lan] [PATCH S12 10/14] ice: Get resources per function
In-Reply-To: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205101.12078-11-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

ice_get_guar_num_vsi currently calculates the number of VSIs per PF.
Rework this into a general function ice_get_num_per_func, that can
calculate per PF allocations for not just VSIs but across multiple
resource types.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote commit message]
---
 drivers/net/ethernet/intel/ice/ice_common.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2dc5c3249e12..d2e1e6f440b8 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1415,13 +1415,15 @@ void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res)
 }
 
 /**
- * ice_get_guar_num_vsi - determine number of guar VSI for a PF
+ * ice_get_num_per_func - determine number of resources per PF
  * @hw: pointer to the hw structure
+ * @max: value to be evenly split between each PF
  *
  * Determine the number of valid functions by going through the bitmap returned
- * from parsing capabilities and use this to calculate the number of VSI per PF.
+ * from parsing capabilities and use this to calculate the number of resources
+ * per PF based on the max value passed in.
  */
-static u32 ice_get_guar_num_vsi(struct ice_hw *hw)
+static u32 ice_get_num_per_func(struct ice_hw *hw, u32 max)
 {
 	u8 funcs;
 
@@ -1432,7 +1434,7 @@ static u32 ice_get_guar_num_vsi(struct ice_hw *hw)
 	if (!funcs)
 		return 0;
 
-	return ICE_MAX_VSI / funcs;
+	return max / funcs;
 }
 
 /**
@@ -1512,7 +1514,8 @@ ice_parse_caps(struct ice_hw *hw, void *buf, u32 cap_count,
 					  "HW caps: Dev.VSI cnt = %d\n",
 					  dev_p->num_vsi_allocd_to_host);
 			} else if (func_p) {
-				func_p->guar_num_vsi = ice_get_guar_num_vsi(hw);
+				func_p->guar_num_vsi =
+					ice_get_num_per_func(hw, ICE_MAX_VSI);
 				ice_debug(hw, ICE_DBG_INIT,
 					  "HW caps: Func.VSI cnt = %d\n",
 					  number);
-- 
2.14.5

