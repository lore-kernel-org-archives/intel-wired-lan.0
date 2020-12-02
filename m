From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 2 Dec 2020 21:06:19 +0800
Subject: [Intel-wired-lan] [PATCH 1/2][v3] e1000e: Leverage
 direct_complete to speed up s2ram
In-Reply-To: <b8896b7748e516e9c440ab22e582e30f1389776c.1606757180.git.yu.c.chen@intel.com>
References: <cover.1606757180.git.yu.c.chen@intel.com>
 <b8896b7748e516e9c440ab22e582e30f1389776c.1606757180.git.yu.c.chen@intel.com>
Message-ID: <DF79FD96-31E6-4D9A-BF0D-40B7FC563C0B@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Yu,

> On Dec 1, 2020, at 09:21, Chen Yu <yu.c.chen@intel.com> wrote:
> 
> The NIC is put in runtime suspend status when there is no cable connected.
> As a result, it is safe to keep non-wakeup NIC in runtime suspended during
> s2ram because the system does not rely on the NIC plug event nor WoL to wake
> up the system. Besides that, unlike the s2idle, s2ram does not need to
> manipulate S0ix settings during suspend.
> 
> This patch introduces the .prepare() for e1000e so that if the NIC is runtime
> suspended the subsequent suspend/resume hooks will be skipped so as to speed
> up the s2ram. The pm core will check whether the NIC is a wake up device so
> there's no need to check it again in .prepare(). DPM_FLAG_SMART_PREPARE flag
> should be set during probe to ask the pci subsystem to honor the driver's
> prepare() result. Besides, the NIC remains runtime suspended after resumed
> from s2ram as there is no need to resume it.
> 
> Tested on i7-2600K with 82579V NIC
> Before the patch:
> e1000e 0000:00:19.0: pci_pm_suspend+0x0/0x160 returned 0 after 225146 usecs
> e1000e 0000:00:19.0: pci_pm_resume+0x0/0x90 returned 0 after 140588 usecs
> 
> After the patch:
> echo disabled > //sys/devices/pci0000\:00/0000\:00\:19.0/power/wakeup
> becomes 0 usecs because the hooks will be skipped.
> 
> Suggested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Well, I was intended to send it, but anyway :)

> ---
> v2: Added test data and some commit log revise(Paul Menzel)
>    Only skip the suspend/resume if the NIC is not a wake up device specified
>    by the user(Kai-Heng Feng)
> v3: Leverage direct complete mechanism to skip all hooks(Kai-Heng Feng)
> ---
> drivers/net/ethernet/intel/e1000e/netdev.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index b30f00891c03..b210bba3f20a 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -25,6 +25,7 @@
> #include <linux/pm_runtime.h>
> #include <linux/aer.h>
> #include <linux/prefetch.h>
> +#include <linux/suspend.h>
> 
> #include "e1000.h"
> 
> @@ -6957,6 +6958,12 @@ static int __e1000_resume(struct pci_dev *pdev)
> 	return 0;
> }
> 
> +static int e1000e_pm_prepare(struct device *dev)
> +{
> +	return pm_runtime_suspended(dev) &&
> +		pm_suspend_via_firmware();
> +}
> +
> static __maybe_unused int e1000e_pm_suspend(struct device *dev)
> {
> 	struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev));
> @@ -7665,7 +7672,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 
> 	e1000_print_device_info(adapter);
> 
> -	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> +	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_SMART_PREPARE);

This isn't required for pci_pm_prepare() to use driver's .prepare callback.

> 
> 	if (pci_dev_run_wake(pdev) && hw->mac.type < e1000_pch_cnp)
> 		pm_runtime_put_noidle(&pdev->dev);
> @@ -7890,6 +7897,7 @@ MODULE_DEVICE_TABLE(pci, e1000_pci_tbl);
> 
> static const struct dev_pm_ops e1000_pm_ops = {
> #ifdef CONFIG_PM_SLEEP
> +	.prepare	= e1000e_pm_prepare,

How do we make sure a link change happened in S3 can be detect after resume, without a .complete callback which ask device to runtime resume?

Kai-Heng

> 	.suspend	= e1000e_pm_suspend,
> 	.resume		= e1000e_pm_resume,
> 	.freeze		= e1000e_pm_freeze,
> -- 
> 2.17.1
> 

