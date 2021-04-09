From: Switzer, David <david.switzer@intel.com>
Date: Fri, 9 Apr 2021 19:56:03 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix unbalanced device
 enable/disable in suspend/resume
In-Reply-To: <20210322071448.12023-1-yongxin.liu@windriver.com>
References: <20210322071448.12023-1-yongxin.liu@windriver.com>
Message-ID: <MW3PR11MB47481E32E6F0701CDA1BAD20EB739@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


>-----Original Message-----
>From: Yongxin Liu <yongxin.liu@windriver.com>
>Sent: Monday, March 22, 2021 12:15 AM
To: vaibhavgupta40@gmail.com; andrewx.bowers at intel.com; Nguyen, Anthony
>L <anthony.l.nguyen@intel.com>
>Cc: netdev at vger.kernel.org; linux-kernel at vger.kernel.org;
>davem at davemloft.net; Brandeburg, Jesse <jesse.brandeburg@intel.com>; intel-
>wired-lan at lists.osuosl.org; kuba at kernel.org
>Subject: [PATCH net] ixgbe: fix unbalanced device enable/disable in
>suspend/resume
>
>pci_disable_device() called in __ixgbe_shutdown() decreases
>dev->enable_cnt by 1. pci_enable_device_mem() which increases enable_cnt
>dev->by 1, was removed from ixgbe_resume() in commit
>6f82b2558735 ("ixgbe: use generic power management"). This caused
>unbalanced increase/decrease. So add pci_enable_device_mem() back.
>
>Fix the following call trace.
>
>  ixgbe 0000:17:00.1: disabling already-disabled device
>  Call Trace:
>   __ixgbe_shutdown+0x10a/0x1e0 [ixgbe]
>   ixgbe_suspend+0x32/0x70 [ixgbe]
>   pci_pm_suspend+0x87/0x160
>   ? pci_pm_freeze+0xd0/0xd0
>   dpm_run_callback+0x42/0x170
>   __device_suspend+0x114/0x460
>   async_suspend+0x1f/0xa0
>   async_run_entry_fn+0x3c/0xf0
>   process_one_work+0x1dd/0x410
>   worker_thread+0x34/0x3f0
>   ? cancel_delayed_work+0x90/0x90
>   kthread+0x14c/0x170
>   ? kthread_park+0x90/0x90
>   ret_from_fork+0x1f/0x30
>
>Fixes: 6f82b2558735 ("ixgbe: use generic power management")
>Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
Tested-by: Dave Switzer <david.switzer@intel.com>

