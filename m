From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:55:02 -0700
Subject: [Intel-wired-lan] [PATCH S46 5/9] ice: fix function signature style
 format
In-Reply-To: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
References: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516005506.5113-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Where possible, cuddle multiple lines of function signatures to be
consistent throughout the code.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c |  3 +--
 drivers/net/ethernet/intel/ice/ice_sched.c    | 12 ++++--------
 drivers/net/ethernet/intel/ice/ice_switch.c   |  9 +++------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index 479a74efc536..1e18021aa073 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -769,8 +769,7 @@ enum ice_status ice_create_all_ctrlq(struct ice_hw *hw)
  *
  * Destroys the send and receive queue locks for a given control queue.
  */
-static void
-ice_destroy_ctrlq_locks(struct ice_ctl_q_info *cq)
+static void ice_destroy_ctrlq_locks(struct ice_ctl_q_info *cq)
 {
 	mutex_destroy(&cq->sq_lock);
 	mutex_destroy(&cq->rq_lock);
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index e2bc7cfea254..5cfb3637dc3e 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -1771,8 +1771,7 @@ ice_sched_cfg_vsi(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u16 maxqs,
  * This function removes single aggregator VSI info entry from
  * aggregator list.
  */
-static void
-ice_sched_rm_agg_vsi_info(struct ice_port_info *pi, u16 vsi_handle)
+static void ice_sched_rm_agg_vsi_info(struct ice_port_info *pi, u16 vsi_handle)
 {
 	struct ice_sched_agg_info *agg_info;
 	struct ice_sched_agg_info *atmp;
@@ -2006,8 +2005,7 @@ ice_sched_cfg_node_bw_alloc(struct ice_hw *hw, struct ice_sched_node *node,
  *
  * Save or clear CIR bandwidth (BW) in the passed param bw_t_info.
  */
-static void
-ice_set_clear_cir_bw(struct ice_bw_type_info *bw_t_info, u32 bw)
+static void ice_set_clear_cir_bw(struct ice_bw_type_info *bw_t_info, u32 bw)
 {
 	if (bw == ICE_SCHED_DFLT_BW) {
 		clear_bit(ICE_BW_TYPE_CIR, bw_t_info->bw_t_bitmap);
@@ -2026,8 +2024,7 @@ ice_set_clear_cir_bw(struct ice_bw_type_info *bw_t_info, u32 bw)
  *
  * Save or clear EIR bandwidth (BW) in the passed param bw_t_info.
  */
-static void
-ice_set_clear_eir_bw(struct ice_bw_type_info *bw_t_info, u32 bw)
+static void ice_set_clear_eir_bw(struct ice_bw_type_info *bw_t_info, u32 bw)
 {
 	if (bw == ICE_SCHED_DFLT_BW) {
 		clear_bit(ICE_BW_TYPE_EIR, bw_t_info->bw_t_bitmap);
@@ -2052,8 +2049,7 @@ ice_set_clear_eir_bw(struct ice_bw_type_info *bw_t_info, u32 bw)
  *
  * Save or clear shared bandwidth (BW) in the passed param bw_t_info.
  */
-static void
-ice_set_clear_shared_bw(struct ice_bw_type_info *bw_t_info, u32 bw)
+static void ice_set_clear_shared_bw(struct ice_bw_type_info *bw_t_info, u32 bw)
 {
 	if (bw == ICE_SCHED_DFLT_BW) {
 		clear_bit(ICE_BW_TYPE_SHARED, bw_t_info->bw_t_bitmap);
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 5760f2a3a8a4..9d5b527d5e38 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1639,8 +1639,7 @@ ice_remove_rule_internal(struct ice_hw *hw, u8 recp_id,
  * check for duplicates in this case, removing duplicates from a given
  * list should be taken care of in the caller of this function.
  */
-enum ice_status
-ice_add_mac(struct ice_hw *hw, struct list_head *m_list)
+enum ice_status ice_add_mac(struct ice_hw *hw, struct list_head *m_list)
 {
 	struct ice_aqc_sw_rules_elem *s_rule, *r_iter;
 	struct ice_fltr_list_entry *m_list_itr;
@@ -1941,8 +1940,7 @@ ice_add_vlan_internal(struct ice_hw *hw, struct ice_fltr_list_entry *f_entry)
  * @hw: pointer to the hardware structure
  * @v_list: list of VLAN entries and forwarding information
  */
-enum ice_status
-ice_add_vlan(struct ice_hw *hw, struct list_head *v_list)
+enum ice_status ice_add_vlan(struct ice_hw *hw, struct list_head *v_list)
 {
 	struct ice_fltr_list_entry *v_list_itr;
 
@@ -2172,8 +2170,7 @@ ice_find_ucast_rule_entry(struct ice_hw *hw, u8 recp_id,
  * the entries passed into m_list were added previously. It will not attempt to
  * do a partial remove of entries that were found.
  */
-enum ice_status
-ice_remove_mac(struct ice_hw *hw, struct list_head *m_list)
+enum ice_status ice_remove_mac(struct ice_hw *hw, struct list_head *m_list)
 {
 	struct ice_fltr_list_entry *list_itr, *tmp;
 	struct mutex *rule_lock; /* Lock to protect filter rule list */
-- 
2.20.1

