From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 27 Nov 2020 20:20:17 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: Assign DPM_FLAG_SMART_SUSPEND
 and DPM_FLAG_MAY_SKIP_RESUME to speed up s2ram
In-Reply-To: <20201126144536.GA19171@chenyu-office.sh.intel.com>
References: <20201124153221.11265-1-yu.c.chen@intel.com>
 <8BA4D1E1-DACF-4E84-A5B8-75A7CEA65F98@canonical.com>
 <20201125103612.GA17700@chenyu-office.sh.intel.com>
 <B66CCBD9-5828-4514-AD08-C6FDF026646D@canonical.com>
 <20201126111053.GA15841@chenyu-office.sh.intel.com>
 <43247451-BA44-4958-A921-2BD0FF5FA5BA@canonical.com>
 <20201126144536.GA19171@chenyu-office.sh.intel.com>
Message-ID: <E385D730-1D0A-41B0-B6CC-CFBA7535BA1B@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> On Nov 26, 2020, at 22:45, Chen Yu <yu.c.chen@intel.com> wrote:
> 
> On Thu, Nov 26, 2020 at 08:05:02PM +0800, Kai-Heng Feng wrote:
>> 
>> 
>>> On Nov 26, 2020, at 19:10, Chen Yu <yu.c.chen@intel.com> wrote:
>>> 
>>> On Thu, Nov 26, 2020 at 02:36:42PM +0800, Kai-Heng Feng wrote:
>>>>>> 
>>>>>> What about plugging ethernet cable and using WoL after system is suspended?
>>>>>> Commit "e1000e: Exclude device from suspend direct complete optimization" was to address that scenario.
>>> [cut]
>>>> 
>>>> I don't think this is right.
>>>> Isn't E1000_WUFC_LNKC already set for runtime suspend?
>>>> What if WoL doesn't have it set?
>>>> 
>>> After re-taking a look at your description, please let me elaborate more about the scenario.
>>> With this patch applied, and with sysfs wake up disabled, the expected behavior is:
>>> 
>>> 1. If NIC is not runtime suspended:
>>> 1.1 s2ram suspend -> wufc will be set to 0(no WoL settings), suspend(), suspend_late(), suspend_noirq()
>>> 1.2 s2ram resume  -> NIC resumes normaly
>>> 
>>> 2. If NIC is runtime suspended:
>>> 2.1 s2ram suspend -> wufc set to E1000_WUFC_LNKC, skip the subsequent suspend callbacks.
>> 
>> Is it safe to keep E1000_WUFC_LNKC enabled here?
>> 
>> From commit 6bf6be1127f7 ("e1000e: Do not wake up the system via WOL if device wakeup is disabled"):
>> 
>>       /* Runtime suspend should only enable wakeup for link changes */
>>       if (runtime)
>>               wufc = E1000_WUFC_LNKC;
>>       else if (device_may_wakeup(&pdev->dev))
>>               wufc = adapter->wol;
>>       else
>>               wufc = 0;
>> 
>> So it has different wakeup settings for runtime suspend and system suspend, either device_may_wakeup() true or false.
> Right.
>> Or maybe e1000e devs can confirm E1000_WUFC_LNKC is a safe for system suspend?
>> 
> Does 'safe' here mean waking up the system?
> For s2ram, whether the NIC can wake up the system from S3 via cable plug is platform
> (BIOS) specific. So the wufc settings here is not directly related to system wake up
> via plug event.

Thanks for the confirmation. How about a different approach? 
Simply use direct-complete to let PM core handle the rest:

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index b30f00891c03..1d1424a20733 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -25,6 +25,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/aer.h>
 #include <linux/prefetch.h>
+#include <linux/suspend.h>
 
 #include "e1000.h"
 
@@ -6868,6 +6869,20 @@ static void e1000e_disable_aspm_locked(struct pci_dev *pdev, u16 state)
 	__e1000e_disable_aspm(pdev, state, 1);
 }
 
+static int e1000e_pm_prepare(struct device *dev)
+{
+	return pm_runtime_suspended(dev) &&
+	       pm_suspend_via_firmware() &&
+	       !device_may_wakeup(dev);
+}
+
+static void e1000e_pm_complete(struct device *dev)
+{
+	/* Detect link change */
+	if (pm_runtime_suspended(dev))
+		pm_request_resume(dev);
+}
+
 static int e1000e_pm_thaw(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
@@ -7665,9 +7680,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	e1000_print_device_info(adapter);
 
-	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
-
-	if (pci_dev_run_wake(pdev) && hw->mac.type < e1000_pch_cnp)
+	if (pci_dev_run_wake(pdev))
 		pm_runtime_put_noidle(&pdev->dev);
 
 	return 0;
@@ -7890,6 +7903,8 @@ MODULE_DEVICE_TABLE(pci, e1000_pci_tbl);
 
 static const struct dev_pm_ops e1000_pm_ops = {
 #ifdef CONFIG_PM_SLEEP
+	.prepare	= e1000e_pm_prepare,
+	.complete	= e1000e_pm_complete,
 	.suspend	= e1000e_pm_suspend,
 	.resume		= e1000e_pm_resume,
 	.freeze		= e1000e_pm_freeze,


> thanks,
> Chenyu

