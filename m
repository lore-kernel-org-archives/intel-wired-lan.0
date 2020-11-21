From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 20 Nov 2020 16:39:36 -0800
Subject: [Intel-wired-lan] [PATCH S54 12/14] ice: use flex_array_size where
 possible
In-Reply-To: <20201121003938.48514-1-anthony.l.nguyen@intel.com>
References: <20201121003938.48514-1-anthony.l.nguyen@intel.com>
Message-ID: <20201121003938.48514-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Use the flex_array_size() helper with the recently added flexible array
members in structures.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c    | 2 +-
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 53adfce78202..9eb0be73cb7b 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1653,7 +1653,7 @@ ice_aq_alloc_free_res(struct ice_hw *hw, u16 num_entries,
 	if (!buf)
 		return ICE_ERR_PARAM;
 
-	if (buf_size < (num_entries * sizeof(buf->elem[0])))
+	if (buf_size < flex_array_size(buf, elem, num_entries))
 		return ICE_ERR_PARAM;
 
 	ice_fill_dflt_direct_cmd_desc(&desc, opc);
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index eb11df8deae8..15ac977d2a8e 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -1525,7 +1525,7 @@ ice_pkg_buf_reserve_section(struct ice_buf_build *bld, u16 count)
 	bld->reserved_section_table_entries += count;
 
 	data_end = le16_to_cpu(buf->data_end) +
-		   (count * sizeof(buf->section_entry[0]));
+		flex_array_size(buf, section_entry, count);
 	buf->data_end = cpu_to_le16(data_end);
 
 	return 0;
-- 
2.20.1

