From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 11 Mar 2021 00:27:11 +0000
Subject: [Intel-wired-lan] [PATCH S55 06/14] ice: handle increasing Tx
 or Rx ring sizes
In-Reply-To: <20210302181213.51718-6-anthony.l.nguyen@intel.com>
References: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
 <20210302181213.51718-6-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51054A06063DC01953AC6045FA909@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Tuesday, March 2, 2021 10:12 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S55 06/14] ice: handle increasing Tx or Rx
> ring sizes
> 
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> There is an issue when the Tx or Rx ring size increases using 'ethtool -L ...'
> where the new rings don't get the correct ITR values because when we
> rebuild the VSI we don't know that some of the rings may be new.
> 
> Fix this by looking at the original number of rings and determining if the rings
> in ice_vsi_rebuild_set_coalesce() were not present in the original rings
> received in ice_vsi_rebuild_get_coalesce().
> 
> Also change the code to return an error if we can't allocate memory for the
> coalesce data in ice_vsi_rebuild().
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 123 ++++++++++++++++------
>  drivers/net/ethernet/intel/ice/ice_txrx.h |   2 +
>  2 files changed, 92 insertions(+), 33 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


