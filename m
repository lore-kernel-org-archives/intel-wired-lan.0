From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed,  4 Aug 2021 12:12:42 -0700
Subject: [Intel-wired-lan] [PATCH net] ice: Stop processing VF messages
 during teardown
Message-ID: <20210804191242.871950-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When VFs are setup and torn down in quick succession, it is possible
that a VF is torn down by the PF while the VF's virtchnl requests are
still in the PF's mailbox ring. Processing the VF's virtchnl request
when the VF itself doesn't exist results in undefined behavior. Fix
this by adding a check to stop processing virtchnl requests when VF
teardown is in progress.

Fixes: ddf30f7ff840 ("ice: Add handler to configure SR-IOV")
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h             | 1 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 5517e13..e452397 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -240,6 +240,7 @@ enum ice_pf_state {
 	ICE_VFLR_EVENT_PENDING,
 	ICE_FLTR_OVERFLOW_PROMISC,
 	ICE_VF_DIS,
+	ICE_VF_DEINIT_IN_PROGRESS,
 	ICE_CFG_BUSY,
 	ICE_SERVICE_SCHED,
 	ICE_SERVICE_DIS,
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 85d98a8..9779519 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -499,6 +499,8 @@ void ice_free_vfs(struct ice_pf *pf)
 	struct ice_hw *hw = &pf->hw;
 	unsigned int tmp, i;
 
+	set_bit(ICE_VF_DEINIT_IN_PROGRESS, pf->state);
+
 	if (!pf->vf)
 		return;
 
@@ -567,6 +569,7 @@ void ice_free_vfs(struct ice_pf *pf)
 				i);
 
 	clear_bit(ICE_VF_DIS, pf->state);
+	clear_bit(ICE_VF_DEINIT_IN_PROGRESS, pf->state);
 	clear_bit(ICE_FLAG_SRIOV_ENA, pf->flags);
 }
 
@@ -4527,6 +4530,10 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
 	struct device *dev;
 	int err = 0;
 
+	/* if de-init is underway, don't process messages from VF */
+	if (test_bit(ICE_VF_DEINIT_IN_PROGRESS, pf->state))
+		return;
+
 	dev = ice_pf_to_dev(pf);
 	if (ice_validate_vf_id(pf, vf_id)) {
 		err = -EINVAL;
-- 
2.31.1

