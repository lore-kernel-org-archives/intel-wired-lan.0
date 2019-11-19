From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 19 Nov 2019 13:45:32 +0200
Subject: [Intel-wired-lan] [PATCH v1 14/15] igc: Remove no need declaration
 of the igc_write_itr
Message-ID: <20191119114532.42554-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We want to avoid forward-declarations of function if possible.
Rearrange the igc_write_itr function implementation.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 33 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index bce18aee8d8f..309e9694633a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -53,7 +53,6 @@ MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
 
 /* forward declaration */
 static int igc_sw_init(struct igc_adapter *);
-static void igc_write_itr(struct igc_q_vector *q_vector);
 
 enum latency_range {
 	lowest_latency = 0,
@@ -2931,6 +2930,22 @@ static irqreturn_t igc_msix_other(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void igc_write_itr(struct igc_q_vector *q_vector)
+{
+	u32 itr_val = q_vector->itr_val & IGC_QVECTOR_MASK;
+
+	if (!q_vector->set_itr)
+		return;
+
+	if (!itr_val)
+		itr_val = IGC_ITR_VAL_MASK;
+
+	itr_val |= IGC_EITR_CNT_IGNR;
+
+	writel(itr_val, q_vector->itr_register);
+	q_vector->set_itr = 0;
+}
+
 static irqreturn_t igc_msix_ring(int irq, void *data)
 {
 	struct igc_q_vector *q_vector = data;
@@ -4044,22 +4059,6 @@ static int igc_request_irq(struct igc_adapter *adapter)
 	return err;
 }
 
-static void igc_write_itr(struct igc_q_vector *q_vector)
-{
-	u32 itr_val = q_vector->itr_val & IGC_QVECTOR_MASK;
-
-	if (!q_vector->set_itr)
-		return;
-
-	if (!itr_val)
-		itr_val = IGC_ITR_VAL_MASK;
-
-	itr_val |= IGC_EITR_CNT_IGNR;
-
-	writel(itr_val, q_vector->itr_register);
-	q_vector->set_itr = 0;
-}
-
 /**
  * __igc_open - Called when a network interface is made active
  * @netdev: network interface device structure
-- 
2.11.0

