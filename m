From: Qi Zhang <qi.z.zhang@intel.com>
Date: Fri, 10 Jul 2020 09:06:36 +0800
Subject: [Intel-wired-lan] [PATCH S48 v5 08/16] ice: Support RSS configure
 removal for AVF
In-Reply-To: <20200710010644.33817-1-qi.z.zhang@intel.com>
References: <20200710010644.33817-1-qi.z.zhang@intel.com>
Message-ID: <20200710010644.33817-9-qi.z.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add ice_add_rss_cfg's reverse operation ice_rem_rss_cfg.
It is invoked when handle VIRTCHNL_OP_DEL_RSS_CFG.

Signed-off-by: Vignesh Sridhar <vignesh.sridhar@intel.com>
Signed-off-by: Jia Guo <jia.guo@intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flow.c        | 90 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_flow.h        |  5 ++
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 17 ++++-
 3 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 731f1156d92d..6455b85712b8 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -2131,6 +2131,96 @@ ice_add_rss_cfg(struct ice_hw *hw, u16 vsi_handle, u64 hashed_flds,
 	return status;
 }
 
+#ifdef CONFIG_PCI_IOV
+/**
+ * ice_rem_rss_cfg_sync - remove an existing RSS configuration
+ * @hw: pointer to the hardware structure
+ * @vsi_handle: software VSI handle
+ * @hashed_flds: Packet hash types (ICE_FLOW_HASH_*) to remove
+ * @addl_hdrs: Protocol header fields within a packet segment
+ * @segs_cnt: packet segment count
+ *
+ * Assumption: lock has already been acquired for RSS list
+ */
+static enum ice_status
+ice_rem_rss_cfg_sync(struct ice_hw *hw, u16 vsi_handle, u64 hashed_flds,
+		     u32 addl_hdrs, u8 segs_cnt)
+{
+	const enum ice_block blk = ICE_BLK_RSS;
+	struct ice_flow_seg_info *segs;
+	struct ice_flow_prof *prof;
+	enum ice_status status;
+
+	segs = kcalloc(segs_cnt, sizeof(*segs), GFP_KERNEL);
+	if (!segs)
+		return ICE_ERR_NO_MEMORY;
+
+	/* Construct the packet segment info from the hashed fields */
+	status = ice_flow_set_rss_seg_info(&segs[segs_cnt - 1], hashed_flds,
+					   addl_hdrs);
+	if (status)
+		goto out;
+
+	prof = ice_flow_find_prof_conds(hw, blk, ICE_FLOW_RX, segs, segs_cnt,
+					vsi_handle,
+					ICE_FLOW_FIND_PROF_CHK_FLDS);
+	if (!prof) {
+		status = ICE_ERR_DOES_NOT_EXIST;
+		goto out;
+	}
+
+	status = ice_flow_disassoc_prof(hw, blk, prof, vsi_handle);
+	if (status)
+		goto out;
+
+	/* Remove RSS configuration from VSI context before deleting
+	 * the flow profile.
+	 */
+	ice_rem_rss_list(hw, vsi_handle, prof);
+
+	if (bitmap_empty(prof->vsis, ICE_MAX_VSI))
+		status = ice_flow_rem_prof(hw, blk, prof->id);
+
+out:
+	kfree(segs);
+	return status;
+}
+
+/**
+ * ice_rem_rss_cfg - remove an existing RSS config with matching hashed fields
+ * @hw: pointer to the hardware structure
+ * @vsi_handle: software VSI handle
+ * @hashed_flds: Packet hash types (ICE_FLOW_HASH_*) to remove
+ * @addl_hdrs: Protocol header fields within a packet segment
+ *
+ * This function will lookup the flow profile based on the input
+ * hash field bitmap, iterate through the profile entry list of
+ * that profile and find entry associated with input VSI to be
+ * removed. Calls are made to underlying flow apis which will in
+ * turn build or update buffers for RSS XLT1 section.
+ */
+enum ice_status
+ice_rem_rss_cfg(struct ice_hw *hw, u16 vsi_handle, u64 hashed_flds,
+		u32 addl_hdrs)
+{
+	enum ice_status status;
+
+	if (hashed_flds == ICE_HASH_INVALID ||
+	    !ice_is_vsi_valid(hw, vsi_handle))
+		return ICE_ERR_PARAM;
+
+	mutex_lock(&hw->rss_locks);
+	status = ice_rem_rss_cfg_sync(hw, vsi_handle, hashed_flds, addl_hdrs,
+				      ICE_RSS_OUTER_HEADERS);
+	if (!status)
+		status = ice_rem_rss_cfg_sync(hw, vsi_handle, hashed_flds,
+					      addl_hdrs, ICE_RSS_INNER_HEADERS);
+	mutex_unlock(&hw->rss_locks);
+
+	return status;
+}
+#endif /* CONFIG_PCI_IOV */
+
 /* Mapping of AVF hash bit fields to an L3-L4 hash combination.
  * As the ice_flow_avf_hdr_field represent individual bit shifts in a hash,
  * convert its values to their appropriate flow L3, L4 values.
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethernet/intel/ice/ice_flow.h
index 571b81d77fde..85d001b99e9f 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.h
+++ b/drivers/net/ethernet/intel/ice/ice_flow.h
@@ -408,5 +408,10 @@ enum ice_status ice_rem_vsi_rss_cfg(struct ice_hw *hw, u16 vsi_handle);
 enum ice_status
 ice_add_rss_cfg(struct ice_hw *hw, u16 vsi_handle, u64 hashed_flds,
 		u32 addl_hdrs);
+#ifdef CONFIG_PCI_IOV
+enum ice_status
+ice_rem_rss_cfg(struct ice_hw *hw, u16 vsi_handle, u64 hashed_flds,
+		u32 addl_hdrs);
+#endif /* CONFIG_PCI_IOV */
 u64 ice_get_rss_cfg(struct ice_hw *hw, u16 vsi_handle, u32 hdrs);
 #endif /* _ICE_FLOW_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index ec48c0b46f16..c71e930bfdb9 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2579,8 +2579,21 @@ static int ice_vc_handle_rss_cfg(struct ice_vf *vf, u8 *msg, bool add)
 					vsi->vsi_num, v_ret);
 			}
 		} else {
-			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-			dev_err(dev, "RSS removal not support\n");
+			enum ice_status status;
+
+			status = ice_rem_rss_cfg(hw, vsi->idx, hash_flds,
+						 addl_hdrs);
+			/* We just ignore ICE_ERR_DOES_NOT_EXIST, because
+			 * if two configurations share the same profile remove
+			 * one of them actually removes both, since the
+			 * profile is deleted.
+			 */
+			if (status && status != ICE_ERR_DOES_NOT_EXIST) {
+				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+				dev_err(dev,
+					"ice_rem_rss_cfg failed for vsi = %d, v_ret = %d\n",
+					vsi->vsi_num, v_ret);
+			}
 		}
 	}
 
-- 
2.13.6

