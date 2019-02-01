From: Megha Dey <megha.dey@linux.intel.com>
Date: Fri,  1 Feb 2019 11:14:13 -0800
Subject: [Intel-wired-lan] [RFC v4 6/6] Documentation: PCI/MSI: Document
 dynamic MSI-X infrastructure
In-Reply-To: <1549048453-3584-1-git-send-email-megha.dey@linux.intel.com>
References: <1549048453-3584-1-git-send-email-megha.dey@linux.intel.com>
Message-ID: <1549048453-3584-7-git-send-email-megha.dey@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add Documentation for the newly introduced dynamic allocation
and deallocation of MSI-X vectors.

Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 Documentation/PCI/MSI-HOWTO.txt | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.txt
index 618e13d..28674bb 100644
--- a/Documentation/PCI/MSI-HOWTO.txt
+++ b/Documentation/PCI/MSI-HOWTO.txt
@@ -156,6 +156,42 @@ the driver can specify that only MSI or MSI-X is acceptable:
 	if (nvec < 0)
 		goto out_err;
 
+The pci_alloc_irq_vectors() API are one-shot methods to allocate MSI resources
+i.e. they cannot be called multiple times. In order to allocate MSI-X vectors
+post probe phase, multiple times, use the following API:
+
+  int pci_alloc_irq_vectors_dyn(struct pci_dev *dev, unsigned int min_vecs,
+                unsigned int max_vecs, unsigned int flags, int *group_id);
+
+This API allocates up to max_vecs interrupt vectors for a PCI device. It returns
+the number of vectors allocated or a negative error. If the device has a
+requirement for a minimum number of vectors the driver can pass a min_vecs
+argument set to this limit, and the PCI core will return -ENOSPC if it can't
+meet the minimum number of vectors. This API is only to be used for MSI-X vectors.
+
+A group ID pointer is passed which gets populated by this function. A unique
+group_id will associated with all the MSI-X vectors allocated each time this
+function is called:
+
+	int group_id;
+	nvec = pci_alloc_irq_vectors_dyn(pdev, minvecs, maxvecs,
+					flags | PCI_IRQ_MSIX, &group_id);
+	if (nvec < 0)
+		goto out_err;
+
+To get the Linux IRQ numbers passed to request_irq() and free_irq() and the
+vectors, use the following function:
+
+  int pci_irq_vec_grp(struct pci_dev *dev, unsigned int nr, unsigned int group_id);
+
+In order to free the MSI-X resources associated with a particular group, use
+the following function:
+
+  int pci_free_irq_vectors_grp(struct pci_dev *dev, int group_id);
+
+To delete the group allocated with the pci_alloc_irq_vectors_dyn() call:
+	nvec = pci_free_irq_vectors_grp(pdev, group_id);
+
 4.3 Legacy APIs
 
 The following old APIs to enable and disable MSI or MSI-X interrupts should
-- 
2.7.4

