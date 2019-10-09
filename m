From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  9 Oct 2019 07:09:52 -0700
Subject: [Intel-wired-lan] [PATCH S31 14/15] ice: Rename VF function
 ice_vc_dis_vf to match its behavior
In-Reply-To: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
Message-ID: <20191009140953.14087-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

ice_vc_dis_vf() tells iavf that it's going to perform a reset
and then performs a software reset. This is misleading based on
the function name because the VF does not get disabled. So fix
this by changing the name to ice_vc_reset_vf().

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 33b19f1ad2ed..965bbd68caa1 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1477,12 +1477,10 @@ void ice_process_vflr_event(struct ice_pf *pf)
 }
 
 /**
- * ice_vc_dis_vf - Disable a given VF via SW reset
+ * ice_vc_reset_vf - Perform software reset on the VF after informing the AVF
  * @vf: pointer to the VF info
- *
- * Disable the VF through a SW reset
  */
-static void ice_vc_dis_vf(struct ice_vf *vf)
+static void ice_vc_reset_vf(struct ice_vf *vf)
 {
 	ice_vc_notify_vf_reset(vf);
 	ice_reset_vf(vf, false);
@@ -2522,7 +2520,7 @@ static int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 	} else {
 		/* request is successful, then reset VF */
 		vf->num_req_qs = req_queues;
-		ice_vc_dis_vf(vf);
+		ice_vc_reset_vf(vf);
 		dev_info(&pf->pdev->dev,
 			 "VF %d granted request of %u queues.\n",
 			 vf->vf_id, req_queues);
@@ -3149,7 +3147,7 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 		    "MAC on VF %d set to %pM. VF driver will be reinitialized\n",
 		    vf_id, mac);
 
-	ice_vc_dis_vf(vf);
+	ice_vc_reset_vf(vf);
 	return ret;
 }
 
@@ -3185,7 +3183,7 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 		return 0;
 
 	vf->trusted = trusted;
-	ice_vc_dis_vf(vf);
+	ice_vc_reset_vf(vf);
 	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
 		 vf_id, trusted ? "" : "un");
 
-- 
2.20.1

