From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Thu, 17 Jun 2021 14:22:37 -0400
Subject: [Intel-wired-lan] [PATCH v1 09/14] ixgbe: Use
 irq_update_affinity_hint
In-Reply-To: <20210617182242.8637-1-nitesh@redhat.com>
References: <20210617182242.8637-1-nitesh@redhat.com>
Message-ID: <20210617182242.8637-10-nitesh@redhat.com>
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
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2ac5b82676f3..b66040319bc6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3243,7 +3243,7 @@ static int ixgbe_request_msix_irqs(struct ixgbe_adapter *adapter)
 		/* If Flow Director is enabled, set interrupt affinity */
 		if (adapter->flags & IXGBE_FLAG_FDIR_HASH_CAPABLE) {
 			/* assign the mask for this irq */
-			irq_set_affinity_hint(entry->vector,
+			irq_update_affinity_hint(entry->vector,
 					      &q_vector->affinity_mask);
 		}
 	}
@@ -3260,7 +3260,7 @@ static int ixgbe_request_msix_irqs(struct ixgbe_adapter *adapter)
 free_queue_irqs:
 	while (vector) {
 		vector--;
-		irq_set_affinity_hint(adapter->msix_entries[vector].vector,
+		irq_update_affinity_hint(adapter->msix_entries[vector].vector,
 				      NULL);
 		free_irq(adapter->msix_entries[vector].vector,
 			 adapter->q_vector[vector]);
@@ -3394,7 +3394,7 @@ static void ixgbe_free_irq(struct ixgbe_adapter *adapter)
 			continue;
 
 		/* clear the affinity_mask in the IRQ descriptor */
-		irq_set_affinity_hint(entry->vector, NULL);
+		irq_update_affinity_hint(entry->vector, NULL);
 
 		free_irq(entry->vector, q_vector);
 	}
-- 
2.27.0

