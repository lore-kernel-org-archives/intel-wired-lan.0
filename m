From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 16 Jul 2021 15:16:42 -0700
Subject: [Intel-wired-lan] [PATCH net-next 5/7] ice: Add package PTYPE
 enable information
In-Reply-To: <20210716221644.45946-1-anthony.l.nguyen@intel.com>
References: <20210716221644.45946-1-anthony.l.nguyen@intel.com>
Message-ID: <20210716221644.45946-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Haiyue Wang <haiyue.wang@intel.com>

Scan the 'Marker Ptype TCAM' section to retrieve the Rx parser PTYPE
enable information from the current package.

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
 .../net/ethernet/intel/ice/ice_flex_pipe.c    | 76 +++++++++++++++++++
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |  4 +
 .../net/ethernet/intel/ice/ice_flex_type.h    | 20 +++++
 drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
 4 files changed, 101 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index 06ac9badee77..915a00f73d34 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -313,6 +313,81 @@ ice_pkg_enum_entry(struct ice_seg *ice_seg, struct ice_pkg_enum *state,
 	return entry;
 }
 
+/**
+ * ice_hw_ptype_ena - check if the PTYPE is enabled or not
+ * @hw: pointer to the HW structure
+ * @ptype: the hardware PTYPE
+ */
+bool ice_hw_ptype_ena(struct ice_hw *hw, u16 ptype)
+{
+	return ptype < ICE_FLOW_PTYPE_MAX &&
+	       test_bit(ptype, hw->hw_ptype);
+}
+
+/**
+ * ice_marker_ptype_tcam_handler
+ * @sect_type: section type
+ * @section: pointer to section
+ * @index: index of the Marker PType TCAM entry to be returned
+ * @offset: pointer to receive absolute offset, always 0 for ptype TCAM sections
+ *
+ * This is a callback function that can be passed to ice_pkg_enum_entry.
+ * Handles enumeration of individual Marker PType TCAM entries.
+ */
+static void *
+ice_marker_ptype_tcam_handler(u32 sect_type, void *section, u32 index,
+			      u32 *offset)
+{
+	struct ice_marker_ptype_tcam_section *marker_ptype;
+
+	if (!section)
+		return NULL;
+
+	if (sect_type != ICE_SID_RXPARSER_MARKER_PTYPE)
+		return NULL;
+
+	if (index > ICE_MAX_MARKER_PTYPE_TCAMS_IN_BUF)
+		return NULL;
+
+	if (offset)
+		*offset = 0;
+
+	marker_ptype = section;
+	if (index >= le16_to_cpu(marker_ptype->count))
+		return NULL;
+
+	return marker_ptype->tcam + index;
+}
+
+/**
+ * ice_fill_hw_ptype - fill the enabled PTYPE bit information
+ * @hw: pointer to the HW structure
+ */
+static void ice_fill_hw_ptype(struct ice_hw *hw)
+{
+	struct ice_marker_ptype_tcam_entry *tcam;
+	struct ice_seg *seg = hw->seg;
+	struct ice_pkg_enum state;
+
+	bitmap_zero(hw->hw_ptype, ICE_FLOW_PTYPE_MAX);
+	if (!seg)
+		return;
+
+	memset(&state, 0, sizeof(state));
+
+	do {
+		tcam = ice_pkg_enum_entry(seg, &state,
+					  ICE_SID_RXPARSER_MARKER_PTYPE, NULL,
+					  ice_marker_ptype_tcam_handler);
+		if (tcam &&
+		    le16_to_cpu(tcam->addr) < ICE_MARKER_PTYPE_TCAM_ADDR_MAX &&
+		    le16_to_cpu(tcam->ptype) < ICE_FLOW_PTYPE_MAX)
+			set_bit(le16_to_cpu(tcam->ptype), hw->hw_ptype);
+
+		seg = NULL;
+	} while (tcam);
+}
+
 /**
  * ice_boost_tcam_handler
  * @sect_type: section type
@@ -1408,6 +1483,7 @@ enum ice_status ice_init_pkg(struct ice_hw *hw, u8 *buf, u32 len)
 		 */
 		ice_init_pkg_regs(hw);
 		ice_fill_blk_tbls(hw);
+		ice_fill_hw_ptype(hw);
 	} else {
 		ice_debug(hw, ICE_DBG_INIT, "package load failed, %d\n",
 			  status);
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.h b/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
index 8a58e79729b9..995b33d37b67 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
@@ -25,6 +25,10 @@ int ice_udp_tunnel_set_port(struct net_device *netdev, unsigned int table,
 int ice_udp_tunnel_unset_port(struct net_device *netdev, unsigned int table,
 			      unsigned int idx, struct udp_tunnel_info *ti);
 
+/* Rx parser PTYPE functions */
+bool ice_hw_ptype_ena(struct ice_hw *hw, u16 ptype);
+
+/* XLT2/VSI group functions */
 enum ice_status
 ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
 	     const struct ice_ptype_attributes *attr, u16 attr_cnt,
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_type.h b/drivers/net/ethernet/intel/ice/ice_flex_type.h
index 7d8b517a63c9..647304f88b78 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_flex_type.h
@@ -158,6 +158,7 @@ struct ice_meta_sect {
 #define ICE_SID_CDID_KEY_BUILDER_RSS	47
 #define ICE_SID_CDID_REDIR_RSS		48
 
+#define ICE_SID_RXPARSER_MARKER_PTYPE	55
 #define ICE_SID_RXPARSER_BOOST_TCAM	56
 #define ICE_SID_TXPARSER_BOOST_TCAM	66
 
@@ -321,6 +322,25 @@ struct ice_boost_tcam_section {
 	sizeof(struct ice_boost_tcam_entry), \
 	sizeof(struct ice_boost_tcam_entry))
 
+/* package Marker Ptype TCAM entry */
+struct ice_marker_ptype_tcam_entry {
+#define ICE_MARKER_PTYPE_TCAM_ADDR_MAX	1024
+	__le16 addr;
+	__le16 ptype;
+	u8 keys[20];
+};
+
+struct ice_marker_ptype_tcam_section {
+	__le16 count;
+	__le16 reserved;
+	struct ice_marker_ptype_tcam_entry tcam[];
+};
+
+#define ICE_MAX_MARKER_PTYPE_TCAMS_IN_BUF	\
+	ICE_MAX_ENTRIES_IN_BUF(struct_size((struct ice_marker_ptype_tcam_section *)0, tcam, 1) - \
+	sizeof(struct ice_marker_ptype_tcam_entry), \
+	sizeof(struct ice_marker_ptype_tcam_entry))
+
 struct ice_xlt1_section {
 	__le16 count;
 	__le16 offset;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 95bf4fd6f6b8..dcaa6bfab484 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -933,6 +933,7 @@ struct ice_hw {
 	struct mutex rss_locks;	/* protect RSS configuration */
 	struct list_head rss_list_head;
 	struct ice_mbx_snapshot mbx_snapshot;
+	DECLARE_BITMAP(hw_ptype, ICE_FLOW_PTYPE_MAX);
 };
 
 /* Statistics collected by each port, VSI, VEB, and S-channel */
-- 
2.20.1

