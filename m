From: Megha Dey <megha.dey@linux.intel.com>
Date: Fri,  1 Feb 2019 11:14:11 -0800
Subject: [Intel-wired-lan] [RFC v4 4/6] PCI/MSI: Introduce new structure to
 manage MSI-x entries
In-Reply-To: <1549048453-3584-1-git-send-email-megha.dey@linux.intel.com>
References: <1549048453-3584-1-git-send-email-megha.dey@linux.intel.com>
Message-ID: <1549048453-3584-5-git-send-email-megha.dey@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is a preparatory patch to introduce disabling of MSI-X vectors
belonging to a particular group. In this patch, we introduce a new
structure msix_sysfs, which manages sysfs entries for dynamically
allocated MSI-X vectors belonging to a particular group.

Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 drivers/pci/msi.c   | 15 ++++++++++++++-
 drivers/pci/probe.c |  1 +
 include/linux/pci.h |  9 +++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 5e4f452..e7bbd21 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -481,10 +481,11 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 	struct device_attribute *msi_dev_attr;
 	struct attribute_group *msi_irq_group;
 	const struct attribute_group **msi_irq_groups;
+	struct msix_sysfs *msix_sysfs_entry;
 	struct msi_desc *entry;
 	int ret = -ENOMEM;
 	int num_msi = 0;
-	int count = 0;
+	int count = 0, *group = NULL;
 	int i;
 
 	/* Determine how many msi entries we have */
@@ -511,6 +512,10 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 				goto error_attrs;
 			msi_dev_attr->attr.mode = S_IRUGO;
 			msi_dev_attr->show = msi_mode_show;
+			if (!i)
+				group = idr_find(
+					pdev->dev.msix_dev_idr->entry_idr,
+						entry->msi_attrib.entry_nr);
 			++count;
 		}
 	}
@@ -526,6 +531,14 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 		goto error_irq_group;
 	msi_irq_groups[0] = msi_irq_group;
 
+	msix_sysfs_entry = kzalloc(sizeof(*msix_sysfs_entry) * 2, GFP_KERNEL);
+	msix_sysfs_entry->msi_irq_group = msi_irq_group;
+	if (group)
+		msix_sysfs_entry->group_id = *group;
+	msix_sysfs_entry->vecs_in_grp = count;
+	INIT_LIST_HEAD(&msix_sysfs_entry->list);
+	list_add_tail(&msix_sysfs_entry->list, &pdev->msix_sysfs);
+
 	if (!pdev->msix_enabled)
 		ret = sysfs_create_group(&pdev->dev.kobj, msi_irq_group);
 	else
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd4a6ef..02f5d88 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2208,6 +2208,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	idr_init(dev->dev.msix_dev_idr->entry_idr);
 
 	INIT_LIST_HEAD(&dev->bus_list);
+	INIT_LIST_HEAD(&dev->msix_sysfs);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 28eab4a..2e2f4c9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -461,6 +461,7 @@ struct pci_dev {
 	unsigned long	priv_flags;	/* Private flags for the PCI driver */
 	unsigned int	num_msix;	/* Number of MSI-X vectors supported */
 	void __iomem	*base;		/* Base address of MSI-X table */
+	struct list_head        msix_sysfs; /* Manage sysfs entries for each MSI-x group */
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
@@ -1375,6 +1376,14 @@ struct msix_entry {
 	u16	entry;	/* Driver uses to specify entry, OS writes */
 };
 
+/* Manage sysfs entries for dynamically allocated MSI-X vectors */
+struct msix_sysfs {
+	struct	attribute_group *msi_irq_group;
+	struct	list_head list;
+	int	group_id;
+	int	vecs_in_grp;
+};
+
 #ifdef CONFIG_PCI_MSI
 int pci_msi_vec_count(struct pci_dev *dev);
 void pci_disable_msi(struct pci_dev *dev);
-- 
2.7.4

