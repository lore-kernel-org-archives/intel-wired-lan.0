From: Barry Song <21cnbao@gmail.com>
Date: Wed, 25 Aug 2021 18:26:36 +0800
Subject: [Intel-wired-lan] [PATCH v3 3/3] PCI/MSI: remove
 msi_attrib.default_irq in msi_desc
In-Reply-To: <20210825102636.52757-1-21cnbao@gmail.com>
References: <20210825102636.52757-1-21cnbao@gmail.com>
Message-ID: <20210825102636.52757-4-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Marc Zyngier <maz@kernel.org>

default_irq is hideous as it should be per-device but not per-desc.
On the other hand, MSI-X case doesn't use it at all. Since sysfs
IRQ has moved to use the msi_entry instead of pci_dev.irq, now it
seems it is safe to remove msi_attrib.default_irq.

Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
[Barry: Updated pci_irq_vector and __pci_restore_msi_state]
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/pci/msi.c   | 12 +++++-------
 include/linux/msi.h |  2 --
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index e5e7533..9434afa 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -422,7 +422,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	if (!dev->msi_enabled)
 		return;
 
-	entry = irq_get_msi_desc(dev->irq);
+	entry = first_pci_msi_entry(dev);
 
 	pci_intx_for_msi(dev, 0);
 	pci_msi_set_enable(dev, 0);
@@ -591,7 +591,6 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 	entry->msi_attrib.is_virtual    = 0;
 	entry->msi_attrib.entry_nr	= 0;
 	entry->msi_attrib.maskbit	= !!(control & PCI_MSI_FLAGS_MASKBIT);
-	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
 	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
 	entry->msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
 
@@ -682,7 +681,6 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	dev->msi_enabled = 1;
 
 	pcibios_free_irq(dev);
-	dev->irq = entry->irq;
 	return 0;
 }
 
@@ -742,7 +740,6 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 		entry->msi_attrib.is_virtual =
 			entry->msi_attrib.entry_nr >= vec_count;
 
-		entry->msi_attrib.default_irq	= dev->irq;
 		entry->mask_base		= base;
 
 		addr = pci_msix_desc_addr(entry);
@@ -964,8 +961,6 @@ static void pci_msi_shutdown(struct pci_dev *dev)
 	mask = msi_mask(desc->msi_attrib.multi_cap);
 	msi_mask_irq(desc, mask, 0);
 
-	/* Restore dev->irq to its default pin-assertion IRQ */
-	dev->irq = desc->msi_attrib.default_irq;
 	pcibios_alloc_irq(dev);
 }
 
@@ -1301,12 +1296,15 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 
 		if (WARN_ON_ONCE(nr >= entry->nvec_used))
 			return -EINVAL;
+
+		return entry->irq + nr;
 	} else {
 		if (WARN_ON_ONCE(nr > 0))
 			return -EINVAL;
 	}
 
-	return dev->irq + nr;
+	/* legacy INTx */
+	return dev->irq;
 }
 EXPORT_SYMBOL(pci_irq_vector);
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index e8bdcb8..a631664 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -114,7 +114,6 @@ struct ti_sci_inta_msi_desc {
  * @maskbit:	[PCI MSI/X] Mask-Pending bit supported?
  * @is_64:	[PCI MSI/X] Address size: 0=32bit 1=64bit
  * @entry_nr:	[PCI MSI/X] Entry which is described by this descriptor
- * @default_irq:[PCI MSI/X] The default pre-assigned non-MSI irq
  * @mask_pos:	[PCI MSI]   Mask register position
  * @mask_base:	[PCI MSI-X] Mask register base address
  * @platform:	[platform]  Platform device specific msi descriptor data
@@ -148,7 +147,6 @@ struct msi_desc {
 				u8	is_64		: 1;
 				u8	is_virtual	: 1;
 				u16	entry_nr;
-				unsigned default_irq;
 			} msi_attrib;
 			union {
 				u8	mask_pos;
-- 
1.8.3.1

