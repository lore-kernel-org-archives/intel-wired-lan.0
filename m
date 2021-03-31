From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 31 Mar 2021 14:17:05 -0700
Subject: [Intel-wired-lan] [PATCH S58 10/13] ice: suppress false cppcheck
 issues
In-Reply-To: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
Message-ID: <20210331211708.55205-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Silence false errors, warnings and style issues reported by cppcheck.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 3 +++
 drivers/net/ethernet/intel/ice/ice_nvm.c       | 1 +
 drivers/net/ethernet/intel/ice/ice_sched.c     | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index 4b83960876f4..06ac9badee77 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -334,6 +334,7 @@ ice_boost_tcam_handler(u32 sect_type, void *section, u32 index, u32 *offset)
 	if (sect_type != ICE_SID_RXPARSER_BOOST_TCAM)
 		return NULL;
 
+	/* cppcheck-suppress nullPointer */
 	if (index > ICE_MAX_BST_TCAMS_IN_BUF)
 		return NULL;
 
@@ -404,6 +405,7 @@ ice_label_enum_handler(u32 __always_unused sect_type, void *section, u32 index,
 	if (!section)
 		return NULL;
 
+	/* cppcheck-suppress nullPointer */
 	if (index > ICE_MAX_LABELS_IN_BUF)
 		return NULL;
 
@@ -2067,6 +2069,7 @@ ice_match_prop_lst(struct list_head *list1, struct list_head *list2)
 		count++;
 	list_for_each_entry(tmp2, list2, list)
 		chk_count++;
+	/* cppcheck-suppress knownConditionTrueFalse */
 	if (!count || count != chk_count)
 		return false;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 2f7de2d03510..4058d8f4e782 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -740,6 +740,7 @@ ice_get_orom_civd_data(struct ice_hw *hw, enum ice_bank_select bank,
 
 		/* Verify that the simple checksum is zero */
 		for (i = 0; i < sizeof(tmp); i++)
+			/* cppcheck-suppress objectIndex */
 			sum += ((u8 *)&tmp)[i];
 
 		if (sum) {
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 97562051fe14..2f097637e405 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -988,6 +988,7 @@ ice_sched_add_nodes_to_layer(struct ice_port_info *pi,
 	*num_nodes_added = 0;
 	while (*num_nodes_added < num_nodes) {
 		u16 max_child_nodes, num_added = 0;
+		/* cppcheck-suppress unusedVariable */
 		u32 temp;
 
 		status = ice_sched_add_nodes_to_hw_layer(pi, tc_node, parent,
-- 
2.20.1

