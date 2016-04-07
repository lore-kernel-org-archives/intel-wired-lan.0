From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 7 Apr 2016 01:42:24 +0000
Subject: [Intel-wired-lan] [PATCH] Revert "igb: Fix a deadlock
	in	igb_sriov_reinit"
In-Reply-To: <57047E20.1090700@huawei.com>
References: <57047E20.1090700@huawei.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81ECB902@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of c00176621
> Sent: Tuesday, April 5, 2016 8:10 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Liuyongan <liuyongan@huawei.com>; baijiaju1990 at 163.com;
> wangyunjian <wangyunjian@huawei.com>
> Subject: [Intel-wired-lan] [PATCH] Revert "igb: Fix a deadlock in
> igb_sriov_reinit"
> 
> This reverts commit 3eb14ea8d958 ("igb: Fix a deadlock in
> igb_sriov_reinit")
> It is the same as commit f468adc944ef ("igb: missing rtnl_unlock in
> igb_sriov_reinit()")
> There is no rtnl_lock() in igb_resume before, rtnl_unlock will cause a
> deadlock.
> 
> Signed-off-by: Arika Chen <arika.chen@huawei.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 1 -
>  1 file changed, 1 deletion(-)

Yeah, it looks like the a rtnl_unlock got thrown into another function as a side effect of adding it to igb_sriov_reinit

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
