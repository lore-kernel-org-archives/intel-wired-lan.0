From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  3 May 2016 15:13:13 -0700
Subject: [Intel-wired-lan] [next PATCH S36 05/12] i40e: lie to the VF
In-Reply-To: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1462313600-3123-6-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

If an untrusted VF attempts to configure promiscuous mode, log a message
pointing out its naughty behavior. But then, instead of returning an
error to the offender, just lie to it and say everything's OK. It will
continue on its way, thinking it's in promiscuous mode, but receiving no
packets except its own.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I63369215b1720f3c531eedfc06af86ff8c0e3dc8
---
Testing Hints : Configure promiscuous mode on a non-trusted VF and
observe the results. Make sure trusted VFs still work.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 8ab029d..333945c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1474,12 +1474,16 @@ static int i40e_vc_config_promiscuous_mode_msg(struct i40e_vf *vf,
 
 	vsi = i40e_find_vsi_from_id(pf, info->vsi_id);
 	if (!test_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states) ||
-	    !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) ||
 	    !i40e_vc_isvalid_vsi_id(vf, info->vsi_id)) {
+		aq_ret = I40E_ERR_PARAM;
+		goto error_param;
+	}
+	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
 		dev_err(&pf->pdev->dev,
-			"VF %d doesn't meet requirements to enter promiscuous mode\n",
+			"Unprivileged VF %d is attempting to configure promiscuous mode\n",
 			vf->vf_id);
-		aq_ret = I40E_ERR_PARAM;
+		/* Lie to the VF on purpose. */
+		aq_ret = 0;
 		goto error_param;
 	}
 	/* Multicast promiscuous handling*/
-- 
2.4.11

