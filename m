From: Alice Michael <alice.michael@intel.com>
Date: Wed,  7 Jun 2017 05:43:01 -0400
Subject: [Intel-wired-lan] [next PATCH S72-V3 01/13] i40evf: assign
	num_active_queues inside i40evf_alloc_queues
Message-ID: <20170607094313.32060-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The variable num_active_queues represents the number of active queues we
have for the device. We assign this pretty early in i40evf_init_subtask.

Several code locations are written with loops over the tx_rings and
rx_rings structures, which don't get allocated until
i40evf_alloc_queues, and which get freed by i40evf_free_queues.

These call sites were written under the assumption that tx_rings and
rx_rings would always be allocated at least when num_active_queues is
non-zero.

Lets fix this by moving the assignment into the function where we
allocate queues. We'll use a temporary variable for storage so that we
don't assign the value in the adapter structure until after the rings
have been set up.

Finally, when we free the queues, we'll clear the value to ensure that
we do not loop over the rings memory that no longer exists.

This resolves a possible NULL pointer derference in
i40evf_get_ethtool_stats which could occur if the VF fails to recover
from a reset, and then a user requests statistics.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 3a3ca96..7c213a3 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1198,6 +1198,7 @@ static void i40evf_free_queues(struct i40evf_adapter *adapter)
 {
 	if (!adapter->vsi_res)
 		return;
+	adapter->num_active_queues = 0;
 	kfree(adapter->tx_rings);
 	adapter->tx_rings = NULL;
 	kfree(adapter->rx_rings);
@@ -1214,18 +1215,22 @@ static void i40evf_free_queues(struct i40evf_adapter *adapter)
  **/
 static int i40evf_alloc_queues(struct i40evf_adapter *adapter)
 {
-	int i;
+	int i, num_active_queues;
+
+	num_active_queues = min_t(int,
+				  adapter->vsi_res->num_queue_pairs,
+				  (int)(num_online_cpus()));
 
-	adapter->tx_rings = kcalloc(adapter->num_active_queues,
+	adapter->tx_rings = kcalloc(num_active_queues,
 				    sizeof(struct i40e_ring), GFP_KERNEL);
 	if (!adapter->tx_rings)
 		goto err_out;
-	adapter->rx_rings = kcalloc(adapter->num_active_queues,
+	adapter->rx_rings = kcalloc(num_active_queues,
 				    sizeof(struct i40e_ring), GFP_KERNEL);
 	if (!adapter->rx_rings)
 		goto err_out;
 
-	for (i = 0; i < adapter->num_active_queues; i++) {
+	for (i = 0; i < num_active_queues; i++) {
 		struct i40e_ring *tx_ring;
 		struct i40e_ring *rx_ring;
 
@@ -1247,6 +1252,8 @@ static int i40evf_alloc_queues(struct i40evf_adapter *adapter)
 		rx_ring->rx_itr_setting = (I40E_ITR_DYNAMIC | I40E_ITR_RX_DEF);
 	}
 
+	adapter->num_active_queues = num_active_queues;
+
 	return 0;
 
 err_out:
@@ -2636,9 +2643,6 @@ static void i40evf_init_task(struct work_struct *work)
 	adapter->watchdog_timer.data = (unsigned long)adapter;
 	mod_timer(&adapter->watchdog_timer, jiffies + 1);
 
-	adapter->num_active_queues = min_t(int,
-					   adapter->vsi_res->num_queue_pairs,
-					   (int)(num_online_cpus()));
 	adapter->tx_desc_count = I40EVF_DEFAULT_TXD;
 	adapter->rx_desc_count = I40EVF_DEFAULT_RXD;
 	err = i40evf_init_interrupt_scheme(adapter);
-- 
2.9.3

