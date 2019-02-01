From: Megha Dey <megha.dey@linux.intel.com>
Date: Fri,  1 Feb 2019 11:14:09 -0800
Subject: [Intel-wired-lan] [RFC v4 2/6] PCI/MSI: Dynamic allocation of MSI-X
 vectors by group
In-Reply-To: <1549048453-3584-1-git-send-email-megha.dey@linux.intel.com>
References: <1549048453-3584-1-git-send-email-megha.dey@linux.intel.com>
Message-ID: <1549048453-3584-3-git-send-email-megha.dey@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently, MSI-X vector enabling and allocation for a PCIe device is
static i.e. a device driver gets only one chance to enable a specific
number of MSI-X vectors, usually during device probe. Also, in many
cases, drivers usually reserve more than required number of vectors
anticipating their use, which unnecessarily blocks resources that
could have been made available to other devices. Lastly, there is no
way for drivers to reserve more vectors, if the MSI-x has already been
enabled for that device.

Hence, a dynamic MSI-X kernel infrastructure can benefit drivers by
deferring MSI-X allocation to post probe phase, where actual demand
information is available.

This patch enables the dynamic allocation of MSI-X vectors even after
MSI-X is enabled for a PCIe device by introducing a new API:
pci_alloc_irq_vectors_dyn().

This API can be called multiple times by the driver. The MSI-X vectors
allocated each time this API is called are associated with a group ID.

In order to obtain the Linux IRQ number associated with each vector in
a group, a new api, pci_irq_vector_group() has been introduced.

Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 drivers/pci/msi.c   | 186 +++++++++++++++++++++++++++++++++++++++++++++-------
 drivers/pci/probe.c |  19 ++++++
 include/linux/pci.h |  36 ++++++++++
 kernel/irq/msi.c    |   8 +--
 4 files changed, 222 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4c0b478..a0cf3d3 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -102,7 +102,7 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (type == PCI_CAP_ID_MSI && nvec > 1)
 		return 1;
 
-	for_each_pci_msi_entry(entry, dev) {
+	for_each_pci_msi_entry_from(entry, dev) {
 		ret = arch_setup_msi_irq(dev, entry);
 		if (ret < 0)
 			return ret;
@@ -468,7 +468,7 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 	int i;
 
 	/* Determine how many msi entries we have */
-	for_each_pci_msi_entry(entry, pdev)
+	for_each_pci_msi_entry_from(entry, pdev)
 		num_msi += entry->nvec_used;
 	if (!num_msi)
 		return 0;
@@ -477,7 +477,7 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 	msi_attrs = kcalloc(num_msi + 1, sizeof(void *), GFP_KERNEL);
 	if (!msi_attrs)
 		return -ENOMEM;
-	for_each_pci_msi_entry(entry, pdev) {
+	for_each_pci_msi_entry_from(entry, pdev) {
 		for (i = 0; i < entry->nvec_used; i++) {
 			msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
 			if (!msi_dev_attr)
@@ -506,7 +506,11 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 		goto error_irq_group;
 	msi_irq_groups[0] = msi_irq_group;
 
-	ret = sysfs_create_groups(&pdev->dev.kobj, msi_irq_groups);
+	if (!pdev->msix_enabled)
+		ret = sysfs_create_group(&pdev->dev.kobj, msi_irq_group);
+	else
+		ret = sysfs_merge_group(&pdev->dev.kobj, msi_irq_group);
+
 	if (ret)
 		goto error_irq_groups;
 	pdev->msi_irq_groups = msi_irq_groups;
@@ -574,7 +578,7 @@ static int msi_verify_entries(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
 
-	for_each_pci_msi_entry(entry, dev) {
+	for_each_pci_msi_entry_from(entry, dev) {
 		if (!dev->no_64bit_msi || !entry->msg.address_hi)
 			continue;
 		pci_err(dev, "Device has broken 64-bit MSI but arch"
@@ -615,6 +619,9 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 
 	list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
 
+	 dev->dev.first_desc = list_last_entry
+                        (dev_to_msi_list(&dev->dev), struct msi_desc, list);
+
 	/* Configure MSI capability structure */
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
 	if (ret) {
@@ -700,6 +707,17 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 		entry->mask_base		= base;
 
 		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
+
+		/*
+		 * Save the pointer to the first msi_desc entry of every
+		 * MSI-X group. This pointer is used by other functions
+		 * as the starting point to iterate through each of the
+		 * entries in that particular group.
+		 */
+		if (!i)
+			dev->dev.first_desc = list_last_entry
+			(dev_to_msi_list(&dev->dev), struct msi_desc, list);
+
 		if (masks)
 			curmsk++;
 	}
@@ -715,7 +733,7 @@ static void msix_program_entries(struct pci_dev *dev,
 	struct msi_desc *entry;
 	int i = 0;
 
-	for_each_pci_msi_entry(entry, dev) {
+	for_each_pci_msi_entry_from(entry, dev) {
 		if (entries)
 			entries[i++].vector = entry->irq;
 		entry->masked = readl(pci_msix_desc_addr(entry) +
@@ -740,18 +758,20 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 {
 	int ret;
 	u16 control;
-	void __iomem *base;
 
 	/* Ensure MSI-X is disabled while it is set up */
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 
 	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
+
 	/* Request & Map MSI-X table region */
-	base = msix_map_region(dev, msix_table_size(control));
-	if (!base)
-		return -ENOMEM;
+	if (!dev->msix_enabled) {
+		dev->base = msix_map_region(dev, msix_table_size(control));
+		if (!dev->base)
+			return -ENOMEM;
+	}
 
-	ret = msix_setup_entries(dev, base, entries, nvec, affd);
+	ret = msix_setup_entries(dev, dev->base, entries, nvec, affd);
 	if (ret)
 		return ret;
 
@@ -784,6 +804,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 
 	pcibios_free_irq(dev);
+
 	return 0;
 
 out_avail:
@@ -795,7 +816,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 		struct msi_desc *entry;
 		int avail = 0;
 
-		for_each_pci_msi_entry(entry, dev) {
+		for_each_pci_msi_entry_from(entry, dev) {
 			if (entry->irq != 0)
 				avail++;
 		}
@@ -932,7 +953,8 @@ int pci_msix_vec_count(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_msix_vec_count);
 
 static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
-			     int nvec, const struct irq_affinity *affd)
+			     int nvec, const struct irq_affinity *affd,
+			     bool one_shot)
 {
 	int nr_entries;
 	int i, j;
@@ -1086,7 +1108,8 @@ EXPORT_SYMBOL(pci_enable_msi);
 
 static int __pci_enable_msix_range(struct pci_dev *dev,
 				   struct msix_entry *entries, int minvec,
-				   int maxvec, const struct irq_affinity *affd)
+				   int maxvec, const struct irq_affinity *affd,
+				   bool one_shot)
 {
 	int rc, nvec = maxvec;
 
@@ -1100,7 +1123,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (affd && affd->nr_sets && minvec != maxvec)
 		return -EINVAL;
 
-	if (WARN_ON_ONCE(dev->msix_enabled))
+	if (one_shot && WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
 	for (;;) {
@@ -1110,7 +1133,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 				return -ENOSPC;
 		}
 
-		rc = __pci_enable_msix(dev, entries, nvec, affd);
+		rc = __pci_enable_msix(dev, entries, nvec, affd, one_shot);
 		if (rc == 0)
 			return nvec;
 
@@ -1141,7 +1164,8 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 		int minvec, int maxvec)
 {
-	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL);
+	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL,
+									false);
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
 
@@ -1167,9 +1191,45 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
 				   const struct irq_affinity *affd)
 {
+	int *group = NULL;
+
+	dev->dev.one_shot = true;
+
+	return pci_alloc_irq_vectors_affinity_dyn(dev, min_vecs, max_vecs,
+					flags, NULL, group, dev->dev.one_shot);
+}
+EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
+
+/**
+ * pci_alloc_irq_vectors_affinity_dyn - allocate multiple IRQs for a device
+ * dynamically. Can be called multiple times.
+ * @dev:		PCI device to operate on
+ * @min_vecs:		minimum number of vectors required (must be >= 1)
+ * @max_vecs:		maximum (desired) number of vectors
+ * @flags:		flags or quirks for the allocation
+ * @affd:		optional description of the affinity requirements
+ * @group_id:		group ID assigned to vectors allocated
+ *
+ * Allocate up to @max_vecs interrupt vectors for @dev, using MSI-X. Return
+ * the number of vectors allocated (which might be smaller than @max_vecs)
+ * if successful, or a negative error code on error. If less than @min_vecs
+ * interrupt vectors are available for @dev the function will fail with -ENOSPC.
+ * Assign a unique group ID to the set of vectors being allocated.
+ *
+ * To get the Linux IRQ number used for a vector that can be passed to
+ * request_irq() use the pci_irq_vector() helper.
+ */
+int pci_alloc_irq_vectors_affinity_dyn(struct pci_dev *dev,
+				      unsigned int min_vecs,
+				      unsigned int max_vecs,
+				      unsigned int flags,
+				      const struct irq_affinity *affd,
+				      int *group_id, bool one_shot)
+{
 	static const struct irq_affinity msi_default_affd;
-	int msix_vecs = -ENOSPC;
+	int msix_vecs = -ENOSPC, i, *group = NULL;
 	int msi_vecs = -ENOSPC;
+	struct msix_entry *entries = NULL;
 
 	if (flags & PCI_IRQ_AFFINITY) {
 		if (!affd)
@@ -1180,15 +1240,53 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	}
 
 	if (flags & PCI_IRQ_MSIX) {
-		msix_vecs = __pci_enable_msix_range(dev, NULL, min_vecs,
-						    max_vecs, affd);
+		if (!one_shot) {
+			entries = kcalloc(max_vecs, sizeof(struct msix_entry),
+								GFP_KERNEL);
+			if (entries == NULL)
+				return -ENOMEM;
+
+			group = kcalloc(max_vecs, sizeof(int), GFP_KERNEL);
+			if (group == NULL)
+				return -ENOMEM;
+
+			if (!dev->msix_enabled)
+				dev->num_msix = pci_msix_vec_count(dev);
+
+			/* Assign a unique group ID */
+			*group = idr_alloc(dev->dev.msix_dev_idr->grp_idr, NULL,
+						0, dev->num_msix, GFP_KERNEL);
+			if (*group < 0) {
+				if (*group == -ENOSPC)
+					pci_err(dev, "No free group IDs\n");
+				return *group;
+			}
+			*group_id = *group;
+
+			for (i = 0; i < max_vecs; i++) {
+				/* tag every entry with a group ID */
+				entries[i].entry = idr_alloc(
+					dev->dev.msix_dev_idr->entry_idr,
+					group, 0, dev->num_msix, GFP_KERNEL);
+				if (entries[i].entry < 0) {
+					if (entries[i].entry == -ENOSPC)
+						pci_err(dev, "No free IDs\n");
+					return entries[i].entry;
+				}
+			}
+		}
+
+		msix_vecs = __pci_enable_msix_range(dev, entries, min_vecs, max_vecs,
+								affd, one_shot);
+
+		kfree(entries);
+
 		if (msix_vecs > 0)
 			return msix_vecs;
 	}
 
 	if (flags & PCI_IRQ_MSI) {
-		msi_vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs,
-						  affd);
+		msi_vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
 		if (msi_vecs > 0)
 			return msi_vecs;
 	}
@@ -1201,11 +1299,14 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 		}
 	}
 
+	if (flags & (PCI_IRQ_MSI | PCI_IRQ_LEGACY))
+		return -EINVAL;
+
 	if (msix_vecs == -ENOSPC)
 		return -ENOSPC;
 	return msi_vecs;
 }
-EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
+EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity_dyn);
 
 /**
  * pci_free_irq_vectors - free previously allocated IRQs for a device
@@ -1255,6 +1356,45 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 EXPORT_SYMBOL(pci_irq_vector);
 
 /**
+ * pci_irq_vector_group - return the IRQ number of a device vector associated
+ * with a group
+ * @dev: PCI device to operate on
+ * @nr: device-relative interrupt vector index (0-based).
+ * @group: group from which IRQ number should be returned
+ */
+int pci_irq_vector_group(struct pci_dev *dev, unsigned int nr,
+						unsigned int group_id)
+{
+	if (dev->msix_enabled) {
+		struct msi_desc *entry;
+		int *group, i = 0, grp_present = 0;
+
+		for_each_pci_msi_entry(entry, dev) {
+			group = idr_find(dev->dev.msix_dev_idr->entry_idr,
+						entry->msi_attrib.entry_nr);
+			if (*group == group_id) {
+				grp_present = 1;
+				if (i == nr)
+					return entry->irq;
+				i++;
+			}
+		}
+
+		if (!grp_present) {
+			pci_err(dev, "Group %d not present\n", group_id);
+			return -EINVAL;
+		}
+
+		pci_err(dev, "Interrupt vector index %d does not exist in "
+						"group %d\n", nr, group_id);
+	}
+
+	pci_err(dev, "MSI-X not enabled\n");
+	return -EINVAL;
+}
+EXPORT_SYMBOL(pci_irq_vector_group);
+
+/**
  * pci_irq_get_affinity - return the affinity of a particular msi vector
  * @dev:	PCI device to operate on
  * @nr:		device-relative interrupt vector index (0-based).
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 257b9f6..dd4a6ef 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2188,6 +2188,25 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	if (!dev)
 		return NULL;
 
+	/* For dynamic MSI-x */
+	dev->dev.msix_dev_idr = kzalloc(sizeof(struct dev_idr), GFP_KERNEL);
+	if (!dev->dev.msix_dev_idr)
+		return NULL;
+
+	dev->dev.msix_dev_idr->grp_idr = kzalloc(sizeof(struct idr),
+								GFP_KERNEL);
+	if (!dev->dev.msix_dev_idr->grp_idr)
+		return NULL;
+
+	dev->dev.msix_dev_idr->entry_idr = kzalloc(sizeof(struct idr),
+								GFP_KERNEL);
+	if (!dev->dev.msix_dev_idr->entry_idr)
+		return NULL;
+
+	/* Initialise the IDR structures */
+	idr_init(dev->dev.msix_dev_idr->grp_idr);
+	idr_init(dev->dev.msix_dev_idr->entry_idr);
+
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 177305f..28eab4a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1396,9 +1396,16 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
 				   const struct irq_affinity *affd);
+int pci_alloc_irq_vectors_affinity_dyn(struct pci_dev *dev,
+				   unsigned int min_vecs, unsigned int max_vecs,
+				   unsigned int flags,
+				   const struct irq_affinity *affd,
+				   int *group_id, bool one_shot);
 
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
+int pci_irq_vector_group(struct pci_dev *dev, unsigned int nr,
+						unsigned int group_id);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
 int pci_irq_get_node(struct pci_dev *pdev, int vec);
 
@@ -1428,6 +1435,17 @@ pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	return -ENOSPC;
 }
 
+static inline int
+pci_alloc_irq_vectors_affinity_dyn(struct pci_dev *dev, unsigned int min_vecs,
+				   unsigned int max_vecs, unsigned int flags,
+				   const struct irq_affinity *aff_desc,
+				   int *group_id, bool one_shot)
+{
+	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1 && dev->irq)
+		return 1;
+	return -ENOSPC;
+}
+
 static inline void pci_free_irq_vectors(struct pci_dev *dev)
 {
 }
@@ -1438,6 +1456,15 @@ static inline int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 		return -EINVAL;
 	return dev->irq;
 }
+
+static inline int pci_irq_vector_group(struct pci_dev *dev, unsigned int nr,
+							unsigned int group)
+{
+	if (WARN_ON_ONCE(nr > 0))
+		return -EINVAL;
+	return dev->irq;
+}
+
 static inline const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev,
 		int vec)
 {
@@ -1458,6 +1485,15 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 					      NULL);
 }
 
+static inline int
+pci_alloc_irq_vectors_dyn(struct pci_dev *dev, unsigned int min_vecs,
+			  unsigned int max_vecs, unsigned int flags,
+			  int *group_id)
+{
+	return pci_alloc_irq_vectors_affinity_dyn(dev, min_vecs, max_vecs,
+					  flags, NULL, group_id, false);
+}
+
 /**
  * pci_irqd_intx_xlate() - Translate PCI INTx value to an IRQ domain hwirq
  * @d: the INTx IRQ domain
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index ad26fbc..5cfa931 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -411,7 +411,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	if (ret)
 		return ret;
 
-	for_each_msi_entry(desc, dev) {
+	for_each_msi_entry_from(desc, dev) {
 		ops->set_desc(&arg, desc);
 
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
@@ -437,7 +437,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 
 	can_reserve = msi_check_reservation_mode(domain, info, dev);
 
-	for_each_msi_entry(desc, dev) {
+	for_each_msi_entry_from(desc, dev) {
 		virq = desc->irq;
 		if (desc->nvec_used == 1)
 			dev_dbg(dev, "irq %d for MSI\n", virq);
@@ -465,7 +465,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	 * so request_irq() will assign the final vector.
 	 */
 	if (can_reserve) {
-		for_each_msi_entry(desc, dev) {
+		for_each_msi_entry_from(desc, dev) {
 			irq_data = irq_domain_get_irq_data(domain, desc->irq);
 			irqd_clr_activated(irq_data);
 		}
@@ -473,7 +473,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	return 0;
 
 cleanup:
-	for_each_msi_entry(desc, dev) {
+	for_each_msi_entry_from(desc, dev) {
 		struct irq_data *irqd;
 
 		if (desc->irq == virq)
-- 
2.7.4

