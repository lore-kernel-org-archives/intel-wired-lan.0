From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 Dec 2017 00:28:05 +0000
Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] i40e/i40evf:
 Account for frags split over multiple descriptors in check linearize
In-Reply-To: <20171208185336.3685.3975.stgit@localhost.localdomain>
References: <20171208185336.3685.3975.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EBC329@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Friday, December 8, 2017 10:55 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] i40e/i40evf: Account
> for frags split over multiple descriptors in check linearize
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The original code for __i40e_chk_linearize didn't take into account the fact
> that if a fragment is 16K in size or larger it has to be split over 2 descriptors
> and the smaller of those 2 descriptors will be on the trailing edge of the
> transmit. As a result we can get into situations where we didn't catch
> requests that could result in a Tx hang.
> 
> This patch takes care of that by subtracting the length of all but the trailing
> edge of the stale fragment before we test for sum. By doing this we can
> guarantee that we have all cases covered, including the case of a fragment
> that spans multiple descriptors. We don't need to worry about checking the
> inner portions of this since 12K is the maximum aligned DMA size and that is
> larger than any MSS will ever be since the MTU limit for jumbos is something
> on the order of 9K.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   26
> ++++++++++++++++++++++---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   26
> ++++++++++++++++++++++---
>  2 files changed, 46 insertions(+), 6 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


