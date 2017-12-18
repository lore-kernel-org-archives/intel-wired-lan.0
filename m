From: Alice Michael <alice.michael@intel.com>
Date: Mon, 18 Dec 2017 05:18:02 -0500
Subject: [Intel-wired-lan] [next PATCH S83-V5 8/9] i40e: simplify pointer
 dereferences
Message-ID: <20171218101802.75967-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Now that i40e_vsi_config_tc() has the pf and hw variable defined, use
them, instead of dereferencing vsi->back. Much easier to read.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1ce24e2..5c5296e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5250,7 +5250,7 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 	if (ret) {
 		struct i40e_aqc_query_vsi_bw_config_resp bw_config = {0};
 
-		dev_info(&vsi->back->pdev->dev,
+		dev_info(&pf->pdev->dev,
 			 "Failed configuring TC map %d for VSI %d\n",
 			 enabled_tc, vsi->seid);
 		ret = i40e_aq_query_vsi_bw_config(hw, vsi->seid,
@@ -5321,13 +5321,12 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 	/* Update the VSI after updating the VSI queue-mapping
 	 * information
 	 */
-	ret = i40e_aq_update_vsi_params(&vsi->back->hw, &ctxt, NULL);
+	ret = i40e_aq_update_vsi_params(hw, &ctxt, NULL);
 	if (ret) {
-		dev_info(&vsi->back->pdev->dev,
+		dev_info(&pf->pdev->dev,
 			 "Update vsi tc config failed, err %s aq_err %s\n",
-			 i40e_stat_str(&vsi->back->hw, ret),
-			 i40e_aq_str(&vsi->back->hw,
-				     vsi->back->hw.aq.asq_last_status));
+			 i40e_stat_str(hw, ret),
+			 i40e_aq_str(hw, hw->aq.asq_last_status));
 		goto out;
 	}
 	/* update the local VSI info with updated queue map */
@@ -5337,11 +5336,10 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 	/* Update current VSI BW information */
 	ret = i40e_vsi_get_bw_info(vsi);
 	if (ret) {
-		dev_info(&vsi->back->pdev->dev,
+		dev_info(&pf->pdev->dev,
 			 "Failed updating vsi bw info, err %s aq_err %s\n",
-			 i40e_stat_str(&vsi->back->hw, ret),
-			 i40e_aq_str(&vsi->back->hw,
-				     vsi->back->hw.aq.asq_last_status));
+			 i40e_stat_str(hw, ret),
+			 i40e_aq_str(hw, hw->aq.asq_last_status));
 		goto out;
 	}
 
-- 
2.9.5

