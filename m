From: Alice Michael <alice.michael@intel.com>
Date: Thu, 28 Feb 2019 09:52:55 -0800
Subject: [Intel-wired-lan] [next PATCH S3 9/9] i40e: fix misleading message
 about promisc setting on un-trusted VF
In-Reply-To: <20190228175255.54754-1-alice.michael@intel.com>
References: <20190228175255.54754-1-alice.michael@intel.com>
Message-ID: <20190228175255.54754-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

A refactor of the i40e_vc_config_promiscuous_mode_msg function moved
the check for un-trusted VF into another function. We have to lie to
an un-trusted VF that its request to set promiscuous mode is
successful even when it is not because we don't want the VF to find
out its trust status this way. With the refactor, we were running into
a case where even though we were not setting promiscuous mode for an
un-trusted VF, we still printed a misleading message that it was
successful.

This patch fixes that by ensuring that a success message is printed
on the host side only when the promiscuous mode change has been
successful.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 925ca880bea3..8a6fb9c03955 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1112,15 +1112,6 @@ static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
 	if (!i40e_vc_isvalid_vsi_id(vf, vsi_id) || !vsi)
 		return I40E_ERR_PARAM;
 
-	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) &&
-	    (allmulti || alluni)) {
-		dev_err(&pf->pdev->dev,
-			"Unprivileged VF %d is attempting to configure promiscuous mode\n",
-			vf->vf_id);
-		/* Lie to the VF on purpose. */
-		return 0;
-	}
-
 	if (vf->port_vlan_id) {
 		aq_ret = i40e_aq_set_vsi_mc_promisc_on_vlan(hw, vsi->seid,
 							    allmulti,
@@ -1997,8 +1988,21 @@ static int i40e_vc_config_promiscuous_mode_msg(struct i40e_vf *vf, u8 *msg)
 	bool allmulti = false;
 	bool alluni = false;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states))
-		return I40E_ERR_PARAM;
+	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+		aq_ret = I40E_ERR_PARAM;
+		goto err_out;
+	}
+	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
+		dev_err(&pf->pdev->dev,
+			"Unprivileged VF %d is attempting to configure promiscuous mode\n",
+			vf->vf_id);
+
+		/* Lie to the VF on purpose, because this is an error we can
+		 * ignore. Unprivileged VF is not a virtual channel error.
+		 */
+		aq_ret = 0;
+		goto err_out;
+	}
 
 	/* Multicast promiscuous handling*/
 	if (info->flags & FLAG_VF_MULTICAST_PROMISC)
@@ -2032,7 +2036,7 @@ static int i40e_vc_config_promiscuous_mode_msg(struct i40e_vf *vf, u8 *msg)
 			clear_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states);
 		}
 	}
-
+err_out:
 	/* send the response to the VF */
 	return i40e_vc_send_resp_to_vf(vf,
 				       VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE,
-- 
2.19.2

