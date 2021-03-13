From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Sat, 13 Mar 2021 00:10:57 +0000
Subject: [Intel-wired-lan] [PATCH S56 06/13] ice: Drop leading
 underscores in enum ice_pf_state
In-Reply-To: <20210302181545.51822-6-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
 <20210302181545.51822-6-anthony.l.nguyen@intel.com>
Message-ID: <SA2PR11MB51145695937D1F718EB01501FA6E9@SA2PR11MB5114.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S56 06/13] ice: Drop leading underscores in
> enum ice_pf_state
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Remove the leading untracked in enum ice_status. This is not really
> communicating anything and is unnecessary. No functional change.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  68 ++---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  18 +-
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c |   2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  18 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     | 234 +++++++++---------
>  .../ethernet/intel/ice/ice_virtchnl_fdir.c    |   6 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  22 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |   6 +-
>  8 files changed, 187 insertions(+), 187 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


