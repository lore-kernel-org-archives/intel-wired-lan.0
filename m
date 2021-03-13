From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Sat, 13 Mar 2021 00:04:00 +0000
Subject: [Intel-wired-lan] [PATCH S56 02/13] ice: Refactor promiscuous
 functions
In-Reply-To: <20210302181545.51822-2-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
 <20210302181545.51822-2-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105E7CC94DB5FA24962AF24FA6E9@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S56 02/13] ice: Refactor promiscuous
> functions
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Some of the promiscuous mode functions take a boolean to indicate
> set/clear, which affects readability. Refactor and provide an interface for the
> promiscuous mode code with explicit set and clear promiscuous mode
> operations.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_fltr.c     |  56 +++++++
>  drivers/net/ethernet/intel/ice/ice_fltr.h     |  10 ++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  51 ++++---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 137 +++++++-----------
>  4 files changed, 152 insertions(+), 102 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


