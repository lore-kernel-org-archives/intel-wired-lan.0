From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:25:50 -0800
Subject: [Intel-wired-lan] [PATCH S17 04/17] ice: Resolve static analysis
 reported issue
In-Reply-To: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190228232603.32156-5-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Static analysis points out the default case in the switch statement in
ice_get_itr_intrl_gran() is an infeasible condition causing the default
case statement to be unreachable.  Remove it and since the function no
longer returns anything but success, change it to just return void and
update the only call to it accordingly.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_common.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 9e2171b93d77..977e2a50dc93 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -647,7 +647,7 @@ void ice_output_fw_log(struct ice_hw *hw, struct ice_aq_desc *desc, void *buf)
  * Determines the itr/intrl granularities based on the maximum aggregate
  * bandwidth according to the device's configuration during power-on.
  */
-static enum ice_status ice_get_itr_intrl_gran(struct ice_hw *hw)
+static void ice_get_itr_intrl_gran(struct ice_hw *hw)
 {
 	u8 max_agg_bw = (rd32(hw, GL_PWR_MODE_CTL) &
 			 GL_PWR_MODE_CTL_CAR_MAX_BW_M) >>
@@ -664,13 +664,7 @@ static enum ice_status ice_get_itr_intrl_gran(struct ice_hw *hw)
 		hw->itr_gran = ICE_ITR_GRAN_MAX_25;
 		hw->intrl_gran = ICE_INTRL_GRAN_MAX_25;
 		break;
-	default:
-		ice_debug(hw, ICE_DBG_INIT,
-			  "Failed to determine itr/intrl granularity\n");
-		return ICE_ERR_CFG;
 	}
-
-	return 0;
 }
 
 /**
@@ -697,9 +691,7 @@ enum ice_status ice_init_hw(struct ice_hw *hw)
 	if (status)
 		return status;
 
-	status = ice_get_itr_intrl_gran(hw);
-	if (status)
-		return status;
+	ice_get_itr_intrl_gran(hw);
 
 	status = ice_init_all_ctrlq(hw);
 	if (status)
-- 
2.14.5

