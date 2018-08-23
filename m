From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Aug 2018 21:04:08 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] net: intel: igb: Replace
 GFP_ATOMIC with GFP_KERNEL in igb_sw_init()
In-Reply-To: <20180727080453.3198-1-baijiaju1990@gmail.com>
References: <20180727080453.3198-1-baijiaju1990@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9655021D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jia-Ju Bai
> Sent: Friday, July 27, 2018 1:05 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; Jia-Ju Bai <baijiaju1990@gmail.com>; intel-
> wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH 1/2] net: intel: igb: Replace GFP_ATOMIC
> with GFP_KERNEL in igb_sw_init()
> 
> igb_sw_init() is never called in atomic context.
> It calls kzalloc() and kcalloc() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
