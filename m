From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:51:08 -0800
Subject: [Intel-wired-lan] [PATCH S13 12/16] ice: Get VF VSI instances
 directly via PF
In-Reply-To: <20190208205112.12180-1-anirudh.venkataramanan@intel.com>
References: <20190208205112.12180-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205112.12180-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

This patch changes how we get VF VSIs instances. Instead of relying on
mailbox virtual channel message to retrieve VSI, it is more reliable
getting it directly via VF object in PF data structure.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 35 ++++++++++++++++++------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 70bd81ea1943..b84620068a3c 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1390,6 +1390,11 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 
 	vfres->vf_cap_flags = VIRTCHNL_VF_OFFLOAD_L2;
 	vsi = pf->vsi[vf->lan_vsi_idx];
+	if (!vsi) {
+		aq_ret = ICE_ERR_PARAM;
+		goto err;
+	}
+
 	if (!vsi->info.pvid)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_VLAN;
 
@@ -1523,6 +1528,7 @@ static int ice_vc_config_rss_key(struct ice_vf *vf, u8 *msg)
 	struct virtchnl_rss_key *vrk =
 		(struct virtchnl_rss_key *)msg;
 	struct ice_vsi *vsi = NULL;
+	struct ice_pf *pf = vf->pf;
 	enum ice_status aq_ret;
 	int ret;
 
@@ -1536,7 +1542,7 @@ static int ice_vc_config_rss_key(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	vsi = ice_find_vsi_from_id(vf->pf, vrk->vsi_id);
+	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (!vsi) {
 		aq_ret = ICE_ERR_PARAM;
 		goto error_param;
@@ -1570,6 +1576,7 @@ static int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *msg)
 {
 	struct virtchnl_rss_lut *vrl = (struct virtchnl_rss_lut *)msg;
 	struct ice_vsi *vsi = NULL;
+	struct ice_pf *pf = vf->pf;
 	enum ice_status aq_ret;
 	int ret;
 
@@ -1583,7 +1590,7 @@ static int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	vsi = ice_find_vsi_from_id(vf->pf, vrl->vsi_id);
+	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (!vsi) {
 		aq_ret = ICE_ERR_PARAM;
 		goto error_param;
@@ -1618,6 +1625,7 @@ static int ice_vc_get_stats_msg(struct ice_vf *vf, u8 *msg)
 	struct virtchnl_queue_select *vqs =
 		(struct virtchnl_queue_select *)msg;
 	enum ice_status aq_ret = 0;
+	struct ice_pf *pf = vf->pf;
 	struct ice_eth_stats stats;
 	struct ice_vsi *vsi;
 
@@ -1631,7 +1639,7 @@ static int ice_vc_get_stats_msg(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	vsi = ice_find_vsi_from_id(vf->pf, vqs->vsi_id);
+	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (!vsi) {
 		aq_ret = ICE_ERR_PARAM;
 		goto error_param;
@@ -1660,6 +1668,7 @@ static int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 	struct virtchnl_queue_select *vqs =
 	    (struct virtchnl_queue_select *)msg;
 	enum ice_status aq_ret = 0;
+	struct ice_pf *pf = vf->pf;
 	struct ice_vsi *vsi;
 
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
@@ -1677,7 +1686,7 @@ static int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	vsi = ice_find_vsi_from_id(vf->pf, vqs->vsi_id);
+	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (!vsi) {
 		aq_ret = ICE_ERR_PARAM;
 		goto error_param;
@@ -1713,6 +1722,7 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 	struct virtchnl_queue_select *vqs =
 	    (struct virtchnl_queue_select *)msg;
 	enum ice_status aq_ret = 0;
+	struct ice_pf *pf = vf->pf;
 	struct ice_vsi *vsi;
 
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states) &&
@@ -1731,7 +1741,7 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	vsi = ice_find_vsi_from_id(vf->pf, vqs->vsi_id);
+	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (!vsi) {
 		aq_ret = ICE_ERR_PARAM;
 		goto error_param;
@@ -1797,7 +1807,7 @@ static int ice_vc_cfg_irq_map_msg(struct ice_vf *vf, u8 *msg)
 			goto error_param;
 		}
 
-		vsi = ice_find_vsi_from_id(vf->pf, vsi_id);
+		vsi = pf->vsi[vf->lan_vsi_idx];
 		if (!vsi) {
 			aq_ret = ICE_ERR_PARAM;
 			goto error_param;
@@ -1868,7 +1878,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	vsi = ice_find_vsi_from_id(vf->pf, qci->vsi_id);
+	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (!vsi) {
 		aq_ret = ICE_ERR_PARAM;
 		goto error_param;
@@ -1998,6 +2008,10 @@ ice_vc_handle_mac_addr_msg(struct ice_vf *vf, u8 *msg, bool set)
 	}
 
 	vsi = pf->vsi[vf->lan_vsi_idx];
+	if (!vsi) {
+		ret = ICE_ERR_PARAM;
+		goto handle_mac_exit;
+	}
 
 	for (i = 0; i < al->num_elements; i++) {
 		u8 *maddr = al->list[i].addr;
@@ -2291,7 +2305,7 @@ static int ice_vc_process_vlan_msg(struct ice_vf *vf, u8 *msg, bool add_v)
 	}
 
 	hw = &pf->hw;
-	vsi = ice_find_vsi_from_id(vf->pf, vfl->vsi_id);
+	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (!vsi) {
 		aq_ret = ICE_ERR_PARAM;
 		goto error_param;
@@ -2452,6 +2466,11 @@ static int ice_vc_dis_vlan_stripping(struct ice_vf *vf)
 	}
 
 	vsi = pf->vsi[vf->lan_vsi_idx];
+	if (!vsi) {
+		aq_ret = ICE_ERR_PARAM;
+		goto error_param;
+	}
+
 	if (ice_vsi_manage_vlan_stripping(vsi, false))
 		aq_ret = ICE_ERR_AQ_ERROR;
 
-- 
2.14.5

