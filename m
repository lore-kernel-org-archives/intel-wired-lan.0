From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  3 Sep 2019 01:31:03 -0700
Subject: [Intel-wired-lan] [PATCH S28 v2 4/9] ice: Report VF link status
 with opcode to get resources
In-Reply-To: <20190903083108.19593-1-anthony.l.nguyen@intel.com>
References: <20190903083108.19593-1-anthony.l.nguyen@intel.com>
Message-ID: <20190903083108.19593-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

This patch changes how and when the driver report link status, instead of
waiting till the call to enable queues for VF, we should report link
status earlier with opcode to get VF resources - So as to avoid reporting
erroneous information, especially when queues have not been configured.
In addition, we can also make a call to get and report link status change
after when queue is enabled, at least to report netdev or PHY link status.
This is in accordance to how link speed is being reported for PF...

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 1ec2a037a369..30e8e6166a59 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2934,6 +2934,7 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
 		break;
 	case VIRTCHNL_OP_GET_VF_RESOURCES:
 		err = ice_vc_get_vf_res_msg(vf, msg);
+		ice_vc_notify_vf_link_state(vf);
 		break;
 	case VIRTCHNL_OP_RESET_VF:
 		ice_vc_reset_vf_msg(vf);
-- 
2.20.1

