From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Mon, 28 Sep 2020 14:35:29 -0400
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit pci_alloc_irq_vectors()
 to housekeeping CPUs
In-Reply-To: <20200928183529.471328-1-nitesh@redhat.com>
References: <20200928183529.471328-1-nitesh@redhat.com>
Message-ID: <20200928183529.471328-5-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If we have isolated CPUs dedicated for use by real-time tasks, we try to
move IRQs to housekeeping CPUs from the userspace to reduce latency
overhead on the isolated CPUs.

If we allocate too many IRQ vectors, moving them all to housekeeping CPUs
may exceed per-CPU vector limits.

When we have isolated CPUs, limit the number of vectors allocated by
pci_alloc_irq_vectors() to the minimum number required by the driver, or
to one per housekeeping CPU if that is larger.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 drivers/pci/msi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 30ae4ffda5c1..8c156867803c 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
+#include <linux/sched/isolation.h>
 
 #include "pci.h"
 
@@ -1191,8 +1192,25 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   struct irq_affinity *affd)
 {
 	struct irq_affinity msi_default_affd = {0};
+	unsigned int hk_cpus;
 	int nvecs = -ENOSPC;
 
+	hk_cpus = housekeeping_num_online_cpus(HK_FLAG_MANAGED_IRQ);
+
+	/*
+	 * If we have isolated CPUs for use by real-time tasks, to keep the
+	 * latency overhead to a minimum, device-specific IRQ vectors are moved
+	 * to the housekeeping CPUs from the userspace by changing their
+	 * affinity mask. Limit the vector usage to keep housekeeping CPUs from
+	 * running out of IRQ vectors.
+	 */
+	if (hk_cpus < num_online_cpus()) {
+		if (hk_cpus < min_vecs)
+			max_vecs = min_vecs;
+		else if (hk_cpus < max_vecs)
+			max_vecs = hk_cpus;
+	}
+
 	if (flags & PCI_IRQ_AFFINITY) {
 		if (!affd)
 			affd = &msi_default_affd;
-- 
2.18.2

