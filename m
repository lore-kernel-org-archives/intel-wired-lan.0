From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Mon, 19 Jul 2021 14:07:41 -0400
Subject: [Intel-wired-lan] [PATCH v4 09/14] ixgbe: Use
 irq_update_affinity_hint
In-Reply-To: <20210719180746.1008665-1-nitesh@redhat.com>
References: <20210719180746.1008665-1-nitesh@redhat.com>
Message-ID: <20210719180746.1008665-10-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver uses irq_set_affinity_hint() to update the affinity_hint mask
that is consumed by the userspace to distribute the interrupts. However,
under the hood irq_set_affinity_hint() also applies the provided cpumask
(if not NULL) as the affinity for the given interrupt which is an
undocumented side effect.

To remove this side effect irq_set_affinity_hint() has been marked
as deprecated and new interfaces have been introduced. Hence, replace the
irq_set_affinity_hint() with the new interface irq_update_affinity_hint()
that only updates the affinity_hint pointer.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 913253f8ecb4..3b7db68ef860 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3241,8 +3241,8 @@ static int ixgbe_request_msix_irqs(struct ixgbe_adapter *adapter)
 		/* If Flow Director is enabled, set interrupt affinity */
 		if (adapter->flags & IXGBE_FLAG_FDIR_HASH_CAPABLE) {
 			/* assign the mask for this irq */
-			irq_set_affinity_hint(entry->vector,
-					      &q_vector->affinity_mask);
+			irq_update_affinity_hint(entry->vector,
+						 &q_vector->affinity_mask);
 		}
 	}
 
@@ -3258,8 +3258,8 @@ static int ixgbe_request_msix_irqs(struct ixgbe_adapter *adapter)
 free_queue_irqs:
 	while (vector) {
 		vector--;
-		irq_set_affinity_hint(adapter->msix_entries[vector].vector,
-				      NULL);
+		irq_update_affinity_hint(adapter->msix_entries[vector].vector,
+					 NULL);
 		free_irq(adapter->msix_entries[vector].vector,
 			 adapter->q_vector[vector]);
 	}
@@ -3392,7 +3392,7 @@ static void ixgbe_free_irq(struct ixgbe_adapter *adapter)
 			continue;
 
 		/* clear the affinity_mask in the IRQ descriptor */
-		irq_set_affinity_hint(entry->vector, NULL);
+		irq_update_affinity_hint(entry->vector, NULL);
 
 		free_irq(entry->vector, q_vector);
 	}
-- 
2.27.0

