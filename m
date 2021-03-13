From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Sat, 13 Mar 2021 00:09:46 +0000
Subject: [Intel-wired-lan] [PATCH S56 05/13] ice: Consolidate VSI state
 and flags
In-Reply-To: <20210302181545.51822-5-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
 <20210302181545.51822-5-anthony.l.nguyen@intel.com>
Message-ID: <SA2PR11MB51146BD79EADA5F14198E9BCFA6E9@SA2PR11MB5114.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S56 05/13] ice: Consolidate VSI state and
> flags
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> struct ice_vsi has two fields, state and flags which seem to be serving the
> same purpose. Consolidate them into one field 'state'.
> 
> enum ice_state is used to represent state information of the PF.
> While some of these enum values can be use to represent VSI state, it makes
> more sense to represent VSI state with its own enum. So derive a new enum
> ice_vsi_state from ice_vsi_flags and ice_state and use it. Also rename enum
> ice_state to ice_pf_state for clarity.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         | 21 ++++----
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |  2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 14 +++---
>  drivers/net/ethernet/intel/ice/ice_main.c    | 50 ++++++++++----------
>  drivers/net/ethernet/intel/ice/ice_txrx.c    |  6 +--
>  5 files changed, 47 insertions(+), 46 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


