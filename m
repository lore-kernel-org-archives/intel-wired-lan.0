From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 12 Jul 2021 21:34:58 +0800
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: Make mei_me active when
 e1000e is in use
In-Reply-To: <20210712133500.1126371-1-kai.heng.feng@canonical.com>
References: <20210712133500.1126371-1-kai.heng.feng@canonical.com>
Message-ID: <20210712133500.1126371-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Many users report rather sluggish RX speed on TGP I219. Since
"intel_idle.max_cstate=1" doesn't help, so it's not caused by deeper
package C-state.

A workaround that always works is to make sure mei_me is runtime active
when e1000e is in use.

The root cause is still unknown, but since many users are affected by
the issue, implment the quirk in the driver as a temporary workaround.

Also adds mei_me as soft dependency to ensure the device link can be
created if e1000e is in initramfs.

BugLink: https://bugs.launchpad.net/bugs/1927925
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213377
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213651
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 5835d6cf2f51..e63445a8ce12 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7317,6 +7317,27 @@ static const struct net_device_ops e1000e_netdev_ops = {
 	.ndo_features_check	= passthru_features_check,
 };
 
+static void e1000e_create_device_links(struct pci_dev *pdev)
+{
+	struct pci_dev *tgp_mei_me;
+
+	/* Find TGP mei_me devices and make e1000e power depend on mei_me */
+	tgp_mei_me = pci_get_device(PCI_VENDOR_ID_INTEL, 0xa0e0, NULL);
+	if (!tgp_mei_me) {
+		tgp_mei_me = pci_get_device(PCI_VENDOR_ID_INTEL, 0x43e0, NULL);
+		if (!tgp_mei_me)
+			return;
+	}
+
+	if (device_link_add(&pdev->dev, &tgp_mei_me->dev,
+			    DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE |
+			    DL_FLAG_AUTOREMOVE_CONSUMER))
+		pci_info(pdev, "System and runtime PM depends on %s\n",
+			 pci_name(tgp_mei_me));
+
+	pci_dev_put(tgp_mei_me);
+}
+
 /**
  * e1000_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -7645,6 +7666,9 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (pci_dev_run_wake(pdev) && hw->mac.type != e1000_pch_cnp)
 		pm_runtime_put_noidle(&pdev->dev);
 
+	if (hw->mac.type == e1000_pch_tgp)
+		e1000e_create_device_links(pdev);
+
 	return 0;
 
 err_register:
@@ -7917,6 +7941,8 @@ static void __exit e1000_exit_module(void)
 }
 module_exit(e1000_exit_module);
 
+/* Ensure device link can be created if e1000e is in the initramfs. */
+MODULE_SOFTDEP("pre: mei_me");
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) PRO/1000 Network Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.31.1

