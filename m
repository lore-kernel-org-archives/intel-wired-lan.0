From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 13 Apr 2016 03:08:29 -0700
Subject: [Intel-wired-lan] [next PATCH S34 09/12] i40e: Use consistent type
	for vf_id
In-Reply-To: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460542112-20166-10-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The driver was all over the place using signed or unsigned types
for vf_id, when it should always be signed.

This fixes warnings of type unsafe comparisons from gcc with W=2.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-Id: I2cb681f83d0f68ca124d2e4131e4ac0d9f8a6b22
---
Testing Hints : make sure virtchannel (VF) still
works to configure MAC addresses and such from the VF.

 drivers/net/ethernet/intel/i40e/i40e.h             |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 13 +++++++------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index ceb848a..618a2a8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -569,7 +569,7 @@ struct i40e_vsi {
 	u16 num_queue_pairs; /* Used tx and rx pairs */
 	u16 num_desc;
 	enum i40e_vsi_type type;  /* VSI type, e.g., LAN, FCoE, etc */
-	u16 vf_id;		/* Virtual function ID for SRIOV VSIs */
+	s16 vf_id;		/* Virtual function ID for SRIOV VSIs */
 
 	struct i40e_tc_configuration tc_config;
 	struct i40e_aqc_vsi_properties_data info;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 4f0214e..41be42d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -48,7 +48,7 @@ static void i40e_vc_vf_broadcast(struct i40e_pf *pf,
 	int i;
 
 	for (i = 0; i < pf->num_alloc_vfs; i++, vf++) {
-		int abs_vf_id = vf->vf_id + hw->func_caps.vf_base_id;
+		int abs_vf_id = vf->vf_id + (int)hw->func_caps.vf_base_id;
 		/* Not all vfs are enabled so skip the ones that are not */
 		if (!test_bit(I40E_VF_STAT_INIT, &vf->vf_states) &&
 		    !test_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states))
@@ -74,7 +74,7 @@ static void i40e_vc_notify_vf_link_state(struct i40e_vf *vf)
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_hw *hw = &pf->hw;
 	struct i40e_link_status *ls = &pf->hw.phy.link_info;
-	int abs_vf_id = vf->vf_id + hw->func_caps.vf_base_id;
+	int abs_vf_id = vf->vf_id + (int)hw->func_caps.vf_base_id;
 
 	pfe.event = I40E_VIRTCHNL_EVENT_LINK_CHANGE;
 	pfe.severity = I40E_PF_EVENT_SEVERITY_INFO;
@@ -141,7 +141,7 @@ void i40e_vc_notify_vf_reset(struct i40e_vf *vf)
 	    !test_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states))
 		return;
 
-	abs_vf_id = vf->vf_id + vf->pf->hw.func_caps.vf_base_id;
+	abs_vf_id = vf->vf_id + (int)vf->pf->hw.func_caps.vf_base_id;
 
 	pfe.event = I40E_VIRTCHNL_EVENT_RESET_IMPENDING;
 	pfe.severity = I40E_PF_EVENT_SEVERITY_CERTAIN_DOOM;
@@ -2516,11 +2516,11 @@ static int i40e_vc_validate_vf_msg(struct i40e_vf *vf, u32 v_opcode,
  * called from the common aeq/arq handler to
  * process request from VF
  **/
-int i40e_vc_process_vf_msg(struct i40e_pf *pf, u16 vf_id, u32 v_opcode,
+int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
 			   u32 v_retval, u8 *msg, u16 msglen)
 {
 	struct i40e_hw *hw = &pf->hw;
-	unsigned int local_vf_id = vf_id - hw->func_caps.vf_base_id;
+	int local_vf_id = vf_id - (s16)hw->func_caps.vf_base_id;
 	struct i40e_vf *vf;
 	int ret;
 
@@ -2622,9 +2622,10 @@ int i40e_vc_process_vf_msg(struct i40e_pf *pf, u16 vf_id, u32 v_opcode,
  **/
 int i40e_vc_process_vflr_event(struct i40e_pf *pf)
 {
-	u32 reg, reg_idx, bit_idx, vf_id;
 	struct i40e_hw *hw = &pf->hw;
+	u32 reg, reg_idx, bit_idx;
 	struct i40e_vf *vf;
+	int vf_id;
 
 	if (!test_bit(__I40E_VFLR_EVENT_PENDING, &pf->state))
 		return 0;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index bf54873..8751741 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -77,7 +77,7 @@ struct i40e_vf {
 	struct i40e_pf *pf;
 
 	/* VF id in the PF space */
-	u16 vf_id;
+	s16 vf_id;
 	/* all VF vsis connect to the same parent */
 	enum i40e_switch_element_types parent_type;
 	struct i40e_virtchnl_version_info vf_ver;
@@ -121,7 +121,7 @@ struct i40e_vf {
 void i40e_free_vfs(struct i40e_pf *pf);
 int i40e_pci_sriov_configure(struct pci_dev *dev, int num_vfs);
 int i40e_alloc_vfs(struct i40e_pf *pf, u16 num_alloc_vfs);
-int i40e_vc_process_vf_msg(struct i40e_pf *pf, u16 vf_id, u32 v_opcode,
+int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
 			   u32 v_retval, u8 *msg, u16 msglen);
 int i40e_vc_process_vflr_event(struct i40e_pf *pf);
 void i40e_reset_vf(struct i40e_vf *vf, bool flr);
-- 
2.4.3

