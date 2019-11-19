From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 19 Nov 2019 13:44:47 +0200
Subject: [Intel-wired-lan] [PATCH v1 09/15] igc: Remove no need declaration
 of the igc_irq_enable
Message-ID: <20191119114447.42241-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We want to avoid forward-declarations of function if possible.
Rearrange the igc_irq_enable function implementation.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 47 +++++++++++++++----------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7be1e500bed5..4877161f2ea5 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -58,7 +58,6 @@ static void igc_assign_vector(struct igc_q_vector *q_vector, int msix_vector);
 static void igc_free_q_vector(struct igc_adapter *adapter, int v_idx);
 static void igc_free_q_vectors(struct igc_adapter *adapter);
 static void igc_irq_disable(struct igc_adapter *adapter);
-static void igc_irq_enable(struct igc_adapter *adapter);
 
 enum latency_range {
 	lowest_latency = 0,
@@ -2244,6 +2243,29 @@ static void igc_configure_msix(struct igc_adapter *adapter)
 }
 
 /**
+ * igc_irq_enable - Enable default interrupt generation settings
+ * @adapter: board private structure
+ */
+static void igc_irq_enable(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+
+	if (adapter->msix_entries) {
+		u32 ims = IGC_IMS_LSC | IGC_IMS_DOUTSYNC | IGC_IMS_DRSTA;
+		u32 regval = rd32(IGC_EIAC);
+
+		wr32(IGC_EIAC, regval | adapter->eims_enable_mask);
+		regval = rd32(IGC_EIAM);
+		wr32(IGC_EIAM, regval | adapter->eims_enable_mask);
+		wr32(IGC_EIMS, adapter->eims_enable_mask);
+		wr32(IGC_IMS, ims);
+	} else {
+		wr32(IGC_IMS, IMS_ENABLE_MASK | IGC_IMS_DRSTA);
+		wr32(IGC_IAM, IMS_ENABLE_MASK | IGC_IMS_DRSTA);
+	}
+}
+
+/**
  * igc_up - Open the interface and prepare it to handle traffic
  * @adapter: board private structure
  */
@@ -3973,29 +3995,6 @@ static void igc_irq_disable(struct igc_adapter *adapter)
 }
 
 /**
- * igc_irq_enable - Enable default interrupt generation settings
- * @adapter: board private structure
- */
-static void igc_irq_enable(struct igc_adapter *adapter)
-{
-	struct igc_hw *hw = &adapter->hw;
-
-	if (adapter->msix_entries) {
-		u32 ims = IGC_IMS_LSC | IGC_IMS_DOUTSYNC | IGC_IMS_DRSTA;
-		u32 regval = rd32(IGC_EIAC);
-
-		wr32(IGC_EIAC, regval | adapter->eims_enable_mask);
-		regval = rd32(IGC_EIAM);
-		wr32(IGC_EIAM, regval | adapter->eims_enable_mask);
-		wr32(IGC_EIMS, adapter->eims_enable_mask);
-		wr32(IGC_IMS, ims);
-	} else {
-		wr32(IGC_IMS, IMS_ENABLE_MASK | IGC_IMS_DRSTA);
-		wr32(IGC_IAM, IMS_ENABLE_MASK | IGC_IMS_DRSTA);
-	}
-}
-
-/**
  * igc_request_irq - initialize interrupts
  * @adapter: Pointer to adapter structure
  *
-- 
2.11.0

