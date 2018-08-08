From: Alice Michael <alice.michael@intel.com>
Date: Tue,  7 Aug 2018 17:11:23 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Fix for tx timeouts when interface
 is brought up if DCB is enabled
Message-ID: <20180808001123.55890-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Szapar, Martyna" <martyna.szapar@intel.com>

If interface is connected to switch port configured for DCB there are
TX timeouts when bringing up interface. Problem started appearing after
adding in i40e driver code mqprio hardware offload mode. In function
i40e_vsi_configure_bw_alloc was added resetting BW rate which should
be executing when mqprio qdisc is removed but was also when there was
no mqprio qdisc added and DCB was enabled. In this patch was added
additional check for DCB flag so now when DCB is enabled the correct
DCB configs from before mqprio patch are restored.

Signed-off-by: Martyna Szapar <martyna.szapar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4300483..9c0fe8c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5127,15 +5127,17 @@ static int i40e_vsi_configure_bw_alloc(struct i40e_vsi *vsi, u8 enabled_tc,
 				       u8 *bw_share)
 {
 	struct i40e_aqc_configure_vsi_tc_bw_data bw_data;
+	struct i40e_pf *pf = vsi->back;
 	i40e_status ret;
 	int i;
 
-	if (vsi->back->flags & I40E_FLAG_TC_MQPRIO)
+	/* There is no need to reset BW when mqprio mode is on.  */
+	if (pf->flags & I40E_FLAG_TC_MQPRIO)
 		return 0;
-	if (!vsi->mqprio_qopt.qopt.hw) {
+	if (!vsi->mqprio_qopt.qopt.hw && !(pf->flags & I40E_FLAG_DCB_ENABLED)) {
 		ret = i40e_set_bw_limit(vsi, vsi->seid, 0);
 		if (ret)
-			dev_info(&vsi->back->pdev->dev,
+			dev_info(&pf->pdev->dev,
 				 "Failed to reset tx rate for vsi->seid %u\n",
 				 vsi->seid);
 		return ret;
@@ -5144,12 +5146,11 @@ static int i40e_vsi_configure_bw_alloc(struct i40e_vsi *vsi, u8 enabled_tc,
 	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++)
 		bw_data.tc_bw_credits[i] = bw_share[i];
 
-	ret = i40e_aq_config_vsi_tc_bw(&vsi->back->hw, vsi->seid, &bw_data,
-				       NULL);
+	ret = i40e_aq_config_vsi_tc_bw(&pf->hw, vsi->seid, &bw_data, NULL);
 	if (ret) {
-		dev_info(&vsi->back->pdev->dev,
+		dev_info(&pf->pdev->dev,
 			 "AQ command Config VSI BW allocation per TC failed = %d\n",
-			 vsi->back->hw.aq.asq_last_status);
+			 pf->hw.aq.asq_last_status);
 		return -EINVAL;
 	}
 
-- 
2.9.5

