From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  2 Mar 2021 10:15:42 -0800
Subject: [Intel-wired-lan] [PATCH S56 10/13] ice: cleanup style issues
In-Reply-To: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
Message-ID: <20210302181545.51822-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

A few style issues reported by checkpatch have snuck into the code; resolve
the style issues.

COMPLEX_MACRO: Macros with complex values should be enclosed in parentheses

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.h  | 4 ++--
 drivers/net/ethernet/intel/ice/ice_flex_type.h | 4 ++--
 drivers/net/ethernet/intel/ice/ice_flow.c      | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index 68866f4f0eb0..77c2307d4fb8 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -14,8 +14,8 @@
 	(&(((struct ice_aq_desc *)((R).desc_buf.va))[i]))
 
 #define ICE_CTL_Q_DESC_UNUSED(R) \
-	(u16)((((R)->next_to_clean > (R)->next_to_use) ? 0 : (R)->count) + \
-	      (R)->next_to_clean - (R)->next_to_use - 1)
+	((u16)((((R)->next_to_clean > (R)->next_to_use) ? 0 : (R)->count) + \
+	       (R)->next_to_clean - (R)->next_to_use - 1))
 
 /* Defines that help manage the driver vs FW API checks.
  * Take a look at ice_aq_ver_check in ice_controlq.c for actual usage.
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_type.h b/drivers/net/ethernet/intel/ice/ice_flex_type.h
index bc20cff7ab9d..d43b8360b1bb 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_flex_type.h
@@ -497,8 +497,8 @@ struct ice_xlt1 {
 #define ICE_PF_NUM_S	13
 #define ICE_PF_NUM_M	(0x07 << ICE_PF_NUM_S)
 #define ICE_VSIG_VALUE(vsig, pf_id) \
-	(u16)((((u16)(vsig)) & ICE_VSIG_IDX_M) | \
-	      (((u16)(pf_id) << ICE_PF_NUM_S) & ICE_PF_NUM_M))
+	((u16)((((u16)(vsig)) & ICE_VSIG_IDX_M) | \
+	       (((u16)(pf_id) << ICE_PF_NUM_S) & ICE_PF_NUM_M)))
 #define ICE_DEFAULT_VSIG	0
 
 /* XLT2 Table */
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 2eec44ef2346..56715decd496 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -2008,9 +2008,9 @@ ice_add_rss_list(struct ice_hw *hw, u16 vsi_handle, struct ice_flow_prof *prof)
  * [63] - Encapsulation flag, 0 if non-tunneled, 1 if tunneled
  */
 #define ICE_FLOW_GEN_PROFID(hash, hdr, segs_cnt) \
-	(u64)(((u64)(hash) & ICE_FLOW_PROF_HASH_M) | \
-	      (((u64)(hdr) << ICE_FLOW_PROF_HDR_S) & ICE_FLOW_PROF_HDR_M) | \
-	      ((u8)((segs_cnt) - 1) ? ICE_FLOW_PROF_ENCAP_M : 0))
+	((u64)(((u64)(hash) & ICE_FLOW_PROF_HASH_M) | \
+	       (((u64)(hdr) << ICE_FLOW_PROF_HDR_S) & ICE_FLOW_PROF_HDR_M) | \
+	       ((u8)((segs_cnt) - 1) ? ICE_FLOW_PROF_ENCAP_M : 0)))
 
 /**
  * ice_add_rss_cfg_sync - add an RSS configuration
-- 
2.20.1

