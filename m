From: Yang Li <yang.lee@linux.alibaba.com>
Date: Mon, 13 Dec 2021 11:11:07 +0800
Subject: [Intel-wired-lan] [PATCH -next] i40e: remove variables set but not
 used
Message-ID: <20211213031107.52438-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The code that uses variables pe_cntx_size and pe_filt_size 
has been removed, so they should be removed as well.

Eliminate the following clang warnings:
drivers/net/ethernet/intel/i40e/i40e_common.c:4139:20:
warning: variable 'pe_filt_size' set but not used.
drivers/net/ethernet/intel/i40e/i40e_common.c:4139:6:
warning: variable 'pe_cntx_size' set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 467d729abb72 ("i40e/i40evf: Fix code to accommodate i40e_register.h changes")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index b4d3fed0d2f2..a775e55ae8bc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -4136,7 +4136,6 @@ static i40e_status i40e_validate_filter_settings(struct i40e_hw *hw,
 				struct i40e_filter_control_settings *settings)
 {
 	u32 fcoe_cntx_size, fcoe_filt_size;
-	u32 pe_cntx_size, pe_filt_size;
 	u32 fcoe_fmax;
 	u32 val;
 
@@ -4180,8 +4179,6 @@ static i40e_status i40e_validate_filter_settings(struct i40e_hw *hw,
 	case I40E_HASH_FILTER_SIZE_256K:
 	case I40E_HASH_FILTER_SIZE_512K:
 	case I40E_HASH_FILTER_SIZE_1M:
-		pe_filt_size = I40E_HASH_FILTER_BASE_SIZE;
-		pe_filt_size <<= (u32)settings->pe_filt_num;
 		break;
 	default:
 		return I40E_ERR_PARAM;
@@ -4198,8 +4195,6 @@ static i40e_status i40e_validate_filter_settings(struct i40e_hw *hw,
 	case I40E_DMA_CNTX_SIZE_64K:
 	case I40E_DMA_CNTX_SIZE_128K:
 	case I40E_DMA_CNTX_SIZE_256K:
-		pe_cntx_size = I40E_DMA_CNTX_BASE_SIZE;
-		pe_cntx_size <<= (u32)settings->pe_cntx_num;
 		break;
 	default:
 		return I40E_ERR_PARAM;
-- 
2.20.1.7.g153144c

