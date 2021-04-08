From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 8 Apr 2021 22:24:57 +0000
Subject: [Intel-wired-lan] [PATCH S58 09/13] ice: Set vsi->vf_id as
 ICE_INVAL_VFID for non VF VSI types
In-Reply-To: <20210331211708.55205-9-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
 <20210331211708.55205-9-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51056ECA37855188F50A6A08FA749@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, March 31, 2021 2:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S58 09/13] ice: Set vsi->vf_id as
> ICE_INVAL_VFID for non VF VSI types
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the vsi->vf_id is set only for ICE_VSI_VF and it's left as 0 for all
> other VSI types. This is confusing and could be problematic since 0 is a valid
> vf_id. Fix this by always setting non VF VSI types to ICE_INVAL_VFID.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


