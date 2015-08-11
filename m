From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 11 Aug 2015 02:13:48 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Fix a memory leak in igb_probe
In-Reply-To: <1438783516-13283-1-git-send-email-baijiaju1990@163.com>
References: <1438783516-13283-1-git-send-email-baijiaju1990@163.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81AE35CA@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Jia-Ju Bai
> Sent: Wednesday, August 05, 2015 7:05 AM
> To: Kirsher, Jeffrey T; Brandeburg, Jesse
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; Jia-Ju Bai
> Subject: [PATCH] igb: Fix a memory leak in igb_probe
> 
> In error handling code of igb_probe, the memory adapter->shadow_vfta
> allocated by kcalloc in igb_sw_init is not freed. So when register_netdev
> or igb_init_i2c is failed, a memory leak will occur.
> This patch adds kfree to fix it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |    1 +
>  1 file changed, 1 insertion(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
