From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 8 Apr 2021 22:30:57 +0000
Subject: [Intel-wired-lan] [PATCH S58 11/13] ice: fix clang warning
 regarding deadcode.DeadStores
In-Reply-To: <20210331211708.55205-11-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
 <20210331211708.55205-11-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105D0062051A62514B2C677FA749@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S58 11/13] ice: fix clang warning regarding
> deadcode.DeadStores
> 
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> clang generates deadcode.DeadStores warnings when a variable is used to
> read a value, but then that value isn't used later in the code. Fix this warning.
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


