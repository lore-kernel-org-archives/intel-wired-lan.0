From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 26 Nov 2020 20:05:02 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: Assign DPM_FLAG_SMART_SUSPEND
 and DPM_FLAG_MAY_SKIP_RESUME to speed up s2ram
In-Reply-To: <20201126111053.GA15841@chenyu-office.sh.intel.com>
References: <20201124153221.11265-1-yu.c.chen@intel.com>
 <8BA4D1E1-DACF-4E84-A5B8-75A7CEA65F98@canonical.com>
 <20201125103612.GA17700@chenyu-office.sh.intel.com>
 <B66CCBD9-5828-4514-AD08-C6FDF026646D@canonical.com>
 <20201126111053.GA15841@chenyu-office.sh.intel.com>
Message-ID: <43247451-BA44-4958-A921-2BD0FF5FA5BA@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> On Nov 26, 2020, at 19:10, Chen Yu <yu.c.chen@intel.com> wrote:
> 
> On Thu, Nov 26, 2020 at 02:36:42PM +0800, Kai-Heng Feng wrote:
>>>> 
>>>> What about plugging ethernet cable and using WoL after system is suspended?
>>>> Commit "e1000e: Exclude device from suspend direct complete optimization" was to address that scenario.
> [cut]
>> 
>> I don't think this is right.
>> Isn't E1000_WUFC_LNKC already set for runtime suspend?
>> What if WoL doesn't have it set?
>> 
> After re-taking a look at your description, please let me elaborate more about the scenario.
> With this patch applied, and with sysfs wake up disabled, the expected behavior is:
> 
> 1. If NIC is not runtime suspended:
> 1.1 s2ram suspend -> wufc will be set to 0(no WoL settings), suspend(), suspend_late(), suspend_noirq()
> 1.2 s2ram resume  -> NIC resumes normaly
> 
> 2. If NIC is runtime suspended:
> 2.1 s2ram suspend -> wufc set to E1000_WUFC_LNKC, skip the subsequent suspend callbacks.

Is it safe to keep E1000_WUFC_LNKC enabled here?

From commit 6bf6be1127f7 ("e1000e: Do not wake up the system via WOL if device wakeup is disabled"):

       /* Runtime suspend should only enable wakeup for link changes */
       if (runtime)
               wufc = E1000_WUFC_LNKC;
       else if (device_may_wakeup(&pdev->dev))
               wufc = adapter->wol;
       else
               wufc = 0;

So it has different wakeup settings for runtime suspend and system suspend, either device_may_wakeup() true or false.
Or maybe e1000e devs can confirm E1000_WUFC_LNKC is a safe for system suspend?

Kai-Heng

> 2.2 s2ram resume -> skip the subsequent resume callbacks.
> 
> If between 2.1 and 2.2, the cable is plugged, the user is unable to use WoL to wake up
> the system.
> 
> But if the sysfs wake up is enabled, the code logic falls into the old path, and
> the user can wake up the system via WoL by plugging the cable, and send packages to the
> system. Or do I miss something?
> 
> thanks,
> Chenyu
> 
> 

