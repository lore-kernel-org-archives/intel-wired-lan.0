From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 18 Aug 2020 11:19:26 -0700
Subject: [Intel-wired-lan] [PATCH][v3] i40e: optimise prefetch page
 refcount
In-Reply-To: <1597734477-27859-1-git-send-email-lirongqing@baidu.com>
References: <1597734477-27859-1-git-send-email-lirongqing@baidu.com>
Message-ID: <20200818111926.000028d9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 18 Aug 2020 15:07:57 +0800
Li RongQing <lirongqing@baidu.com> wrote:

> refcount of rx_buffer page will be added here originally, so prefetchw
> is needed, but after commit 1793668c3b8c ("i40e/i40evf: Update code to
>  better handle incrementing page count"), and refcount is not added
> everytime, so change prefetchw as prefetch,
> 
> now it mainly services page_address(), but which accesses struct page
> only when WANT_PAGE_VIRTUAL or HASHED_PAGE_VIRTUAL is defined
> otherwise it returns address based on offset, so we prefetch it
> conditionally
> 
> Jakub suggested to define prefetch_page_address in a common header
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

This change looks fine to me, hopefully the more heavyweight
prefetch instruction doesn't impact performance. Were you able to test
any performance?

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
