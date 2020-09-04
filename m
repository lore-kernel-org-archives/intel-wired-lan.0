From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 4 Sep 2020 23:30:27 +0000
Subject: [Intel-wired-lan] [PATCH][v2] i40e: optimise prefetch page
 refcount
In-Reply-To: <1596191874-27757-1-git-send-email-lirongqing@baidu.com>
References: <1596191874-27757-1-git-send-email-lirongqing@baidu.com>
Message-ID: <DM6PR11MB28909A8D75981EE55BAC8CECBC2D0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Li
> RongQing
> Sent: Friday, July 31, 2020 3:38 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
> kuba at kernel.org; Bowers, AndrewX <andrewx.bowers@intel.com>;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Subject: [Intel-wired-lan] [PATCH][v2] i40e: optimise prefetch page refcount
> 
> refcount of rx_buffer page will be added here originally, so prefetchw
> is needed, but after commit 1793668c3b8c ("i40e/i40evf: Update code to
>  better handle incrementing page count"), and refcount is not added
> everytime, so change prefetchw as prefetch,
> 
> now it mainly services page_address(), but which accesses struct page
> only when WANT_PAGE_VIRTUAL or HASHED_PAGE_VIRTUAL is defined
> otherwise
> it returns address based on offset, so we prefetch it conditionally
> 
> Jakub suggested to define prefetch_page_address in a common header
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> diff with v1: create a common function prefetch_page_address
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 +-
>  include/linux/prefetch.h                    | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
