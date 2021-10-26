From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Tue, 26 Oct 2021 14:21:41 +0200
Subject: [Intel-wired-lan] [PATCH net-next] ice: allow short tunnel recipes
Message-ID: <20211026122141.3348-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Creating unchained tunnel recipes (less than 5 lookups) is impossible
when adding tunnel match flag to recipe only if number of groups is
greater than one. Fix this by adding matching on flags in the same way
as matching on other protocol types.

Matching on flags can be added before creating groups of lookups. In
this case there is no need to add special code in ice_add_sw_recipe only
to add flags matching.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
This commit should be squashed with "ice: low level support for tunnels"

 drivers/net/ethernet/intel/ice/ice_switch.c | 34 ++++++---------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index de08ec08158d..be98f3ed853c 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -4103,12 +4103,11 @@ ice_find_free_recp_res_idx(struct ice_hw *hw, const unsigned long *profiles,
  * ice_add_sw_recipe - function to call AQ calls to create switch recipe
  * @hw: pointer to hardware structure
  * @rm: recipe management list entry
- * @match_tun_mask: tunnel mask that needs to be programmed
  * @profiles: bitmap of profiles that will be associated.
  */
 static int
 ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
-		  u16 match_tun_mask, unsigned long *profiles)
+		  unsigned long *profiles)
 {
 	DECLARE_BITMAP(result_idx_bm, ICE_MAX_FV_WORDS);
 	struct ice_aqc_recipe_data_elem *tmp;
@@ -4316,15 +4315,6 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		}
 		buf[recps].content.act_ctrl_fwd_priority = rm->priority;
 
-		/* To differentiate among different UDP tunnels, a meta data ID
-		 * flag is used.
-		 */
-		if (match_tun_mask) {
-			buf[recps].content.lkup_indx[i] = ICE_TUN_FLAG_FV_IND;
-			buf[recps].content.mask[i] =
-				cpu_to_le16(match_tun_mask);
-		}
-
 		recps++;
 		rm->root_rid = (u8)rid;
 	}
@@ -4573,9 +4563,7 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	struct ice_recp_grp_entry *r_tmp;
 	struct ice_sw_fv_list_entry *tmp;
 	struct ice_sw_recipe *rm;
-	u16 match_tun_mask = 0;
 	int status = 0;
-	u16 mask;
 	u8 i;
 
 	if (!lkups_cnt)
@@ -4625,6 +4613,13 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	if (status)
 		goto err_unroll;
 
+	/* Create any special protocol/offset pairs, such as looking at tunnel
+	 * bits by extracting metadata
+	 */
+	status = ice_add_special_words(rinfo, lkup_exts);
+	if (status)
+		goto err_free_lkup_exts;
+
 	/* Group match words into recipes using preferred recipe grouping
 	 * criteria.
 	 */
@@ -4632,10 +4627,6 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	if (status)
 		goto err_unroll;
 
-	if (ice_tun_type_match_word(rinfo->tun_type, &mask) &&
-	    rm->n_grp_count > 1)
-		match_tun_mask = mask;
-
 	/* set the recipe priority if specified */
 	rm->priority = (u8)rinfo->priority;
 
@@ -4653,13 +4644,6 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 		set_bit((u16)fvit->profile_id, profiles);
 	}
 
-	/* Create any special protocol/offset pairs, such as looking at tunnel
-	 * bits by extracting metadata
-	 */
-	status = ice_add_special_words(rinfo, lkup_exts);
-	if (status)
-		goto err_free_lkup_exts;
-
 	/* Look for a recipe which matches our requested fv / mask list */
 	*rid = ice_find_recp(hw, lkup_exts);
 	if (*rid < ICE_MAX_NUM_RECIPES)
@@ -4667,7 +4651,7 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 		goto err_unroll;
 
 	/* Recipe we need does not exist, add a recipe */
-	status = ice_add_sw_recipe(hw, rm, match_tun_mask, profiles);
+	status = ice_add_sw_recipe(hw, rm, profiles);
 	if (status)
 		goto err_unroll;
 
-- 
2.31.1

