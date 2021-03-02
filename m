From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  2 Mar 2021 10:15:39 -0800
Subject: [Intel-wired-lan] [PATCH S56 07/13] ice: Add helper function to get
 the VF's VSI
In-Reply-To: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
Message-ID: <20210302181545.51822-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently, the driver gets the VF's VSI by using a long string of
dereferences (i.e. vf->pf->vsi[vf->lan_vsi_idx]). If the method to get
the VF's VSI were to change the driver would have to change it in every
location. Fix this by adding the helper ice_get_vf_vsi().

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 82 +++++++++----------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 2d4b39a9f788..7ffad4c8a64e 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -7,6 +7,15 @@
 #include "ice_fltr.h"
 #include "ice_virtchnl_allowlist.h"
 
+/**
+ * ice_get_vf_vsi - get VF's VSI based on the stored index
+ * @vf: VF used to get VSI
+ */
+static struct ice_vsi *ice_get_vf_vsi(struct ice_vf *vf)
+{
+	return vf->pf->vsi[vf->lan_vsi_idx];
+}
+
 /**
  * ice_validate_vf_id - helper to check if VF ID is valid
  * @pf: pointer to the PF structure
@@ -167,7 +176,7 @@ static void ice_vf_invalidate_vsi(struct ice_vf *vf)
  */
 static void ice_vf_vsi_release(struct ice_vf *vf)
 {
-	ice_vsi_release(vf->pf->vsi[vf->lan_vsi_idx]);
+	ice_vsi_release(ice_get_vf_vsi(vf));
 	ice_vf_invalidate_vsi(vf);
 }
 
@@ -243,7 +252,7 @@ static void ice_dis_vf_mappings(struct ice_vf *vf)
 	struct ice_hw *hw;
 
 	hw = &pf->hw;
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 
 	dev = ice_pf_to_dev(pf);
 	wr32(hw, VPINT_ALLOC(vf->vf_id), 0);
@@ -318,10 +327,7 @@ void ice_set_vf_state_qs_dis(struct ice_vf *vf)
  */
 static void ice_dis_vf_qs(struct ice_vf *vf)
 {
-	struct ice_pf *pf = vf->pf;
-	struct ice_vsi *vsi;
-
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
 
 	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, vf->vf_id);
 	ice_vsi_stop_all_rx_rings(vsi);
@@ -609,8 +615,8 @@ static int ice_calc_vf_first_vector_idx(struct ice_pf *pf, struct ice_vf *vf)
  */
 static int ice_vf_rebuild_host_vlan_cfg(struct ice_vf *vf)
 {
-	struct ice_vsi *vsi = vf->pf->vsi[vf->lan_vsi_idx];
 	struct device *dev = ice_pf_to_dev(vf->pf);
+	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
 	u16 vlan_id = 0;
 	int err;
 
@@ -646,8 +652,8 @@ static int ice_vf_rebuild_host_vlan_cfg(struct ice_vf *vf)
  */
 static int ice_vf_rebuild_host_mac_cfg(struct ice_vf *vf)
 {
-	struct ice_vsi *vsi = vf->pf->vsi[vf->lan_vsi_idx];
 	struct device *dev = ice_pf_to_dev(vf->pf);
+	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
 	enum ice_status status;
 	u8 broadcast[ETH_ALEN];
 
@@ -750,8 +756,8 @@ static void ice_ena_vf_msix_mappings(struct ice_vf *vf)
  */
 static void ice_ena_vf_q_mappings(struct ice_vf *vf, u16 max_txq, u16 max_rxq)
 {
-	struct ice_vsi *vsi = vf->pf->vsi[vf->lan_vsi_idx];
 	struct device *dev = ice_pf_to_dev(vf->pf);
+	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
 	struct ice_hw *hw = &vf->pf->hw;
 	u32 reg;
 
@@ -798,7 +804,7 @@ static void ice_ena_vf_q_mappings(struct ice_vf *vf, u16 max_txq, u16 max_rxq)
  */
 static void ice_ena_vf_mappings(struct ice_vf *vf)
 {
-	struct ice_vsi *vsi = vf->pf->vsi[vf->lan_vsi_idx];
+	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
 
 	ice_ena_vf_msix_mappings(vf);
 	ice_ena_vf_q_mappings(vf, vsi->alloc_txq, vsi->alloc_rxq);
@@ -1064,7 +1070,7 @@ static int ice_vf_clear_vsi_promisc(struct ice_vf *vf, struct ice_vsi *vsi, u8 p
 
 static void ice_vf_clear_counters(struct ice_vf *vf)
 {
-	struct ice_vsi *vsi = vf->pf->vsi[vf->lan_vsi_idx];
+	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
 
 	vf->num_mac = 0;
 	vsi->num_vlan = 0;
@@ -1124,8 +1130,8 @@ static void ice_vf_rebuild_aggregator_node_cfg(struct ice_vsi *vsi)
  */
 static void ice_vf_rebuild_host_cfg(struct ice_vf *vf)
 {
-	struct ice_vsi *vsi = vf->pf->vsi[vf->lan_vsi_idx];
 	struct device *dev = ice_pf_to_dev(vf->pf);
+	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
 
 	ice_vf_set_host_trust_cfg(vf);
 
@@ -1165,10 +1171,8 @@ static int ice_vf_rebuild_vsi_with_release(struct ice_vf *vf)
  */
 static int ice_vf_rebuild_vsi(struct ice_vf *vf)
 {
+	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
 	struct ice_pf *pf = vf->pf;
-	struct ice_vsi *vsi;
-
-	vsi = pf->vsi[vf->lan_vsi_idx];
 
 	if (ice_vsi_rebuild(vsi, true)) {
 		dev_err(ice_pf_to_dev(pf), "failed to rebuild VF %d VSI\n",
@@ -1367,7 +1371,7 @@ bool ice_reset_vf(struct ice_vf *vf, bool is_vflr)
 	set_bit(ICE_VF_STATE_DIS, vf->vf_states);
 	ice_trigger_vf_reset(vf, is_vflr, false);
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 
 	if (test_bit(ICE_VF_STATE_QS_ENA, vf->vf_states))
 		ice_dis_vf_qs(vf);
@@ -1416,7 +1420,7 @@ bool ice_reset_vf(struct ice_vf *vf, bool is_vflr)
 		else
 			promisc_m = ICE_UCAST_PROMISC_BITS;
 
-		vsi = pf->vsi[vf->lan_vsi_idx];
+		vsi = ice_get_vf_vsi(vf);
 		if (ice_vf_clear_vsi_promisc(vf, vsi, promisc_m))
 			dev_err(dev, "disabling promiscuous mode failed\n");
 	}
@@ -1867,7 +1871,7 @@ static struct ice_vf *ice_get_vf_from_pfq(struct ice_pf *pf, u16 pfq)
 		struct ice_vsi *vsi;
 		u16 rxq_idx;
 
-		vsi = pf->vsi[vf->lan_vsi_idx];
+		vsi = ice_get_vf_vsi(vf);
 
 		ice_for_each_rxq(vsi, rxq_idx)
 			if (vsi->rxq_map[rxq_idx] == pfq)
@@ -2007,8 +2011,7 @@ static int ice_vc_get_ver_msg(struct ice_vf *vf, u8 *msg)
  */
 static u16 ice_vc_get_max_frame_size(struct ice_vf *vf)
 {
-	struct ice_vsi *vsi = vf->pf->vsi[vf->lan_vsi_idx];
-	struct ice_port_info *pi = vsi->port_info;
+	struct ice_port_info *pi = ice_vf_get_port_info(vf);
 	u16 max_frame_size;
 
 	max_frame_size = pi->phy.link_info.max_frame_size;
@@ -2056,7 +2059,7 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 				  VIRTCHNL_VF_OFFLOAD_VLAN;
 
 	vfres->vf_cap_flags = VIRTCHNL_VF_OFFLOAD_L2;
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 	if (!vsi) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto err;
@@ -2223,7 +2226,6 @@ static int ice_vc_config_rss_key(struct ice_vf *vf, u8 *msg)
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
 	struct virtchnl_rss_key *vrk =
 		(struct virtchnl_rss_key *)msg;
-	struct ice_pf *pf = vf->pf;
 	struct ice_vsi *vsi;
 
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
@@ -2246,7 +2248,7 @@ static int ice_vc_config_rss_key(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 	if (!vsi) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
@@ -2270,7 +2272,6 @@ static int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *msg)
 {
 	struct virtchnl_rss_lut *vrl = (struct virtchnl_rss_lut *)msg;
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	struct ice_pf *pf = vf->pf;
 	struct ice_vsi *vsi;
 
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
@@ -2293,7 +2294,7 @@ static int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 	if (!vsi) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
@@ -2376,7 +2377,7 @@ int ice_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool ena)
 	if (ret)
 		return ret;
 
-	vf_vsi = pf->vsi[vf->lan_vsi_idx];
+	vf_vsi = ice_get_vf_vsi(vf);
 	if (!vf_vsi) {
 		netdev_err(netdev, "VSI %d for VF %d is null\n",
 			   vf->lan_vsi_idx, vf->vf_id);
@@ -2482,7 +2483,7 @@ static int ice_vc_cfg_promiscuous_mode_msg(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 	if (!vsi) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
@@ -2614,7 +2615,6 @@ static int ice_vc_get_stats_msg(struct ice_vf *vf, u8 *msg)
 	struct virtchnl_queue_select *vqs =
 		(struct virtchnl_queue_select *)msg;
 	struct ice_eth_stats stats = { 0 };
-	struct ice_pf *pf = vf->pf;
 	struct ice_vsi *vsi;
 
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
@@ -2627,7 +2627,7 @@ static int ice_vc_get_stats_msg(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 	if (!vsi) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
@@ -2717,7 +2717,6 @@ static int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
 	struct virtchnl_queue_select *vqs =
 	    (struct virtchnl_queue_select *)msg;
-	struct ice_pf *pf = vf->pf;
 	struct ice_vsi *vsi;
 	unsigned long q_map;
 	u16 vf_q_id;
@@ -2737,7 +2736,7 @@ static int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 	if (!vsi) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
@@ -2807,7 +2806,6 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
 	struct virtchnl_queue_select *vqs =
 	    (struct virtchnl_queue_select *)msg;
-	struct ice_pf *pf = vf->pf;
 	struct ice_vsi *vsi;
 	unsigned long q_map;
 	u16 vf_q_id;
@@ -2828,7 +2826,7 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 	if (!vsi) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
@@ -2993,7 +2991,7 @@ static int ice_vc_cfg_irq_map_msg(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 	if (!vsi) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
@@ -3070,7 +3068,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 	if (!vsi) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
@@ -3422,7 +3420,7 @@ ice_vc_handle_mac_addr_msg(struct ice_vf *vf, u8 *msg, bool set)
 		goto handle_mac_exit;
 	}
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 	if (!vsi) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto handle_mac_exit;
@@ -3654,7 +3652,7 @@ static int ice_vc_process_vlan_msg(struct ice_vf *vf, u8 *msg, bool add_v)
 	}
 
 	hw = &pf->hw;
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 	if (!vsi) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
@@ -3821,7 +3819,6 @@ static int ice_vc_remove_vlan_msg(struct ice_vf *vf, u8 *msg)
 static int ice_vc_ena_vlan_stripping(struct ice_vf *vf)
 {
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	struct ice_pf *pf = vf->pf;
 	struct ice_vsi *vsi;
 
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
@@ -3834,7 +3831,7 @@ static int ice_vc_ena_vlan_stripping(struct ice_vf *vf)
 		goto error_param;
 	}
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 	if (ice_vsi_manage_vlan_stripping(vsi, true))
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 
@@ -3852,7 +3849,6 @@ static int ice_vc_ena_vlan_stripping(struct ice_vf *vf)
 static int ice_vc_dis_vlan_stripping(struct ice_vf *vf)
 {
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	struct ice_pf *pf = vf->pf;
 	struct ice_vsi *vsi;
 
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
@@ -3865,7 +3861,7 @@ static int ice_vc_dis_vlan_stripping(struct ice_vf *vf)
 		goto error_param;
 	}
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 	if (!vsi) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
@@ -3891,7 +3887,7 @@ static int ice_vc_dis_vlan_stripping(struct ice_vf *vf)
  */
 static int ice_vf_init_vlan_stripping(struct ice_vf *vf)
 {
-	struct ice_vsi *vsi = vf->pf->vsi[vf->lan_vsi_idx];
+	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
 
 	if (!vsi)
 		return -EINVAL;
@@ -4281,7 +4277,7 @@ int ice_get_vf_stats(struct net_device *netdev, int vf_id,
 	if (ret)
 		return ret;
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	vsi = ice_get_vf_vsi(vf);
 	if (!vsi)
 		return -EINVAL;
 
-- 
2.20.1

