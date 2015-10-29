From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 29 Oct 2015 13:43:40 -0700
Subject: [Intel-wired-lan] [next-queue v2] fm10k: initialize xps at driver
	load
Message-ID: <1446151420-6632-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Similar to ixgbe and i40e, initialize XPS on driver load so that we can
take advantage of this kernel feature.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

- v2
* Fix patch application issue
* Put xps initialization on Tx queues (instead of Rx)

This patch replaces the previous version currently on the queue, in
place.

 drivers/net/ethernet/intel/fm10k/fm10k.h     |  3 +++
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 2920de42441b..5458feefdd55 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -23,6 +23,7 @@
 
 #include <linux/types.h>
 #include <linux/etherdevice.h>
+#include <linux/cpumask.h>
 #include <linux/rtnetlink.h>
 #include <linux/if_vlan.h>
 #include <linux/pci.h>
@@ -66,6 +67,7 @@ struct fm10k_l2_accel {
 enum fm10k_ring_state_t {
 	__FM10K_TX_DETECT_HANG,
 	__FM10K_HANG_CHECK_ARMED,
+	__FM10K_TX_XPS_INIT_DONE,
 };
 
 #define check_for_tx_hang(ring) \
@@ -209,6 +211,7 @@ struct fm10k_q_vector {
 	struct fm10k_ring_container rx, tx;
 
 	struct napi_struct napi;
+	cpumask_t affinity_mask;
 	char name[IFNAMSIZ + 9];
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 15d8e10c2504..d849e83fdafb 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -600,6 +600,13 @@ static void fm10k_configure_tx_ring(struct fm10k_intfc *interface,
 	fm10k_write_reg(hw, FM10K_PFVTCTL(reg_idx),
 			FM10K_PFVTCTL_FTAG_DESC_ENABLE);
 
+	/* Initialize XPS */
+	if (!test_and_set_bit(__FM10K_TX_XPS_INIT_DONE, &ring->state) &&
+	    ring->q_vector)
+		netif_set_xps_queue(ring->netdev,
+				    &ring->q_vector->affinity_mask,
+				    ring->queue_index);
+
 	/* enable queue */
 	fm10k_write_reg(hw, FM10K_TXDCTL(reg_idx), txdctl);
 }
@@ -1478,8 +1485,10 @@ void fm10k_qv_free_irq(struct fm10k_intfc *interface)
 		if (!q_vector->tx.count && !q_vector->rx.count)
 			continue;
 
-		/* disable interrupts */
+		/* clear the affinity_mask in the IRQ descriptor */
+		irq_set_affinity_hint(entry->vector, NULL);
 
+		/* disable interrupts */
 		writel(FM10K_ITR_MASK_SET, q_vector->itr);
 
 		free_irq(entry->vector, q_vector);
@@ -1537,6 +1546,9 @@ int fm10k_qv_request_irq(struct fm10k_intfc *interface)
 			goto err_out;
 		}
 
+		/* assign the mask for this irq */
+		irq_set_affinity_hint(entry->vector, &q_vector->affinity_mask);
+
 		/* Enable q_vector */
 		writel(FM10K_ITR_ENABLE, q_vector->itr);
 
@@ -1557,8 +1569,10 @@ int fm10k_qv_request_irq(struct fm10k_intfc *interface)
 		if (!q_vector->tx.count && !q_vector->rx.count)
 			continue;
 
-		/* disable interrupts */
+		/* clear the affinity_mask in the IRQ descriptor */
+		irq_set_affinity_hint(entry->vector, NULL);
 
+		/* disable interrupts */
 		writel(FM10K_ITR_MASK_SET, q_vector->itr);
 
 		free_irq(entry->vector, q_vector);
-- 
2.6.1.264.gbab76a9

