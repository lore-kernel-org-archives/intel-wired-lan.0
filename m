From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 8 Apr 2021 22:33:49 +0000
Subject: [Intel-wired-lan] [PATCH S58 12/13] ice: remove return variable
In-Reply-To: <20210331211708.55205-12-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
 <20210331211708.55205-12-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51055B789AD531B6DF9EF173FA749@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S58 12/13] ice: remove return variable
> 
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> We were saving the return value from ice_vsi_manage_rss_lut(), but the
> errors from that function are not critical so change it to return void and
> remove the code that saved the value.
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 8 +++-----
> drivers/net/ethernet/intel/ice/ice_lib.h  | 2 +-
> drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
>  3 files changed, 6 insertions(+), 8 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


