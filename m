From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 26 Jul 2021 20:36:54 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v6 1/4] Revert "PCI: Make
 pci_enable_ptm() private"
In-Reply-To: <20210727033657.39885-1-vinicius.gomes@intel.com>
References: <20210727033657.39885-1-vinicius.gomes@intel.com>
Message-ID: <20210727033657.39885-2-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Make pci_enable_ptm() accessible from the drivers.

Exposing this to the driver enables the driver to use the
'ptm_enabled' field of 'pci_dev' to check if PTM is enabled or not.

This reverts commit ac6c26da29c1 ("PCI: Make pci_enable_ptm() private").

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h   | 3 ---
 include/linux/pci.h | 7 +++++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 93dcdd431072..2f52110cac97 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -597,11 +597,8 @@ static inline void pcie_ecrc_get_policy(char *str) { }
 
 #ifdef CONFIG_PCIE_PTM
 void pci_ptm_init(struct pci_dev *dev);
-int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
 #else
 static inline void pci_ptm_init(struct pci_dev *dev) { }
-static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
-{ return -EINVAL; }
 #endif
 
 struct pci_dev_reset_methods {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 540b377ca8f6..21a9d244e4e4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1620,6 +1620,13 @@ static inline bool pci_aer_available(void) { return false; }
 
 bool pci_ats_disabled(void);
 
+#ifdef CONFIG_PCIE_PTM
+int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
+#else
+static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
+{ return -EINVAL; }
+#endif
+
 void pci_cfg_access_lock(struct pci_dev *dev);
 bool pci_cfg_access_trylock(struct pci_dev *dev);
 void pci_cfg_access_unlock(struct pci_dev *dev);
-- 
2.32.0

