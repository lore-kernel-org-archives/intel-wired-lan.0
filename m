From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 20 Jun 2015 02:43:47 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: Cleanup qos request in
	error	handling of e1000_open
In-Reply-To: <1433423247-27228-1-git-send-email-baijiaju1990@163.com>
References: <1433423247-27228-1-git-send-email-baijiaju1990@163.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DF861A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jia-Ju Bai
> Sent: Thursday, June 04, 2015 6:07 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Jia-Ju Bai
> Subject: [Intel-wired-lan] [PATCH] e1000e: Cleanup qos request in error
> handling of e1000_open
> 
> The driver lacks pm_qos_remove_request in error handling (err_req_irq) of
> e1000_open, and qos request inserted by pm_qos_add_request is not removed.
> This patch add pm_qos_remove_request in error handling to fix it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c |    1 +
>  1 file changed, 1 insertion(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
