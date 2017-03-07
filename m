From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 7 Mar 2017 16:30:50 +0000
Subject: [Intel-wired-lan] [next PATCH S61 08/10] i40e/i40evf:
	Clean-up	process_skb_fields
In-Reply-To: <1487721348-25617-9-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
 <1487721348-25617-9-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10401F26@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, February 21, 2017 3:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S61 08/10] i40e/i40evf: Clean-up
> process_skb_fields
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This is a minor clean-up to make the i40e/i40evf process_skb_fields function
> look a little more like what we have in igb.  The Rx checksum function called
> out a need for skb->protocol but I can't see where it actually needs it.  I am
> assuming this is something that was likely refactored out some time ago as
> the Rx checksum code has gone through a few rewrites.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I0b4668a34d90b61b66ded7c7c26e19a3e2d06251
> ---
> Testing Hints:
>         Basically just need to verify this builds and processes Rx
>         checksums correctly.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 8 +++-----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 8 +++-----
>  2 files changed, 6 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


