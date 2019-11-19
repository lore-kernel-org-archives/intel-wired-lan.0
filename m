From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 19 Nov 2019 13:43:32 +0200
Subject: [Intel-wired-lan] [PATCH v1 01/15] igc: Remove no need declaration
 of the igc_clean_tx_ring
Message-ID: <20191119114332.41655-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We want to avoid forward-declarations of function if possible.
Rearrange the igc_clean_tx_ring function implementation.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 75 +++++++++++++++----------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ca7b8d6791f1..ed71d8bdf47d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -52,7 +52,6 @@ static const struct pci_device_id igc_pci_tbl[] = {
 MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
 
 /* forward declaration */
-static void igc_clean_tx_ring(struct igc_ring *tx_ring);
 static int igc_sw_init(struct igc_adapter *);
 static void igc_configure(struct igc_adapter *adapter);
 static void igc_power_down_link(struct igc_adapter *adapter);
@@ -177,43 +176,6 @@ static void igc_get_hw_control(struct igc_adapter *adapter)
 }
 
 /**
- * igc_free_tx_resources - Free Tx Resources per Queue
- * @tx_ring: Tx descriptor ring for a specific queue
- *
- * Free all transmit software resources
- */
-void igc_free_tx_resources(struct igc_ring *tx_ring)
-{
-	igc_clean_tx_ring(tx_ring);
-
-	vfree(tx_ring->tx_buffer_info);
-	tx_ring->tx_buffer_info = NULL;
-
-	/* if not set, then don't free */
-	if (!tx_ring->desc)
-		return;
-
-	dma_free_coherent(tx_ring->dev, tx_ring->size,
-			  tx_ring->desc, tx_ring->dma);
-
-	tx_ring->desc = NULL;
-}
-
-/**
- * igc_free_all_tx_resources - Free Tx Resources for All Queues
- * @adapter: board private structure
- *
- * Free all transmit software resources
- */
-static void igc_free_all_tx_resources(struct igc_adapter *adapter)
-{
-	int i;
-
-	for (i = 0; i < adapter->num_tx_queues; i++)
-		igc_free_tx_resources(adapter->tx_ring[i]);
-}
-
-/**
  * igc_clean_tx_ring - Free Tx Buffers
  * @tx_ring: ring to be cleaned
  */
@@ -275,6 +237,43 @@ static void igc_clean_tx_ring(struct igc_ring *tx_ring)
 }
 
 /**
+ * igc_free_tx_resources - Free Tx Resources per Queue
+ * @tx_ring: Tx descriptor ring for a specific queue
+ *
+ * Free all transmit software resources
+ */
+void igc_free_tx_resources(struct igc_ring *tx_ring)
+{
+	igc_clean_tx_ring(tx_ring);
+
+	vfree(tx_ring->tx_buffer_info);
+	tx_ring->tx_buffer_info = NULL;
+
+	/* if not set, then don't free */
+	if (!tx_ring->desc)
+		return;
+
+	dma_free_coherent(tx_ring->dev, tx_ring->size,
+			  tx_ring->desc, tx_ring->dma);
+
+	tx_ring->desc = NULL;
+}
+
+/**
+ * igc_free_all_tx_resources - Free Tx Resources for All Queues
+ * @adapter: board private structure
+ *
+ * Free all transmit software resources
+ */
+static void igc_free_all_tx_resources(struct igc_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_tx_queues; i++)
+		igc_free_tx_resources(adapter->tx_ring[i]);
+}
+
+/**
  * igc_clean_all_tx_rings - Free Tx Buffers for all queues
  * @adapter: board private structure
  */
-- 
2.11.0

