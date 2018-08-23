From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Aug 2018 21:05:33 +0000
Subject: [Intel-wired-lan] [PATCH] net: intel: igb: Replace mdelay()
 with msleep() in igb_integrated_phy_loopback()
In-Reply-To: <20180727080738.3301-1-baijiaju1990@gmail.com>
References: <20180727080738.3301-1-baijiaju1990@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96550235@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jia-Ju Bai
> Sent: Friday, July 27, 2018 1:08 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; Jia-Ju Bai <baijiaju1990@gmail.com>; intel-
> wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] net: intel: igb: Replace mdelay() with
> msleep() in igb_integrated_phy_loopback()
> 
> igb_integrated_phy_loopback() is never called in atomic context.
> It calls mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep().
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
