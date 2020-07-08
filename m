From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 8 Jul 2020 20:46:00 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: not compute affinity_mask for
 IRQ
In-Reply-To: <1593593693-31299-1-git-send-email-lirongqing@baidu.com>
References: <1593593693-31299-1-git-send-email-lirongqing@baidu.com>
Message-ID: <BN6PR1101MB21459A2A4814EEE38E4B76918C670@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Li
> RongQing
> Sent: Wednesday, July 1, 2020 1:55 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: not compute affinity_mask for IRQ
> 
> After commit 759dc4a7e605 ("i40e: initialize our affinity_mask based on
> cpu_possible_mask"), NAPI IRQ affinity_mask is bind to all possible cpus, not
> a fixed cpu
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


