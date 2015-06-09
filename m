From: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date: Wed, 10 Jun 2015 01:15:05 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: fix locking issue with
	e1000e_disable_aspm
Message-ID: <1433888105-30295-1-git-send-email-yanirx.lubetkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

e1000e_disable_aspm called pci_disable_link_state_locked which requires
pci_bus_sem to be held, but is also called from places where this semaphore
was not previously acquired. This patch implements two flavors of
disable_aspm, one that acquires the lock, and the other (_locked) which
should be called when the semaphore is already acquired.

Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 38 ++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index b114658..ed2b795 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6355,13 +6355,14 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 }
 
 /**
- * e1000e_disable_aspm - Disable ASPM states
+ * __e1000e_disable_aspm - Disable ASPM states
  * @pdev: pointer to PCI device struct
  * @state: bit-mask of ASPM states to disable
+ * @locked: indication if this context holds pci_bus_sem locked.
  *
  * Some devices *must* have certain ASPM states disabled per hardware errata.
  **/
-static void e1000e_disable_aspm(struct pci_dev *pdev, u16 state)
+static void __e1000e_disable_aspm(struct pci_dev *pdev, u16 state, int locked)
 {
 	struct pci_dev *parent = pdev->bus->self;
 	u16 aspm_dis_mask = 0;
@@ -6400,7 +6401,10 @@ static void e1000e_disable_aspm(struct pci_dev *pdev, u16 state)
 		 "L1" : "");
 
 #ifdef CONFIG_PCIEASPM
-	pci_disable_link_state_locked(pdev, state);
+	if (locked)
+		pci_disable_link_state_locked(pdev, state);
+	else
+		 pci_disable_link_state(pdev, state);
 
 	/* Double-check ASPM control.  If not disabled by the above, the
 	 * BIOS is preventing that from happening (or CONFIG_PCIEASPM is
@@ -6423,6 +6427,32 @@ static void e1000e_disable_aspm(struct pci_dev *pdev, u16 state)
 					   aspm_dis_mask);
 }
 
+/**
+ * e1000e_disable_aspm - Disable ASPM states.
+ * @pdev: pointer to PCI device struct
+ * @state: bit-mask of ASPM states to disable
+ *
+ * This function acquires the pci_bus_sem!
+ * Some devices *must* have certain ASPM states disabled per hardware errata.
+ **/
+static void e1000e_disable_aspm(struct pci_dev *pdev, u16 state)
+{
+	__e1000e_disable_aspm(pdev, state, 0);
+}
+
+/**
+ * e1000e_disable_aspm_locked   Disable ASPM states.
+ * @pdev: pointer to PCI device struct
+ * @state: bit-mask of ASPM states to disable
+ *
+ * This function must be called with pci_bus_sem acquired!
+ * Some devices *must* have certain ASPM states disabled per hardware errata.
+ **/
+static void e1000e_disable_aspm_locked(struct pci_dev *pdev, u16 state) 
+{
+	__e1000e_disable_aspm(pdev, state, 1);
+}
+
 #ifdef CONFIG_PM
 static int __e1000_resume(struct pci_dev *pdev)
 {
@@ -6436,7 +6466,7 @@ static int __e1000_resume(struct pci_dev *pdev)
 	if (adapter->flags2 & FLAG2_DISABLE_ASPM_L1)
 		aspm_disable_flag |= PCIE_LINK_STATE_L1;
 	if (aspm_disable_flag)
-		e1000e_disable_aspm(pdev, aspm_disable_flag);
+		e1000e_disable_aspm_locked(pdev, aspm_disable_flag);
 
 	pci_set_master(pdev);
 
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

