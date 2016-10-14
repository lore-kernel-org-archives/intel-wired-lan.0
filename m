From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Oct 2016 22:48:07 +0000
Subject: [Intel-wired-lan] [next PATCH S50 2/6] i40e: Reorder logic
	for	coalescing RS bits
In-Reply-To: <1476224818-16844-3-git-send-email-bimmy.pujari@intel.com>
References: <1476224818-16844-1-git-send-email-bimmy.pujari@intel.com>
 <1476224818-16844-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA17EA7@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, October 11, 2016 3:27 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S50 2/6] i40e: Reorder logic for
> coalescing RS bits
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch reorders the logic at the end of i40e_tx_map to address the fact
> that the logic was rather convoluted and much larger than it needed to be.
> 
> In order to try and coalesce the code paths I have updated some of the
> comments and repurposed some of the variables in order to reduce
> unnecessary overhead.
> 
> This patch does the following:
> 1.  Quit tracking skb->xmit_more with a flag, just max out packet_stride 2.
> Drop tail_bump and do_rs and instead just use desc_count and td_cmd 3.
> Pull comments from ixgbe that make need for wmb() more explicit.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: Ic7da85ec75043c634e87fef958109789bcc6317c
> ---
> Testing Hints:
>         The big area to test for this is performance.  This should perform
>         as well as the original code if not better.  If any signficant
>         performance regressions are seen or hangs are seen then this patch
>         has failed.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 105 +++++++++++++----------
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   1 -
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 105 +++++++++++++---------
> ----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h |   1 -
>  4 files changed, 108 insertions(+), 104 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


