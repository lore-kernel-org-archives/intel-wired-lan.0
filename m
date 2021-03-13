From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Sat, 13 Mar 2021 00:18:04 +0000
Subject: [Intel-wired-lan] [PATCH S56 13/13] ice: Fix prototype warnings
In-Reply-To: <20210302181545.51822-13-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
 <20210302181545.51822-13-anthony.l.nguyen@intel.com>
Message-ID: <SA2PR11MB51140E8938718BB565DC898EFA6E9@SA2PR11MB5114.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S56 13/13] ice: Fix prototype warnings
> 
> Correct reported warnings for "warning: expecting prototype for ...
> Prototype was for ... instead"
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c      | 2 +-
>  drivers/net/ethernet/intel/ice/ice_dcb.c         | 2 +-
>  drivers/net/ethernet/intel/ice/ice_fdir.c        | 2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c        | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_sched.c       | 2 +-
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 4 ++--
>  6 files changed, 8 insertions(+), 8 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


