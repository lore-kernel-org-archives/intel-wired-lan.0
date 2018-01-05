From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 Jan 2018 19:31:37 +0000
Subject: [Intel-wired-lan] [next PATCH S85-V1 12/14] i40evf: Correctly
 populate rxitr_idx and txitr_idx
In-Reply-To: <20171229135120.14693-1-alice.michael@intel.com>
References: <20171229135120.14693-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7277@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, December 29, 2017 5:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S85-V1 12/14] i40evf: Correctly
> populate rxitr_idx and txitr_idx
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> While testing code for the recent ITR changes I found that updating the Tx
> ITR appeared to have no effect with everything defaulting to the Rx ITR. A bit
> of digging narrowed it down the fact that we were asking the PF to associate
> all causes with ITR 0 as we weren't populating the itr_idx values for either Rx
> or Tx.
> 
> To correct it I have added the configuration for these values to this patch. In
> addition I did some minor clean-up to just add a local pointer for the vector
> map instead of dereferencing it based off of the index repeatedly. In my
> opinion this makes the resultant code a bit more readable and saves us a few
> characters.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 24 ++++++++++++++------
> --
>  1 file changed, 15 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


