From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  2 Mar 2021 10:12:04 -0800
Subject: [Intel-wired-lan] [PATCH S55 05/14] ice: Update to use package info
 from ice segment
In-Reply-To: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
References: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
Message-ID: <20210302181213.51718-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dan Nowlin <dan.nowlin@intel.com>

There are two package versions in the package binary. Today, these two
version numbers are the same. However, in the future that may change.

Update code to use the package info from the ice segment metadata
section, which is the package information that is actually downloaded to
the firmware during the download package process.

Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 .../net/ethernet/intel/ice/ice_flex_pipe.c    | 40 ++++++++++---------
 .../net/ethernet/intel/ice/ice_flex_type.h    |  9 +++++
 drivers/net/ethernet/intel/ice/ice_type.h     |  8 ++--
 4 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 770c99a5d181..8c22d0cda153 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1807,6 +1807,7 @@ struct ice_pkg_ver {
 };
 
 #define ICE_PKG_NAME_SIZE	32
+#define ICE_SEG_ID_SIZE		28
 #define ICE_SEG_NAME_SIZE	28
 
 struct ice_aqc_get_pkg_info {
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index 88a0c2daf29f..01d6a64a5a27 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -1063,32 +1063,36 @@ ice_download_pkg(struct ice_hw *hw, struct ice_seg *ice_seg)
 static enum ice_status
 ice_init_pkg_info(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
 {
-	struct ice_global_metadata_seg *meta_seg;
 	struct ice_generic_seg_hdr *seg_hdr;
 
 	if (!pkg_hdr)
 		return ICE_ERR_PARAM;
 
-	meta_seg = (struct ice_global_metadata_seg *)
-		   ice_find_seg_in_pkg(hw, SEGMENT_TYPE_METADATA, pkg_hdr);
-	if (meta_seg) {
-		hw->pkg_ver = meta_seg->pkg_ver;
-		memcpy(hw->pkg_name, meta_seg->pkg_name, sizeof(hw->pkg_name));
+	seg_hdr = ice_find_seg_in_pkg(hw, SEGMENT_TYPE_ICE, pkg_hdr);
+	if (seg_hdr) {
+		struct ice_meta_sect *meta;
+		struct ice_pkg_enum state;
+
+		memset(&state, 0, sizeof(state));
+
+		/* Get package information from the Metadata Section */
+		meta = ice_pkg_enum_section((struct ice_seg *)seg_hdr, &state,
+					    ICE_SID_METADATA);
+		if (!meta) {
+			ice_debug(hw, ICE_DBG_INIT, "Did not find ice metadata section in package\n");
+			return ICE_ERR_CFG;
+		}
+
+		hw->pkg_ver = meta->ver;
+		memcpy(hw->pkg_name, meta->name, sizeof(meta->name));
 
 		ice_debug(hw, ICE_DBG_PKG, "Pkg: %d.%d.%d.%d, %s\n",
-			  meta_seg->pkg_ver.major, meta_seg->pkg_ver.minor,
-			  meta_seg->pkg_ver.update, meta_seg->pkg_ver.draft,
-			  meta_seg->pkg_name);
-	} else {
-		ice_debug(hw, ICE_DBG_INIT, "Did not find metadata segment in driver package\n");
-		return ICE_ERR_CFG;
-	}
+			  meta->ver.major, meta->ver.minor, meta->ver.update,
+			  meta->ver.draft, meta->name);
 
-	seg_hdr = ice_find_seg_in_pkg(hw, SEGMENT_TYPE_ICE, pkg_hdr);
-	if (seg_hdr) {
-		hw->ice_pkg_ver = seg_hdr->seg_format_ver;
-		memcpy(hw->ice_pkg_name, seg_hdr->seg_id,
-		       sizeof(hw->ice_pkg_name));
+		hw->ice_seg_fmt_ver = seg_hdr->seg_format_ver;
+		memcpy(hw->ice_seg_id, seg_hdr->seg_id,
+		       sizeof(hw->ice_seg_id));
 
 		ice_debug(hw, ICE_DBG_PKG, "Ice Seg: %d.%d.%d.%d, %s\n",
 			  seg_hdr->seg_format_ver.major,
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_type.h b/drivers/net/ethernet/intel/ice/ice_flex_type.h
index 2221ae3b22f6..bc20cff7ab9d 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_flex_type.h
@@ -109,6 +109,7 @@ struct ice_buf_hdr {
 	(ent_sz))
 
 /* ice package section IDs */
+#define ICE_SID_METADATA		1
 #define ICE_SID_XLT0_SW			10
 #define ICE_SID_XLT_KEY_BUILDER_SW	11
 #define ICE_SID_XLT1_SW			12
@@ -117,6 +118,14 @@ struct ice_buf_hdr {
 #define ICE_SID_PROFID_REDIR_SW		15
 #define ICE_SID_FLD_VEC_SW		16
 #define ICE_SID_CDID_KEY_BUILDER_SW	17
+
+struct ice_meta_sect {
+	struct ice_pkg_ver ver;
+#define ICE_META_SECT_NAME_SIZE	28
+	char name[ICE_META_SECT_NAME_SIZE];
+	__le32 track_id;
+};
+
 #define ICE_SID_CDID_REDIR_SW		18
 
 #define ICE_SID_XLT0_ACL		20
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 420fd487fd57..8545cba987b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -805,13 +805,13 @@ struct ice_hw {
 
 	enum ice_aq_err pkg_dwnld_status;
 
-	/* Driver's package ver - (from the Metadata seg) */
+	/* Driver's package ver - (from the Ice Metadata section) */
 	struct ice_pkg_ver pkg_ver;
 	u8 pkg_name[ICE_PKG_NAME_SIZE];
 
-	/* Driver's Ice package version (from the Ice seg) */
-	struct ice_pkg_ver ice_pkg_ver;
-	u8 ice_pkg_name[ICE_PKG_NAME_SIZE];
+	/* Driver's Ice segment format version and ID (from the Ice seg) */
+	struct ice_pkg_ver ice_seg_fmt_ver;
+	u8 ice_seg_id[ICE_SEG_ID_SIZE];
 
 	/* Pointer to the ice segment */
 	struct ice_seg *seg;
-- 
2.20.1

