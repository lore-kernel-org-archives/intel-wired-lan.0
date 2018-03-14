From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 14 Mar 2018 11:19:15 -0700
Subject: [Intel-wired-lan] [PATCH S88 5/8] i40e: Fix incorrect return types
In-Reply-To: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
References: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180314181918.21582-5-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Doug Dziggel <douglas.a.dziggel@intel.com>

Fix return types from i40e_status to enum i40e_status_code.

Signed-off-by: Doug Dziggel <douglas.a.dziggel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c    | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_prototype.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 2d00e953b6fe..27d4d208bd04 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -5554,7 +5554,7 @@ i40e_aq_add_cloud_filters(struct i40e_hw *hw, u16 seid,
  * function.
  *
  **/
-i40e_status
+enum i40e_status_code
 i40e_aq_add_cloud_filters_bb(struct i40e_hw *hw, u16 seid,
 			     struct i40e_aqc_cloud_filters_element_bb *filters,
 			     u8 filter_count)
@@ -5648,7 +5648,7 @@ i40e_aq_rem_cloud_filters(struct i40e_hw *hw, u16 seid,
  * function.
  *
  **/
-i40e_status
+enum i40e_status_code
 i40e_aq_rem_cloud_filters_bb(struct i40e_hw *hw, u16 seid,
 			     struct i40e_aqc_cloud_filters_element_bb *filters,
 			     u8 filter_count)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 57f67204e8bc..fc810a9333f5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -288,7 +288,7 @@ i40e_status i40e_aq_query_switch_comp_bw_config(struct i40e_hw *hw,
 		struct i40e_asq_cmd_details *cmd_details);
 i40e_status i40e_aq_resume_port_tx(struct i40e_hw *hw,
 				   struct i40e_asq_cmd_details *cmd_details);
-i40e_status
+enum i40e_status_code
 i40e_aq_add_cloud_filters_bb(struct i40e_hw *hw, u16 seid,
 			     struct i40e_aqc_cloud_filters_element_bb *filters,
 			     u8 filter_count);
@@ -300,7 +300,7 @@ enum i40e_status_code
 i40e_aq_rem_cloud_filters(struct i40e_hw *hw, u16 vsi,
 			  struct i40e_aqc_cloud_filters_element_data *filters,
 			  u8 filter_count);
-i40e_status
+enum i40e_status_code
 i40e_aq_rem_cloud_filters_bb(struct i40e_hw *hw, u16 seid,
 			     struct i40e_aqc_cloud_filters_element_bb *filters,
 			     u8 filter_count);
-- 
2.14.3

