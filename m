From: Chen Yu <yu.c.chen@intel.com>
Date: Tue, 1 Dec 2020 08:57:26 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: Assign DPM_FLAG_SMART_SUSPEND
 and DPM_FLAG_MAY_SKIP_RESUME to speed up s2ram
In-Reply-To: <E385D730-1D0A-41B0-B6CC-CFBA7535BA1B@canonical.com>
References: <20201124153221.11265-1-yu.c.chen@intel.com>
 <8BA4D1E1-DACF-4E84-A5B8-75A7CEA65F98@canonical.com>
 <20201125103612.GA17700@chenyu-office.sh.intel.com>
 <B66CCBD9-5828-4514-AD08-C6FDF026646D@canonical.com>
 <20201126111053.GA15841@chenyu-office.sh.intel.com>
 <43247451-BA44-4958-A921-2BD0FF5FA5BA@canonical.com>
 <20201126144536.GA19171@chenyu-office.sh.intel.com>
 <E385D730-1D0A-41B0-B6CC-CFBA7535BA1B@canonical.com>
Message-ID: <20201201005725.GA32155@chenyu-office.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Nov 27, 2020 at 08:20:17PM +0800, Kai-Heng Feng wrote:
> Thanks for the confirmation. How about a different approach? 
> Simply use direct-complete to let PM core handle the rest:
>
Thanks for your suggestion and sorry about replying too late.
Yes, using direct-complete could leverage pm core to do that,
although this is a little different than my original thought
to mainly skip the resume process. But anyway, I'll use direct
complete and send a v3 out.
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index b30f00891c03..1d1424a20733 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -25,6 +25,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/aer.h>
>  #include <linux/prefetch.h>
> +#include <linux/suspend.h>
>  
>  #include "e1000.h"
>  
> @@ -6868,6 +6869,20 @@ static void e1000e_disable_aspm_locked(struct pci_dev *pdev, u16 state)
>  	__e1000e_disable_aspm(pdev, state, 1);
>  }
>  
> +static int e1000e_pm_prepare(struct device *dev)
> +{
> +	return pm_runtime_suspended(dev) &&
> +	       pm_suspend_via_firmware() &&
> +	       !device_may_wakeup(dev);
> +}
device_may_wakeup() is not needed as pm core will check it anyway.
> +
> +static void e1000e_pm_complete(struct device *dev)
> +{
> +	/* Detect link change */
> +	if (pm_runtime_suspended(dev))
> +		pm_request_resume(dev);
> +}
There is no need to force resume the device, just keep it
runtime suspended would be okay. Besides the pm core's complete()
will restore runtime usage_count which is increased by pm core's
prepare(), so there is no need to do that here again.
> +
>  static int e1000e_pm_thaw(struct device *dev)
>  {
>  	struct net_device *netdev = dev_get_drvdata(dev);
> @@ -7665,9 +7680,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	e1000_print_device_info(adapter);
>  
> -	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> -
DPM_FLAG_SMART_PREPARE must be set otherwise pci subsystem will ignore the
.prepare() from the driver.
> -	if (pci_dev_run_wake(pdev) && hw->mac.type < e1000_pch_cnp)
> +	if (pci_dev_run_wake(pdev))
>  		pm_runtime_put_noidle(&pdev->dev);
>
I would prefer to only disable runtime for cnp, in case of
any user regressions.

thanks,
Chenyu
