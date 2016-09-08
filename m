From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu,  8 Sep 2016 09:27:28 +0300
Subject: [Intel-wired-lan] [PATCH] PCI: disable FLR for 82579 device
Message-ID: <1473316048-7598-1-git-send-email-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

82579 has a problem reattaching itself after the device is detached.
The bug was reported by Redhat. The suggested fix is to disable
FLR capability in PCIe configuration space.

Reproduction:
Attach the device to a VM, then detach and try to attach again.

Fix:
Disable FLR capability to prevent the 82579 from hanging.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/pci/quirks.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 37ff015..729ca69 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4428,3 +4428,24 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 	}
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
+/*
+ * Workaround FLR issues for 82579
+ * This code disables the FLR (Function Level Reset) via PCIe, in order
+ * to workaround a bug found while using device passthrough, where the
+ * interface would become non-responsive.
+ * NOTE: the FLR bit is Read/Write Once (RWO) in config space, so if
+ * the BIOS or kernel writes this register * then this workaround will
+ * not work.
+ */
+static void quirk_intel_flr_cap_dis(struct pci_dev *dev)
+{
+	int pos = pci_find_capability(dev, PCI_CAP_ID_AF);
+	if (pos) {
+		u8 cap;
+		pci_read_config_byte(dev, pos + PCI_AF_CAP, &cap);
+		cap = cap & (~PCI_AF_CAP_FLR);
+		pci_write_config_byte(dev, pos + PCI_AF_CAP, cap);
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_flr_cap_dis);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_flr_cap_dis);
-- 
1.8.3.1

