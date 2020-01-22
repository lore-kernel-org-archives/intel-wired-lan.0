From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 22 Jan 2020 07:21:26 -0800
Subject: [Intel-wired-lan] [PATCH S38 03/15] ice: Add helper to determine if
 VF link is up
In-Reply-To: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
Message-ID: <20200122152138.41585-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

The check for vf->link_up is incorrect because this field is only valid if
vf->link_forced is true. Fix this by adding the helper ice_is_vf_link_up()
to determine if the VF's link is up.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 42 +++++++++++--------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 8349369b06bf..0133a79bbf4c 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -90,6 +90,26 @@ ice_set_pfe_link(struct ice_vf *vf, struct virtchnl_pf_event *pfe,
 	}
 }
 
+/**
+ * ice_is_vf_link_up - check if the VF's link is up
+ * @vf: VF to check if link is up
+ */
+static bool ice_is_vf_link_up(struct ice_vf *vf)
+{
+	struct ice_pf *pf = vf->pf;
+
+	if (ice_check_vf_init(pf, vf))
+		return false;
+
+	if (!vf->num_qs_ena)
+		return false;
+	else if (vf->link_forced)
+		return vf->link_up;
+	else
+		return pf->hw.port_info->phy.link_info.link_info &
+			ICE_AQ_LINK_UP;
+}
+
 /**
  * ice_vc_notify_vf_link_state - Inform a VF of link status
  * @vf: pointer to the VF structure
@@ -99,28 +119,16 @@ ice_set_pfe_link(struct ice_vf *vf, struct virtchnl_pf_event *pfe,
 static void ice_vc_notify_vf_link_state(struct ice_vf *vf)
 {
 	struct virtchnl_pf_event pfe = { 0 };
-	struct ice_link_status *ls;
-	struct ice_pf *pf = vf->pf;
-	struct ice_hw *hw;
-
-	hw = &pf->hw;
-	ls = &hw->port_info->phy.link_info;
+	struct ice_hw *hw = &vf->pf->hw;
 
 	pfe.event = VIRTCHNL_EVENT_LINK_CHANGE;
 	pfe.severity = PF_EVENT_SEVERITY_INFO;
 
-	/* Always report link is down if the VF queues aren't enabled */
-	if (!vf->num_qs_ena) {
+	if (ice_is_vf_link_up(vf))
+		ice_set_pfe_link(vf, &pfe,
+				 hw->port_info->phy.link_info.link_speed, true);
+	else
 		ice_set_pfe_link(vf, &pfe, ICE_AQ_LINK_SPEED_UNKNOWN, false);
-	} else if (vf->link_forced) {
-		u16 link_speed = vf->link_up ?
-			ls->link_speed : ICE_AQ_LINK_SPEED_UNKNOWN;
-
-		ice_set_pfe_link(vf, &pfe, link_speed, vf->link_up);
-	} else {
-		ice_set_pfe_link(vf, &pfe, ls->link_speed,
-				 ls->link_info & ICE_AQ_LINK_UP);
-	}
 
 	ice_aq_send_msg_to_vf(hw, vf->vf_id, VIRTCHNL_OP_EVENT,
 			      VIRTCHNL_STATUS_SUCCESS, (u8 *)&pfe,
-- 
2.20.1

