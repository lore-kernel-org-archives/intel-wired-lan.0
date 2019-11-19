From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 19 Nov 2019 13:45:07 +0200
Subject: [Intel-wired-lan] [PATCH v1 11/15] igc: Remove no need declaration
 of the igc_free_q_vectors
Message-ID: <20191119114507.42377-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We want to avoid forward-declarations of function if possible.
Rearrange the igc_free_q_vectors function implementation.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index f451c90581e5..be611f5fc87e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -56,7 +56,6 @@ static int igc_sw_init(struct igc_adapter *);
 static void igc_write_itr(struct igc_q_vector *q_vector);
 static void igc_assign_vector(struct igc_q_vector *q_vector, int msix_vector);
 static void igc_free_q_vector(struct igc_adapter *adapter, int v_idx);
-static void igc_free_q_vectors(struct igc_adapter *adapter);
 
 enum latency_range {
 	lowest_latency = 0,
@@ -3119,19 +3118,6 @@ static void igc_set_interrupt_capability(struct igc_adapter *adapter,
 }
 
 /**
- * igc_clear_interrupt_scheme - reset the device to a state of no interrupts
- * @adapter: Pointer to adapter structure
- *
- * This function resets the device so that it has 0 rx queues, tx queues, and
- * MSI-X interrupts allocated.
- */
-static void igc_clear_interrupt_scheme(struct igc_adapter *adapter)
-{
-	igc_free_q_vectors(adapter);
-	igc_reset_interrupt_capability(adapter);
-}
-
-/**
  * igc_free_q_vectors - Free memory allocated for interrupt vectors
  * @adapter: board private structure to initialize
  *
@@ -3154,6 +3140,19 @@ static void igc_free_q_vectors(struct igc_adapter *adapter)
 }
 
 /**
+ * igc_clear_interrupt_scheme - reset the device to a state of no interrupts
+ * @adapter: Pointer to adapter structure
+ *
+ * This function resets the device so that it has 0 rx queues, tx queues, and
+ * MSI-X interrupts allocated.
+ */
+static void igc_clear_interrupt_scheme(struct igc_adapter *adapter)
+{
+	igc_free_q_vectors(adapter);
+	igc_reset_interrupt_capability(adapter);
+}
+
+/**
  * igc_free_q_vector - Free memory allocated for specific interrupt vector
  * @adapter: board private structure to initialize
  * @v_idx: Index of vector to be freed
-- 
2.11.0

