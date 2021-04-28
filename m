From: Karen Sornek <karen.sornek@intel.com>
Date: Wed, 28 Apr 2021 10:19:41 +0200
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix warning message and call
 stack during rmmod i40e driver
Message-ID: <20210428081941.4765-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Restore part of reset functionality used when reset is called
from the VF to reset itself. Without this fix warning message
is displayed when vf is being removed via sysfs.

Fix the crash of the VF  during reset by ensuring
that that PF receives the reset message successfully.
Refactor code to use one function instead of two.

Fixes: eeeddbb80640 ("i40e: drop i40e_pf *pf from i40e_vc_disable_vf()")
Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Karen Sornek <karen.sornek@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 53 ++++++++-----------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 139562aaf..49720b5c3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -183,17 +183,18 @@ void i40e_vc_notify_vf_reset(struct i40e_vf *vf)
 /***********************misc routines*****************************/
 
 /**
- * i40e_vc_disable_vf
+ * i40e_vc_reset_vf
  * @vf: pointer to the VF info
- *
- * Disable the VF through a SW reset.
+ * @notify_vf: notify vf about reset or not
+ * Reset VF handler.
  **/
-static inline void i40e_vc_disable_vf(struct i40e_vf *vf)
+static void i40e_vc_reset_vf(struct i40e_vf *vf, bool notify_vf)
 {
 	struct i40e_pf *pf = vf->pf;
 	int i;
 
-	i40e_vc_notify_vf_reset(vf);
+	if (notify_vf)
+		i40e_vc_notify_vf_reset(vf);
 
 	/* We want to ensure that an actual reset occurs initiated after this
 	 * function was called. However, we do not want to wait forever, so
@@ -211,9 +212,14 @@ static inline void i40e_vc_disable_vf(struct i40e_vf *vf)
 		usleep_range(10000, 20000);
 	}
 
-	dev_warn(&vf->pf->pdev->dev,
-		 "Failed to initiate reset for VF %d after 200 milliseconds\n",
-		 vf->vf_id);
+	if (notify_vf)
+		dev_warn(&vf->pf->pdev->dev,
+			 "Failed to initiate reset for VF %d after 200 milliseconds\n",
+			 vf->vf_id);
+	else
+		dev_dbg(&vf->pf->pdev->dev,
+			"Failed to initiate reset for VF %d after 200 milliseconds\n",
+			vf->vf_id);
 }
 
 /**
@@ -2126,20 +2132,6 @@ err:
 	return ret;
 }
 
-/**
- * i40e_vc_reset_vf_msg
- * @vf: pointer to the VF info
- *
- * called from the VF to reset itself,
- * unlike other virtchnl messages, PF driver
- * doesn't send the response back to the VF
- **/
-static void i40e_vc_reset_vf_msg(struct i40e_vf *vf)
-{
-	if (test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states))
-		i40e_reset_vf(vf, false);
-}
-
 /**
  * i40e_vc_config_promiscuous_mode_msg
  * @vf: pointer to the VF info
@@ -2628,8 +2620,7 @@ static int i40e_vc_request_queues_msg(struct i40e_vf *vf, u8 *msg)
 	} else {
 		/* successful request */
 		vf->num_req_queues = req_pairs;
-		i40e_vc_notify_vf_reset(vf);
-		i40e_reset_vf(vf, false);
+		i40e_vc_reset_vf(vf, true);
 		return 0;
 	}
 
@@ -3832,8 +3823,7 @@ static int i40e_vc_add_qch_msg(struct i40e_vf *vf, u8 *msg)
 	vf->num_req_queues = 0;
 
 	/* reset the VF in order to allocate resources */
-	i40e_vc_notify_vf_reset(vf);
-	i40e_reset_vf(vf, false);
+	i40e_vc_reset_vf(vf, true);
 
 	return I40E_SUCCESS;
 
@@ -3873,8 +3863,7 @@ static int i40e_vc_del_qch_msg(struct i40e_vf *vf, u8 *msg)
 	}
 
 	/* reset the VF in order to allocate resources */
-	i40e_vc_notify_vf_reset(vf);
-	i40e_reset_vf(vf, false);
+	i40e_vc_reset_vf(vf, true);
 
 	return I40E_SUCCESS;
 
@@ -3936,7 +3925,7 @@ int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
 		i40e_vc_notify_vf_link_state(vf);
 		break;
 	case VIRTCHNL_OP_RESET_VF:
-		i40e_vc_reset_vf_msg(vf);
+		i40e_vc_reset_vf(vf, false);
 		ret = 0;
 		break;
 	case VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE:
@@ -4190,7 +4179,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	/* Force the VF interface down so it has to bring up with new MAC
 	 * address
 	 */
-	i40e_vc_disable_vf(vf);
+	i40e_vc_reset_vf(vf, true);
 	dev_info(&pf->pdev->dev, "Bring down and up the VF interface to make this change effective.\n");
 
 error_param:
@@ -4254,7 +4243,7 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 		/* duplicate request, so just return success */
 		goto error_pvid;
 
-	i40e_vc_disable_vf(vf);
+	i40e_vc_reset_vf(vf, true);
 	/* During reset the VF got a new VSI, so refresh a pointer. */
 	vsi = pf->vsi[vf->lan_vsi_idx];
 	/* Locked once because multiple functions below iterate list */
@@ -4632,7 +4621,7 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
 		goto out;
 
 	vf->trusted = setting;
-	i40e_vc_disable_vf(vf);
+	i40e_vc_reset_vf(vf, true);
 	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
 		 vf_id, setting ? "" : "un");
 
-- 
2.27.0

