From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 25 Oct 2017 19:44:00 +0000
Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] i40e: Fix
 incorrect use of tx_itr_setting when checking for Rx ITR setup
In-Reply-To: <20171020205906.24055.27032.stgit@localhost.localdomain>
References: <20171020205906.24055.27032.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAD622@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Friday, October 20, 2017 1:59 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] i40e: Fix incorrect use
> of tx_itr_setting when checking for Rx ITR setup
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> It looks like there was either a copy/paste error or just a typo that resulted in
> the Tx ITR setting being used to determine if we were using adaptive Rx
> interrupt moderation or not.
> 
> This patch fixes the typo.
> 
> Fixes: 65e87c0398f5 ("i40evf: support queue-specific settings for interrupt
> moderation")
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
