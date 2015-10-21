From: Lan Tianyu <tianyu.lan@intel.com>
Date: Thu, 22 Oct 2015 00:37:33 +0800
Subject: [Intel-wired-lan] [RFC Patch 01/12] PCI: Add virtfn_index for
	struct pci_device
In-Reply-To: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
Message-ID: <1445445464-5056-2-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add "virtfn_index" member in the struct pci_device to record VF sequence
of PF. This will be used in the VF sysfs node handle.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/pci/iov.c   | 1 +
 include/linux/pci.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ee0ebff..065b6bb 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -136,6 +136,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 	virtfn->physfn = pci_dev_get(dev);
 	virtfn->is_virtfn = 1;
 	virtfn->multifunction = 0;
+	virtfn->virtfn_index = id;
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &dev->resource[i + PCI_IOV_RESOURCES];
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 353db8d..85c5531 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -356,6 +356,7 @@ struct pci_dev {
 	unsigned int	io_window_1k:1;	/* Intel P2P bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
 	pci_dev_flags_t dev_flags;
+	unsigned int	virtfn_index;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
 	u32		saved_config_space[16]; /* config space saved at suspend time */
-- 
1.8.4.rc0.1.g8f6a3e5.dirty

