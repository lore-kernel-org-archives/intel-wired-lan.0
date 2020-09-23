From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Wed, 23 Sep 2020 14:11:26 -0400
Subject: [Intel-wired-lan] [PATCH v2 4/4] PCI: Limit pci_alloc_irq_vectors
 as per housekeeping CPUs
In-Reply-To: <20200923181126.223766-1-nitesh@redhat.com>
References: <20200923181126.223766-1-nitesh@redhat.com>
Message-ID: <20200923181126.223766-5-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch limits the pci_alloc_irq_vectors, max_vecs argument that is
passed on by the caller based on the housekeeping online CPUs (that are
meant to perform managed IRQ jobs).

A minimum of the max_vecs passed and housekeeping online CPUs is derived
to ensure that we don't create excess vectors as that can be problematic
specifically in an RT environment. In cases where the min_vecs exceeds the
housekeeping online CPUs, max vecs is restricted based on the min_vecs
instead. The proposed change is required because for an RT environment
unwanted IRQs are moved to the housekeeping CPUs from isolated CPUs to
keep the latency overhead to a minimum. If the number of housekeeping CPUs
is significantly lower than that of the isolated CPUs we can run into
failures while moving these IRQs to housekeeping CPUs due to per CPU
vector limit.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 include/linux/pci.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 835530605c0d..cf9ca9410213 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -38,6 +38,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/resource_ext.h>
+#include <linux/sched/isolation.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -1797,6 +1798,20 @@ static inline int
 pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 		      unsigned int max_vecs, unsigned int flags)
 {
+	unsigned int hk_cpus = hk_num_online_cpus();
+
+	/*
+	 * For a real-time environment, try to be conservative and at max only
+	 * ask for the same number of vectors as there are housekeeping online
+	 * CPUs. In case, the min_vecs requested exceeds the housekeeping
+	 * online CPUs, restrict the max_vecs based on the min_vecs instead.
+	 */
+	if (hk_cpus != num_online_cpus()) {
+		if (min_vecs > hk_cpus)
+			max_vecs = min_vecs;
+		else
+			max_vecs = min_t(int, max_vecs, hk_cpus);
+	}
 	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs, flags,
 					      NULL);
 }
-- 
2.18.2

