From: Chen Yu <yu.c.chen@intel.com>
Date: Wed, 2 Dec 2020 23:40:46 +0800
Subject: [Intel-wired-lan] [PATCH 1/2][v3] e1000e: Leverage
 direct_complete to speed up s2ram
In-Reply-To: <DF79FD96-31E6-4D9A-BF0D-40B7FC563C0B@canonical.com>
References: <cover.1606757180.git.yu.c.chen@intel.com>
 <b8896b7748e516e9c440ab22e582e30f1389776c.1606757180.git.yu.c.chen@intel.com>
 <DF79FD96-31E6-4D9A-BF0D-40B7FC563C0B@canonical.com>
Message-ID: <20201202154046.GA17693@chenyu-office.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Kai-Heng,
On Wed, Dec 02, 2020 at 09:06:19PM +0800, Kai-Heng Feng wrote:
> > ---
> > v2: Added test data and some commit log revise(Paul Menzel)
> >    Only skip the suspend/resume if the NIC is not a wake up device specified
> >    by the user(Kai-Heng Feng)
> > v3: Leverage direct complete mechanism to skip all hooks(Kai-Heng Feng)
> > ---
> > 
> > -	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> > +	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_SMART_PREPARE);
> 
> This isn't required for pci_pm_prepare() to use driver's .prepare callback.
>
pci_pm_prepare() is likely to return 1 even if driver's prepare() return 0,
when DPM_FLAG_SMART_PREPARE is not set, which might cause prblems:
if (!error && dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_PREPARE))
	return 0;
> > 
> > 	if (pci_dev_run_wake(pdev) && hw->mac.type < e1000_pch_cnp)
> > 		pm_runtime_put_noidle(&pdev->dev);
> > @@ -7890,6 +7897,7 @@ MODULE_DEVICE_TABLE(pci, e1000_pci_tbl);
> > 
> > static const struct dev_pm_ops e1000_pm_ops = {
> > #ifdef CONFIG_PM_SLEEP
> > +	.prepare	= e1000e_pm_prepare,
> 
> How do we make sure a link change happened in S3 can be detect after resume, without a .complete callback which ask device to runtime resume?
> 
The pm core's device_complete() has already done that pm_runtime_put() in the end.

Just talked to Rafael and he might also give some feedbacks later.

thanks,
Chenyu
> Kai-Heng
> 
> 
