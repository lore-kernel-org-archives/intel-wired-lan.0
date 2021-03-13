From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Sat, 13 Mar 2021 00:13:45 +0000
Subject: [Intel-wired-lan] [PATCH S56 10/13] ice: cleanup style issues
In-Reply-To: <20210302181545.51822-10-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
 <20210302181545.51822-10-anthony.l.nguyen@intel.com>
Message-ID: <SA2PR11MB51147FD90E2DEFC8306CBC72FA6E9@SA2PR11MB5114.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S56 10/13] ice: cleanup style issues
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> A few style issues reported by checkpatch have snuck into the code; resolve
> the style issues.
> 
> COMPLEX_MACRO: Macros with complex values should be enclosed in
> parentheses
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_controlq.h  | 4 ++--
> drivers/net/ethernet/intel/ice/ice_flex_type.h | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_flow.c      | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


