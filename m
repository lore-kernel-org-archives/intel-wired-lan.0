From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 11 Aug 2015 02:06:54 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Fix a deadlock in
	igb_sriov_reinit
In-Reply-To: <1438572986-32708-1-git-send-email-baijiaju1990@163.com>
References: <1438572986-32708-1-git-send-email-baijiaju1990@163.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81AE3594@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Jia-Ju Bai
> Sent: Sunday, August 02, 2015 8:36 PM
> To: Kirsher, Jeffrey T; Brandeburg, Jesse
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; Jia-Ju Bai
> Subject: [PATCH] igb: Fix a deadlock in igb_sriov_reinit
> 
> When igb_init_interrupt_scheme in igb_sriov_reinit is failed, the lock
> acquired by rtnl_lock() is not released, which causes a deadlock.
> This patch adds rtnl_unlock() in error handling to fix it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |    1 +
>  1 file changed, 1 insertion(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
