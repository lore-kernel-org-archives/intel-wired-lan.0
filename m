From: Alice Michael <alice.michael@intel.com>
Date: Thu, 29 Jun 2017 04:36:39 -0400
Subject: [Intel-wired-lan] [next PATCH S75-V2 08/12] i40evf: fix possible
	snprintf truncation of q_vector->name
In-Reply-To: <20170629083643.82018-1-alice.michael@intel.com>
References: <20170629083643.82018-1-alice.michael@intel.com>
Message-ID: <20170629083643.82018-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The q_vector names are based on the interface name with a driver prefix,
the type of q_vector setup, and the queue number. We previously set the
size of this variable to IFNAMSIZ + 9, which is incorrect, because we
actually include a minimum of 14 characters extra beyond the interface
name size.

New versions of GCC since 7 include a new warning that detects this
possible truncation and complains. We can fix this by increasing the
size incase our interface name is too large to avoid truncation. We
don't need to go beyond 14 because the compiler is smart enough to
realize our values can never exceed size of 1. We do go up to 15 here
because possible future changes may increase the number of queues beyond
one digit.

While we are here, also change some variables to be unsigned (since they
are never negative) and stop using an extra unnecessary %s format
specifier.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf.h      |  2 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 21 +++++++++------------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index c89767e..f028c09 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -121,7 +121,7 @@ struct i40e_q_vector {
 #define ITR_COUNTDOWN_START 100
 	u8 itr_countdown;	/* when 0 or 1 update ITR */
 	int v_idx;	/* vector index in list */
-	char name[IFNAMSIZ + 9];
+	char name[IFNAMSIZ + 15];
 	bool arm_wb_state;
 	cpumask_t affinity_mask;
 	struct irq_affinity_notify affinity_notify;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 755f60f..a8bc1ed 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -543,9 +543,9 @@ static void i40evf_irq_affinity_release(struct kref *ref) {}
 static int
 i40evf_request_traffic_irqs(struct i40evf_adapter *adapter, char *basename)
 {
-	int vector, err, q_vectors;
-	int rx_int_idx = 0, tx_int_idx = 0;
-	int irq_num;
+	unsigned int vector, q_vectors;
+	unsigned int rx_int_idx = 0, tx_int_idx = 0;
+	int irq_num, err;
 
 	i40evf_irq_disable(adapter);
 	/* Decrement for Other and TCP Timer vectors */
@@ -556,18 +556,15 @@ i40evf_request_traffic_irqs(struct i40evf_adapter *adapter, char *basename)
 		irq_num = adapter->msix_entries[vector + NONQ_VECS].vector;
 
 		if (q_vector->tx.ring && q_vector->rx.ring) {
-			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
-				 "i40evf-%s-%s-%d", basename,
-				 "TxRx", rx_int_idx++);
+			snprintf(q_vector->name, sizeof(q_vector->name),
+				 "i40evf-%s-TxRx-%d", basename, rx_int_idx++);
 			tx_int_idx++;
 		} else if (q_vector->rx.ring) {
-			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
-				 "i40evf-%s-%s-%d", basename,
-				 "rx", rx_int_idx++);
+			snprintf(q_vector->name, sizeof(q_vector->name),
+				 "i40evf-%s-rx-%d", basename, rx_int_idx++);
 		} else if (q_vector->tx.ring) {
-			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
-				 "i40evf-%s-%s-%d", basename,
-				 "tx", tx_int_idx++);
+			snprintf(q_vector->name, sizeof(q_vector->name),
+				 "i40evf-%s-tx-%d", basename, tx_int_idx++);
 		} else {
 			/* skip this unused q_vector */
 			continue;
-- 
2.9.3

