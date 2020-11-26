From: Chen Yu <yu.c.chen@intel.com>
Date: Thu, 26 Nov 2020 14:14:40 +0800
Subject: [Intel-wired-lan] [PATCH 1/2][v2] e1000e: Assign
 DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME to speed up s2ram
In-Reply-To: <cover.1606370334.git.yu.c.chen@intel.com>
References: <cover.1606370334.git.yu.c.chen@intel.com>
Message-ID: <ce83589757381a790153bd5947ea1f9346415102.1606370334.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The NIC is put in runtime suspend status when there is no cable connected.
As a result, it is safe to keep non-wakeup NIC in runtime suspended during
s2ram because the system does not rely on the NIC plug event nor WoL to wake
up the system. Besides that, unlike the s2idle, s2ram does not need to
manipulate S0ix settings during suspend.

This patch assigns DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME
to the e1000e driver so that the s2ram could skip the .suspend_late(),
.suspend_noirq() and .resume_noirq() .resume_early() when possible.
Also skip .suspend() and .resume() if dev_pm_skip_suspend() and
dev_pm_skip_resume() return true, so as to speed up the suspend and
resume during s2ram.

Test1:
i5-8300H CPU with I219-LM NIC(with minor change to remove runtime
suspend restriction on this NIC)

Before:
[  203.391465] e1000e 0000:00:1f.6: pci_pm_suspend+0x0/0x170 returned 0 after 323186 usecs
[  203.598307] e1000e 0000:00:1f.6: pci_pm_suspend_late+0x0/0x40 returned 0 after 4 usecs
[  203.654026] e1000e 0000:00:1f.6: pci_pm_suspend_noirq+0x0/0x290 returned 0 after 20915 usecs
[  203.714464] e1000e 0000:00:1f.6: pci_pm_resume_noirq+0x0/0x120 returned 0 after 19952 usecs
[  203.716208] e1000e 0000:00:1f.6: pci_pm_resume_early+0x0/0x30 returned 0 after 0 usecs
[  203.934399] e1000e 0000:00:1f.6: pci_pm_resume+0x0/0x90 returned 0 after 211437 usecs

After:
[  150.455612] e1000e 0000:00:1f.6: pci_pm_suspend+0x0/0x170 returned 0 after 14 usecs
[  150.987627] e1000e 0000:00:1f.6: pci_pm_suspend_late+0x0/0x40 returned 0 after 3 usecs
[  151.021659] e1000e 0000:00:1f.6: pci_pm_suspend_noirq+0x0/0x290 returned 0 after 1 usecs
[  151.087303] e1000e 0000:00:1f.6: pci_pm_resume_noirq+0x0/0x120 returned 0 after 0 usecs
[  151.112056] e1000e 0000:00:1f.6: pci_pm_resume_early+0x0/0x30 returned 0 after 0 usecs
[  151.136508] e1000e 0000:00:1f.6: pci_pm_resume+0x0/0x90 returned 0 after 3030 usecs

Test2:
i7-2600K with 82579V NIC
Before:
[  336.668713] e1000e 0000:00:19.0: pci_pm_suspend+0x0/0x160 returned 0 after 16210 usecs
[  336.738481] e1000e 0000:00:19.0: pci_pm_suspend_late+0x0/0x40 returned 0 after 4 usecs
[  336.777849] e1000e 0000:00:19.0: pci_pm_suspend_noirq+0x0/0x280 returned 0 after 19058 usecs
[  336.943800] e1000e 0000:00:19.0: pci_pm_resume_noirq+0x0/0x110 returned 0 after 19600 usecs
[  336.963534] e1000e 0000:00:19.0: pci_pm_resume_early+0x0/0x30 returned 0 after 1 usecs
[  337.112877] e1000e 0000:00:19.0: pci_pm_resume+0x0/0x90 returned 0 after 145463 usecs

After:
[  494.657314] e1000e 0000:00:19.0: pci_pm_suspend+0x0/0x160 returned 0 after 5 usecs
[  494.733140] e1000e 0000:00:19.0: pci_pm_suspend_late+0x0/0x40 returned 0 after 1 usecs
[  494.751886] e1000e 0000:00:19.0: pci_pm_suspend_noirq+0x0/0x280 returned 0 after 0 usecs
[  494.917475] e1000e 0000:00:19.0: pci_pm_resume_noirq+0x0/0x110 returned 0 after 1 usecs
[  494.957043] e1000e 0000:00:19.0: pci_pm_resume_early+0x0/0x30 returned 0 after 1 usecs
[  494.957615] e1000e 0000:00:19.0: pci_pm_resume+0x0/0x90 returned 0 after 177 usecs

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2: Added test data and some commit log revise(Paul Menzel)
    Only skip the suspend/resume if the NIC is not a wake up device specified
    by the user(Kai-Heng Feng)
--
 drivers/base/power/main.c                  |  2 ++
 drivers/net/ethernet/intel/e1000e/netdev.c | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index c7ac49042cee..9cd8abba8612 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -580,6 +580,7 @@ bool dev_pm_skip_resume(struct device *dev)
 
 	return !dev->power.must_resume;
 }
+EXPORT_SYMBOL_GPL(dev_pm_skip_resume);
 
 /**
  * device_resume_noirq - Execute a "noirq resume" callback for given device.
@@ -2010,3 +2011,4 @@ bool dev_pm_skip_suspend(struct device *dev)
 	return dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
 		pm_runtime_status_suspended(dev);
 }
+EXPORT_SYMBOL_GPL(dev_pm_skip_suspend);
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index b30f00891c03..e32d443feb24 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6965,6 +6965,19 @@ static __maybe_unused int e1000e_pm_suspend(struct device *dev)
 	struct e1000_hw *hw = &adapter->hw;
 	int rc;
 
+	/* If dev_pm_skip_suspend() returns true it means that the NIC
+	 * is already runtime suspended. The NIC is okay to be put in
+	 * runtime suspended during system suspend as long as the NIC
+	 * is not a wake up device, because:
+	 * 1. Runtime suspend status implies that there is no cable connected,
+	 *    so there is no need to adjust the WoL setting.
+	 * 2. In case the user might plug ethernet cable and use WoL after system
+	 *    is suspended, only non-wakeup NIC could remain runtime suspended(thus
+	 *    not having to adjust WoL settings ).
+	 */
+	if (dev_pm_skip_suspend(dev) && !device_may_wakeup(dev))
+		return 0;
+
 	e1000e_flush_lpic(pdev);
 
 	e1000e_pm_freeze(dev);
@@ -6989,6 +7002,9 @@ static __maybe_unused int e1000e_pm_resume(struct device *dev)
 	struct e1000_hw *hw = &adapter->hw;
 	int rc;
 
+	if (dev_pm_skip_resume(dev) && !device_may_wakeup(dev))
+		return 0;
+
 	/* Introduce S0ix implementation */
 	if (hw->mac.type >= e1000_pch_cnp &&
 	    !e1000e_check_me(hw->adapter->pdev->device))
@@ -7665,7 +7681,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	e1000_print_device_info(adapter);
 
-	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
+				DPM_FLAG_SMART_SUSPEND | DPM_FLAG_MAY_SKIP_RESUME);
 
 	if (pci_dev_run_wake(pdev) && hw->mac.type < e1000_pch_cnp)
 		pm_runtime_put_noidle(&pdev->dev);
-- 
2.17.1

