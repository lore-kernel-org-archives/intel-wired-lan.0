From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 27 Aug 2015 11:42:34 -0400
Subject: [Intel-wired-lan] [next PATCH S12 06/15] i40e: inline interrupt
	enable
In-Reply-To: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440690163-128213-7-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The interrupt enable function can be inlined by moving it to the header
file, which decreases the function call overhead for a frequently called
function.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I3214cc99593725768642680e7b8ce7e9bba7e44d
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 19 ++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ------------------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 73d2e86..edda619 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -704,7 +704,24 @@ static inline void i40e_dbg_pf_exit(struct i40e_pf *pf) {}
 static inline void i40e_dbg_init(void) {}
 static inline void i40e_dbg_exit(void) {}
 #endif /* CONFIG_DEBUG_FS*/
-void i40e_irq_dynamic_enable(struct i40e_vsi *vsi, int vector);
+/**
+ * i40e_irq_dynamic_enable - Enable default interrupt generation settings
+ * @vsi: pointer to a vsi
+ * @vector: enable a particular Hw Interrupt vector, without base_vector
+ **/
+static inline void i40e_irq_dynamic_enable(struct i40e_vsi *vsi, int vector)
+{
+	struct i40e_pf *pf = vsi->back;
+	struct i40e_hw *hw = &pf->hw;
+	u32 val;
+
+	val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
+	      I40E_PFINT_DYN_CTLN_CLEARPBA_MASK |
+	      (I40E_ITR_NONE << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT);
+	wr32(hw, I40E_PFINT_DYN_CTLN(vector + vsi->base_vector - 1), val);
+	/* skip the flush */
+}
+
 void i40e_irq_dynamic_disable(struct i40e_vsi *vsi, int vector);
 void i40e_irq_dynamic_disable_icr0(struct i40e_pf *pf);
 void i40e_irq_dynamic_enable_icr0(struct i40e_pf *pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b3328ca..34c6796 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2953,24 +2953,6 @@ void i40e_irq_dynamic_enable_icr0(struct i40e_pf *pf)
 }
 
 /**
- * i40e_irq_dynamic_enable - Enable default interrupt generation settings
- * @vsi: pointer to a vsi
- * @vector: enable a particular Hw Interrupt vector, without base_vector
- **/
-void i40e_irq_dynamic_enable(struct i40e_vsi *vsi, int vector)
-{
-	struct i40e_pf *pf = vsi->back;
-	struct i40e_hw *hw = &pf->hw;
-	u32 val;
-
-	val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
-	      I40E_PFINT_DYN_CTLN_CLEARPBA_MASK |
-	      (I40E_ITR_NONE << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT);
-	wr32(hw, I40E_PFINT_DYN_CTLN(vector + vsi->base_vector - 1), val);
-	/* skip the flush */
-}
-
-/**
  * i40e_irq_dynamic_disable - Disable default interrupt generation settings
  * @vsi: pointer to a vsi
  * @vector: disable a particular Hw Interrupt vector
-- 
1.9.3

