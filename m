From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Sat, 13 Mar 2021 00:07:29 +0000
Subject: [Intel-wired-lan] [PATCH S56 04/13] ice: Refactor
 ice_set/get_rss into LUT and key specific functions
In-Reply-To: <20210302181545.51822-4-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
 <20210302181545.51822-4-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB510535CB4726ADE8689FF3BAFA6E9@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S56 04/13] ice: Refactor ice_set/get_rss
> into LUT and key specific functions
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently ice_set/get_rss are used to set/get the RSS LUT and/or RSS key.
> However nearly everywhere these functions are called only the LUT or key
> are set/get. Also, making this change reduces how many things
> ice_set/get_rss are doing. Fix this by adding ice_set/get_rss_lut and
> ice_set/get_rss_key functions.
> 
> Also, consolidate all calls for setting/getting the RSS LUT and RSS Key to use
> ice_set/get_rss_lut() and ice_set/get_rss_key().
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   6 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  43 +++---
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  42 ++----
>  drivers/net/ethernet/intel/ice/ice_main.c     | 139 ++++++++++--------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   4 +-
>  5 files changed, 117 insertions(+), 117 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


