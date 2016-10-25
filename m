From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 25 Oct 2016 15:17:57 -0700
Subject: [Intel-wired-lan] [next PATCH S51 3/9] i40e: remove error_param_int
	label from i40e_vc_config_promiscuous_mode_msg
In-Reply-To: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
References: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1477433883-3248-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

This label is unnecessary, as are jumping to a block that checks aq_ret
and then immediately skipping it and returning. So just jump straight to
the error_param and remove this unnecessary label.

Also use goto error_param even in the last check for style consistency.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: If487c7d10c4048e37c594e5eca167693aaed45f6
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 62bca7a..05ed49b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1543,7 +1543,7 @@ static int i40e_vc_config_promiscuous_mode_msg(struct i40e_vf *vf,
 				vf->vf_id,
 				i40e_stat_str(&pf->hw, aq_ret),
 				i40e_aq_str(&pf->hw, aq_err));
-			goto error_param_int;
+			goto error_param;
 		}
 	}
 
@@ -1588,15 +1588,16 @@ static int i40e_vc_config_promiscuous_mode_msg(struct i40e_vf *vf,
 							     allmulti, NULL,
 							     true);
 		aq_err = pf->hw.aq.asq_last_status;
-		if (aq_ret)
+		if (aq_ret) {
 			dev_err(&pf->pdev->dev,
 				"VF %d failed to set unicast promiscuous mode %8.8x err %s aq_err %s\n",
 				vf->vf_id, info->flags,
 				i40e_stat_str(&pf->hw, aq_ret),
 				i40e_aq_str(&pf->hw, aq_err));
+			goto error_param;
+		}
 	}
 
-error_param_int:
 	if (!aq_ret) {
 		dev_info(&pf->pdev->dev,
 			 "VF %d successfully set unicast promiscuous mode\n",
-- 
2.4.11

