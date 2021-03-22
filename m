From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Mon, 22 Mar 2021 23:58:34 +0000
Subject: [Intel-wired-lan] [PATCH net 09/13] ice: remove DCBNL_DEVRESET
 bit from PF state
In-Reply-To: <20210226211932.46683-9-anthony.l.nguyen@intel.com>
References: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
 <20210226211932.46683-9-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105C9324DE7B831ED1DE1D4FA659@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, February 26, 2021 1:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net 09/13] ice: remove DCBNL_DEVRESET
> bit from PF state
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> The original purpose of the ICE_DCBNL_DEVRESET was to protect the driver
> during DCBNL device resets.  But, the flow for DCBNL device resets now
> consists of only calls up the stack such as dev_close() and dev_open() that
> will result in NDO calls to the driver.  These will be handled with state changes
> from the stack.  Also, there is a problem of the dev_close and dev_open
> being blocked by checks for reset in progress also using the
> ICE_DCBNL_DEVRESET bit.
> 
> Since the ICE_DCBNL_DEVRESET bit is not necessary for protecting the driver
> from DCBNL device resets and it is actually blocking changes coming form the
> DCBNL interface, remove the bit from the PF state and don't block driver
> function based on DCBNL reset in progress.
> 
> Fixes: b94b013eb626 ("ice: Implement DCBNL support")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h        | 1 -
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 2 --
>  drivers/net/ethernet/intel/ice/ice_lib.c    | 1 -
>  3 files changed, 4 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


