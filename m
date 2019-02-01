From: Megha Dey <megha.dey@linux.intel.com>
Date: Fri,  1 Feb 2019 11:14:08 -0800
Subject: [Intel-wired-lan] [RFC v4 1/6] PCI/MSI: New structures/macros for
 dynamic MSI-X allocation
In-Reply-To: <1549048453-3584-1-git-send-email-megha.dey@linux.intel.com>
References: <1549048453-3584-1-git-send-email-megha.dey@linux.intel.com>
Message-ID: <1549048453-3584-2-git-send-email-megha.dey@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is a preparatory patch to introduce the dynamic allocation of
MSI-X vectors. In this patch, we add new structure members, introduce
relevant structures and macros which will be consumed by the API which
will dynamically allocate the MSI-X vectors.

Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 include/linux/device.h | 14 ++++++++++++++
 include/linux/msi.h    |  7 +++++++
 include/linux/pci.h    |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 6cb4640..3e9b138 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -887,6 +887,16 @@ struct dev_links_info {
 };
 
 /**
+ * struct dev_idr - Device group and entry ID allocator.
+ * @grp_idr: group ID allocator
+ * @entry_idr: entry ID allocator
+ */
+struct dev_idr {
+	struct idr *grp_idr;
+	struct idr *entry_idr;
+};
+
+/**
  * struct device - The basic device structure
  * @parent:	The device's "parent" device, the device to which it is attached.
  * 		In most cases, a parent device is some sort of bus or host
@@ -1051,6 +1061,10 @@ struct device {
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	bool			dma_coherent:1;
 #endif
+	/* For dynamic MSI-X allocation */
+	struct msi_desc		*first_desc;	/* 1st MSI-X desc of the latest allocated group */
+	struct dev_idr		*msix_dev_idr;	/* entry/group allocator */
+	bool			one_shot;	/* dynamic or oneshot MSI-X allocation */
 };
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 784fb52..2092abf 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -118,11 +118,18 @@ struct msi_desc {
 	list_for_each_entry((desc), dev_to_msi_list((dev)), list)
 #define for_each_msi_entry_safe(desc, tmp, dev)	\
 	list_for_each_entry_safe((desc), (tmp), dev_to_msi_list((dev)), list)
+/* Iterate through MSI entries from a given entry */
+#define for_each_msi_entry_from(desc, dev)                             \
+	desc = (*dev).first_desc;                                       \
+	list_for_each_entry_from((desc), dev_to_msi_list((dev)), list)  \
 
 #ifdef CONFIG_PCI_MSI
 #define first_pci_msi_entry(pdev)	first_msi_entry(&(pdev)->dev)
 #define for_each_pci_msi_entry(desc, pdev)	\
 	for_each_msi_entry((desc), &(pdev)->dev)
+/* Iterate through PCI-MSI entries from a given entry */
+#define for_each_pci_msi_entry_from(desc, pdev)        \
+	for_each_msi_entry_from((desc), &(pdev)->dev)
 
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc);
 void *msi_desc_to_pci_sysdata(struct msi_desc *desc);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 65f1d8c..177305f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -459,6 +459,8 @@ struct pci_dev {
 	char		*driver_override; /* Driver name to force a match */
 
 	unsigned long	priv_flags;	/* Private flags for the PCI driver */
+	unsigned int	num_msix;	/* Number of MSI-X vectors supported */
+	void __iomem	*base;		/* Base address of MSI-X table */
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
-- 
2.7.4

