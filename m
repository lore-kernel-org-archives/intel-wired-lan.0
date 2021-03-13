From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Sat, 13 Mar 2021 00:05:23 +0000
Subject: [Intel-wired-lan] [PATCH S56 03/13] ice: Refactor get/set RSS
 LUT to use struct parameter
In-Reply-To: <20210302181545.51822-3-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
 <20210302181545.51822-3-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105348E76BA589247FCA29BFA6E9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Tuesday, March 2, 2021 10:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S56 03/13] ice: Refactor get/set RSS LUT to
> use struct parameter
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Update ice_aq_get_rss_lut() and ice_aq_set_rss_lut() to take a new
> structure ice_aq_get_set_rss_params instead of passing individual
> parameters. This is done for 2 reasons:
> 
> 1. Reduce the number of parameters passed to the functions.
> 2. Reduce the amount of change required if the arguments ever need to be
>    updated in the future.
> 
> Also, reduce duplicate code that was checking for an invalid vsi_handle and
> lut parameter by moving the checks to the lower level
> __ice_aq_get_set_rss_lut().
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c  | 54 +++++++++-----------
> drivers/net/ethernet/intel/ice/ice_common.h  |  6 +--
> drivers/net/ethernet/intel/ice/ice_ethtool.c |  9 +++-
>  drivers/net/ethernet/intel/ice/ice_lib.c     |  9 +++-
>  drivers/net/ethernet/intel/ice/ice_main.c    | 18 +++++--
>  drivers/net/ethernet/intel/ice/ice_type.h    |  8 +++
>  6 files changed, 62 insertions(+), 42 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


