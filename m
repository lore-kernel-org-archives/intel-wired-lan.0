From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 19 Feb 2019 15:04:12 -0800
Subject: [Intel-wired-lan] [PATCH S15 12/14] ice: Fix typos in code comments
In-Reply-To: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190219230414.25627-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixes typos in code comments.

Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h             | 2 +-
 drivers/net/ethernet/intel/ice/ice_common.c      | 6 +++---
 drivers/net/ethernet/intel/ice/ice_main.c        | 2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 046d05a028b2..576f3d5f77f5 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -162,7 +162,7 @@ struct ice_res_tracker {
 };
 
 struct ice_qs_cfg {
-	struct mutex *qs_mutex;  /* will be assgined to &pf->avail_q_mutex */
+	struct mutex *qs_mutex;  /* will be assigned to &pf->avail_q_mutex */
 	unsigned long *pf_map;
 	unsigned long pf_map_size;
 	unsigned int q_count;
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 5e7a31421c0d..aeae0205bec3 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2477,7 +2477,7 @@ ice_aq_add_lan_txq(struct ice_hw *hw, u8 num_qgrps,
  * @num_qgrps: number of groups in the list
  * @qg_list: the list of groups to disable
  * @buf_size: the total size of the qg_list buffer in bytes
- * @rst_src: if called due to reset, specifies the RST source
+ * @rst_src: if called due to reset, specifies the reset source
  * @vmvf_num: the relative VM or VF number that is undergoing the reset
  * @cd: pointer to command details structure or NULL
  *
@@ -2874,7 +2874,7 @@ ice_ena_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_qgrps,
  * @num_queues: number of queues
  * @q_ids: pointer to the q_id array
  * @q_teids: pointer to queue node teids
- * @rst_src: if called due to reset, specifies the RST source
+ * @rst_src: if called due to reset, specifies the reset source
  * @vmvf_num: the relative VM or VF number that is undergoing the reset
  * @cd: pointer to command details structure or NULL
  *
@@ -2925,7 +2925,7 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u8 num_queues, u16 *q_ids,
 }
 
 /**
- * ice_cfg_vsi_qs - configure the new/exisiting VSI queues
+ * ice_cfg_vsi_qs - configure the new/existing VSI queues
  * @pi: port information structure
  * @vsi_handle: software VSI handle
  * @tc_bitmap: TC bitmap
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e53166cd1797..7b3adc6f65e2 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -504,7 +504,7 @@ static void ice_reset_subtask(struct ice_pf *pf)
 			pf->hw.reset_ongoing = false;
 			ice_rebuild(pf);
 			/* clear bit to resume normal operations, but
-			 * ICE_NEEDS_RESTART bit is set incase rebuild failed
+			 * ICE_NEEDS_RESTART bit is set in case rebuild failed
 			 */
 			clear_bit(__ICE_RESET_OICR_RECV, pf->state);
 			clear_bit(__ICE_PREPARED_FOR_RESET, pf->state);
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index e322bde45c59..6d1fc97c5eb1 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -513,7 +513,7 @@ static int ice_alloc_vsi_res(struct ice_vf *vf)
 
 	/* Clear this bit after VF initialization since we shouldn't reclaim
 	 * and reassign interrupts for synchronous or asynchronous VFR events.
-	 * We dont want to reconfigure interrupts since AVF driver doesn't
+	 * We don't want to reconfigure interrupts since AVF driver doesn't
 	 * expect vector assignment to be changed unless there is a request for
 	 * more vectors.
 	 */
-- 
2.14.5

