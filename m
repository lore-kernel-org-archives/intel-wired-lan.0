From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 May 2020 19:45:23 +0000
Subject: [Intel-wired-lan] [PATCH S41 08/15] ice: cleanup vf_id
 signedness
In-Reply-To: <20200508004113.39725-8-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
 <20200508004113.39725-8-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659A68BB25C6914DB06DEA78CBD0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, May 7, 2020 5:41 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S41 08/15] ice: cleanup vf_id signedness
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The vf_id variable is dealt with in the code in inconsistent ways of sign usage,
> preventing compilation with -Werror=sign-compare.
> Fix this problem in the code by always treating vf_id as unsigned, since there
> are no valid values of vf_id that are negative.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h            |  2 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c    | 17 +++++++++--------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.h    |  2 +-
>  3 files changed, 11 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


