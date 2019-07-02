From: Alice Michael <alice.michael@intel.com>
Date: Tue,  2 Jul 2019 08:22:59 -0400
Subject: [Intel-wired-lan] [next PATCH S7 9/9] i40e: Remove unicast log when
 VF is leaving multicast mode.
In-Reply-To: <20190702122259.79070-1-alice.michael@intel.com>
References: <20190702122259.79070-1-alice.michael@intel.com>
Message-ID: <20190702122259.79070-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Czeslaw Zagorski <czeslawx.zagorski@intel.com>

This patch removes unicast log when VF is leaving multicast mode.
Added check of vf->vf_states &
I40E_VF_STATE_MC_PROMISC/I40E_VF_STATE_UC_PROMISC.
Without this commit, leaving multicast mode logs "unset unicast"
in dmsg.

Signed-off-by: Czeslaw Zagorski <czeslawx.zagorski@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 39 ++++++++++---------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 618781b3b7ac..7bc4e397d56d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2043,30 +2043,33 @@ static int i40e_vc_config_promiscuous_mode_msg(struct i40e_vf *vf, u8 *msg)
 		alluni = true;
 	aq_ret = i40e_config_vf_promiscuous_mode(vf, info->vsi_id, allmulti,
 						 alluni);
-	if (!aq_ret) {
-		if (allmulti) {
+	if (aq_ret)
+		goto err_out;
+
+	if (allmulti) {
+		if (!test_and_set_bit(I40E_VF_STATE_MC_PROMISC,
+				      &vf->vf_states))
 			dev_info(&pf->pdev->dev,
 				 "VF %d successfully set multicast promiscuous mode\n",
 				 vf->vf_id);
-			set_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states);
-		} else {
-			dev_info(&pf->pdev->dev,
-				 "VF %d successfully unset multicast promiscuous mode\n",
-				 vf->vf_id);
-			clear_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states);
-		}
-		if (alluni) {
+	} else if (test_and_clear_bit(I40E_VF_STATE_MC_PROMISC,
+				      &vf->vf_states))
+		dev_info(&pf->pdev->dev,
+			 "VF %d successfully unset multicast promiscuous mode\n",
+			 vf->vf_id);
+
+	if (alluni) {
+		if (!test_and_set_bit(I40E_VF_STATE_UC_PROMISC,
+				      &vf->vf_states))
 			dev_info(&pf->pdev->dev,
 				 "VF %d successfully set unicast promiscuous mode\n",
 				 vf->vf_id);
-			set_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states);
-		} else {
-			dev_info(&pf->pdev->dev,
-				 "VF %d successfully unset unicast promiscuous mode\n",
-				 vf->vf_id);
-			clear_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states);
-		}
-	}
+	} else if (test_and_clear_bit(I40E_VF_STATE_UC_PROMISC,
+				      &vf->vf_states))
+		dev_info(&pf->pdev->dev,
+			 "VF %d successfully unset unicast promiscuous mode\n",
+			 vf->vf_id);
+
 err_out:
 	/* send the response to the VF */
 	return i40e_vc_send_resp_to_vf(vf,
-- 
2.21.0

