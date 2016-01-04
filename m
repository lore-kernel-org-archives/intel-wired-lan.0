From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Mon,  4 Jan 2016 10:33:09 -0800
Subject: [Intel-wired-lan] [next PATCH S26 09/12] i40e: drop unused function
In-Reply-To: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1451932392-15538-10-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Delete the unused irq_dynamic_disable function.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Singhai, Anjali <anjali.singhai@intel.com>
Change-ID: Ia46071066babd121c7c90f141b6210b00078de3f
---
Testing-Hints: Compile only

 drivers/net/ethernet/intel/i40e/i40e.h      |  1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 53ed3bd..5fd58f8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -756,7 +756,6 @@ static inline void i40e_irq_dynamic_enable(struct i40e_vsi *vsi, int vector)
 	/* skip the flush */
 }
 
-void i40e_irq_dynamic_disable(struct i40e_vsi *vsi, int vector);
 void i40e_irq_dynamic_disable_icr0(struct i40e_pf *pf);
 void i40e_irq_dynamic_enable_icr0(struct i40e_pf *pf);
 #ifdef I40E_FCOE
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2939ce8..c16c516 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3273,22 +3273,6 @@ void i40e_irq_dynamic_enable_icr0(struct i40e_pf *pf)
 }
 
 /**
- * i40e_irq_dynamic_disable - Disable default interrupt generation settings
- * @vsi: pointer to a vsi
- * @vector: disable a particular Hw Interrupt vector
- **/
-void i40e_irq_dynamic_disable(struct i40e_vsi *vsi, int vector)
-{
-	struct i40e_pf *pf = vsi->back;
-	struct i40e_hw *hw = &pf->hw;
-	u32 val;
-
-	val = I40E_ITR_NONE << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT;
-	wr32(hw, I40E_PFINT_DYN_CTLN(vector - 1), val);
-	i40e_flush(hw);
-}
-
-/**
  * i40e_msix_clean_rings - MSIX mode Interrupt Handler
  * @irq: interrupt number
  * @data: pointer to a q_vector
-- 
2.1.0

