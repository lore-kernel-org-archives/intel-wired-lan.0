From: Chen Yu <yu.c.chen@intel.com>
Date: Tue, 24 Nov 2020 23:32:21 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: Assign DPM_FLAG_SMART_SUSPEND and
 DPM_FLAG_MAY_SKIP_RESUME to speed up s2ram
Message-ID: <20201124153221.11265-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The NIC is put in runtime suspend status when there is no wire connected.
As a result, it is safe to keep this NIC in runtime suspended during s2ram
because the system does not rely on the NIC plug event nor WOL to wake up
the system. Unlike the s2idle, s2ram does not need to manipulate S0ix settings
during suspend.

This patch assigns DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME
to the e1000e driver so that the s2ram could skip the .suspend_late(),
.suspend_noirq() and .resume_noirq() .resume_early() when possible.
Also skip .suspend() and .resume() if dev_pm_skip_suspend() and
dev_pm_skip_resume() return true, so as to speed up the s2ram.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/base/power/main.c                  |  2 ++
 drivers/net/ethernet/intel/e1000e/netdev.c | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

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
index b30f00891c03..d79fddabc553 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6965,6 +6965,14 @@ static __maybe_unused int e1000e_pm_suspend(struct device *dev)
 	struct e1000_hw *hw = &adapter->hw;
 	int rc;
 
+	/* Runtime suspended means that there is no wired connection
+	 * and it has nothing to do with WOL that, we don't need to
+	 * adjust the WOL settings. So it is safe to put NIC in
+	 * runtime suspend while doing system suspend.
+	 */
+	if (dev_pm_skip_suspend(dev))
+		return 0;
+
 	e1000e_flush_lpic(pdev);
 
 	e1000e_pm_freeze(dev);
@@ -6989,6 +6997,9 @@ static __maybe_unused int e1000e_pm_resume(struct device *dev)
 	struct e1000_hw *hw = &adapter->hw;
 	int rc;
 
+	if (dev_pm_skip_resume(dev))
+		return 0;
+
 	/* Introduce S0ix implementation */
 	if (hw->mac.type >= e1000_pch_cnp &&
 	    !e1000e_check_me(hw->adapter->pdev->device))
@@ -7665,7 +7676,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	e1000_print_device_info(adapter);
 
-	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
+				DPM_FLAG_SMART_SUSPEND | DPM_FLAG_MAY_SKIP_RESUME);
 
 	if (pci_dev_run_wake(pdev) && hw->mac.type < e1000_pch_cnp)
 		pm_runtime_put_noidle(&pdev->dev);
-- 
2.25.1

