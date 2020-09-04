From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 4 Sep 2020 23:45:09 +0000
Subject: [Intel-wired-lan] [PATCH][v3] i40e: optimise prefetch page
 refcount
In-Reply-To: <1597734477-27859-1-git-send-email-lirongqing@baidu.com>
References: <1597734477-27859-1-git-send-email-lirongqing@baidu.com>
Message-ID: <DM6PR11MB289076BE0502BC161EDF82F9BC2D0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org <netdev-owner@vger.kernel.org>
> On Behalf Of Li RongQing
> Sent: Tuesday, August 18, 2020 12:08 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [PATCH][v3] i40e: optimise prefetch page refcount
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
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> diff with v2: fix a build warning -Wvisibility
> diff with v1: create a common function prefetch_page_address
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 +-
>  include/linux/prefetch.h                    | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
Ignore my prior mail on the v2 for this patch.  I really was using v3.
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

