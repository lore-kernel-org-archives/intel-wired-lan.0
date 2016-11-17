From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 Nov 2016 19:22:17 +0000
Subject: [Intel-wired-lan] [next PATCH S54 02/15] i40e:
	recalculate	vsi->active_filters from hash contents
In-Reply-To: <1478896779-13697-3-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
 <1478896779-13697-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA37FCF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, November 11, 2016 12:39 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S54 02/15] i40e: recalculate vsi-
> >active_filters from hash contents
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Previous code refactors have accidentally caused issues with the counting of
> active_filters. Avoid similar issues in the future by simply re-counting the
> active filters every time after we handle add and delete of all the filters.
> Additionally this allows us to simplify the check for when we exit
> promiscuous mode since we can combine the check for failed filters at the
> same time.
> 
> Additionally since we recount filters at the end we need to set
> vsi->promisc_threshold as well.
> 
> The resulting code takes a bit longer since we do have to loop over filters
> again. However, the result is more readable and less likely to become
> incorrect due to failed accounting of filters in the future.
> Finally, this ensures that it is not possible for vsi->active_filters to ever
> underflow since we never decrement it.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ib4f3a377e60eb1fa6c91ea86cc02238c08edd102
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 52 ++++++++++++++++-------
> ------
>  1 file changed, 29 insertions(+), 23 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Adding/deleting multiple filters works correctly and filter counts updated properly
