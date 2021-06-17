From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Thu, 17 Jun 2021 14:22:33 -0400
Subject: [Intel-wired-lan] [PATCH v1 05/14] scsi: mpt3sas: Use
 irq_set_affinity_and_hint
In-Reply-To: <20210617182242.8637-1-nitesh@redhat.com>
References: <20210617182242.8637-1-nitesh@redhat.com>
Message-ID: <20210617182242.8637-6-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver uses irq_set_affinity_hint() specifically for the high IOPS
queue interrupts for two purposes:

- To set the affinity_hint which is consumed by the userspace for
? distributing the interrupts

- To apply an affinity that it provides

The driver enforces its own affinity to bind the high IOPS queue interrupts
to the local NUMA node. However, irq_set_affinity_hint() applying the
provided cpumask as an affinity (if not NULL) for the interrupt is an
undocumented side effect.

To remove this side effect irq_set_affinity_hint() has been marked
as deprecated and new interfaces have been introduced. Hence, replace the
irq_set_affinity_hint() with the new interface irq_set_affinity_and_hint()
that clearly indicates the purpose of the usage and is meant to apply the
affinity and set the affinity_hint pointer. Also, replace
irq_set_affinity_hint() with irq_update_affinity_hint() when only
affinity_hint needs to be updated.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 5779f313f6f8..c112c30577bb 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2998,8 +2998,8 @@ _base_free_irq(struct MPT3SAS_ADAPTER *ioc)
 	list_for_each_entry_safe(reply_q, next, &ioc->reply_queue_list, list) {
 		list_del(&reply_q->list);
 		if (ioc->smp_affinity_enable)
-			irq_set_affinity_hint(pci_irq_vector(ioc->pdev,
-			    reply_q->msix_index), NULL);
+			irq_update_affinity_hint(pci_irq_vector(ioc->pdev,
+						reply_q->msix_index), NULL);
 		free_irq(pci_irq_vector(ioc->pdev, reply_q->msix_index),
 			 reply_q);
 		kfree(reply_q);
@@ -3055,15 +3055,13 @@ _base_request_irq(struct MPT3SAS_ADAPTER *ioc, u8 index)
  * @ioc: per adapter object
  *
  * The enduser would need to set the affinity via /proc/irq/#/smp_affinity
- *
- * It would nice if we could call irq_set_affinity, however it is not
- * an exported symbol
  */
 static void
 _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 {
-	unsigned int cpu, nr_cpus, nr_msix, index = 0;
+	unsigned int cpu, nr_cpus, nr_msix, index = 0, irq;
 	struct adapter_reply_queue *reply_q;
+	const struct cpumask *mask;
 	int local_numa_node;
 
 	if (!_base_is_controller_msix_enabled(ioc))
@@ -3090,8 +3088,9 @@ _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 			local_numa_node = dev_to_node(&ioc->pdev->dev);
 			for (index = 0; index < ioc->high_iops_queues;
 			    index++) {
-				irq_set_affinity_hint(pci_irq_vector(ioc->pdev,
-				    index), cpumask_of_node(local_numa_node));
+				irq = pci_irq_vector(ioc->pdev, index);
+				mask = cpumask_of_node(local_numa_node);
+				irq_set_affinity_and_hint(irq, mask);
 			}
 		}
 
-- 
2.27.0

