From: Lan Tianyu <tianyu.lan@intel.com>
Date: Tue, 24 Nov 2015 21:38:17 +0800
Subject: [Intel-wired-lan] [RFC PATCH V2 2/3] PCI: Add macros for faked PCI
	migration capability
In-Reply-To: <1448372298-28386-1-git-send-email-tianyu.lan@intel.com>
References: <1448372298-28386-1-git-send-email-tianyu.lan@intel.com>
Message-ID: <1448372298-28386-3-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch is to extend PCI CAP id for migration cap and
add reg macros. The CAP ID is trial and we may find better one if the
solution is feasible.

*PCI_VF_MIGRATION_CAP
For VF driver to  control that triggers mailbox irq or not during migration.

*PCI_VF_MIGRATION_VMM_STATUS
Qemu stores migration status in the reg

*PCI_VF_MIGRATION_VF_STATUS
VF driver tells Qemu ready for migration

*PCI_VF_MIGRATION_IRQ
VF driver stores mailbox interrupt vector in the reg for Qemu to trigger during migration.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 include/uapi/linux/pci_regs.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index efe3443..9defb6f 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -216,7 +216,8 @@
 #define  PCI_CAP_ID_MSIX	0x11	/* MSI-X */
 #define  PCI_CAP_ID_SATA	0x12	/* SATA Data/Index Conf. */
 #define  PCI_CAP_ID_AF		0x13	/* PCI Advanced Features */
-#define  PCI_CAP_ID_MAX		PCI_CAP_ID_AF
+#define  PCI_CAP_ID_MIGRATION	0X14   
+#define  PCI_CAP_ID_MAX		PCI_CAP_ID_MIGRATION
 #define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
 #define PCI_CAP_FLAGS		2	/* Capability defined flags (16 bits) */
 #define PCI_CAP_SIZEOF		4
@@ -904,4 +905,19 @@
 #define PCI_TPH_CAP_ST_SHIFT	16	/* st table shift */
 #define PCI_TPH_BASE_SIZEOF	12	/* size with no st table */
 
+/* Migration*/
+#define PCI_VF_MIGRATION_CAP		0x04
+#define PCI_VF_MIGRATION_VMM_STATUS	0x05
+#define PCI_VF_MIGRATION_VF_STATUS	0x06
+#define PCI_VF_MIGRATION_IRQ		0x07
+
+#define PCI_VF_MIGRATION_DISABLE	0x00
+#define PCI_VF_MIGRATION_ENABLE		0x01
+
+#define VMM_MIGRATION_END        0x00
+#define VMM_MIGRATION_START      0x01
+
+#define PCI_VF_WAIT_FOR_MIGRATION   0x00
+#define PCI_VF_READY_FOR_MIGRATION  0x01
+
 #endif /* LINUX_PCI_REGS_H */
-- 
1.8.4.rc0.1.g8f6a3e5.dirty

