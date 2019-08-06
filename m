From: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
Date: Tue,  6 Aug 2019 10:33:47 -0300
Subject: [Intel-wired-lan] [PATCH 1/2] i40e: fix hw_dbg usage in
 i40e_hmc_get_object_va
Message-ID: <20190806133348.17924-1-maurosr@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The mentioned function references a i40e_hw attribute, as parameter for
hw_dbg, but it doesn't exist in the function scope.
Fixes it by changing  parameters from i40e_hmc_info to i40e_hw which can
retrieve the necessary i40e_hmc_info.

Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
---
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
index 994011c38fb4..f059de33a0fd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include "i40e.h"
 #include "i40e_osdep.h"
 #include "i40e_register.h"
 #include "i40e_type.h"
@@ -963,7 +964,7 @@ static i40e_status i40e_set_hmc_context(u8 *context_bytes,
 
 /**
  * i40e_hmc_get_object_va - retrieves an object's virtual address
- * @hmc_info: pointer to i40e_hmc_info struct
+ * @hw: the hardware struct, from which we obtain the i40e_hmc_info pointer
  * @object_base: pointer to u64 to get the va
  * @rsrc_type: the hmc resource type
  * @obj_idx: hmc object index
@@ -972,7 +973,7 @@ static i40e_status i40e_set_hmc_context(u8 *context_bytes,
  * base pointer.  This function is used for LAN Queue contexts.
  **/
 static
-i40e_status i40e_hmc_get_object_va(struct i40e_hmc_info *hmc_info,
+i40e_status i40e_hmc_get_object_va(struct i40e_hw *hw,
 					u8 **object_base,
 					enum i40e_hmc_lan_rsrc_type rsrc_type,
 					u32 obj_idx)
@@ -982,6 +983,7 @@ i40e_status i40e_hmc_get_object_va(struct i40e_hmc_info *hmc_info,
 	struct i40e_hmc_sd_entry *sd_entry;
 	struct i40e_hmc_pd_entry *pd_entry;
 	u32 pd_idx, pd_lmt, rel_pd_idx;
+	struct i40e_hmc_info *hmc_info = &hw->hmc;
 	u64 obj_offset_in_fpm;
 	u32 sd_idx, sd_lmt;
 
@@ -1047,7 +1049,7 @@ i40e_status i40e_clear_lan_tx_queue_context(struct i40e_hw *hw,
 	i40e_status err;
 	u8 *context_bytes;
 
-	err = i40e_hmc_get_object_va(&hw->hmc, &context_bytes,
+	err = i40e_hmc_get_object_va(hw, &context_bytes,
 				     I40E_HMC_LAN_TX, queue);
 	if (err < 0)
 		return err;
@@ -1068,7 +1070,7 @@ i40e_status i40e_set_lan_tx_queue_context(struct i40e_hw *hw,
 	i40e_status err;
 	u8 *context_bytes;
 
-	err = i40e_hmc_get_object_va(&hw->hmc, &context_bytes,
+	err = i40e_hmc_get_object_va(hw, &context_bytes,
 				     I40E_HMC_LAN_TX, queue);
 	if (err < 0)
 		return err;
@@ -1088,7 +1090,7 @@ i40e_status i40e_clear_lan_rx_queue_context(struct i40e_hw *hw,
 	i40e_status err;
 	u8 *context_bytes;
 
-	err = i40e_hmc_get_object_va(&hw->hmc, &context_bytes,
+	err = i40e_hmc_get_object_va(hw, &context_bytes,
 				     I40E_HMC_LAN_RX, queue);
 	if (err < 0)
 		return err;
@@ -1109,7 +1111,7 @@ i40e_status i40e_set_lan_rx_queue_context(struct i40e_hw *hw,
 	i40e_status err;
 	u8 *context_bytes;
 
-	err = i40e_hmc_get_object_va(&hw->hmc, &context_bytes,
+	err = i40e_hmc_get_object_va(hw, &context_bytes,
 				     I40E_HMC_LAN_RX, queue);
 	if (err < 0)
 		return err;
-- 
2.21.0

