From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 12 May 2021 15:46:15 +0000
Subject: [Intel-wired-lan] [PATCH S59 01/13] ice: use static inline for
 dummy functions
In-Reply-To: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB510516C355C9607D116513FAFA529@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, May 6, 2021 8:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S59 01/13] ice: use static inline for dummy
> functions
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Trivial:
> The driver had previously attempted to use #define macros to make
> functions that have no use in certain configs disappear. Using static inlines
> instead allows for certain static checkers to process the code better, and
> results in no functional change.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_arfs.h     | 12 +++++-----
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h  | 15 +++++++------
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.h   |  9 ++++----
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.h  | 22 ++++++++++---------
>  drivers/net/ethernet/intel/ice/ice_xsk.h      |  4 ++--
>  5 files changed, 33 insertions(+), 29 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


