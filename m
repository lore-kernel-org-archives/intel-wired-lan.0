From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jul 2016 20:21:23 +0000
Subject: [Intel-wired-lan] [PATCH -next] ixgbe: Add
	missing	destroy_workqueue() on error in ixgbe_init_module()
In-Reply-To: <1468336622-10538-1-git-send-email-weiyj_lk@163.com>
References: <1468336622-10538-1-git-send-email-weiyj_lk@163.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EAF21@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of weiyj_lk at 163.com
> Sent: Tuesday, July 12, 2016 8:17 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; Wei Yongjun
> <yongjun_wei@trendmicro.com.cn>; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH -next] ixgbe: Add missing
> destroy_workqueue() on error in ixgbe_init_module()
> 
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing destroy_workqueue() before return from
> ixgbe_init_module() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
