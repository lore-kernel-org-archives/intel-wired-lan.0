From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Tue, 20 Jul 2021 19:26:16 -0400
Subject: [Intel-wired-lan] [PATCH v5 06/14] RDMA/irdma: Use
 irq_update_affinity_hint
In-Reply-To: <20210720232624.1493424-1-nitesh@redhat.com>
References: <20210720232624.1493424-1-nitesh@redhat.com>
Message-ID: <20210720232624.1493424-7-nitesh@redhat.com>
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
 drivers/infiniband/hw/irdma/hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 7afb8a6a0526..ec8de708a4df 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -537,7 +537,7 @@ static void irdma_destroy_irq(struct irdma_pci_f *rf,
 	struct irdma_sc_dev *dev = &rf->sc_dev;
 
 	dev->irq_ops->irdma_dis_irq(dev, msix_vec->idx);
-	irq_set_affinity_hint(msix_vec->irq, NULL);
+	irq_update_affinity_hint(msix_vec->irq, NULL);
 	free_irq(msix_vec->irq, dev_id);
 }
 
@@ -1087,7 +1087,7 @@ irdma_cfg_ceq_vector(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
 	}
 	cpumask_clear(&msix_vec->mask);
 	cpumask_set_cpu(msix_vec->cpu_affinity, &msix_vec->mask);
-	irq_set_affinity_hint(msix_vec->irq, &msix_vec->mask);
+	irq_update_affinity_hint(msix_vec->irq, &msix_vec->mask);
 	if (status) {
 		ibdev_dbg(&rf->iwdev->ibdev, "ERR: ceq irq config fail\n");
 		return IRDMA_ERR_CFG;
-- 
2.27.0

