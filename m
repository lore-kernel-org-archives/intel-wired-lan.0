From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 8 Mar 2017 18:55:05 +0000
Subject: [Intel-wired-lan] [next PATCH S61 03/10] i40e/i40evf: Fix use
 after	free in Rx cleanup path
In-Reply-To: <1487721348-25617-4-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
 <1487721348-25617-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10402349@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S61 03/10] i40e/i40evf: Fix use after
> free in Rx cleanup path
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> We need to reset skb back to NULL when we have freed it in the Rx cleanup
> path.  I found one spot where this wasn't occurring so this patch fixes it.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: Iaca68934200732cd4a63eb0bd83b539c95f8c4dd
> ---
> Testing Hints:
>         The "Fixes" commit ID will need to be updated before this is pushed
>         upstream.  Ideally this patch can be dropped if the patch that
>         introduced the bug has not yet made it upstream, and this fix can
>         be taken care of there.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 1 +
>  2 files changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


