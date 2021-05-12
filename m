From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 12 May 2021 22:04:05 +0000
Subject: [Intel-wired-lan] [PATCH S59 12/13] ice: reduce scope of
 variables
In-Reply-To: <20210506154008.12880-12-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
 <20210506154008.12880-12-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB510510D3C4C4EA355F830FC2FA529@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, May 6, 2021 8:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S59 12/13] ice: reduce scope of variables
> 
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> There are some places where the scope of a variable can be reduced so do
> that.
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 8 ++++----
> drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


