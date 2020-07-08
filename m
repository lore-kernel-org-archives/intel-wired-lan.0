From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 8 Jul 2020 20:46:53 +0000
Subject: [Intel-wired-lan] [PATCH][net-next] i40e: prefetch struct page
 of rx buffer conditionally
In-Reply-To: <1593671885-30822-1-git-send-email-lirongqing@baidu.com>
References: <1593671885-30822-1-git-send-email-lirongqing@baidu.com>
Message-ID: <BN6PR1101MB214501BA0231A0EF89CD66C78C670@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Li
> RongQing
> Sent: Wednesday, July 1, 2020 11:38 PM
> To: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH][net-next] i40e: prefetch struct page of rx
> buffer conditionally
> 
> page_address() accesses struct page only when WANT_PAGE_VIRTUAL or
> HASHED_PAGE_VIRTUAL is defined, otherwise it returns address based on
> offset, so we prefetch it conditionally
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


