From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Mon, 12 Apr 2021 17:18:49 +0000
Subject: [Intel-wired-lan] [PATCH S58 04/13] ice: refactor ITR data
 structures
In-Reply-To: <20210331211708.55205-4-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
 <20210331211708.55205-4-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105CABA30ECC29A2C3F9A71FA709@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S58 04/13] ice: refactor ITR data structures
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Use a dedicated bitfield in order to both increase the amount of checking
> around the length of ITR writes as well as simplify the checks of dynamic
> mode.
> 
> Basically unpack the "high bit means dynamic" logic into bitfields.
> 
> Also, remove some unused ITR defines.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c    |  3 ++
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 15 +++++-----
>  drivers/net/ethernet/intel/ice/ice_lib.c     |  7 -----
>  drivers/net/ethernet/intel/ice/ice_txrx.c    |  4 +--
>  drivers/net/ethernet/intel/ice/ice_txrx.h    | 30 +++++++++-----------
>  5 files changed, 26 insertions(+), 33 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


