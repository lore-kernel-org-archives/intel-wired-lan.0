From: Nelson, Shannon <shannon.nelson@intel.com>
Date: Mon, 1 Jun 2015 19:33:03 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: clean up unneeded gotos
Message-ID: <FC41C24E35F18A40888AACA1A36F3E418AE6C940@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


With a little work we can clean up some unnecessary logic jumping and
drop a variable.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Cc: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_hmc.c | 37 ++++++++++--------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
index 9b987cc..6c0dd54 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
@@ -287,21 +287,15 @@ i40e_status i40e_remove_sd_bp_new(struct i40e_hw *hw,
 					    u32 idx, bool is_pf)
 {
 	struct i40e_hmc_sd_entry *sd_entry;
-	i40e_status ret_code = 0;
+
+	if (!is_pf)
+		return I40E_NOT_SUPPORTED;
 
 	/* get the entry and decrease its ref counter */
 	sd_entry = &hmc_info->sd_table.sd_entry[idx];
-	if (is_pf) {
-		I40E_CLEAR_PF_SD_ENTRY(hw, idx, I40E_SD_TYPE_DIRECT);
-	} else {
-		ret_code = I40E_NOT_SUPPORTED;
-		goto exit;
-	}
-	ret_code = i40e_free_dma_mem(hw, &(sd_entry->u.bp.addr));
-	if (ret_code)
-		goto exit;
-exit:
-	return ret_code;
+	I40E_CLEAR_PF_SD_ENTRY(hw, idx, I40E_SD_TYPE_DIRECT);
+
+	return i40e_free_dma_mem(hw, &sd_entry->u.bp.addr);
 }
 
 /**
@@ -341,20 +335,13 @@ i40e_status i40e_remove_pd_page_new(struct i40e_hw *hw,
 					      struct i40e_hmc_info *hmc_info,
 					      u32 idx, bool is_pf)
 {
-	i40e_status ret_code = 0;
 	struct i40e_hmc_sd_entry *sd_entry;
 
+	if (!is_pf)
+		return I40E_NOT_SUPPORTED;
+
 	sd_entry = &hmc_info->sd_table.sd_entry[idx];
-	if (is_pf) {
-		I40E_CLEAR_PF_SD_ENTRY(hw, idx, I40E_SD_TYPE_PAGED);
-	} else {
-		ret_code = I40E_NOT_SUPPORTED;
-		goto exit;
-	}
-	/* free memory here */
-	ret_code = i40e_free_dma_mem(hw, &(sd_entry->u.pd_table.pd_page_addr));
-	if (ret_code)
-		goto exit;
-exit:
-	return ret_code;
+	I40E_CLEAR_PF_SD_ENTRY(hw, idx, I40E_SD_TYPE_PAGED);
+
+	return  i40e_free_dma_mem(hw, &sd_entry->u.pd_table.pd_page_addr);
 }
-- 
1.8.3.1



