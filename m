From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 13 Sep 2018 15:31:38 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 08/14] iavf: rename
 I40E_ADMINQ_DESC
In-Reply-To: <20180913223144.75823-1-jesse.brandeburg@intel.com>
References: <20180913223144.75823-1-jesse.brandeburg@intel.com>
Message-ID: <20180913223144.75823-9-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Take care of some renames containing I40E_ADMINQ_DESC.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/iavf/i40e_adminq.c | 18 +++++++++---------
 drivers/net/ethernet/intel/iavf/i40e_adminq.h |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/i40e_adminq.c b/drivers/net/ethernet/intel/iavf/i40e_adminq.c
index 8110b92fa2b0..69dfdfd69796 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/iavf/i40e_adminq.c
@@ -40,7 +40,7 @@ static iavf_status i40e_alloc_adminq_asq_ring(struct i40e_hw *hw)
 					 i40e_mem_atq_ring,
 					 (hw->aq.num_asq_entries *
 					 sizeof(struct i40e_aq_desc)),
-					 I40E_ADMINQ_DESC_ALIGNMENT);
+					 IAVF_ADMINQ_DESC_ALIGNMENT);
 	if (ret_code)
 		return ret_code;
 
@@ -67,7 +67,7 @@ static iavf_status i40e_alloc_adminq_arq_ring(struct i40e_hw *hw)
 					 i40e_mem_arq_ring,
 					 (hw->aq.num_arq_entries *
 					 sizeof(struct i40e_aq_desc)),
-					 I40E_ADMINQ_DESC_ALIGNMENT);
+					 IAVF_ADMINQ_DESC_ALIGNMENT);
 
 	return ret_code;
 }
@@ -124,12 +124,12 @@ static iavf_status i40e_alloc_arq_bufs(struct i40e_hw *hw)
 		ret_code = i40e_allocate_dma_mem(hw, bi,
 						 i40e_mem_arq_buf,
 						 hw->aq.arq_buf_size,
-						 I40E_ADMINQ_DESC_ALIGNMENT);
+						 IAVF_ADMINQ_DESC_ALIGNMENT);
 		if (ret_code)
 			goto unwind_alloc_arq_bufs;
 
 		/* now configure the descriptors for use */
-		desc = I40E_ADMINQ_DESC(hw->aq.arq, i);
+		desc = IAVF_ADMINQ_DESC(hw->aq.arq, i);
 
 		desc->flags = cpu_to_le16(I40E_AQ_FLAG_BUF);
 		if (hw->aq.arq_buf_size > I40E_AQ_LARGE_BUF)
@@ -186,7 +186,7 @@ static iavf_status i40e_alloc_asq_bufs(struct i40e_hw *hw)
 		ret_code = i40e_allocate_dma_mem(hw, bi,
 						 i40e_mem_asq_buf,
 						 hw->aq.asq_buf_size,
-						 I40E_ADMINQ_DESC_ALIGNMENT);
+						 IAVF_ADMINQ_DESC_ALIGNMENT);
 		if (ret_code)
 			goto unwind_alloc_asq_bufs;
 	}
@@ -574,7 +574,7 @@ static u16 i40e_clean_asq(struct i40e_hw *hw)
 	struct i40e_aq_desc desc_cb;
 	struct i40e_aq_desc *desc;
 
-	desc = I40E_ADMINQ_DESC(*asq, ntc);
+	desc = IAVF_ADMINQ_DESC(*asq, ntc);
 	details = I40E_ADMINQ_DETAILS(*asq, ntc);
 	while (rd32(hw, hw->aq.asq.head) != ntc) {
 		i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
@@ -592,7 +592,7 @@ static u16 i40e_clean_asq(struct i40e_hw *hw)
 		ntc++;
 		if (ntc == asq->count)
 			ntc = 0;
-		desc = I40E_ADMINQ_DESC(*asq, ntc);
+		desc = IAVF_ADMINQ_DESC(*asq, ntc);
 		details = I40E_ADMINQ_DETAILS(*asq, ntc);
 	}
 
@@ -714,7 +714,7 @@ iavf_status iavf_asq_send_command(struct i40e_hw *hw, struct i40e_aq_desc *desc,
 	}
 
 	/* initialize the temp desc pointer with the right desc */
-	desc_on_ring = I40E_ADMINQ_DESC(hw->aq.asq, hw->aq.asq.next_to_use);
+	desc_on_ring = IAVF_ADMINQ_DESC(hw->aq.asq, hw->aq.asq.next_to_use);
 
 	/* if the desc is available copy the temp desc to the right place */
 	*desc_on_ring = *desc;
@@ -874,7 +874,7 @@ iavf_status iavf_clean_arq_element(struct i40e_hw *hw,
 	}
 
 	/* now clean the next descriptor */
-	desc = I40E_ADMINQ_DESC(hw->aq.arq, ntc);
+	desc = IAVF_ADMINQ_DESC(hw->aq.arq, ntc);
 	desc_idx = ntc;
 
 	hw->aq.arq_last_status =
diff --git a/drivers/net/ethernet/intel/iavf/i40e_adminq.h b/drivers/net/ethernet/intel/iavf/i40e_adminq.h
index 80b70a65028f..fd162a293c38 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/iavf/i40e_adminq.h
@@ -8,10 +8,10 @@
 #include "i40e_status.h"
 #include "i40e_adminq_cmd.h"
 
-#define I40E_ADMINQ_DESC(R, i)   \
+#define IAVF_ADMINQ_DESC(R, i)   \
 	(&(((struct i40e_aq_desc *)((R).desc_buf.va))[i]))
 
-#define I40E_ADMINQ_DESC_ALIGNMENT 4096
+#define IAVF_ADMINQ_DESC_ALIGNMENT 4096
 
 struct i40e_adminq_ring {
 	struct i40e_virt_mem dma_head;	/* space for dma structures */
-- 
2.14.4

