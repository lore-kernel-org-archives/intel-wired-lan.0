From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Feb 2022 16:27:08 -0800
Subject: [Intel-wired-lan] [net-next PATCH 21/25] ice: introduce
 ICE_VF_RESET_NOTIFY flag
In-Reply-To: <20220223002712.2771809-1-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
Message-ID: <20220223002712.2771809-22-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In some cases of resetting a VF, the PF would like to first notify the
VF that a reset is impending. This is currently done via
ice_vc_notify_vf_reset. A wrapper to ice_reset_vf, ice_vf_reset_vf, is
used to call this function first before calling ice_reset_vf.

In fact, every single call to ice_vc_notify_vf_reset occurs just prior
to a call to ice_vc_reset_vf.

Now that ice_reset_vf has flags, replace this separate call with an
ICE_VF_RESET_NOTIFY flag. This removes an unnecessary exported function
of ice_vc_notify_vf_reset, and also makes there be a single function to
reset VFs (ice_reset_vf).

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c  | 44 +++------------------
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 28 +++++++++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib.h |  1 +
 3 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index c234e4edc7f0..46d656d385c4 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -829,30 +829,6 @@ void ice_vc_notify_reset(struct ice_pf *pf)
 			    (u8 *)&pfe, sizeof(struct virtchnl_pf_event));
 }
 
-/**
- * ice_vc_notify_vf_reset - Notify VF of a reset event
- * @vf: pointer to the VF structure
- */
-static void ice_vc_notify_vf_reset(struct ice_vf *vf)
-{
-	struct virtchnl_pf_event pfe;
-	struct ice_pf *pf = vf->pf;
-
-	/* Bail out if VF is in disabled state, neither initialized, nor active
-	 * state - otherwise proceed with notifications
-	 */
-	if ((!test_bit(ICE_VF_STATE_INIT, vf->vf_states) &&
-	     !test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) ||
-	    test_bit(ICE_VF_STATE_DIS, vf->vf_states))
-		return;
-
-	pfe.event = VIRTCHNL_EVENT_RESET_IMPENDING;
-	pfe.severity = PF_EVENT_SEVERITY_CERTAIN_DOOM;
-	ice_aq_send_msg_to_vf(&pf->hw, vf->vf_id, VIRTCHNL_OP_EVENT,
-			      VIRTCHNL_STATUS_SUCCESS, (u8 *)&pfe, sizeof(pfe),
-			      NULL);
-}
-
 /**
  * ice_init_vf_vsi_res - initialize/setup VF VSI resources
  * @vf: VF to initialize/setup the VSI for
@@ -1400,16 +1376,6 @@ void ice_process_vflr_event(struct ice_pf *pf)
 	mutex_unlock(&pf->vfs.table_lock);
 }
 
-/**
- * ice_vc_reset_vf - Perform software reset on the VF after informing the AVF
- * @vf: pointer to the VF info
- */
-static void ice_vc_reset_vf(struct ice_vf *vf)
-{
-	ice_vc_notify_vf_reset(vf);
-	ice_reset_vf(vf, 0);
-}
-
 /**
  * ice_get_vf_from_pfq - get the VF who owns the PF space queue passed in
  * @pf: PF used to index all VFs
@@ -1488,7 +1454,7 @@ ice_vf_lan_overflow_event(struct ice_pf *pf, struct ice_rq_event_info *event)
 		return;
 
 	mutex_lock(&vf->cfg_lock);
-	ice_vc_reset_vf(vf);
+	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
 	mutex_unlock(&vf->cfg_lock);
 
 	ice_put_vf(vf);
@@ -3311,7 +3277,7 @@ static int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 	} else {
 		/* request is successful, then reset VF */
 		vf->num_req_qs = req_queues;
-		ice_vc_reset_vf(vf);
+		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
 		dev_info(dev, "VF %d granted request of %u queues.\n",
 			 vf->vf_id, req_queues);
 		return 0;
@@ -5183,7 +5149,7 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 			    mac, vf_id);
 	}
 
-	ice_vc_reset_vf(vf);
+	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
 	mutex_unlock(&vf->cfg_lock);
 
 out_put_vf:
@@ -5227,7 +5193,7 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 	mutex_lock(&vf->cfg_lock);
 
 	vf->trusted = trusted;
-	ice_vc_reset_vf(vf);
+	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
 	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
 		 vf_id, trusted ? "" : "un");
 
@@ -5549,7 +5515,7 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 	else
 		dev_info(dev, "Clearing port VLAN on VF %d\n", vf_id);
 
-	ice_vc_reset_vf(vf);
+	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
 	mutex_unlock(&vf->cfg_lock);
 
 out_put_vf:
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 3b4e55c62786..dce32bc194a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -441,6 +441,30 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 	mutex_unlock(&pf->vfs.table_lock);
 }
 
+/**
+ * ice_notify_vf_reset - Notify VF of a reset event
+ * @vf: pointer to the VF structure
+ */
+static void ice_notify_vf_reset(struct ice_vf *vf)
+{
+	struct ice_hw *hw = &vf->pf->hw;
+	struct virtchnl_pf_event pfe;
+
+	/* Bail out if VF is in disabled state, neither initialized, nor active
+	 * state - otherwise proceed with notifications
+	 */
+	if ((!test_bit(ICE_VF_STATE_INIT, vf->vf_states) &&
+	     !test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) ||
+	    test_bit(ICE_VF_STATE_DIS, vf->vf_states))
+		return;
+
+	pfe.event = VIRTCHNL_EVENT_RESET_IMPENDING;
+	pfe.severity = PF_EVENT_SEVERITY_CERTAIN_DOOM;
+	ice_aq_send_msg_to_vf(hw, vf->vf_id, VIRTCHNL_OP_EVENT,
+			      VIRTCHNL_STATUS_SUCCESS, (u8 *)&pfe, sizeof(pfe),
+			      NULL);
+}
+
 /**
  * ice_reset_vf - Reset a particular VF
  * @vf: pointer to the VF structure
@@ -448,6 +472,7 @@ void ice_reset_all_vfs(struct ice_pf *pf)
  *
  * Flags:
  *   ICE_VF_RESET_VFLR - Indicates a reset is due to VFLR event
+ *   ICE_VF_RESET_NOTIFY - Send VF a notification prior to reset
  *
  * Returns 0 if the VF is currently in reset, if the resets are disabled, or
  * if the VF resets successfully. Returns an error code if the VF fails to
@@ -467,6 +492,9 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 	dev = ice_pf_to_dev(pf);
 	hw = &pf->hw;
 
+	if (flags & ICE_VF_RESET_NOTIFY)
+		ice_notify_vf_reset(vf);
+
 	if (test_bit(ICE_VF_RESETS_DISABLED, pf->state)) {
 		dev_dbg(dev, "Trying to reset VF %d, but all VF resets are disabled\n",
 			vf->vf_id);
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index f33d55f8bcc3..9155c0d2f998 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -136,6 +136,7 @@ struct ice_vf {
 /* Flags for controlling behavior of ice_reset_vf */
 enum ice_vf_reset_flags {
 	ICE_VF_RESET_VFLR = BIT(0), /* Indicate a VFLR reset */
+	ICE_VF_RESET_NOTIFY = BIT(1), /* Notify VF prior to reset */
 };
 
 static inline u16 ice_vf_get_port_vlan_id(struct ice_vf *vf)
-- 
2.35.1.129.gb80121027d12

