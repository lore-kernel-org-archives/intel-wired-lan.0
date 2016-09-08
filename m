From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Sep 2016 16:53:06 +0000
Subject: [Intel-wired-lan] [next PATCH S45 02/10] i40e: Limit TX
 descriptor	count in cases where frag size is greater than 16K
In-Reply-To: <1473210312-29592-3-git-send-email-bimmy.pujari@intel.com>
References: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
 <1473210312-29592-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FC82A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, September 06, 2016 6:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S45 02/10] i40e: Limit TX descriptor
> count in cases where frag size is greater than 16K
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The i40e driver was incorrectly assuming that we would always be pulling no
> more than 1 descriptor from each fragment.  It is in fact possible for us to end
> up with the case where 2 descriptors worth of data may be pulled when a
> frame is larger than one of the pieces generated when aligning the payload
> to either 4K or pieces smaller than 16K.
> 
> To adjust for this we just need to make certain to test all the way to the end
> of the fragments as it is possible for us to span 2 descriptors in the block
> before us so we need to guarantee that even the last 6 descriptors have
> enough data to fill a full frame.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: Ic2ecb4d6b745f447d334e66c14002152f50e2f99
> ---
> Testing Hints:
>         This is hard to reproduce.  Patch submitted to customer for
>         testing.  Best effort would be to try testing TSO, if possible
>         TSO with iSCSI to verify nothing there is broken.
> 
> HSD-number: 10021204
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 7 ++-----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 7 ++-----
>  2 files changed, 4 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


