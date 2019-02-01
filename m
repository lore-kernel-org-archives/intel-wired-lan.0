From: Megha Dey <megha.dey@linux.intel.com>
Date: Fri,  1 Feb 2019 11:14:10 -0800
Subject: [Intel-wired-lan] [RFC v4 3/6] x86: Introduce the dynamic teardown
 function
In-Reply-To: <1549048453-3584-1-git-send-email-megha.dey@linux.intel.com>
References: <1549048453-3584-1-git-send-email-megha.dey@linux.intel.com>
Message-ID: <1549048453-3584-4-git-send-email-megha.dey@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is a preparatory patch to introduce disabling of MSI-X vectors
belonging to a particular group. In this patch, we introduce a x86
specific mechanism to teardown the IRQ vectors belonging to a
particular group.

Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 arch/x86/include/asm/x86_init.h |  1 +
 arch/x86/kernel/x86_init.c      |  6 ++++++
 drivers/pci/msi.c               | 20 ++++++++++++++++++++
 include/linux/msi.h             |  2 ++
 4 files changed, 29 insertions(+)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index b85a7c5..50f26a0 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -283,6 +283,7 @@ struct pci_dev;
 struct x86_msi_ops {
 	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
 	void (*teardown_msi_irq)(unsigned int irq);
+	void (*teardown_msi_irqs_grp)(struct pci_dev *dev, int group_id);
 	void (*teardown_msi_irqs)(struct pci_dev *dev);
 	void (*restore_msi_irqs)(struct pci_dev *dev);
 };
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 50a2b49..794e7d4 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -127,6 +127,7 @@ EXPORT_SYMBOL_GPL(x86_platform);
 struct x86_msi_ops x86_msi __ro_after_init = {
 	.setup_msi_irqs		= native_setup_msi_irqs,
 	.teardown_msi_irq	= native_teardown_msi_irq,
+	.teardown_msi_irqs_grp	= default_teardown_msi_irqs_grp,
 	.teardown_msi_irqs	= default_teardown_msi_irqs,
 	.restore_msi_irqs	= default_restore_msi_irqs,
 };
@@ -142,6 +143,11 @@ void arch_teardown_msi_irqs(struct pci_dev *dev)
 	x86_msi.teardown_msi_irqs(dev);
 }
 
+void arch_teardown_msi_irqs_grp(struct pci_dev *dev, int group_id)
+{
+	x86_msi.teardown_msi_irqs_grp(dev, group_id);
+}
+
 void arch_teardown_msi_irq(unsigned int irq)
 {
 	x86_msi.teardown_msi_irq(irq);
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a0cf3d3..5e4f452 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -133,6 +133,26 @@ void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
 	return default_teardown_msi_irqs(dev);
 }
 
+void default_teardown_msi_irqs_grp(struct pci_dev *dev, int group_id)
+{
+	int i, *group = NULL;
+	struct msi_desc *entry;
+
+	for_each_pci_msi_entry(entry, dev) {
+		group = idr_find(dev->dev.msix_dev_idr->entry_idr,
+						entry->msi_attrib.entry_nr);
+		if (*group == group_id && entry->irq) {
+			for (i = 0; i < entry->nvec_used; i++)
+				arch_teardown_msi_irq(entry->irq + i);
+		}
+	}
+}
+
+void __weak arch_teardown_msi_irqs_grp(struct pci_dev *dev, int group_id)
+{
+	return default_teardown_msi_irqs_grp(dev, group_id);
+}
+
 static void default_restore_msi_irq(struct pci_dev *dev, int irq)
 {
 	struct msi_desc *entry;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 2092abf..6be0377 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -182,9 +182,11 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
 void arch_teardown_msi_irq(unsigned int irq);
 int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void arch_teardown_msi_irqs(struct pci_dev *dev);
+void arch_teardown_msi_irqs_grp(struct pci_dev *dev, int group_id);
 void arch_restore_msi_irqs(struct pci_dev *dev);
 
 void default_teardown_msi_irqs(struct pci_dev *dev);
+void default_teardown_msi_irqs_grp(struct pci_dev *dev, int group_id);
 void default_restore_msi_irqs(struct pci_dev *dev);
 
 struct msi_controller {
-- 
2.7.4

