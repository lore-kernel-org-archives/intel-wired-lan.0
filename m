From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 21:42:27 +0000
Subject: [Intel-wired-lan] [PATCH S45 09/15] ice: Refactor VF reset
In-Reply-To: <20200516005121.4963-9-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
 <20200516005121.4963-9-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659ABC7CC3973AE2C65CC3E8C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S45 09/15] ice: Refactor VF reset
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently VF VSI are being reset twice during a PFR or greater. This is causing
> reset, specifically resetting all VFs, to take too long. This is causing various
> issues with VF drivers not being able to gracefully handle the VF reset
> timeout. Fix this by refactoring how VF reset is handled for the case
> mentioned previously and for the VFR/VFLR case.
> 
> The refactor was done by doing the following:
> 
> 1. Removing the call to ice_vsi_rebuild_by_type for
>    ICE_VSI_VF VSI, which was causing the initial VSI rebuild.
> 
> 2. Adding functions for pre/post VSI rebuild functions that can be called
>    in both the reset all VFs case and reset individual VF case.
> 
> 3. Adding VSI rebuild functions that are specific for the reset all VFs
>    case and adding functions that are specific for the reset individual
>    VF case.
> 
> 4. Calling the pre-rebuild function, then the specific VSI rebuild
>    function based on the reset type, and then calling the post-rebuild
>    function to handle VF resets.
> 
> This patch series makes some assumptions about how VSI are handling by
> FW during reset:
> 
> 1. During a PFR or greater all VSI in FW will be cleared.
> 2. During a VFR/VFLR the VSI rebuild responsibility is in the hands of
>    the PF software.
> 3. There is code in the ice_reset_all_vfs() case to amortize operations
>    if possible. This was left intact.
> 4. PF software should not be replaying VSI based filters that were added
>    other than host configured, PF software configured, or the VF's
>    default/LAA MAC. This is the VF drivers job after it has been reset.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c     |  12 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 304 +++++++-----------
>  2 files changed, 130 insertions(+), 186 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


